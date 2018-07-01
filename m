From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Date: Mon,  2 Jul 2018 01:30:22 +0800
Message-ID: <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-csky-v1.c      | 126 ++++++++++++++++++++++++
 drivers/irqchip/irq-csky-v2.c      | 191 +++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-nationalchip.c | 131 +++++++++++++++++++++++++
 4 files changed, 449 insertions(+)
 create mode 100644 drivers/irqchip/irq-csky-v1.c
 create mode 100644 drivers/irqchip/irq-csky-v2.c
 create mode 100644 drivers/irqchip/irq-nationalchip.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3..51e7316 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -85,3 +85,4 @@ obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
 obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
 obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
+obj-$(CONFIG_CSKY) 			+= irq-csky-v1.o irq-csky-v2.o irq-nationalchip.o
diff --git a/drivers/irqchip/irq-csky-v1.c b/drivers/irqchip/irq-csky-v1.c
new file mode 100644
index 0000000..64ea564
--- /dev/null
+++ b/drivers/irqchip/irq-csky-v1.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/traps.h>
+
+#ifdef CONFIG_CSKY_VECIRQ_LEGENCY
+#include <asm/reg_ops.h>
+#endif
+
+static void __iomem *reg_base;
+
+#define INTC_ICR	0x00
+#define INTC_ISR	0x00
+#define INTC_NEN31_00	0x10
+#define INTC_NEN63_32	0x28
+#define INTC_IFR31_00	0x08
+#define INTC_IFR63_32	0x20
+#define INTC_SOURCE	0x40
+
+#define INTC_IRQS	64
+
+#define INTC_ICR_AVE	BIT(31)
+
+#define VEC_IRQ_BASE	32
+
+static struct irq_domain *root_domain;
+
+static void __init ck_set_gc(void __iomem *reg_base, u32 irq_base,
+			     u32 mask_reg)
+{
+	struct irq_chip_generic *gc;
+
+	gc = irq_get_domain_generic_chip(root_domain, irq_base);
+	gc->reg_base = reg_base;
+	gc->chip_types[0].regs.mask = mask_reg;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+}
+
+static struct irq_domain *root_domain;
+static void ck_irq_handler(struct pt_regs *regs)
+{
+#ifdef CONFIG_CSKY_VECIRQ_LEGENCY
+	irq_hw_number_t irq = ((mfcr("psr") >> 16) & 0xff) - VEC_IRQ_BASE;
+#else
+	irq_hw_number_t irq = readl_relaxed(reg_base + INTC_ISR) & 0x3f;
+#endif
+	handle_domain_irq(root_domain, irq, regs);
+}
+
+#define expand_byte_to_word(i) (i|(i<<8)|(i<<16)|(i<<24))
+static inline void setup_irq_channel(void __iomem *reg_base)
+{
+	int i;
+
+	/*
+	 * There are 64 irq nums and irq-channels and one byte per channel.
+	 * Setup every channel with the same hwirq num.
+	 */
+	for (i = 0; i < INTC_IRQS; i += 4) {
+		writel_relaxed(expand_byte_to_word(i) + 0x00010203,
+			       reg_base + INTC_SOURCE + i);
+	}
+}
+
+static int __init
+csky_intc_v1_init(struct device_node *node, struct device_node *parent)
+{
+	u32 clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	int ret;
+
+	if (parent) {
+		pr_err("C-SKY Intc not a root irq controller\n");
+		return -EINVAL;
+	}
+
+	reg_base = of_iomap(node, 0);
+	if (!reg_base) {
+		pr_err("C-SKY Intc unable to map: %p.\n", node);
+		return -EINVAL;
+	}
+
+	writel_relaxed(0, reg_base + INTC_NEN31_00);
+	writel_relaxed(0, reg_base + INTC_NEN63_32);
+
+#ifndef CONFIG_CSKY_VECIRQ_LEGENCY
+	writel_relaxed(INTC_ICR_AVE, reg_base + INTC_ICR);
+#else
+	writel_relaxed(0, reg_base + INTC_ICR);
+#endif
+
+	setup_irq_channel(reg_base);
+
+	root_domain = irq_domain_add_linear(node, INTC_IRQS, &irq_generic_chip_ops, NULL);
+	if (!root_domain) {
+		pr_err("C-SKY Intc irq_domain_add failed.\n");
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(root_domain, 32, 1,
+					     "csky_intc_v1", handle_level_irq,
+					     clr, 0, 0);
+	if (ret) {
+		pr_err("C-SKY Intc irq_alloc_gc failed.\n");
+		return -ENOMEM;
+	}
+
+	ck_set_gc(reg_base, 0,  INTC_NEN31_00);
+	ck_set_gc(reg_base, 32, INTC_NEN63_32);
+
+	set_handle_irq(ck_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(csky_intc_v1, "csky,intc-v1", csky_intc_v1_init);
+
diff --git a/drivers/irqchip/irq-csky-v2.c b/drivers/irqchip/irq-csky-v2.c
new file mode 100644
index 0000000..b588364
--- /dev/null
+++ b/drivers/irqchip/irq-csky-v2.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/traps.h>
+#include <asm/reg_ops.h>
+#include <asm/smp.h>
+
+static void __iomem *INTCG_base;
+static void __iomem *INTCL_base;
+
+#define COMM_IRQ_BASE	32
+
+#define INTCG_SIZE	0x8000
+#define INTCL_SIZE	0x1000
+#define INTC_SIZE	INTCL_SIZE*nr_cpu_ids + INTCG_SIZE
+
+#define INTCG_ICTLR	0x0
+#define INTCG_CICFGR	0x100
+#define INTCG_CIDSTR	0x1000
+
+#define INTCL_PICTLR	0x0
+#define INTCL_SIGR	0x60
+#define INTCL_RDYIR	0x6c
+#define INTCL_SENR	0xa0
+#define INTCL_CENR	0xa4
+#define INTCL_CACR	0xb4
+
+#define INTC_IRQS	256
+
+#define INTC_ICR_AVE	BIT(31)
+
+DEFINE_PER_CPU(void __iomem *, intcl_reg);
+
+static void csky_irq_v2_handler(struct pt_regs *regs)
+{
+	static void __iomem	*reg_base;
+	irq_hw_number_t		hwirq;
+
+	reg_base = *this_cpu_ptr(&intcl_reg);
+
+	hwirq = readl_relaxed(reg_base + INTCL_RDYIR);
+	handle_domain_irq(NULL, hwirq, regs);
+}
+
+static void csky_irq_v2_enable(struct irq_data *d)
+{
+	static void __iomem	*reg_base;
+
+	reg_base = *this_cpu_ptr(&intcl_reg);
+
+	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
+}
+
+static void csky_irq_v2_disable(struct irq_data *d)
+{
+	static void __iomem	*reg_base;
+
+	reg_base = *this_cpu_ptr(&intcl_reg);
+
+	writel_relaxed(d->hwirq, reg_base + INTCL_CENR);
+}
+
+static void csky_irq_v2_eoi(struct irq_data *d)
+{
+	static void __iomem	*reg_base;
+
+	reg_base = *this_cpu_ptr(&intcl_reg);
+
+	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
+}
+
+#ifdef CONFIG_SMP
+static int csky_irq_set_affinity(struct irq_data *d,
+				 const struct cpumask *mask_val,
+				 bool force)
+{
+	unsigned int cpu;
+
+	if (!force)
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	/* Enable interrupt destination */
+	cpu |= BIT(31);
+
+	writel_relaxed(cpu, INTCG_base + INTCG_CIDSTR + (4*(d->hwirq - COMM_IRQ_BASE)));
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip csky_irq_chip = {
+	.name           = "C-SKY SMP Intc V2",
+	.irq_eoi	= csky_irq_v2_eoi,
+	.irq_enable	= csky_irq_v2_enable,
+	.irq_disable	= csky_irq_v2_disable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = csky_irq_set_affinity,
+#endif
+};
+
+static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	if(hwirq < COMM_IRQ_BASE) {
+		irq_set_percpu_devid(irq);
+		irq_set_chip_and_handler(irq, &csky_irq_chip, handle_percpu_irq);
+	} else
+		irq_set_chip_and_handler(irq, &csky_irq_chip, handle_fasteoi_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops csky_irqdomain_ops = {
+	.map	= csky_irqdomain_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+#ifdef CONFIG_SMP
+static void csky_irq_v2_send_ipi(const unsigned long *mask, unsigned long irq)
+{
+	static void __iomem	*reg_base;
+
+	reg_base = *this_cpu_ptr(&intcl_reg);
+
+	/*
+	 * INTCL_SIGR[3:0] INTID
+	 * INTCL_SIGR[8:15] CPUMASK
+	 */
+	writel_relaxed((*mask) << 8 | irq, reg_base + INTCL_SIGR);
+}
+#endif
+
+static int __init
+csky_intc_v2_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *root_domain;
+	int cpu;
+
+	if (parent)
+		return 0;
+
+	if (INTCG_base == NULL) {
+		INTCG_base = ioremap(mfcr("cr<31, 14>"), INTC_SIZE);
+		if (INTCG_base == NULL)
+			return -EIO;
+
+		INTCL_base = INTCG_base + INTCG_SIZE;
+
+		writel_relaxed(BIT(0), INTCG_base + INTCG_ICTLR);
+	}
+
+	root_domain = irq_domain_add_linear(node, INTC_IRQS,
+					&csky_irqdomain_ops, NULL);
+	if (!root_domain)
+		return -ENXIO;
+
+	irq_set_default_host(root_domain);
+
+	/* for every cpu */
+	for_each_present_cpu(cpu) {
+		per_cpu(intcl_reg, cpu) = INTCL_base + (INTCL_SIZE * cpu);
+		writel_relaxed(BIT(0), per_cpu(intcl_reg, cpu) + INTCL_PICTLR);
+	}
+
+	set_handle_irq(&csky_irq_v2_handler);
+
+#ifdef CONFIG_SMP
+	set_send_ipi(&csky_irq_v2_send_ipi);
+#endif
+
+	return 0;
+}
+IRQCHIP_DECLARE(csky_intc_v2, "csky,intc-v2", csky_intc_v2_init);
+
diff --git a/drivers/irqchip/irq-nationalchip.c b/drivers/irqchip/irq-nationalchip.c
new file mode 100644
index 0000000..90b1805
--- /dev/null
+++ b/drivers/irqchip/irq-nationalchip.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/traps.h>
+
+static void __iomem *reg_base;
+
+#define INTC_NINT31_00		0x00
+#define INTC_NINT63_32		0x04
+#define INTC_NEN31_00		0x40
+#define INTC_NEN63_32		0x44
+#define INTC_NENSET31_00	0x20
+#define INTC_NENSET63_32	0x24
+#define INTC_NENCLR31_00	0x30
+#define INTC_NENCLR63_32	0x34
+#define INTC_NMASK31_00		0x50
+#define INTC_NMASK63_32		0x54
+#define INTC_SOURCE		0x60
+
+#define INTC_IRQS		64
+
+static struct irq_domain *root_domain;
+
+static void nc_irq_handler(struct pt_regs *regs)
+{
+	u32 status, irq;
+
+	do {
+		status = readl_relaxed(reg_base + INTC_NINT31_00);
+		if (status) {
+			irq = __ffs(status);
+		} else {
+			status = readl_relaxed(reg_base + INTC_NINT63_32);
+			if (status)
+				irq = __ffs(status) + 32;
+			else
+				return;
+		}
+		handle_domain_irq(root_domain, irq, regs);
+	} while(1);
+}
+
+static void __init nc_set_gc(void __iomem *reg_base, u32 irq_base,
+			     u32 en_reg, u32 dis_reg)
+{
+	struct irq_chip_generic *gc;
+
+	gc = irq_get_domain_generic_chip(root_domain, irq_base);
+	gc->reg_base = reg_base;
+	gc->chip_types[0].regs.enable = en_reg;
+	gc->chip_types[0].regs.disable = dis_reg;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
+}
+
+#define expand_byte_to_word(i) (i|(i<<8)|(i<<16)|(i<<24))
+static inline void setup_irq_channel(void __iomem *reg_base)
+{
+	int i;
+
+	/*
+	 * There are 64 irq nums and irq-channels and one byte per channel.
+	 * Setup every channel with the same hwirq num.
+	 */
+	for (i = 0; i < INTC_IRQS; i += 4) {
+		writel_relaxed(expand_byte_to_word(i) + 0x03020100,
+			       reg_base + INTC_SOURCE + i);
+	}
+}
+
+static int __init
+intc_init(struct device_node *node, struct device_node *parent)
+{
+	u32 clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	int ret;
+
+	if (parent) {
+		pr_err("Nationalchip gx6605s Intc not a root irq controller\n");
+		return -EINVAL;
+	}
+
+	reg_base = of_iomap(node, 0);
+	if (!reg_base) {
+		pr_err("Nationalchip gx6605s Intc unable to map: %p.\n", node);
+		return -EINVAL;
+	}
+
+	/* Initial enable reg to disable all interrupts */
+	writel_relaxed(0x0, reg_base + INTC_NEN31_00);
+	writel_relaxed(0x0, reg_base + INTC_NEN63_32);
+
+	/* Initial mask reg with all unmasked, becasue we only use enalbe reg */
+	writel_relaxed(0x0, reg_base + INTC_NMASK31_00);
+	writel_relaxed(0x0, reg_base + INTC_NMASK63_32);
+
+	setup_irq_channel(reg_base);
+
+	root_domain = irq_domain_add_linear(node, INTC_IRQS, &irq_generic_chip_ops, NULL);
+	if (!root_domain) {
+		pr_err("Nationalchip gx6605s Intc irq_domain_add failed.\n");
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(root_domain, 32, 1,
+					     "gx6605s_irq", handle_level_irq,
+					     clr, 0, 0);
+	if (ret) {
+		pr_err("Nationalchip gx6605s Intc irq_alloc_gc failed.\n");
+		return -ENOMEM;
+	}
+
+	nc_set_gc(reg_base, 0,  INTC_NENSET31_00, INTC_NENCLR31_00);
+	nc_set_gc(reg_base, 32, INTC_NENSET63_32, INTC_NENCLR63_32);
+
+	set_handle_irq(nc_irq_handler);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(nationalchip_intc_v1_ave, "nationalchip,intc-v1,ave", intc_init);
+
-- 
2.7.4
