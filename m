From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 11/17] xtensa: move built-in PIC to drivers/irqchip
Date: Thu, 17 Oct 2013 02:42:22 +0400
Message-ID: <1381963348-29448-12-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:55037 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762052Ab3JPWnD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:03 -0400
Received: by mail-la0-f51.google.com with SMTP id hp15so1104539lab.24
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:01 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Extract xtensa built-in interrupt controller implementation from
xtensa/kernel/irq.c and move it to other irqchips, providing way to
instantiate it from the device tree.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/irq.h      |   7 ++
 arch/xtensa/kernel/irq.c           | 137 ++++++++-----------------------------
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-xtensa-pic.c   | 108 +++++++++++++++++++++++++++++
 include/linux/irqchip/xtensa-pic.h |  18 +++++
 5 files changed, 164 insertions(+), 107 deletions(-)
 create mode 100644 drivers/irqchip/irq-xtensa-pic.c
 create mode 100644 include/linux/irqchip/xtensa-pic.h

diff --git a/arch/xtensa/include/asm/irq.h b/arch/xtensa/include/asm/irq.h
index 4c0ccc9..16464f2 100644
--- a/arch/xtensa/include/asm/irq.h
+++ b/arch/xtensa/include/asm/irq.h
@@ -43,5 +43,12 @@ static __inline__ int irq_canonicalize(int irq)
 }
 
 struct irqaction;
+struct irq_domain;
+
+int xtensa_irq_domain_xlate(const u32 *intspec, unsigned int intsize,
+		unsigned long int_irq, unsigned long ext_irq,
+		unsigned long *out_hwirq, unsigned int *out_type);
+int xtensa_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw);
+unsigned xtensa_map_ext_irq(unsigned ext_irq);
 
 #endif	/* _XTENSA_IRQ_H */
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 6f4f974..ada1e48 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -18,28 +18,20 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel_stat.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/xtensa-pic.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 
 #include <asm/uaccess.h>
 #include <asm/platform.h>
 
-static unsigned int cached_irq_mask;
-
 atomic_t irq_err_count;
 
-static struct irq_domain *root_domain;
-
-/*
- * do_IRQ handles all normal device IRQ's (the special
- * SMP cross-CPU interrupts have their own specific
- * handlers).
- */
-
 asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	int irq = irq_find_mapping(root_domain, hwirq);
+	int irq = irq_find_mapping(NULL, hwirq);
 
 	if (hwirq >= NR_IRQS) {
 		printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
@@ -74,83 +66,57 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-static void xtensa_irq_mask(struct irq_data *d)
-{
-	cached_irq_mask &= ~(1 << d->hwirq);
-	set_sr (cached_irq_mask, intenable);
-}
-
-static void xtensa_irq_unmask(struct irq_data *d)
-{
-	cached_irq_mask |= 1 << d->hwirq;
-	set_sr (cached_irq_mask, intenable);
-}
-
-static void xtensa_irq_enable(struct irq_data *d)
-{
-	variant_irq_enable(d->hwirq);
-	xtensa_irq_unmask(d);
-}
-
-static void xtensa_irq_disable(struct irq_data *d)
-{
-	xtensa_irq_mask(d);
-	variant_irq_disable(d->hwirq);
-}
-
-static void xtensa_irq_ack(struct irq_data *d)
-{
-	set_sr(1 << d->hwirq, intclear);
-}
-
-static int xtensa_irq_retrigger(struct irq_data *d)
+int xtensa_irq_domain_xlate(const u32 *intspec, unsigned int intsize,
+		unsigned long int_irq, unsigned long ext_irq,
+		unsigned long *out_hwirq, unsigned int *out_type)
 {
-	set_sr(1 << d->hwirq, intset);
-	return 1;
+	if (WARN_ON(intsize < 1 || intsize > 2))
+		return -EINVAL;
+	if (intsize == 2 && intspec[1] == 1) {
+		int_irq = xtensa_map_ext_irq(ext_irq);
+		if (int_irq < XCHAL_NUM_INTERRUPTS)
+			*out_hwirq = int_irq;
+		else
+			return -EINVAL;
+	} else {
+		*out_hwirq = int_irq;
+	}
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
 }
 
-static struct irq_chip xtensa_irq_chip = {
-	.name		= "xtensa",
-	.irq_enable	= xtensa_irq_enable,
-	.irq_disable	= xtensa_irq_disable,
-	.irq_mask	= xtensa_irq_mask,
-	.irq_unmask	= xtensa_irq_unmask,
-	.irq_ack	= xtensa_irq_ack,
-	.irq_retrigger	= xtensa_irq_retrigger,
-};
-
-static int xtensa_irq_map(struct irq_domain *d, unsigned int irq,
+int xtensa_irq_map(struct irq_domain *d, unsigned int irq,
 		irq_hw_number_t hw)
 {
+	struct irq_chip *irq_chip = d->host_data;
 	u32 mask = 1 << hw;
 
 	if (mask & XCHAL_INTTYPE_MASK_SOFTWARE) {
-		irq_set_chip_and_handler_name(irq, &xtensa_irq_chip,
+		irq_set_chip_and_handler_name(irq, irq_chip,
 				handle_simple_irq, "level");
 		irq_set_status_flags(irq, IRQ_LEVEL);
 	} else if (mask & XCHAL_INTTYPE_MASK_EXTERN_EDGE) {
-		irq_set_chip_and_handler_name(irq, &xtensa_irq_chip,
+		irq_set_chip_and_handler_name(irq, irq_chip,
 				handle_edge_irq, "edge");
 		irq_clear_status_flags(irq, IRQ_LEVEL);
 	} else if (mask & XCHAL_INTTYPE_MASK_EXTERN_LEVEL) {
-		irq_set_chip_and_handler_name(irq, &xtensa_irq_chip,
+		irq_set_chip_and_handler_name(irq, irq_chip,
 				handle_level_irq, "level");
 		irq_set_status_flags(irq, IRQ_LEVEL);
 	} else if (mask & XCHAL_INTTYPE_MASK_TIMER) {
-		irq_set_chip_and_handler_name(irq, &xtensa_irq_chip,
-				handle_edge_irq, "edge");
+		irq_set_chip_and_handler_name(irq, irq_chip,
+				handle_percpu_irq, "timer");
 		irq_clear_status_flags(irq, IRQ_LEVEL);
 	} else {/* XCHAL_INTTYPE_MASK_WRITE_ERROR */
 		/* XCHAL_INTTYPE_MASK_NMI */
-
-		irq_set_chip_and_handler_name(irq, &xtensa_irq_chip,
+		irq_set_chip_and_handler_name(irq, irq_chip,
 				handle_level_irq, "level");
 		irq_set_status_flags(irq, IRQ_LEVEL);
 	}
 	return 0;
 }
 
-static unsigned map_ext_irq(unsigned ext_irq)
+unsigned xtensa_map_ext_irq(unsigned ext_irq)
 {
 	unsigned mask = XCHAL_INTTYPE_MASK_EXTERN_EDGE |
 		XCHAL_INTTYPE_MASK_EXTERN_LEVEL;
@@ -163,55 +129,12 @@ static unsigned map_ext_irq(unsigned ext_irq)
 	return XCHAL_NUM_INTERRUPTS;
 }
 
-/*
- * Device Tree IRQ specifier translation function which works with one or
- * two cell bindings. First cell value maps directly to the hwirq number.
- * Second cell if present specifies whether hwirq number is external (1) or
- * internal (0).
- */
-int xtensa_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-		const u32 *intspec, unsigned int intsize,
-		unsigned long *out_hwirq, unsigned int *out_type)
-{
-	if (WARN_ON(intsize < 1 || intsize > 2))
-		return -EINVAL;
-	if (intsize == 2 && intspec[1] == 1) {
-		unsigned int_irq = map_ext_irq(intspec[0]);
-		if (int_irq < XCHAL_NUM_INTERRUPTS)
-			*out_hwirq = int_irq;
-		else
-			return -EINVAL;
-	} else {
-		*out_hwirq = intspec[0];
-	}
-	*out_type = IRQ_TYPE_NONE;
-	return 0;
-}
-
-static const struct irq_domain_ops xtensa_irq_domain_ops = {
-	.xlate = xtensa_irq_domain_xlate,
-	.map = xtensa_irq_map,
-};
-
 void __init init_IRQ(void)
 {
-	struct device_node *intc = NULL;
-
-	cached_irq_mask = 0;
-	set_sr(~0, intclear);
-
 #ifdef CONFIG_OF
-	/* The interrupt controller device node is mandatory */
-	intc = of_find_compatible_node(NULL, NULL, "xtensa,pic");
-	BUG_ON(!intc);
-
-	root_domain = irq_domain_add_linear(intc, NR_IRQS,
-			&xtensa_irq_domain_ops, NULL);
+	irqchip_init();
 #else
-	root_domain = irq_domain_add_legacy(intc, NR_IRQS, 0, 0,
-			&xtensa_irq_domain_ops, NULL);
+	xtensa_pic_init_legacy(NULL);
 #endif
-	irq_set_default_host(root_domain);
-
 	variant_init_irq();
 }
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c60b901..c81a7f3 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
 obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
+obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
new file mode 100644
index 0000000..846d181
--- /dev/null
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -0,0 +1,108 @@
+/*
+ * Xtensa built-in interrupt controller
+ *
+ * Copyright (C) 2002 - 2013 Tensilica, Inc.
+ * Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Chris Zankel <chris@zankel.net>
+ * Kevin Chea
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+
+#include "irqchip.h"
+
+unsigned int cached_irq_mask;
+
+/*
+ * Device Tree IRQ specifier translation function which works with one or
+ * two cell bindings. First cell value maps directly to the hwirq number.
+ * Second cell if present specifies whether hwirq number is external (1) or
+ * internal (0).
+ */
+static int xtensa_pic_irq_domain_xlate(struct irq_domain *d,
+		struct device_node *ctrlr,
+		const u32 *intspec, unsigned int intsize,
+		unsigned long *out_hwirq, unsigned int *out_type)
+{
+	return xtensa_irq_domain_xlate(intspec, intsize,
+			intspec[0], intspec[0],
+			out_hwirq, out_type);
+}
+
+static const struct irq_domain_ops xtensa_irq_domain_ops = {
+	.xlate = xtensa_pic_irq_domain_xlate,
+	.map = xtensa_irq_map,
+};
+
+static void xtensa_irq_mask(struct irq_data *d)
+{
+	cached_irq_mask &= ~(1 << d->hwirq);
+	set_sr(cached_irq_mask, intenable);
+}
+
+static void xtensa_irq_unmask(struct irq_data *d)
+{
+	cached_irq_mask |= 1 << d->hwirq;
+	set_sr(cached_irq_mask, intenable);
+}
+
+static void xtensa_irq_enable(struct irq_data *d)
+{
+	variant_irq_enable(d->hwirq);
+	xtensa_irq_unmask(d);
+}
+
+static void xtensa_irq_disable(struct irq_data *d)
+{
+	xtensa_irq_mask(d);
+	variant_irq_disable(d->hwirq);
+}
+
+static void xtensa_irq_ack(struct irq_data *d)
+{
+	set_sr(1 << d->hwirq, intclear);
+}
+
+static int xtensa_irq_retrigger(struct irq_data *d)
+{
+	set_sr(1 << d->hwirq, intset);
+	return 1;
+}
+
+static struct irq_chip xtensa_irq_chip = {
+	.name		= "xtensa",
+	.irq_enable	= xtensa_irq_enable,
+	.irq_disable	= xtensa_irq_disable,
+	.irq_mask	= xtensa_irq_mask,
+	.irq_unmask	= xtensa_irq_unmask,
+	.irq_ack	= xtensa_irq_ack,
+	.irq_retrigger	= xtensa_irq_retrigger,
+};
+
+int __init xtensa_pic_init_legacy(struct device_node *interrupt_parent)
+{
+	struct irq_domain *root_domain =
+		irq_domain_add_legacy(NULL, NR_IRQS, 0, 0,
+				&xtensa_irq_domain_ops, &xtensa_irq_chip);
+	irq_set_default_host(root_domain);
+	return 0;
+}
+
+static int __init xtensa_pic_init(struct device_node *np,
+		struct device_node *interrupt_parent)
+{
+	struct irq_domain *root_domain =
+		irq_domain_add_linear(np, NR_IRQS, &xtensa_irq_domain_ops,
+				&xtensa_irq_chip);
+	irq_set_default_host(root_domain);
+	return 0;
+}
+IRQCHIP_DECLARE(xtensa_irq_chip, "xtensa,pic", xtensa_pic_init);
diff --git a/include/linux/irqchip/xtensa-pic.h b/include/linux/irqchip/xtensa-pic.h
new file mode 100644
index 0000000..48718ae
--- /dev/null
+++ b/include/linux/irqchip/xtensa-pic.h
@@ -0,0 +1,18 @@
+/*
+ * Xtensa built-in interrupt controller
+ *
+ * Copyright (C) 2002 - 2013 Tensilica, Inc.
+ * Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __LINUX_IRQCHIP_XTENSA_PIC_H
+#define __LINUX_IRQCHIP_XTENSA_PIC_H
+
+struct device_node;
+int xtensa_pic_init_legacy(struct device_node *interrupt_parent);
+
+#endif /* __LINUX_IRQCHIP_XTENSA_PIC_H */
-- 
1.8.1.4
