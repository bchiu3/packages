/*	$Id: test-nullqueryval.c,v 1.2 2017/11/21 03:06:00 kristaps Exp $ */
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

	curl_easy_setopt(curl, CURLOPT_URL, 
		"http://localhost:17123/index.html?foo=bar&baz&foo2=bar2&xyzzy");
	return(CURLE_OK == curl_easy_perform(curl));
}

static int
child(void)
{
	struct kreq	 r;
	struct kvalid	 key[5] = { 
		{ kvalid_string, "foo" },
		{ kvalid_string, "baz" },
		{ kvalid_string, "foo2" },
		{ kvalid_string, "xyzzy" },
		{ kvalid_string, "bar" }};
	const char 	*page[] = { "index" };

	if (KCGI_OK != khttp_parse(&r, key, 5, page, 1, 0))
		return(0);

	if (NULL == r.fieldmap[0] ||
	    NULL == r.fieldmap[1] ||
	    NULL == r.fieldmap[2] ||
	    NULL == r.fieldmap[3] ||
	    NULL != r.fieldmap[4])
		return(0);

	if (strcmp(r.fieldmap[0]->parsed.s, "bar") ||
	    strcmp(r.fieldmap[1]->parsed.s, "") ||
	    strcmp(r.fieldmap[2]->parsed.s, "bar2") ||
	    strcmp(r.fieldmap[3]->parsed.s, ""))
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
