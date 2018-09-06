From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 06/26] csky: Cache and TLB routines
Date: Thu, 6 Sep 2018 16:31:16 +0200
Message-ID: <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
References: <cover.1536138304.git.ren_guo@c-sky.com> <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> new file mode 100644
> index 0000000..fcb2142
> --- /dev/null
> +++ b/arch/csky/include/asm/io.h
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef __ASM_CSKY_IO_H
> +#define __ASM_CSKY_IO_H
> +
> +#include <abi/pgtable-bits.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +extern void __iomem *ioremap(phys_addr_t offset, size_t size);
> +
> +extern void iounmap(void *addr);
> +
> +extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
> +               size_t size, unsigned long flags);
> +
> +#define ioremap_nocache(phy, sz)       ioremap(phy, sz)
> +#define ioremap_wc ioremap_nocache
> +#define ioremap_wt ioremap_nocache
> +
> +#include <asm-generic/io.h>

It is very unusual for an architecture to not need special handling in asm/io.h,
to do the proper barriers etc.

Can you describe how C-Sky hardware implements MMIO?

In particular:

- Is a read from uncached memory always serialized with DMA, and with
  other CPUs doing MMIO access to a different address?

- How does endianess work? Are there any buses that flip bytes around
  when running big-endian, or do you always do that in software?

        Arnd
