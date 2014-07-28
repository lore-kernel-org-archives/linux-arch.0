From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 05/29] nios2: Memory management
Date: Mon, 28 Jul 2014 16:59:13 +0200
Message-ID: <CAMuHMdUyif5JS9OdiamHhf+r5oeTRdd7Gzd6-rBUyamnNQ6C8A@mail.gmail.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-6-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-6-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 15, 2014 at 10:45 AM, Ley Foon Tan <lftan@altera.com> wrote:
> --- /dev/null
> +++ b/arch/nios2/include/asm/mmu.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
> + * Copyright (C) 2004 Microtronix Datacom Ltd.
> + *
> + * Taken from m68knommu.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License. See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#ifndef _ASM_NIOS2_MMU_H
> +#define _ASM_NIOS2_MMU_H
> +
> +/* Default "unsigned long" context */
> +typedef unsigned long mm_context_t;
> +
> +#endif /* _ASM_NIOS2_MMU_H */

Any chance you can use mmu.h from asm-generic instead?
It uses a struct with a single "unsigned long end_brk" member (unless
CONFIG_BINFMT_ELF_FDPIC is defined).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
