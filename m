From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] string: provide strscpy()
Date: Wed, 8 Jul 2015 22:54:00 +0200
Message-ID: <CAMuHMdXJRD6wC5WsJOfyoFO5J_AyX+ifT6+6h6JXt-ZFpbjFGw@mail.gmail.com>
References: <1436386845-11989-1-git-send-email-cmetcalf@ezchip.com>
	<1436386845-11989-3-git-send-email-cmetcalf@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35282 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbbGHUyB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2015 16:54:01 -0400
In-Reply-To: <1436386845-11989-3-git-send-email-cmetcalf@ezchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Chris,

On Wed, Jul 8, 2015 at 10:20 PM, Chris Metcalf <cmetcalf@ezchip.com> wrote:
> + * strscpy - Copy a C-string into a sized buffer
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + * @count: Size of destination buffer
> + *
> + * Copy the string, or as much of it as fits, into the dest buffer.
> + * The routine returns the number of characters copied (not including
> + * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
> + * The behavior is undefined if the string buffers overlap.
> + * If the destination buffer isn't big enough, it is NUL terminated.

... unless count is zero

and it's also NUL terminated if it is big enough ;-)

Perhaps
"The destination buffer is always NUL terminated, unless it's zero-sized."

> + *
> + * Preferred to strlcpy() since the API doesn't require reading memory
> + * from the src string beyond the specified "count" bytes, and since
> + * the return value is easier to error-check than strlcpy()'s.
> + * In addition, the implementation is robust to the string changing out
> + * from underneath it, unlike the current strlcpy() implementation.
> + *
> + * Preferred to strncpy() since it always returns a valid string, and
> + * doesn't unnecessarily force the tail of the destination buffer to be
> + * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
> + * with an overflow test, then just memset() the tail of the dest buffer.
> + */
> +ssize_t strscpy(char *dest, const char *src, size_t count)
> +{
> +       const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
> +       size_t max = count;
> +       long res = 0;
> +
> +       if (count == 0)
> +               return -E2BIG;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
