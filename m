From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] string: provide strscpy() and strscpy_truncate()
Date: Wed, 6 May 2015 18:45:56 +0200
Message-ID: <CAMuHMdUuaRGn10_k+Gm7vG5P_=QfSw7Mao3oB_u2Poy=PeiGtg@mail.gmail.com>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
	<1430409677-13284-3-git-send-email-cmetcalf@ezchip.com>
	<20150506150140.GB12986@mwanda>
	<554A3161.3030609@ezchip.com>
	<20150506155951.GS16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35926 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbbEFQp5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2015 12:45:57 -0400
In-Reply-To: <20150506155951.GS16501@mwanda>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, May 6, 2015 at 5:59 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We actually do have a __must_check tag so it's easy enough to force
> people to check.  A different option is we could make it trigger a

People tend to ignore compiler warnings...

> WARN_ONCE().
>
> #define strXcpy(dest, src, len) (({                             \
>         ssize_t __ret = strscpy_truncate(dest, src, len);       \
>         WARN_ONCE(__ret < 0, "strXcpy trancates\n");            \
>         __ret; }))

Which will probably trigger only in extreme cases in the wild, not during
development.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
