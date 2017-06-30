From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 6/9] RISC-V: Device, timer, IRQs, and the SBI
Date: Fri, 30 Jun 2017 09:57:10 +0200
Message-ID: <20170630075710.GC5851@distanz.ch>
References: <20170629083924.GB5851@distanz.ch>
 <mhng-b71fc2a8-a47a-49af-82e1-fb88c016d547@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:36309 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdF3H5P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jun 2017 03:57:15 -0400
Content-Disposition: inline
In-Reply-To: <mhng-b71fc2a8-a47a-49af-82e1-fb88c016d547@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On 2017-06-30 at 00:52:44 +0200, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Thu, 29 Jun 2017 01:39:25 PDT (-0700), tklauser@distanz.ch wrote:
> > On 2017-06-28 at 20:55:35 +0200, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > [...]
> >> diff --git a/arch/riscv/include/asm/device.h b/arch/riscv/include/asm/device.h
> >> new file mode 100644
> >> index 000000000000..28975e528d2f
> >> --- /dev/null
> >> +++ b/arch/riscv/include/asm/device.h
> >> @@ -0,0 +1,27 @@
> >> +/*
> >> + * Copyright (C) 2016 SiFive
> >> + *
> >> + *   This program is free software; you can redistribute it and/or
> >> + *   modify it under the terms of the GNU General Public License
> >> + *   as published by the Free Software Foundation, version 2.
> >> + *
> >> + *   This program is distributed in the hope that it will be useful,
> >> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + *   GNU General Public License for more details.
> >> + */
> >> +
> >> +
> >> +#ifndef _ASM_RISCV_DEVICE_H
> >> +#define _ASM_RISCV_DEVICE_H
> >> +
> >> +#include <linux/sysfs.h>
> >> +
> >> +struct dev_archdata {
> >> +	struct dma_map_ops *dma_ops;
> >> +};
> >
> > The dma_ops member isn't used in any arch code or driver from what I can
> > tell (I checked against your riscv-for-submission-v3 branch). Could
> > device.h from asm-generic be used instead, or did I miss something?
> 
> I think you're right.  I'll include this
> 
>   diff --git a/arch/riscv/include/asm/device.h b/arch/riscv/include/asm/device.h
>   index 28975e528d2f..a310c2c26101 100644
>   --- a/arch/riscv/include/asm/device.h
>   +++ b/arch/riscv/include/asm/device.h
>   @@ -11,17 +11,9 @@
>     *   GNU General Public License for more details.
>     */
> 
>   -
>    #ifndef _ASM_RISCV_DEVICE_H
>    #define _ASM_RISCV_DEVICE_H
> 
>   -#include <linux/sysfs.h>
>   -
>   -struct dev_archdata {
>   -       struct dma_map_ops *dma_ops;
>   -};
>   -
>   -struct pdev_archdata {
>   -};
>   +#include <asm-generic/device.h>
> 
>    #endif /* _ASM_RISCV_DEVICE_H */
> 
> in the v4

Better yet, remove arch/riscv/include/asm/device.h altogether and add device.h
to generic-y in the asm/Kbuild file, as follows:

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 710397395981..52b254e26378 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += cacheflush.h
 generic-y += checksum.h
 generic-y += clkdev.h
 generic-y += cputime.h
+generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
 generic-y += dma-contiguous.h
diff --git a/arch/riscv/include/asm/device.h b/arch/riscv/include/asm/device.h
deleted file mode 100644
index 28975e528d2f..000000000000
--- a/arch/riscv/include/asm/device.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2016 SiFive
- *
- *   This program is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License
- *   as published by the Free Software Foundation, version 2.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- */
-
-
-#ifndef _ASM_RISCV_DEVICE_H
-#define _ASM_RISCV_DEVICE_H
-
-#include <linux/sysfs.h>
-
-struct dev_archdata {
-       struct dma_map_ops *dma_ops;
-};
-
-struct pdev_archdata {
-};
-
-#endif /* _ASM_RISCV_DEVICE_H */

> 
> >
> >> +
> >> +struct pdev_archdata {
> >> +};
> >> +
> >> +#endif /* _ASM_RISCV_DEVICE_H */
> 
> Thanks!
> 
