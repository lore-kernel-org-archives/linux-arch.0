From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
Date: Fri, 24 Oct 2014 11:10:36 +0200
Message-ID: <CAMuHMdXTg3s_ZKL5M+=LwiNBa4gL8Z=eOchocD3qjvp-d=gW_Q@mail.gmail.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
	<1414139071-3818-30-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1414139071-3818-30-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 24, 2014 at 10:24 AM, Ley Foon Tan <lftan@altera.com> wrote:
> --- /dev/null
> +++ b/arch/nios2/boot/install.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +# Copyright (C) 1995 by Linus Torvalds
> +#
> +# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> +#
> +# "make install" script for m68k architecture

You probably want to s/m68k/nios2/ here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
