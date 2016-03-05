Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35154 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760487AbcCEALB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 19:11:01 -0500
Date: Fri, 4 Mar 2016 16:10:57 -0800
From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Message-ID: <20160305001057.GC55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <20160305000225.GB55664@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160305000225.GB55664@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
Message-ID: <20160305001057.Zhpee4iDjCUwfaONq8KRkHb-7tN17x_NIlCrT5esU1I@z>

+ others

On Fri, Mar 04, 2016 at 04:02:25PM -0800, Brian Norris wrote:
> Hi Arnd,
> 
> I know you're travelling, but...
> 
> On Mon, Jan 25, 2016 at 04:41:50PM +0100, Arnd Bergmann wrote:
> > When XIP_KERNEL is enabled, some functions are defined in the .data
> > ELF section because we require them to be in RAM whenever we communicate
> > with the flash chip. However this causes problems when FTRACE is
> > enabled and gcc emits calls to __gnu_mcount_nc in the function
> > prolog:
> > 
> > drivers/built-in.o: In function `cfi_chip_setup':
> > :(.data+0x272fc): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > drivers/built-in.o: In function `cfi_probe_chip':
> > :(.data+0x27de8): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > /tmp/ccY172rP.s: Assembler messages:
> > /tmp/ccY172rP.s:70: Warning: ignoring changed section attributes for .data
> > /tmp/ccY172rP.s: Error: 1 warning, treating warnings as errors
> > make[5]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
> > /tmp/ccK4rjeO.s: Assembler messages:
> > /tmp/ccK4rjeO.s:421: Warning: ignoring changed section attributes for .data
> > /tmp/ccK4rjeO.s: Error: 1 warning, treating warnings as errors
> > make[5]: *** [drivers/mtd/chips/cfi_util.o] Error 1
> > /tmp/ccUvhCYR.s: Assembler messages:
> > /tmp/ccUvhCYR.s:1895: Warning: ignoring changed section attributes for .data
> > /tmp/ccUvhCYR.s: Error: 1 warning, treating warnings as errors
> 
> Can you provide a sample .config that DOES build correctly with
> XIP_KERNEL enabled + this patch? My first attempt yields some other
> failures I don't care to fixup right now...

Particularly, mach-pxa MTD_XIP looks like it's broken, at least since
here:

  5d284e353eb1 ARM: pxa: avoid accessing interrupt registers directly

  CC      drivers/mtd/chips/cfi_cmdset_0002.o
drivers/mtd/chips/cfi_cmdset_0002.c: In function ‘xip_udelay’:
drivers/mtd/chips/cfi_cmdset_0002.c:962:35: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/mtd/chips/cfi_cmdset_0002.c:967:8: error: ‘ICIP’ undeclared (first use in this function)
drivers/mtd/chips/cfi_cmdset_0002.c:967:8: note: each undeclared identifier is reported only once for each function it appears in
drivers/mtd/chips/cfi_cmdset_0002.c:967:15: error: ‘ICMR’ undeclared (first use in this function)
drivers/mtd/chips/cfi_cmdset_0002.c:981:123: error: invalid operands to binary / (have ‘void *’ and ‘int’)
drivers/mtd/chips/cfi_cmdset_0002.c:982:14: warning: assignment makes integer from pointer without a cast [enabled by default]
drivers/mtd/chips/cfi_cmdset_0002.c:984:124: error: invalid operands to binary / (have ‘void *’ and ‘int’)
drivers/mtd/chips/cfi_cmdset_0002.c:1034:10: warning: assignment makes integer from pointer without a cast [enabled by default]
drivers/mtd/chips/cfi_cmdset_0002.c:1045:118: error: invalid operands to binary / (have ‘void *’ and ‘int’)

Looks like arch/arm/mach-pxa/include/mach/mtd-xip.h can't find ICIP or ICMR...

> Anyway, I don't doubt you have a good fix here, so I can probably take
> it. Any review from others would be welcome though.
> 
> > Specifically, this does not work because the .data section is not
> > marked executable, which leads LD to not generate trampolines for
> > long calls.
> > 
> > This moves the __xipram functions into their own .xiptext section instead.
> > The section is still placed next to .data and located in RAM but is marked
> > executable, which avoids the build errors.
> > 
> > Also, we only need to place the XIP functions into a separate section
> > if both CONFIG_XIP_KERNEL and CONFIG_MTD_XIP are set: When only MTD_XIP
> > is used, the whole kernel is still in RAM and we do not need to worry
> > about pulling out the rug under it. When only XIP_KERNEL but not MTD_XIP
> > is set, the kernel is in some form of ROM, but we never write to it.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Brian
