/*	$Id: test-urlencode.c,v 1.6 2020/04/10 10:24:39 kristaps Exp $ */
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

struct	test {
	const char	*input;
	const char	*output;
};

static	const struct test tests[] = {
	{ "", "" },
	{ "foobar", "foobar" },
	{ "foo bar", "foo+bar" },
	{ "foo~bar", "foo~bar" },
	{ "foo-bar", "foo-bar" },
	{ "foo_bar", "foo_bar" },
	{ "foo.bar", "foo.bar" },
	{ "foo.bar.", "foo.bar." },
	{ "foo.bar.-", "foo.bar.-" },
	{ "-_foo.bar.-", "-_foo.bar.-" },
	{ "-_foo+bar.-", "-_foo%2Bbar.-" },
	{ "-_foo\tbar.-", "-_foo%09bar.-" },
	{ "\t-_foo\tbar.-", "%09-_foo%09bar.-" },
	{ "\t-_foo\tbar.-\t", "%09-_foo%09bar.-%09" },
	{ "\t-_foo%\tbar.-\t", "%09-_foo%25%09bar.-%09" },
	{ "-_foo%09}bar.-", "-_foo%2509%7Dbar.-" },
	{ "\t\t\t\t", "%09%09%09%09" },
	{ "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "ABCDEFGHIJKLMNOPQRSTUVWXYZ" },
	{ "abcdefghijklmnopqrstuvwxyz", "abcdefghijklmnopqrstuvwxyz" },
	{ "0123456789-_.~", "0123456789-_.~" },
	{ "!#$%&'()*+,/:;=?@[]", "%21%23%24%25%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D" },
	{ NULL, NULL }
};

int
main(int argc, char *argv[])
{
	const struct test *t;
	char	*url;

	if ((url = khttp_urlencode(NULL)) == NULL)
		err(1, "khttp_urlencode");
	if (strcmp(url, ""))
		errx(1, "khttp_urlencode: should have empty");
	free(url);

	for (t = tests; t->input != NULL; t++) {
		if ((url = khttp_urlencode(t->input)) == NULL)
			err(1, "khttp_urlencode");
		if (strcmp(url, t->output))
			errx(1, "khttp_urlencode: have %s, want %s", url, t->output);
		free(url);
	}

	return 0;
}
