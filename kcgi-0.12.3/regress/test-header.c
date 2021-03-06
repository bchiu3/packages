/*	$Id: test-header.c,v 1.5 2017/10/18 21:36:59 kristaps Exp $ */
/*
 * Copyright (c) 2017 Kristaps Dzonsons <kristaps@bsd.lv>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
#include "../config.h"

#include <stdarg.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <curl/curl.h>

#include "../kcgi.h"
#include "regress.h"

static int
parent(CURL *curl)
{
	struct curl_slist *slist;
	int		   ret;

	slist = NULL;
	slist = curl_slist_append(slist, "Testing:123");
	slist = curl_slist_append(slist, "Testing-Test:321");
	curl_easy_setopt(curl, CURLOPT_URL, "http://localhost:17123/");
	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, slist);
	ret = curl_easy_perform(curl);
	curl_slist_free_all(slist);
	return(CURLE_OK == ret);
}

static int
child(void)
{
	struct kreq	 r;
	const char 	*page = "index";
	size_t		 i, found1, found2;

	if (KCGI_OK != khttp_parse(&r, NULL, 0, &page, 1, 0))
		return(0);

	found1 = found2 = 0;
	for (i = 0; i < r.reqsz; i++) {
		if (0 == strcmp(r.reqs[i].key, "Testing")) 
			found1 += 0 == strcmp(r.reqs[i].val, "123");
		else if (0 == strcmp(r.reqs[i].key, "Testing-Test")) 
			found2 += 0 == strcmp(r.reqs[i].val, "321");
	}

	if (1 != found1 || 1 != found2) 
		return(0);

	khttp_head(&r, kresps[KRESP_STATUS], 
		"%s", khttps[KHTTP_200]);
	khttp_head(&r, kresps[KRESP_CONTENT_TYPE], 
		"%s", kmimetypes[KMIME_TEXT_HTML]);
	khttp_body(&r);
	khttp_free(&r);
	return(1);
}

int
main(int argc, char *argv[])
{

	return(regress_cgi(parent, child) ? EXIT_SUCCESS : EXIT_FAILURE);
}
