Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64563 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760612AbcCEAZd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 19:25:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Sat, 05 Mar 2016 01:24:36 +0100
Message-ID: <3582240.H8v1IXn8EB@wuerfel>
In-Reply-To: <20160305001057.GC55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de> <20160305000225.GB55664@google.com> <20160305001057.GC55664@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brian Norris <computersforpeace@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
Message-ID: <20160305002436.KCReGl81hrhk1uMBCq2i801YwN4qDGp2Lsr5bTwhiUg@z>

On Friday 04 March 2016 16:10:57 Brian Norris wrote:
>   5d284e353eb1 ARM: pxa: avoid accessing interrupt registers directly
> 
>   CC      drivers/mtd/chips/cfi_cmdset_0002.o
> drivers/mtd/chips/cfi_cmdset_0002.c: In function ‘xip_udelay’:
> drivers/mtd/chips/cfi_cmdset_0002.c:962:35: warning: initialization makes integer from pointer without a cast [enabled by default]
> drivers/mtd/chips/cfi_cmdset_0002.c:967:8: error: ‘ICIP’ undeclared (first use in this function)
> drivers/mtd/chips/cfi_cmdset_0002.c:967:8: note: each undeclared identifier is reported only once for each function it appears in
> drivers/mtd/chips/cfi_cmdset_0002.c:967:15: error: ‘ICMR’ undeclared (first use in this function)
> drivers/mtd/chips/cfi_cmdset_0002.c:981:123: error: invalid operands to binary / (have ‘void *’ and ‘int’)
> drivers/mtd/chips/cfi_cmdset_0002.c:982:14: warning: assignment makes integer from pointer without a cast [enabled by default]
> drivers/mtd/chips/cfi_cmdset_0002.c:984:124: error: invalid operands to binary / (have ‘void *’ and ‘int’)
> drivers/mtd/chips/cfi_cmdset_0002.c:1034:10: warning: assignment makes integer from pointer without a cast [enabled by default]
> drivers/mtd/chips/cfi_cmdset_0002.c:1045:118: error: invalid operands to binary / (have ‘void *’ and ‘int’)
> 
> Looks like arch/arm/mach-pxa/include/mach/mtd-xip.h can't find ICIP or ICMR...
> 

Right, I also have a workaround for that one, but found later that it
won't work. I think this is the patch that broke it five years ago:

commit 5d284e353eb11ab2e8b1c5671ba06489b0bd1e0c
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Wed Apr 27 22:48:04 2011 +0800

    ARM: pxa: avoid accessing interrupt registers directly
    
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/include/mach/regs-intc.h b/arch/arm/mach-pxa/include/mach/regs-intc.h
deleted file mode 100644
index 662288eb6f95..000000000000
--- a/arch/arm/mach-pxa/include/mach/regs-intc.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef __ASM_MACH_REGS_INTC_H
-#define __ASM_MACH_REGS_INTC_H
-
-#include <mach/hardware.h>
-
-/*
- * Interrupt Controller
- */
-
-#define ICIP           __REG(0x40D00000)  /* Interrupt Controller IRQ Pending Register */
-#define ICMR           __REG(0x40D00004)  /* Interrupt Controller Mask Register */
-#define ICLR           __REG(0x40D00008)  /* Interrupt Controller Level Register */
-#define ICFP           __REG(0x40D0000C)  /* Interrupt Controller FIQ Pending Register */
-#define ICPR           __REG(0x40D00010)  /* Interrupt Controller Pending Register */
-#define ICCR           __REG(0x40D00014)  /* Interrupt Controller Control Register */
-#define ICHP           __REG(0x40D00018)  /* Interrupt Controller Highest Priority Register */

and it's possible that nobody ever noticed...

I guess we can bring back the macros for the case that MTD_XIP and XIP_KERNEL
are both enabled.

	Arnd
