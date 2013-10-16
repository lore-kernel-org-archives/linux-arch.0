From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 14/17] xtensa: add MX irqchip
Date: Thu, 17 Oct 2013 02:42:25 +0400
Message-ID: <1381963348-29448-15-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:55787 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762101Ab3JPWnH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:07 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so1112702lab.5
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:05 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

MX is an interrupt distributor used in some SMP-capable xtensa
configurations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/irq.h       |   1 +
 arch/xtensa/include/asm/mxregs.h    |  46 ++++++++++
 arch/xtensa/include/asm/processor.h |  20 +++++
 arch/xtensa/kernel/irq.c            |   8 ++
 drivers/irqchip/Kconfig             |   4 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-xtensa-mx.c     | 166 ++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/xtensa-mx.h   |  17 ++++
 8 files changed, 263 insertions(+)
 create mode 100644 arch/xtensa/include/asm/mxregs.h
 create mode 100644 drivers/irqchip/irq-xtensa-mx.c
 create mode 100644 include/linux/irqchip/xtensa-mx.h

diff --git a/arch/xtensa/include/asm/irq.h b/arch/xtensa/include/asm/irq.h
index 16464f2..7d194d4 100644
--- a/arch/xtensa/include/asm/irq.h
+++ b/arch/xtensa/include/asm/irq.h
@@ -50,5 +50,6 @@ int xtensa_irq_domain_xlate(const u32 *intspec, unsigned int intsize,
 		unsigned long *out_hwirq, unsigned int *out_type);
 int xtensa_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw);
 unsigned xtensa_map_ext_irq(unsigned ext_irq);
+unsigned xtensa_get_ext_irq_no(unsigned irq);
 
 #endif	/* _XTENSA_IRQ_H */
diff --git a/arch/xtensa/include/asm/mxregs.h b/arch/xtensa/include/asm/mxregs.h
new file mode 100644
index 0000000..73dcc54
--- /dev/null
+++ b/arch/xtensa/include/asm/mxregs.h
@@ -0,0 +1,46 @@
+/*
+ * Xtensa MX interrupt distributor
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 - 2013 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_MXREGS_H
+#define _XTENSA_MXREGS_H
+
+/*
+ * RER/WER at, as	Read/write external register
+ *	at: value
+ *	as: address
+ *
+ * Address	Value
+ * 00nn		0...0p..p	Interrupt Routing, route IRQ n to processor p
+ * 01pp		0...0d..d	16 bits (d) 'ored' as single IPI to processor p
+ * 0180		0...0m..m	Clear enable specified by mask (m)
+ * 0184		0...0m..m	Set enable specified by mask (m)
+ * 0190		0...0x..x	8-bit IPI partition register
+ *				VVVVVVVVPPPPUUUUUUUUUUUUUUUUU
+ *				V (10-bit) Release/Version
+ *				P ( 4-bit) Number of cores - 1
+ *				U (18-bit) ID
+ * 01a0		i.......i	32-bit ConfigID
+ * 0200		0...0m..m	RunStall core 'n'
+ * 0220		c		Cache coherency enabled
+ */
+
+#define MIROUT(irq)	(0x000 + (irq))
+#define MIPICAUSE(cpu)	(0x100 + (cpu))
+#define MIPISET(cause)	(0x140 + (cause))
+#define MIENG		0x180
+#define MIENGSET	0x184
+#define MIASG		0x188	/* Read Global Assert Register */
+#define MIASGSET	0x18c	/* Set Global Addert Regiter */
+#define MIPIPART	0x190
+#define SYSCFGID	0x1a0
+#define MPSCORE		0x200
+#define CCON		0x220
+
+#endif /* _XTENSA_MXREGS_H */
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 7e409a5..abb5970 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -191,5 +191,25 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define set_sr(x,sr) ({unsigned int v=(unsigned int)x; WSR(v,sr);})
 #define get_sr(sr) ({unsigned int v; RSR(v,sr); v; })
 
+#ifndef XCHAL_HAVE_EXTERN_REGS
+#define XCHAL_HAVE_EXTERN_REGS 0
+#endif
+
+#if XCHAL_HAVE_EXTERN_REGS
+
+static inline void set_er(unsigned long value, unsigned long addr)
+{
+	asm volatile ("wer %0, %1" : : "a" (value), "a" (addr) : "memory");
+}
+
+static inline unsigned long get_er(unsigned long addr)
+{
+	register unsigned long value;
+	asm volatile ("rer %0, %1" : "=a" (value) : "a" (addr) : "memory");
+	return value;
+}
+
+#endif /* XCHAL_HAVE_EXTERN_REGS */
+
 #endif	/* __ASSEMBLY__ */
 #endif	/* _XTENSA_PROCESSOR_H */
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 3cef58e..7d49730 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -123,6 +123,14 @@ unsigned xtensa_map_ext_irq(unsigned ext_irq)
 	return XCHAL_NUM_INTERRUPTS;
 }
 
+unsigned xtensa_get_ext_irq_no(unsigned irq)
+{
+	unsigned mask = (XCHAL_INTTYPE_MASK_EXTERN_EDGE |
+		XCHAL_INTTYPE_MASK_EXTERN_LEVEL) &
+		((1u << irq) - 1);
+	return hweight32(mask);
+}
+
 void __init init_IRQ(void)
 {
 #ifdef CONFIG_OF
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3792a1a..07bc79c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -61,3 +61,7 @@ config VERSATILE_FPGA_IRQ_NR
        int
        default 4
        depends on VERSATILE_FPGA_IRQ
+
+config XTENSA_MX
+	bool
+	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c81a7f3..66913f9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
 obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
+obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
diff --git a/drivers/irqchip/irq-xtensa-mx.c b/drivers/irqchip/irq-xtensa-mx.c
new file mode 100644
index 0000000..86f91f0
--- /dev/null
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -0,0 +1,166 @@
+/*
+ * Xtensa MX interrupt distributor
+ *
+ * Copyright (C) 2002 - 2013 Tensilica, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+
+#include <asm/mxregs.h>
+
+#include "irqchip.h"
+
+#define HW_IRQ_IPI_COUNT 2
+#define HW_IRQ_MX_BASE 2
+#define HW_IRQ_EXTERN_BASE 3
+
+static DEFINE_PER_CPU(unsigned int, cached_irq_mask);
+
+static int xtensa_mx_irq_map(struct irq_domain *d, unsigned int irq,
+		irq_hw_number_t hw)
+{
+	if (hw < HW_IRQ_IPI_COUNT) {
+		struct irq_chip *irq_chip = d->host_data;
+		irq_set_chip_and_handler_name(irq, irq_chip,
+				handle_percpu_irq, "ipi");
+		irq_set_status_flags(irq, IRQ_LEVEL);
+		return 0;
+	}
+	return xtensa_irq_map(d, irq, hw);
+}
+
+/*
+ * Device Tree IRQ specifier translation function which works with one or
+ * two cell bindings. First cell value maps directly to the hwirq number.
+ * Second cell if present specifies whether hwirq number is external (1) or
+ * internal (0).
+ */
+static int xtensa_mx_irq_domain_xlate(struct irq_domain *d,
+		struct device_node *ctrlr,
+		const u32 *intspec, unsigned int intsize,
+		unsigned long *out_hwirq, unsigned int *out_type)
+{
+	return xtensa_irq_domain_xlate(intspec, intsize,
+			intspec[0], intspec[0] + HW_IRQ_EXTERN_BASE,
+			out_hwirq, out_type);
+}
+
+static const struct irq_domain_ops xtensa_mx_irq_domain_ops = {
+	.xlate = xtensa_mx_irq_domain_xlate,
+	.map = xtensa_mx_irq_map,
+};
+
+void secondary_init_irq(void)
+{
+	this_cpu_write(cached_irq_mask,
+			XCHAL_INTTYPE_MASK_EXTERN_EDGE |
+			XCHAL_INTTYPE_MASK_EXTERN_LEVEL);
+	set_sr(XCHAL_INTTYPE_MASK_EXTERN_EDGE |
+			XCHAL_INTTYPE_MASK_EXTERN_LEVEL, intenable);
+}
+
+static void xtensa_mx_irq_mask(struct irq_data *d)
+{
+	unsigned long mask = 1u << d->hwirq;
+
+	if (mask & (XCHAL_INTTYPE_MASK_EXTERN_EDGE |
+				XCHAL_INTTYPE_MASK_EXTERN_LEVEL)) {
+		set_er(1u << (xtensa_get_ext_irq_no(d->hwirq) -
+					HW_IRQ_MX_BASE), MIENG);
+	} else {
+		int cpu = get_cpu();
+		per_cpu(cached_irq_mask, cpu) &= ~mask;
+		set_sr(per_cpu(cached_irq_mask, cpu), intenable);
+		put_cpu();
+	}
+}
+
+static void xtensa_mx_irq_unmask(struct irq_data *d)
+{
+	unsigned long mask = 1u << d->hwirq;
+
+	if (mask & (XCHAL_INTTYPE_MASK_EXTERN_EDGE |
+				XCHAL_INTTYPE_MASK_EXTERN_LEVEL)) {
+		set_er(1u << (xtensa_get_ext_irq_no(d->hwirq) -
+					HW_IRQ_MX_BASE), MIENGSET);
+	} else {
+		int cpu = get_cpu();
+		per_cpu(cached_irq_mask, cpu) |= mask;
+		set_sr(per_cpu(cached_irq_mask, cpu), intenable);
+		put_cpu();
+	}
+}
+
+static void xtensa_mx_irq_enable(struct irq_data *d)
+{
+	variant_irq_enable(d->hwirq);
+	xtensa_mx_irq_unmask(d);
+}
+
+static void xtensa_mx_irq_disable(struct irq_data *d)
+{
+	xtensa_mx_irq_mask(d);
+	variant_irq_disable(d->hwirq);
+}
+
+static void xtensa_mx_irq_ack(struct irq_data *d)
+{
+	set_sr(1 << d->hwirq, intclear);
+}
+
+static int xtensa_mx_irq_retrigger(struct irq_data *d)
+{
+	set_sr(1 << d->hwirq, intset);
+	return 1;
+}
+
+static int xtensa_mx_irq_set_affinity(struct irq_data *d,
+		const struct cpumask *dest, bool force)
+{
+	unsigned mask = 1u << cpumask_any(dest);
+
+	set_er(mask, MIROUT(d->hwirq - HW_IRQ_MX_BASE));
+	return 0;
+
+}
+
+static struct irq_chip xtensa_mx_irq_chip = {
+	.name		= "xtensa-mx",
+	.irq_enable	= xtensa_mx_irq_enable,
+	.irq_disable	= xtensa_mx_irq_disable,
+	.irq_mask	= xtensa_mx_irq_mask,
+	.irq_unmask	= xtensa_mx_irq_unmask,
+	.irq_ack	= xtensa_mx_irq_ack,
+	.irq_retrigger	= xtensa_mx_irq_retrigger,
+	.irq_set_affinity = xtensa_mx_irq_set_affinity,
+};
+
+int __init xtensa_mx_init_legacy(struct device_node *interrupt_parent)
+{
+	struct irq_domain *root_domain =
+		irq_domain_add_legacy(NULL, NR_IRQS, 0, 0,
+				&xtensa_mx_irq_domain_ops,
+				&xtensa_mx_irq_chip);
+	irq_set_default_host(root_domain);
+	secondary_init_irq();
+	return 0;
+}
+
+static int __init xtensa_mx_init(struct device_node *np,
+		struct device_node *interrupt_parent)
+{
+	struct irq_domain *root_domain =
+		irq_domain_add_linear(np, NR_IRQS, &xtensa_mx_irq_domain_ops,
+				&xtensa_mx_irq_chip);
+	irq_set_default_host(root_domain);
+	secondary_init_irq();
+	return 0;
+}
+IRQCHIP_DECLARE(xtensa_mx_irq_chip, "xtensa,mx", xtensa_mx_init);
diff --git a/include/linux/irqchip/xtensa-mx.h b/include/linux/irqchip/xtensa-mx.h
new file mode 100644
index 0000000..9c3b6ec
--- /dev/null
+++ b/include/linux/irqchip/xtensa-mx.h
@@ -0,0 +1,17 @@
+/*
+ * Xtensa MX interrupt distributor
+ *
+ * Copyright (C) 2002 - 2013 Tensilica, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __LINUX_IRQCHIP_XTENSA_MX_H
+#define __LINUX_IRQCHIP_XTENSA_MX_H
+
+struct device_node;
+int xtensa_mx_init_legacy(struct device_node *interrupt_parent);
+
+#endif /* __LINUX_IRQCHIP_XTENSA_MX_H */
-- 
1.8.1.4
