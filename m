From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 01/15] h8300: Assembly headers.
Date: Sun, 15 Feb 2015 10:11:58 +0100
Message-ID: <CAMuHMdVyquFQJAiSqyP7iuP+7gxfNOgGv6OjT3b4B2d6TJfJPw@mail.gmail.com>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
	<1423986573-2329-2-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64508 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbbBOJL7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Feb 2015 04:11:59 -0500
In-Reply-To: <1423986573-2329-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Sato-san,

On Sun, Feb 15, 2015 at 8:49 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> --- /dev/null
> +++ b/arch/h8300/include/asm/io.h
> @@ -0,0 +1,372 @@
> +#ifndef _H8300_IO_H
> +#define _H8300_IO_H
> +
> +#ifdef __KERNEL__
> +
> +#include <linux/types.h>
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
> + */

While some of the above applies to h8300, I think you should remove
the parts that don't apply.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
