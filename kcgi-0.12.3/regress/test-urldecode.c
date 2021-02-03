/*	$Id: test-urldecode.c,v 1.5 2020/04/10 11:53:23 kristaps Exp $ */
/*
 * Copyright (c) 2018, 2020 Kristaps Dzonsons <kristaps@bsd.lv>
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

#include <sys/param.h>

#if HAVE_ERR
# include <err.h>
#endif
#include <stdarg.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include "../kcgi.h"

#ifndef nitems
# define nitems(_a) (sizeof((_a)) / sizeof((_a)[0]))
#endif

struct	test {
	enum kcgi_err	 errorcode;
	const char	*input;
	const char	*output;
};

static	const struct test tests[] = {
	{ KCGI_OK, "", "" },
	{ KCGI_OK, "foobar", "foobar" },
	{ KCGI_OK, "foo+bar", "foo bar" },
	{ KCGI_OK, "foo~bar", "foo~bar" },
	{ KCGI_OK, "foo-bar", "foo-bar" },
	{ KCGI_OK, "foo_bar", "foo_bar" },
	{ KCGI_OK, "foo.bar", "foo.bar" },
	{ KCGI_OK, "foo.bar.", "foo.bar." },
	{ KCGI_OK, "foo.bar.-", "foo.bar.-" },
	{ KCGI_OK, "-_foo.bar.-", "-_foo.bar.-" },
	{ KCGI_OK, "-_foo%2Bbar.-", "-_foo+bar.-" },
	{ KCGI_OK, "-_foo%2bbar.-", "-_foo+bar.-" },
	{ KCGI_OK, "-_foo%09bar.-", "-_foo\tbar.-" },
	{ KCGI_OK, "%09-_foo%09bar.-", "\t-_foo\tbar.-" },
	{ KCGI_OK, "%09-_foo%09bar.-%09", "\t-_foo\tbar.-\t" },
	{ KCGI_OK, "%09-_foo%25%09bar.-%09", "\t-_foo%\tbar.-\t" },
	{ KCGI_OK, "-_foo%2509%7dbar.-", "-_foo%09}bar.-" },
	{ KCGI_OK, "-_foo%2509%7Dbar.-", "-_foo%09}bar.-" },
	{ KCGI_OK, "%09%09%09%09", "\t\t\t\t" },
	{ KCGI_OK, "%F8", "\xf8" },
	{ KCGI_FORM, "%-9", NULL },
	{ KCGI_FORM, "% 9", NULL },
	{ KCGI_FORM, "%9 ", NULL },
	{ KCGI_FORM, "%9", NULL },
	{ KCGI_FORM, "% ", NULL },
	{ KCGI_FORM, "%", NULL },
	{ KCGI_FORM, "foo%zubar", NULL },
	{ KCGI_FORM, "foo%", NULL },
	{ KCGI_FORM, "%%%%%%", NULL },
	{ KCGI_OK, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "ABCDEFGHIJKLMNOPQRSTUVWXYZ" },
	{ KCGI_OK, "abcdefghijklmnopqrstuvwxyz", "abcdefghijklmnopqrstuvwxyz" },
	{ KCGI_OK, "0123456789-_.~", "0123456789-_.~" },
	{ KCGI_OK, "%21%23%24%25%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D",
		"!#$%&'()*+,/:;=?@[]" },
	{ KCGI_FORM, NULL, NULL }
};

int
main(int argc, char *argv[])
{
	const struct test *t;
	char		*url;
	enum kcgi_err 	 code;
	size_t	 	 len, i;

	if (khttp_urldecode(NULL, &url) != KCGI_FORM)
		errx(1, "khttp_urldecode should fail");
	if (khttp_urldecode("abcdef", NULL) != KCGI_FORM)
		errx(1, "khttp_urldecode should fail");

	len = nitems(tests);

	url = NULL;
	for (i = 0; i < len; i++) {
		t = &tests[i];
		code = khttp_urldecode(t->input, &url);
		if (code == KCGI_ENOMEM)
			err(1, NULL);
		if (t->errorcode != code)
			errx(1, "%s: have %i, want %i", 
				t->input, code, t->errorcode);
		if (code != KCGI_OK) {
			if (url != NULL)
				errx(1, "%s: want NULL", t->input);
		} else {
			if (url == NULL)
				errx(1, "%s: have NULL", t->input);
			if (strcmp(url, t->output))
				errx(1, "%s: have %s, want %s", 
					t->input, url, t->output);
		}
		free(url);
	}

	return 0;
}
