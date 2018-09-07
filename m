From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 06/26] csky: Cache and TLB routines
Date: Fri, 7 Sep 2018 11:04:49 +0800
Message-ID: <20180907030447.GA10434@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 04:31:16PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> > new file mode 100644
> > index 0000000..fcb2142
> > --- /dev/null
> > +++ b/arch/csky/include/asm/io.h
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#ifndef __ASM_CSKY_IO_H
> > +#define __ASM_CSKY_IO_H
> > +
> > +#include <abi/pgtable-bits.h>
> > +#include <linux/types.h>
> > +#include <linux/version.h>
> > +
> > +extern void __iomem *ioremap(phys_addr_t offset, size_t size);
> > +
> > +extern void iounmap(void *addr);
> > +
> > +extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
> > +               size_t size, unsigned long flags);
> > +
> > +#define ioremap_nocache(phy, sz)       ioremap(phy, sz)
> > +#define ioremap_wc ioremap_nocache
> > +#define ioremap_wt ioremap_nocache
> > +
> > +#include <asm-generic/io.h>
> 
> It is very unusual for an architecture to not need special handling in asm/io.h,
> to do the proper barriers etc.
> 
> Can you describe how C-Sky hardware implements MMIO?
Our mmio is uncachable and strong-order address, so there is no need
barriers for access these io addr.

 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache

Current ioremap_wc and ioremap_wt implementation are too simple and
we'll improve it in future.

> In particular:
> 
> - Is a read from uncached memory always serialized with DMA, and with
>   other CPUs doing MMIO access to a different address?
CPU use ld.w to get data from uncached strong order memory.
Other CPUs use the same mmio vaddr to access the uncachable strong order
memory paddr.

> - How does endianess work? Are there any buses that flip bytes around
>   when running big-endian, or do you always do that in software?
Currently we only support little-endian and soc will follow it.

 Guo Ren
