Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:51523 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752773AbXJJM6o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Oct 2007 08:58:44 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [RFC] AVR32: NMI debugging
Date: Wed, 10 Oct 2007 14:58:29 +0200
Message-Id: <1192021109-16404-1-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: kernel@avr32linux.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Change the NMI handler to use the die notifier chain to signal anyone
who cares. Add a simple "nmi debugger" which hooks into this chain and
that may dump registers, task state, etc. when it happens.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 Documentation/kernel-parameters.txt |    5 ++
 arch/avr32/Kconfig                  |   10 ++++
 arch/avr32/kernel/Makefile          |    1 +
 arch/avr32/kernel/irq.c             |   11 +++++
 arch/avr32/kernel/nmi_debug.c       |   82 +++++++++++++++++++++++++++++++++++
 arch/avr32/kernel/traps.c           |   21 ++++++++-
 arch/avr32/mach-at32ap/at32ap7000.c |   25 +++++++++++
 include/asm-avr32/irq.h             |    5 ++
 include/asm-avr32/kdebug.h          |    1 +
 9 files changed, 158 insertions(+), 3 deletions(-)
 create mode 100644 arch/avr32/kernel/nmi_debug.c

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index b41cde3..524634e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -34,6 +34,7 @@ parameter is applicable:
 	ALSA	ALSA sound support is enabled.
 	APIC	APIC support is enabled.
 	APM	Advanced Power Management support is enabled.
+	AVR32	AVR32 architecture is enabled.
 	AX25	Appropriate AX.25 support is enabled.
 	DRM	Direct Rendering Management support is enabled.
 	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
@@ -1076,6 +1077,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			[NFS] set the maximum lifetime for idmapper cache
 			entries.
 
+	nmi_debug=	[KNL,AVR32] Specify one or more actions to take
+			when a NMI is triggered.
+			Format: [state][,regs][,debounce][,die]
+
 	nmi_watchdog=	[KNL,BUGS=X86-32] Debugging features for SMP kernels
 
 	no387		[BUGS=X86-32] Tells the kernel to use the 387 maths
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index ec6c7c5..2f5fe0d 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -178,6 +178,16 @@ config OWNERSHIP_TRACE
 	  enabling Nexus-compliant debuggers to keep track of the PID of the
 	  currently executing task.
 
+config NMI_DEBUGGING
+	bool "NMI Debugging"
+	default n
+	help
+	  Say Y here and pass the nmi_debug command-line parameter to
+	  the kernel to turn on NMI debugging. Depending on the value
+	  of the nmi_debug option, various pieces of information will
+	  be dumped to the console when a Non-Maskable Interrupt
+	  happens.
+
 config DW_DMAC
 	tristate "Synopsys DesignWare DMA Controller support"
 	default y if CPU_AT32AP7000
diff --git a/arch/avr32/kernel/Makefile b/arch/avr32/kernel/Makefile
index 1aedaeb..0f45975 100644
--- a/arch/avr32/kernel/Makefile
+++ b/arch/avr32/kernel/Makefile
@@ -12,3 +12,4 @@ obj-y				+= init_task.o switch_to.o cpu.o
 obj-y				+= dma-controller.o
 obj-$(CONFIG_MODULES)		+= module.o avr32_ksyms.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_NMI_DEBUGGING)	+= nmi_debug.o
diff --git a/arch/avr32/kernel/irq.c b/arch/avr32/kernel/irq.c
index 61f2de2..a8e767d 100644
--- a/arch/avr32/kernel/irq.c
+++ b/arch/avr32/kernel/irq.c
@@ -25,6 +25,17 @@ void ack_bad_irq(unsigned int irq)
 	printk("unexpected IRQ %u\n", irq);
 }
 
+/* May be overridden by platform code */
+int __weak nmi_enable(void)
+{
+	return -ENOSYS;
+}
+
+void __weak nmi_disable(void)
+{
+
+}
+
 #ifdef CONFIG_PROC_FS
 int show_interrupts(struct seq_file *p, void *v)
 {
diff --git a/arch/avr32/kernel/nmi_debug.c b/arch/avr32/kernel/nmi_debug.c
new file mode 100644
index 0000000..3414b85
--- /dev/null
+++ b/arch/avr32/kernel/nmi_debug.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2007 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/kdebug.h>
+#include <linux/notifier.h>
+#include <linux/sched.h>
+
+#include <asm/irq.h>
+
+enum nmi_action {
+	NMI_SHOW_STATE	= 1 << 0,
+	NMI_SHOW_REGS	= 1 << 1,
+	NMI_DIE		= 1 << 2,
+	NMI_DEBOUNCE	= 1 << 3,
+};
+
+static unsigned long nmi_actions;
+
+static int nmi_debug_notify(struct notifier_block *self,
+		unsigned long val, void *data)
+{
+	struct die_args *args = data;
+
+	if (likely(val != DIE_NMI))
+		return NOTIFY_DONE;
+
+	if (nmi_actions & NMI_SHOW_STATE)
+		show_state();
+	if (nmi_actions & NMI_SHOW_REGS)
+		show_regs(args->regs);
+	if (nmi_actions & NMI_DEBOUNCE)
+		mdelay(10);
+	if (nmi_actions & NMI_DIE)
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block nmi_debug_nb = {
+	.notifier_call = nmi_debug_notify,
+};
+
+static int __init nmi_debug_setup(char *str)
+{
+	char *p, *sep;
+
+	register_die_notifier(&nmi_debug_nb);
+	if (nmi_enable()) {
+		printk(KERN_WARNING "Unable to enable NMI.\n");
+		return 0;
+	}
+
+	if (*str != '=')
+		return 0;
+
+	for (p = str + 1; *p; p = sep + 1) {
+		sep = strchr(p, ',');
+		if (sep)
+			*sep = 0;
+		if (strcmp(p, "state") == 0)
+			nmi_actions |= NMI_SHOW_STATE;
+		else if (strcmp(p, "regs") == 0)
+			nmi_actions |= NMI_SHOW_REGS;
+		else if (strcmp(p, "debounce") == 0)
+			nmi_actions |= NMI_DEBOUNCE;
+		else if (strcmp(p, "die") == 0)
+			nmi_actions |= NMI_DIE;
+		else
+			printk(KERN_WARNING "NMI: Unrecognized action `%s'\n",
+				p);
+		if (!sep)
+			break;
+	}
+
+	return 0;
+}
+__setup("nmi_debug", nmi_debug_setup);
diff --git a/arch/avr32/kernel/traps.c b/arch/avr32/kernel/traps.c
index 9a73ce7..d18b46b 100644
--- a/arch/avr32/kernel/traps.c
+++ b/arch/avr32/kernel/traps.c
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
+#include <linux/kdebug.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/sched.h>
@@ -107,9 +108,23 @@ void _exception(long signr, struct pt_regs *regs, int code,
 
 asmlinkage void do_nmi(unsigned long ecr, struct pt_regs *regs)
 {
-	printk(KERN_ALERT "Got Non-Maskable Interrupt, dumping regs\n");
-	show_regs_log_lvl(regs, KERN_ALERT);
-	show_stack_log_lvl(current, regs->sp, regs, KERN_ALERT);
+	int ret;
+
+	nmi_enter();
+
+	ret = notify_die(DIE_NMI, "NMI", regs, 0, ecr, SIGINT);
+	switch (ret) {
+	case NOTIFY_OK:
+	case NOTIFY_STOP:
+		return;
+	case NOTIFY_BAD:
+		die("Fatal Non-Maskable Interrupt", regs, SIGINT);
+	default:
+		break;
+	}
+
+	printk(KERN_ALERT "Got NMI, but nobody cared. Disabling...\n");
+	nmi_disable();
 }
 
 asmlinkage void do_critical_exception(unsigned long ecr, struct pt_regs *regs)
diff --git a/arch/avr32/mach-at32ap/at32ap7000.c b/arch/avr32/mach-at32ap/at32ap7000.c
index a12ca61..a69165b 100644
--- a/arch/avr32/mach-at32ap/at32ap7000.c
+++ b/arch/avr32/mach-at32ap/at32ap7000.c
@@ -13,6 +13,7 @@
 #include <linux/spi/spi.h>
 
 #include <asm/io.h>
+#include <asm/irq.h>
 
 #include <asm/arch/at32ap7000.h>
 #include <asm/arch/board.h>
@@ -21,6 +22,7 @@
 #include <video/atmel_lcdc.h>
 
 #include "clock.h"
+#include "eic.h"
 #include "hmatrix.h"
 #include "pio.h"
 #include "pm.h"
@@ -567,6 +569,29 @@ static struct resource dmaca0_resource[] = {
 DEFINE_DEV(dmaca, 0);
 DEV_CLK(hclk, dmaca0, hsb, 10);
 
+int nmi_enable(void)
+{
+	/* We know that phys==virt for internal devices */
+	void __iomem *regs = (void __iomem *)0xfff00100;
+
+	clk_enable(&at32_pm_pclk);
+	eic_writel(regs, NMIC, EIC_NMIC_ENABLE);
+	eic_readl(regs, NMIC);
+	clk_disable(&at32_pm_pclk);
+
+	return 0;
+}
+
+void nmi_disable(void)
+{
+	void __iomem *regs = (void __iomem *)0xfff00100;
+
+	clk_enable(&at32_pm_pclk);
+	eic_writel(regs, NMIC, 0);
+	eic_readl(regs, NMIC);
+	clk_disable(&at32_pm_pclk);
+}
+
 /* --------------------------------------------------------------------
  * HMATRIX
  * -------------------------------------------------------------------- */
diff --git a/include/asm-avr32/irq.h b/include/asm-avr32/irq.h
index 83e6549..9315724 100644
--- a/include/asm-avr32/irq.h
+++ b/include/asm-avr32/irq.h
@@ -11,4 +11,9 @@
 
 #define irq_canonicalize(i)	(i)
 
+#ifndef __ASSEMBLER__
+int nmi_enable(void);
+void nmi_disable(void);
+#endif
+
 #endif /* __ASM_AVR32_IOCTLS_H */
diff --git a/include/asm-avr32/kdebug.h b/include/asm-avr32/kdebug.h
index 7f54e2b..eebea1b 100644
--- a/include/asm-avr32/kdebug.h
+++ b/include/asm-avr32/kdebug.h
@@ -7,6 +7,7 @@
 enum die_val {
 	DIE_BREAKPOINT,
 	DIE_SSTEP,
+	DIE_NMI,
 };
 
 /*
-- 
1.5.3.2

