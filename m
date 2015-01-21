From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/16] h8300: Assembly headers
Date: Wed, 21 Jan 2015 12:02:14 +0100
Message-ID: <CAMuHMdWWzqtgSZGMr-RGn6j7V5gn1-eCUUQZv27d3HKf=g_=gA@mail.gmail.com>
References: <cover.1421813622.git.ysato@users.sourceforge.jp>
	<87y4owvk27.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:49489 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbAULCP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 06:02:15 -0500
Received: by mail-la0-f46.google.com with SMTP id s18so18582664lam.5
        for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2015 03:02:14 -0800 (PST)
In-Reply-To: <87y4owvk27.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linux-Arch <linux-arch@vger.kernel.org>

On Wed, Jan 21, 2015 at 5:23 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> --- /dev/null
> +++ b/arch/h8300/include/asm/cache.h
> @@ -0,0 +1,13 @@
> +#ifndef __ARCH_H8300_CACHE_H
> +#define __ARCH_H8300_CACHE_H
> +
> +/* bytes per L1 cache line */
> +#define        L1_CACHE_SHIFT  2
> +#define        L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)
> +
> +/* m68k-elf-gcc  2.95.2 doesn't like these */

Please drop the above comment.

> +
> +#define __cacheline_aligned
> +#define ____cacheline_aligned
> +
> +#endif

> --- /dev/null
> +++ b/arch/h8300/include/asm/io.h
> @@ -0,0 +1,355 @@
> +#ifndef _H8300_IO_H
> +#define _H8300_IO_H
> +
> +#ifdef __KERNEL__
> +
> +/*
> + * These are for ISA/PCI shared memory _only_ and should never be used
> + * on any other type of memory, including Zorro memory. They are meant to
> + * access the bus in the bus byte order which is little-endian!.
> + *
> + * readX/writeX() are used to access memory mapped devices. On some
> + * architectures the memory mapped IO stuff needs to be accessed
> + * differently. On the m68k architecture, we just read/write the
> + * memory location directly.
> + */
> +/* ++roman: The assignments to temp. vars avoid that gcc sometimes generates
> + * two accesses to memory, which may be undesirable for some devices.

I doubt all of the above is relevant for h8300.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
