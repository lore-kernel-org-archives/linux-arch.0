From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: possible problem with generic asm/types.h
Date: Sat, 25 May 2013 18:01:39 +0200
Message-ID: <CAMuHMdVqFdbv88qDgHAGB7kmBFEwPZWVhr27KqUgiqhrUrga+A@mail.gmail.com>
References: <1369494858.25297.58.camel@t520.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62351 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056Ab3EYQBj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 May 2013 12:01:39 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so5422951pac.14
        for <linux-arch@vger.kernel.org>; Sat, 25 May 2013 09:01:39 -0700 (PDT)
In-Reply-To: <1369494858.25297.58.camel@t520.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>

On Sat, May 25, 2013 at 5:14 PM, Mark Salter <msalter@redhat.com> wrote:
>     /*
>      * int-ll64 is used practically everywhere now,

This comment is obsolete, it's used everywhere now.

>      * so use it as a reasonable default.
>      */
>     #include <asm-generic/int-ll64.h>
>
> Shouldn't this be:
>
>     #include <asm/bitsperlong.h>
>     #if __BITS_PER_LONG == 64
>     #include <asm-generic/int-l64.h>
>     #else
>     #include <asm-generic/int-ll64.h>
>     #endif

No. Inside the kernel, all 64-bit platforms use int-ll64.h.

For backwards compatibility, alpha, ia64, mips, and powerpc (unless
__SANE_USERSPACE_TYPES__ is defined) still use int-l64.h in userspace.

So it seems your glibc ues the old convention. Any chance you can still
switch?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
