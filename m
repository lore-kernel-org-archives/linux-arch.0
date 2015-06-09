From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 01/28] ARCv2: [intc] HS38 core interrupt controller
Date: Tue, 9 Jun 2015 17:18:01 +0530
Message-ID: <1433850508-26317-2-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33132 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753763AbbFILvi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:51:38 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 .../devicetree/bindings/arc/archs-intc.txt         |  22 ++++
 arch/arc/include/asm/irqflags-arcv2.h              | 116 +++++++++++++++++++
 arch/arc/kernel/intc-arcv2.c                       | 126 +++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-intc.txt
 create mode 100644 arch/arc/include/asm/irqflags-arcv2.h
 create mode 100644 arch/arc/kernel/intc-arcv2.c

diff --git a/Documentation/devicetree/bindings/arc/archs-intc.txt b/Documentation/devicetree/bindings/arc/archs-intc.txt
new file mode 100644
index 000000000000..69f326d6a5ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/arc/archs-intc.txt
@@ -0,0 +1,22 @@
+* ARC-HS incore Interrupt Controller (Provided by cores implementing ARCv2 ISA)
+
+Properties:
+
+- compatible: "snps,archs-intc"
+- interrupt-controller: This is an interrupt controller.
+- #interrupt-cells: Must be <1>.
+
+  Single Cell "interrupts" property of a device specifies the IRQ number
+  between 16 to 256
+
+  intc accessed via the special ARC AUX register interface, hence "reg" property
+  is not specified.
+
+Example:
+
+	intc: interrupt-controller {
+		compatible = "snps,archs-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <16 17 18 19 20 21 22 23 24 25>;
+	};
diff --git a/arch/arc/include/asm/irqflags-arcv2.h b/arch/arc/include/asm/irqflags-arcv2.h
new file mode 100644
index 000000000000..c946c56f141c
--- /dev/null
+++ b/arch/arc/include/asm/irqflags-arcv2.h
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_IRQFLAGS_ARCV2_H
+#define __ASM_IRQFLAGS_ARCV2_H
+
+#include <asm/arcregs.h>
+
+/* status32 Bits */
+#define STATUS_AD_BIT	19   /* Disable Align chk: core supports non-aligned */
+#define STATUS_IE_BIT	31
+
+#define STATUS_AD_MASK		(1<<STATUS_AD_BIT)
+#define STATUS_IE_MASK		(1<<STATUS_IE_BIT)
+
+#define AUX_USER_SP		0x00D
+#define AUX_IRQ_CTRL		0x00E
+#define AUX_IRQ_ACT		0x043	/* Active Intr across all levels */
+#define AUX_IRQ_LVL_PEND	0x200	/* Pending Intr across all levels */
+#define AUX_IRQ_PRIORITY	0x206
+#define ICAUSE			0x40a
+#define AUX_IRQ_SELECT		0x40b
+#define AUX_IRQ_ENABLE		0x40c
+
+/* 0 is highest level, but taken by FIRQs, if present in design */
+#define ARCV2_IRQ_DEF_PRIO		0
+
+/* seed value for status register */
+#define ISA_INIT_STATUS_BITS	(STATUS_IE_MASK | STATUS_AD_MASK | \
+					(ARCV2_IRQ_DEF_PRIO << 1))
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Save IRQ state and disable IRQs
+ */
+static inline long arch_local_irq_save(void)
+{
+	unsigned long flags;
+
+	__asm__ __volatile__("	clri %0	\n" : "=r" (flags) : : "memory");
+
+	return flags;
+}
+
+/*
+ * restore saved IRQ state
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	__asm__ __volatile__("	seti %0	\n" : : "r" (flags) : "memory");
+}
+
+/*
+ * Unconditionally Enable IRQs
+ */
+static inline void arch_local_irq_enable(void)
+{
+	__asm__ __volatile__("	seti	\n" : : : "memory");
+}
+
+/*
+ * Unconditionally Disable IRQs
+ */
+static inline void arch_local_irq_disable(void)
+{
+	__asm__ __volatile__("	clri	\n" : : : "memory");
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
+	return !(flags & (STATUS_IE_MASK));
+}
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+#else
+
+.macro IRQ_DISABLE  scratch
+	clri
+.endm
+
+.macro IRQ_ENABLE  scratch
+	seti
+.endm
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
new file mode 100644
index 000000000000..3876e11d4553
--- /dev/null
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2014 Synopsys, Inc. (www.synopsys.com)
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
+ * -Called very early (start_kernel -> setup_arch -> setup_processor)
+ * -Platform Independent (must for any ARC Core)
+ * -Needed for each CPU (hence not foldable into init_IRQ)
+ */
+void arc_init_IRQ(void)
+{
+	unsigned int tmp;
+
+	struct aux_irq_ctrl {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		unsigned int res3:18, save_idx_regs:1, res2:1,
+			     save_u_to_u:1, save_lp_regs:1, save_blink:1,
+			     res:4, save_nr_gpr_pairs:5;
+#else
+		unsigned int save_nr_gpr_pairs:5, res:4,
+			     save_blink:1, save_lp_regs:1, save_u_to_u:1,
+			     res2:1, save_idx_regs:1, res3:18;
+#endif
+	} ictrl;
+
+	*(unsigned int *)&ictrl = 0;
+
+	ictrl.save_nr_gpr_pairs = 6;	/* r0 to r11 (r12 saved manually) */
+	ictrl.save_blink = 1;
+	ictrl.save_lp_regs = 1;		/* LP_COUNT, LP_START, LP_END */
+	ictrl.save_u_to_u = 0;		/* user ctxt saved on kernel stack */
+	ictrl.save_idx_regs = 1;	/* JLI, LDI, EI */
+
+	WRITE_AUX(AUX_IRQ_CTRL, ictrl);
+
+	/* setup status32, don't enable intr yet as kernel doesn't want */
+	tmp = read_aux_reg(0xa);
+	tmp |= ISA_INIT_STATUS_BITS;
+	tmp &= ~STATUS_IE_MASK;
+	asm volatile("flag %0	\n"::"r"(tmp));
+}
+
+static void arcv2_irq_mask(struct irq_data *data)
+{
+	write_aux_reg(AUX_IRQ_SELECT, data->irq);
+	write_aux_reg(AUX_IRQ_ENABLE, 0);
+}
+
+static void arcv2_irq_unmask(struct irq_data *data)
+{
+	write_aux_reg(AUX_IRQ_SELECT, data->irq);
+	write_aux_reg(AUX_IRQ_ENABLE, 1);
+}
+
+void arcv2_irq_enable(struct irq_data *data)
+{
+	/* set default priority */
+	write_aux_reg(AUX_IRQ_SELECT, data->irq);
+	write_aux_reg(AUX_IRQ_PRIORITY, ARCV2_IRQ_DEF_PRIO);
+
+	/*
+	 * hw auto enables (linux unmask) all by default
+	 * So no need to do IRQ_ENABLE here
+	 * XXX: However OSCI LAN need it
+	 */
+	write_aux_reg(AUX_IRQ_ENABLE, 1);
+}
+
+static struct irq_chip arcv2_irq_chip = {
+	.name           = "ARCv2 core Intc",
+	.irq_mask	= arcv2_irq_mask,
+	.irq_unmask	= arcv2_irq_unmask,
+	.irq_enable	= arcv2_irq_enable
+};
+
+static int arcv2_irq_map(struct irq_domain *d, unsigned int irq,
+			 irq_hw_number_t hw)
+{
+	if (irq == TIMER0_IRQ)
+		irq_set_chip_and_handler(irq, &arcv2_irq_chip, handle_percpu_irq);
+	else
+		irq_set_chip_and_handler(irq, &arcv2_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops arcv2_irq_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = arcv2_irq_map,
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
+					    &arcv2_irq_ops, NULL);
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
+IRQCHIP_DECLARE(arc_intc, "snps,archs-intc", init_onchip_IRQ);
-- 
1.9.1
