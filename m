From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 19/19] ARC: intc: split into ARCompact ISA specific, common bits
Date: Sun, 7 Jun 2015 14:08:23 +0530
Message-ID: <1433666303-26112-20-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37843 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932897AbbFGIke (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:40:34 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-compact.h    |   1 +
 arch/arc/include/asm/irqflags-compact.h | 181 +++++++++++++++++++++++++
 arch/arc/include/asm/irqflags.h         | 168 +----------------------
 arch/arc/kernel/Makefile                |   2 +-
 arch/arc/kernel/intc-compact.c          | 230 ++++++++++++++++++++++++++++++++
 arch/arc/kernel/irq.c                   | 210 -----------------------------
 arch/arc/kernel/process.c               |   3 +-
 7 files changed, 416 insertions(+), 379 deletions(-)
 create mode 100644 arch/arc/include/asm/irqflags-compact.h
 create mode 100644 arch/arc/kernel/intc-compact.c

diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 8d0dd4d1001c..a54081cf0c86 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -33,6 +33,7 @@
 #define __ASM_ARC_ENTRY_COMPACT_H
 
 #include <asm/asm-offsets.h>
+#include <asm/irqflags-compact.h>
 #include <asm/thread_info.h>	/* For THREAD_SIZE */
 
 /*--------------------------------------------------------------
diff --git a/arch/arc/include/asm/irqflags-compact.h b/arch/arc/include/asm/irqflags-compact.h
new file mode 100644
index 000000000000..bdb854840f10
--- /dev/null
+++ b/arch/arc/include/asm/irqflags-compact.h
@@ -0,0 +1,181 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_IRQFLAGS_ARCOMPACT_H
+#define __ASM_IRQFLAGS_ARCOMPACT_H
+
+/* vineetg: March 2010 : local_irq_save( ) optimisation
+ *  -Remove explicit mov of current status32 into reg, that is not needed
+ *  -Use BIC  insn instead of INVERTED + AND
+ *  -Conditionally disable interrupts (if they are not enabled, don't disable)
+*/
+
+#include <asm/arcregs.h>
+
+/* status32 Reg bits related to Interrupt Handling */
+#define STATUS_E1_BIT		1	/* Int 1 enable */
+#define STATUS_E2_BIT		2	/* Int 2 enable */
+#define STATUS_A1_BIT		3	/* Int 1 active */
+#define STATUS_A2_BIT		4	/* Int 2 active */
+
+#define STATUS_E1_MASK		(1<<STATUS_E1_BIT)
+#define STATUS_E2_MASK		(1<<STATUS_E2_BIT)
+#define STATUS_A1_MASK		(1<<STATUS_A1_BIT)
+#define STATUS_A2_MASK		(1<<STATUS_A2_BIT)
+#define STATUS_IE_MASK		(STATUS_E1_MASK | STATUS_E2_MASK)
+
+/* Other Interrupt Handling related Aux regs */
+#define AUX_IRQ_LEV		0x200	/* IRQ Priority: L1 or L2 */
+#define AUX_IRQ_HINT		0x201	/* For generating Soft Interrupts */
+#define AUX_IRQ_LV12		0x43	/* interrupt level register */
+
+#define AUX_IENABLE		0x40c
+#define AUX_ITRIGGER		0x40d
+#define AUX_IPULSE		0x415
+
+#ifndef __ASSEMBLY__
+
+/******************************************************************
+ * IRQ Control Macros
+ *
+ * All of them have "memory" clobber (compiler barrier) which is needed to
+ * ensure that LD/ST requiring irq safetly (R-M-W when LLSC is not available)
+ * are redone after IRQs are re-enabled (and gcc doesn't reuse stale register)
+ *
+ * Noted at the time of Abilis Timer List corruption
+ * 	Orig Bug + Rejected solution	: https://lkml.org/lkml/2013/3/29/67
+ * 	Reasoning			: https://lkml.org/lkml/2013/4/8/15
+ *
+ ******************************************************************/
+
+/*
+ * Save IRQ state and disable IRQs
+ */
+static inline long arch_local_irq_save(void)
+{
+	unsigned long temp, flags;
+
+	__asm__ __volatile__(
+	"	lr  %1, [status32]	\n"
+	"	bic %0, %1, %2		\n"
+	"	and.f 0, %1, %2	\n"
+	"	flag.nz %0		\n"
+	: "=r"(temp), "=r"(flags)
+	: "n"((STATUS_E1_MASK | STATUS_E2_MASK))
+	: "memory", "cc");
+
+	return flags;
+}
+
+/*
+ * restore saved IRQ state
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+
+	__asm__ __volatile__(
+	"	flag %0			\n"
+	:
+	: "r"(flags)
+	: "memory");
+}
+
+/*
+ * Unconditionally Enable IRQs
+ */
+extern void arch_local_irq_enable(void);
+
+/*
+ * Unconditionally Disable IRQs
+ */
+static inline void arch_local_irq_disable(void)
+{
+	unsigned long temp;
+
+	__asm__ __volatile__(
+	"	lr  %0, [status32]	\n"
+	"	and %0, %0, %1		\n"
+	"	flag %0			\n"
+	: "=&r"(temp)
+	: "n"(~(STATUS_E1_MASK | STATUS_E2_MASK))
+	: "memory");
+}
+
+/*
+ * save IRQ state
+ */
+static inline long arch_local_save_flags(void)
+{
+	unsigned long temp;
+
+	__asm__ __volatile__(
+	"	lr  %0, [status32]	\n"
+	: "=&r"(temp)
+	:
+	: "memory");
+
+	return temp;
+}
+
+/*
+ * Query IRQ state
+ */
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (STATUS_E1_MASK
+#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
+			| STATUS_E2_MASK
+#endif
+		));
+}
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+#else
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+
+.macro TRACE_ASM_IRQ_DISABLE
+	bl	trace_hardirqs_off
+.endm
+
+.macro TRACE_ASM_IRQ_ENABLE
+	bl	trace_hardirqs_on
+.endm
+
+#else
+
+.macro TRACE_ASM_IRQ_DISABLE
+.endm
+
+.macro TRACE_ASM_IRQ_ENABLE
+.endm
+
+#endif
+
+.macro IRQ_DISABLE  scratch
+	lr	\scratch, [status32]
+	bic	\scratch, \scratch, (STATUS_E1_MASK | STATUS_E2_MASK)
+	flag	\scratch
+	TRACE_ASM_IRQ_DISABLE
+.endm
+
+.macro IRQ_ENABLE  scratch
+	lr	\scratch, [status32]
+	or	\scratch, \scratch, (STATUS_E1_MASK | STATUS_E2_MASK)
+	flag	\scratch
+	TRACE_ASM_IRQ_ENABLE
+.endm
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arc/include/asm/irqflags.h b/arch/arc/include/asm/irqflags.h
index 27ecc6975a58..333972600680 100644
--- a/arch/arc/include/asm/irqflags.h
+++ b/arch/arc/include/asm/irqflags.h
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  *
  * This program is free software; you can redistribute it and/or modify
@@ -9,171 +10,6 @@
 #ifndef __ASM_ARC_IRQFLAGS_H
 #define __ASM_ARC_IRQFLAGS_H
 
-/* vineetg: March 2010 : local_irq_save( ) optimisation
- *  -Remove explicit mov of current status32 into reg, that is not needed
- *  -Use BIC  insn instead of INVERTED + AND
- *  -Conditionally disable interrupts (if they are not enabled, don't disable)
-*/
-
-#include <asm/arcregs.h>
-
-/* status32 Reg bits related to Interrupt Handling */
-#define STATUS_E1_BIT		1	/* Int 1 enable */
-#define STATUS_E2_BIT		2	/* Int 2 enable */
-#define STATUS_A1_BIT		3	/* Int 1 active */
-#define STATUS_A2_BIT		4	/* Int 2 active */
-
-#define STATUS_E1_MASK		(1<<STATUS_E1_BIT)
-#define STATUS_E2_MASK		(1<<STATUS_E2_BIT)
-#define STATUS_A1_MASK		(1<<STATUS_A1_BIT)
-#define STATUS_A2_MASK		(1<<STATUS_A2_BIT)
-
-/* Other Interrupt Handling related Aux regs */
-#define AUX_IRQ_LEV		0x200	/* IRQ Priority: L1 or L2 */
-#define AUX_IRQ_HINT		0x201	/* For generating Soft Interrupts */
-#define AUX_IRQ_LV12		0x43	/* interrupt level register */
-
-#define AUX_IENABLE		0x40c
-#define AUX_ITRIGGER		0x40d
-#define AUX_IPULSE		0x415
-
-#ifndef __ASSEMBLY__
-
-/******************************************************************
- * IRQ Control Macros
- *
- * All of them have "memory" clobber (compiler barrier) which is needed to
- * ensure that LD/ST requiring irq safetly (R-M-W when LLSC is not available)
- * are redone after IRQs are re-enabled (and gcc doesn't reuse stale register)
- *
- * Noted at the time of Abilis Timer List corruption
- * 	Orig Bug + Rejected solution	: https://lkml.org/lkml/2013/3/29/67
- * 	Reasoning			: https://lkml.org/lkml/2013/4/8/15
- *
- ******************************************************************/
-
-/*
- * Save IRQ state and disable IRQs
- */
-static inline long arch_local_irq_save(void)
-{
-	unsigned long temp, flags;
-
-	__asm__ __volatile__(
-	"	lr  %1, [status32]	\n"
-	"	bic %0, %1, %2		\n"
-	"	and.f 0, %1, %2	\n"
-	"	flag.nz %0		\n"
-	: "=r"(temp), "=r"(flags)
-	: "n"((STATUS_E1_MASK | STATUS_E2_MASK))
-	: "memory", "cc");
-
-	return flags;
-}
-
-/*
- * restore saved IRQ state
- */
-static inline void arch_local_irq_restore(unsigned long flags)
-{
-
-	__asm__ __volatile__(
-	"	flag %0			\n"
-	:
-	: "r"(flags)
-	: "memory");
-}
-
-/*
- * Unconditionally Enable IRQs
- */
-extern void arch_local_irq_enable(void);
-
-/*
- * Unconditionally Disable IRQs
- */
-static inline void arch_local_irq_disable(void)
-{
-	unsigned long temp;
-
-	__asm__ __volatile__(
-	"	lr  %0, [status32]	\n"
-	"	and %0, %0, %1		\n"
-	"	flag %0			\n"
-	: "=&r"(temp)
-	: "n"(~(STATUS_E1_MASK | STATUS_E2_MASK))
-	: "memory");
-}
-
-/*
- * save IRQ state
- */
-static inline long arch_local_save_flags(void)
-{
-	unsigned long temp;
-
-	__asm__ __volatile__(
-	"	lr  %0, [status32]	\n"
-	: "=&r"(temp)
-	:
-	: "memory");
-
-	return temp;
-}
-
-/*
- * Query IRQ state
- */
-static inline int arch_irqs_disabled_flags(unsigned long flags)
-{
-	return !(flags & (STATUS_E1_MASK
-#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
-			| STATUS_E2_MASK
-#endif
-		));
-}
-
-static inline int arch_irqs_disabled(void)
-{
-	return arch_irqs_disabled_flags(arch_local_save_flags());
-}
-
-#else
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-
-.macro TRACE_ASM_IRQ_DISABLE
-	bl	trace_hardirqs_off
-.endm
-
-.macro TRACE_ASM_IRQ_ENABLE
-	bl	trace_hardirqs_on
-.endm
-
-#else
-
-.macro TRACE_ASM_IRQ_DISABLE
-.endm
-
-.macro TRACE_ASM_IRQ_ENABLE
-.endm
-
-#endif
-
-.macro IRQ_DISABLE  scratch
-	lr	\scratch, [status32]
-	bic	\scratch, \scratch, (STATUS_E1_MASK | STATUS_E2_MASK)
-	flag	\scratch
-	TRACE_ASM_IRQ_DISABLE
-.endm
-
-.macro IRQ_ENABLE  scratch
-	lr	\scratch, [status32]
-	or	\scratch, \scratch, (STATUS_E1_MASK | STATUS_E2_MASK)
-	flag	\scratch
-	TRACE_ASM_IRQ_ENABLE
-.endm
-
-#endif	/* __ASSEMBLY__ */
+#include <asm/irqflags-compact.h>
 
 #endif
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 024a63e90b72..cc929c0e2133 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -10,7 +10,7 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 obj-y	:= arcksyms.o setup.o irq.o time.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o clk.o
-obj-y	+= entry-compact.o
+obj-y	+= entry-compact.o intc-compact.o
 
 obj-$(CONFIG_MODULES)			+= arcksyms.o module.o
 obj-$(CONFIG_SMP) 			+= smp.o
diff --git a/arch/arc/kernel/intc-compact.c b/arch/arc/kernel/intc-compact.c
new file mode 100644
index 000000000000..0ab1734d3b88
--- /dev/null
+++ b/arch/arc/kernel/intc-compact.c
@@ -0,0 +1,230 @@
+/*
+ * Copyright (C) 2011-12 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include "../../drivers/irqchip/irqchip.h"
+#include <asm/irq.h>
+
+/*
+ * Early Hardware specific Interrupt setup
+ * -Platform independent, needed for each CPU (not foldable into init_IRQ)
+ * -Called very early (start_kernel -> setup_arch -> setup_processor)
+ *
+ * what it does ?
+ * -Optionally, setup the High priority Interrupts as Level 2 IRQs
+ */
+void arc_init_IRQ(void)
+{
+	int level_mask = 0;
+
+       /* setup any high priority Interrupts (Level2 in ARCompact jargon) */
+	level_mask |= IS_ENABLED(CONFIG_ARC_IRQ3_LV2) << 3;
+	level_mask |= IS_ENABLED(CONFIG_ARC_IRQ5_LV2) << 5;
+	level_mask |= IS_ENABLED(CONFIG_ARC_IRQ6_LV2) << 6;
+
+	/*
+	 * Write to register, even if no LV2 IRQs configured to reset it
+	 * in case bootloader had mucked with it
+	 */
+	write_aux_reg(AUX_IRQ_LEV, level_mask);
+
+	if (level_mask)
+		pr_info("Level-2 interrupts bitset %x\n", level_mask);
+}
+
+/*
+ * ARC700 core includes a simple on-chip intc supporting
+ * -per IRQ enable/disable
+ * -2 levels of interrupts (high/low)
+ * -all interrupts being level triggered
+ *
+ * To reduce platform code, we assume all IRQs directly hooked-up into intc.
+ * Platforms with external intc, hence cascaded IRQs, are free to over-ride
+ * below, per IRQ.
+ */
+
+static void arc_irq_mask(struct irq_data *data)
+{
+	unsigned int ienb;
+
+	ienb = read_aux_reg(AUX_IENABLE);
+	ienb &= ~(1 << data->irq);
+	write_aux_reg(AUX_IENABLE, ienb);
+}
+
+static void arc_irq_unmask(struct irq_data *data)
+{
+	unsigned int ienb;
+
+	ienb = read_aux_reg(AUX_IENABLE);
+	ienb |= (1 << data->irq);
+	write_aux_reg(AUX_IENABLE, ienb);
+}
+
+static struct irq_chip onchip_intc = {
+	.name           = "ARC In-core Intc",
+	.irq_mask	= arc_irq_mask,
+	.irq_unmask	= arc_irq_unmask,
+};
+
+static int arc_intc_domain_map(struct irq_domain *d, unsigned int irq,
+			       irq_hw_number_t hw)
+{
+	/* For percpu devices, more efficient handler can be used */
+	//desc = irq_to_desc(irq);
+	//if (irqd_is_per_cpu(&desc->irq_data) &&
+
+	/*
+	 * XXX: the IPI IRQ needs to be handled like TIMER too. However ARC core
+	 *      code doesn't own it (like TIMER0). ISS IDU / ezchip define it
+	 *      in platform header which can't be included here as it goes
+	 *      against multi-platform image philisophy
+	 */
+	if (irq == TIMER0_IRQ)
+		irq_set_chip_and_handler(irq, &onchip_intc, handle_percpu_irq);
+	else
+		irq_set_chip_and_handler(irq, &onchip_intc, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops arc_intc_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = arc_intc_domain_map,
+};
+
+static struct irq_domain *root_domain;
+
+static int __init
+init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
+{
+	if (parent)
+		panic("DeviceTree incore intc not a root irq controller\n");
+
+	root_domain = irq_domain_add_legacy(intc, NR_CPU_IRQS, 0, 0,
+					    &arc_intc_domain_ops, NULL);
+
+	if (!root_domain)
+		panic("root irq domain not avail\n");
+
+	/* with this we don't need to export root_domain */
+	irq_set_default_host(root_domain);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(arc_intc, "snps,arc700-intc", init_onchip_IRQ);
+
+/*
+ * arch_local_irq_enable - Enable interrupts.
+ *
+ * 1. Explicitly called to re-enable interrupts
+ * 2. Implicitly called from spin_unlock_irq, write_unlock_irq etc
+ *    which maybe in hard ISR itself
+ *
+ * Semantics of this function change depending on where it is called from:
+ *
+ * -If called from hard-ISR, it must not invert interrupt priorities
+ *  e.g. suppose TIMER is high priority (Level 2) IRQ
+ *    Time hard-ISR, timer_interrupt( ) calls spin_unlock_irq several times.
+ *    Here local_irq_enable( ) shd not re-enable lower priority interrupts
+ * -If called from soft-ISR, it must re-enable all interrupts
+ *    soft ISR are low prioity jobs which can be very slow, thus all IRQs
+ *    must be enabled while they run.
+ *    Now hardware context wise we may still be in L2 ISR (not done rtie)
+ *    still we must re-enable both L1 and L2 IRQs
+ *  Another twist is prev scenario with flow being
+ *     L1 ISR ==> interrupted by L2 ISR  ==> L2 soft ISR
+ *     here we must not re-enable Ll as prev Ll Interrupt's h/w context will get
+ *     over-written (this is deficiency in ARC700 Interrupt mechanism)
+ */
+
+#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS	/* Complex version for 2 IRQ levels */
+
+void arch_local_irq_enable(void)
+{
+
+	unsigned long flags;
+	flags = arch_local_save_flags();
+
+	/* Allow both L1 and L2 at the onset */
+	flags |= (STATUS_E1_MASK | STATUS_E2_MASK);
+
+	/* Called from hard ISR (between irq_enter and irq_exit) */
+	if (in_irq()) {
+
+		/* If in L2 ISR, don't re-enable any further IRQs as this can
+		 * cause IRQ priorities to get upside down. e.g. it could allow
+		 * L1 be taken while in L2 hard ISR which is wrong not only in
+		 * theory, it can also cause the dreaded L1-L2-L1 scenario
+		 */
+		if (flags & STATUS_A2_MASK)
+			flags &= ~(STATUS_E1_MASK | STATUS_E2_MASK);
+
+		/* Even if in L1 ISR, allowe Higher prio L2 IRQs */
+		else if (flags & STATUS_A1_MASK)
+			flags &= ~(STATUS_E1_MASK);
+	}
+
+	/* called from soft IRQ, ideally we want to re-enable all levels */
+
+	else if (in_softirq()) {
+
+		/* However if this is case of L1 interrupted by L2,
+		 * re-enabling both may cause whaco L1-L2-L1 scenario
+		 * because ARC700 allows level 1 to interrupt an active L2 ISR
+		 * Thus we disable both
+		 * However some code, executing in soft ISR wants some IRQs
+		 * to be enabled so we re-enable L2 only
+		 *
+		 * How do we determine L1 intr by L2
+		 *  -A2 is set (means in L2 ISR)
+		 *  -E1 is set in this ISR's pt_regs->status32 which is
+		 *      saved copy of status32_l2 when l2 ISR happened
+		 */
+		struct pt_regs *pt = get_irq_regs();
+		if ((flags & STATUS_A2_MASK) && pt &&
+		    (pt->status32 & STATUS_A1_MASK)) {
+			/*flags &= ~(STATUS_E1_MASK | STATUS_E2_MASK); */
+			flags &= ~(STATUS_E1_MASK);
+		}
+	}
+
+	arch_local_irq_restore(flags);
+}
+
+#else /* ! CONFIG_ARC_COMPACT_IRQ_LEVELS */
+
+/*
+ * Simpler version for only 1 level of interrupt
+ * Here we only Worry about Level 1 Bits
+ */
+void arch_local_irq_enable(void)
+{
+	unsigned long flags;
+
+	/*
+	 * ARC IDE Drivers tries to re-enable interrupts from hard-isr
+	 * context which is simply wrong
+	 */
+	if (in_irq()) {
+		WARN_ONCE(1, "IRQ enabled from hard-isr");
+		return;
+	}
+
+	flags = arch_local_save_flags();
+	flags |= (STATUS_E1_MASK | STATUS_E2_MASK);
+	arch_local_irq_restore(flags);
+}
+#endif
+EXPORT_SYMBOL(arch_local_irq_enable);
diff --git a/arch/arc/kernel/irq.c b/arch/arc/kernel/irq.c
index 620ec2fe32a9..2989a7bcf8a8 100644
--- a/arch/arc/kernel/irq.c
+++ b/arch/arc/kernel/irq.c
@@ -8,116 +8,10 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/irqdomain.h>
 #include <linux/irqchip.h>
-#include "../../drivers/irqchip/irqchip.h"
-#include <asm/sections.h>
-#include <asm/irq.h>
 #include <asm/mach_desc.h>
 
 /*
- * Early Hardware specific Interrupt setup
- * -Platform independent, needed for each CPU (not foldable into init_IRQ)
- * -Called very early (start_kernel -> setup_arch -> setup_processor)
- *
- * what it does ?
- * -Optionally, setup the High priority Interrupts as Level 2 IRQs
- */
-void arc_init_IRQ(void)
-{
-	int level_mask = 0;
-
-       /* setup any high priority Interrupts (Level2 in ARCompact jargon) */
-	level_mask |= IS_ENABLED(CONFIG_ARC_IRQ3_LV2) << 3;
-	level_mask |= IS_ENABLED(CONFIG_ARC_IRQ5_LV2) << 5;
-	level_mask |= IS_ENABLED(CONFIG_ARC_IRQ6_LV2) << 6;
-
-	/*
-	 * Write to register, even if no LV2 IRQs configured to reset it
-	 * in case bootloader had mucked with it
-	 */
-	write_aux_reg(AUX_IRQ_LEV, level_mask);
-
-	if (level_mask)
-		pr_info("Level-2 interrupts bitset %x\n", level_mask);
-}
-
-/*
- * ARC700 core includes a simple on-chip intc supporting
- * -per IRQ enable/disable
- * -2 levels of interrupts (high/low)
- * -all interrupts being level triggered
- *
- * To reduce platform code, we assume all IRQs directly hooked-up into intc.
- * Platforms with external intc, hence cascaded IRQs, are free to over-ride
- * below, per IRQ.
- */
-
-static void arc_irq_mask(struct irq_data *data)
-{
-	unsigned int ienb;
-
-	ienb = read_aux_reg(AUX_IENABLE);
-	ienb &= ~(1 << data->irq);
-	write_aux_reg(AUX_IENABLE, ienb);
-}
-
-static void arc_irq_unmask(struct irq_data *data)
-{
-	unsigned int ienb;
-
-	ienb = read_aux_reg(AUX_IENABLE);
-	ienb |= (1 << data->irq);
-	write_aux_reg(AUX_IENABLE, ienb);
-}
-
-static struct irq_chip onchip_intc = {
-	.name           = "ARC In-core Intc",
-	.irq_mask	= arc_irq_mask,
-	.irq_unmask	= arc_irq_unmask,
-};
-
-static int arc_intc_domain_map(struct irq_domain *d, unsigned int irq,
-				irq_hw_number_t hw)
-{
-	if (irq == TIMER0_IRQ)
-		irq_set_chip_and_handler(irq, &onchip_intc, handle_percpu_irq);
-	else
-		irq_set_chip_and_handler(irq, &onchip_intc, handle_level_irq);
-
-	return 0;
-}
-
-static const struct irq_domain_ops arc_intc_domain_ops = {
-	.xlate = irq_domain_xlate_onecell,
-	.map = arc_intc_domain_map,
-};
-
-static struct irq_domain *root_domain;
-
-static int __init
-init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
-{
-	if (parent)
-		panic("DeviceTree incore intc not a root irq controller\n");
-
-	root_domain = irq_domain_add_legacy(intc, NR_CPU_IRQS, 0, 0,
-					    &arc_intc_domain_ops, NULL);
-
-	if (!root_domain)
-		panic("root irq domain not avail\n");
-
-	/* with this we don't need to export root_domain */
-	irq_set_default_host(root_domain);
-
-	return 0;
-}
-
-IRQCHIP_DECLARE(arc_intc, "snps,arc700-intc", init_onchip_IRQ);
-
-/*
  * Late Interrupt system init called from start_kernel for Boot CPU only
  *
  * Since slab must already be initialized, platforms can start doing any
@@ -178,107 +72,3 @@ void arc_request_percpu_irq(int irq, int cpu,
 
 	enable_percpu_irq(irq, 0);
 }
-
-/*
- * arch_local_irq_enable - Enable interrupts.
- *
- * 1. Explicitly called to re-enable interrupts
- * 2. Implicitly called from spin_unlock_irq, write_unlock_irq etc
- *    which maybe in hard ISR itself
- *
- * Semantics of this function change depending on where it is called from:
- *
- * -If called from hard-ISR, it must not invert interrupt priorities
- *  e.g. suppose TIMER is high priority (Level 2) IRQ
- *    Time hard-ISR, timer_interrupt( ) calls spin_unlock_irq several times.
- *    Here local_irq_enable( ) shd not re-enable lower priority interrupts
- * -If called from soft-ISR, it must re-enable all interrupts
- *    soft ISR are low prioity jobs which can be very slow, thus all IRQs
- *    must be enabled while they run.
- *    Now hardware context wise we may still be in L2 ISR (not done rtie)
- *    still we must re-enable both L1 and L2 IRQs
- *  Another twist is prev scenario with flow being
- *     L1 ISR ==> interrupted by L2 ISR  ==> L2 soft ISR
- *     here we must not re-enable Ll as prev Ll Interrupt's h/w context will get
- *     over-written (this is deficiency in ARC700 Interrupt mechanism)
- */
-
-#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS	/* Complex version for 2 IRQ levels */
-
-void arch_local_irq_enable(void)
-{
-
-	unsigned long flags;
-	flags = arch_local_save_flags();
-
-	/* Allow both L1 and L2 at the onset */
-	flags |= (STATUS_E1_MASK | STATUS_E2_MASK);
-
-	/* Called from hard ISR (between irq_enter and irq_exit) */
-	if (in_irq()) {
-
-		/* If in L2 ISR, don't re-enable any further IRQs as this can
-		 * cause IRQ priorities to get upside down. e.g. it could allow
-		 * L1 be taken while in L2 hard ISR which is wrong not only in
-		 * theory, it can also cause the dreaded L1-L2-L1 scenario
-		 */
-		if (flags & STATUS_A2_MASK)
-			flags &= ~(STATUS_E1_MASK | STATUS_E2_MASK);
-
-		/* Even if in L1 ISR, allowe Higher prio L2 IRQs */
-		else if (flags & STATUS_A1_MASK)
-			flags &= ~(STATUS_E1_MASK);
-	}
-
-	/* called from soft IRQ, ideally we want to re-enable all levels */
-
-	else if (in_softirq()) {
-
-		/* However if this is case of L1 interrupted by L2,
-		 * re-enabling both may cause whaco L1-L2-L1 scenario
-		 * because ARC700 allows level 1 to interrupt an active L2 ISR
-		 * Thus we disable both
-		 * However some code, executing in soft ISR wants some IRQs
-		 * to be enabled so we re-enable L2 only
-		 *
-		 * How do we determine L1 intr by L2
-		 *  -A2 is set (means in L2 ISR)
-		 *  -E1 is set in this ISR's pt_regs->status32 which is
-		 *      saved copy of status32_l2 when l2 ISR happened
-		 */
-		struct pt_regs *pt = get_irq_regs();
-		if ((flags & STATUS_A2_MASK) && pt &&
-		    (pt->status32 & STATUS_A1_MASK)) {
-			/*flags &= ~(STATUS_E1_MASK | STATUS_E2_MASK); */
-			flags &= ~(STATUS_E1_MASK);
-		}
-	}
-
-	arch_local_irq_restore(flags);
-}
-
-#else /* ! CONFIG_ARC_COMPACT_IRQ_LEVELS */
-
-/*
- * Simpler version for only 1 level of interrupt
- * Here we only Worry about Level 1 Bits
- */
-void arch_local_irq_enable(void)
-{
-	unsigned long flags;
-
-	/*
-	 * ARC IDE Drivers tries to re-enable interrupts from hard-isr
-	 * context which is simply wrong
-	 */
-	if (in_irq()) {
-		WARN_ONCE(1, "IRQ enabled from hard-isr");
-		return;
-	}
-
-	flags = arch_local_save_flags();
-	flags |= (STATUS_E1_MASK | STATUS_E2_MASK);
-	arch_local_irq_restore(flags);
-}
-#endif
-EXPORT_SYMBOL(arch_local_irq_enable);
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index e095c557afdd..b5426babd3c8 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -166,8 +166,7 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long usp)
 	 * [L] ZOL loop inhibited to begin with - cleared by a LP insn
 	 * Interrupts enabled
 	 */
-	regs->status32 = STATUS_U_MASK | STATUS_L_MASK |
-			 STATUS_E1_MASK | STATUS_E2_MASK;
+	regs->status32 = STATUS_U_MASK | STATUS_L_MASK | STATUS_IE_MASK;
 
 	/* bogus seed values for debugging */
 	regs->lp_start = 0x10;
-- 
1.9.1
