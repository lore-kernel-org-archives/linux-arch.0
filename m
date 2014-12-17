From: Joe Perches <joe@perches.com>
Subject: rfc: remove early_printk from a few arches? (blackfin, m68k, mips)
Date: Wed, 17 Dec 2014 12:58:47 -0800
Message-ID: <1418849927.28384.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:60797 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750999AbaLQU6v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Dec 2014 15:58:51 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>

It seems like early_printk can be configured into
a few architectures but also appear not to be used.

$ git grep -w "early_printk"
arch/arm/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/arm/kernel/early_printk.c: *  linux/arch/arm/kernel/early_printk.c
arch/arm/mach-socfpga/socfpga.c:	early_printk("Early printk initialized\n");
arch/blackfin/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)           += early_printk.o
arch/blackfin/kernel/bfin_dma.c:#include <asm/early_printk.h>
arch/blackfin/kernel/early_printk.c: * derived from arch/x86/kernel/early_printk.c
arch/blackfin/kernel/early_printk.c:#include <asm/early_printk.h>
arch/blackfin/kernel/setup.c:#include <asm/early_printk.h>
arch/blackfin/kernel/shadow_console.c:#include <asm/early_printk.h>
arch/blackfin/mm/init.c:#include <asm/early_printk.h>
arch/ia64/sn/kernel/setup.c:	 * IO on SN2 is done via SAL calls, early_printk won't work without this.
arch/m68k/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/microblaze/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c:	early_printk("ERROR: Microblaze " x "-different for PVR and DTS\n");
arch/microblaze/kernel/cpu/cpuinfo-static.c:	early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
arch/microblaze/kernel/setup.c:/* initialize device tree for usage in early_printk */
arch/mips/ath25/Makefile:obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
arch/mips/ath79/Makefile:obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
arch/mips/bcm63xx/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h: * during early_printk no ioremap possible at this early stage
arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h: * during early_printk no ioremap is possible
arch/mips/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/mips/lantiq/Makefile:obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
arch/mips/loongson/common/Makefile:obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
arch/mips/ralink/Makefile:obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
arch/tile/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/tile/kernel/early_printk.c:	early_printk("Kernel panic - not syncing: %pV", &vaf);
arch/um/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
arch/unicore32/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/unicore32/kernel/early_printk.c: * linux/arch/unicore32/kernel/early_printk.c
arch/x86/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
arch/x86/kernel/e820.c:	early_printk(msg);
arch/x86/kernel/head64.c:		early_printk("Kernel alive\n");
arch/x86/kernel/head_64.S:	call early_printk
arch/x86/platform/efi/Makefile:obj-$(CONFIG_EARLY_PRINTK_EFI)	+= early_printk.o
drivers/tty/serial/8250/8250_early.c: * and on early_printk.c by Andi Kleen.
drivers/tty/serial/sn_console.c: * synchronous (raw) and asynchronous (buffered).  initially, early_printk
drivers/tty/serial/sn_console.c:	/* without early_printk, we may be invoked late enough to race
drivers/tty/serial/sn_console.c:	/* early_printk invocation may have done this for us */
include/linux/printk.h:void early_printk(const char *fmt, ...);
include/linux/printk.h:void early_printk(const char *s, ...) { }
kernel/events/core.c:		early_printk("perf interrupt took too long (%lld > %lld), lowering "
kernel/locking/lockdep.c: * We cannot printk in early bootup code. Not even early_printk()
kernel/printk/printk.c:asmlinkage __visible void early_printk(const char *fmt, ...)
kernel/printk/printk.c: * early_printk) - sometimes before setup_arch() completes - be careful
kernel/printk/printk.c: * There are two types of consoles - bootconsoles (early_printk) and

These seem to the only uses:

arch/arm/mach-socfpga/socfpga.c:	early_printk("Early printk initialized\n");
[]
arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c:	early_printk("ERROR: Microblaze " x "-different for PVR and DTS\n");
arch/microblaze/kernel/cpu/cpuinfo-static.c:	early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
[]
arch/tile/kernel/early_printk.c:	early_printk("Kernel panic - not syncing: %pV", &vaf);
[]
arch/x86/kernel/e820.c:	early_printk(msg);
arch/x86/kernel/head64.c:		early_printk("Kernel alive\n");
arch/x86/kernel/head_64.S:	call early_printk
[]
kernel/events/core.c:		early_printk("perf interrupt took too long (%lld > %lld), lowering "

So blackfin, m68k, and mips seems to have it possible to enable,
but also don't appear at first glance to use it,

Is early_printk really used by these architectures?
Should it be removed?
