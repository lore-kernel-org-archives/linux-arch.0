Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37797 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728491AbeILT72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Sep 2018 15:59:28 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 26/27] irqchip: add C-SKY irqchip drivers
Date: Wed, 12 Sep 2018 22:52:08 +0800
Message-ID: <60808788fef80cc6c64064982e58a22ed4abd006.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180912145208.kI84cZKuVQl_LyZZt06FmtsPxtf2sPY5ZcnSxZeWXIE@z>

This patch add C-SKY two interrupt conrollers.

 - irq-csky-apb-intc is a simple SOC interrupt controller which is
   used in a lot of C-SKY SOC products.

 - irq-csky-mpintc is C-SKY smp system interrupt controller and it
   could support 16 soft irqs, 16 private irqs, and 992 irqs.

Changelog:
 - change name with upstream feed-back.
 - remove CSKY_VECIRQ_LEGENCY.
 - change irq map, reserve soft_irq&private_irq space.
 - add License and Copyright
 - change to generic irq chip framework.
 - support set_affinity for irq balance in SMP
 - add INTC_IFR to clear irq-pending
 - use irq_domain_add_linear instead of leagcy.
 - add set_handle_irq(), ref from openrisc & arm.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-csky-apb-intc.c | 243 ++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-csky-mpintc.c   | 191 ++++++++++++++++++++++++++++
 3 files changed, 435 insertions(+)
 create mode 100644 drivers/irqchip/irq-csky-apb-intc.c
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f..4838546 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_CSKY)			+= irq-csky-mpintc.o irq-csky-apb-intc.o
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
new file mode 100644
index 0000000..2c869ab
--- /dev/null
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
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
+
+#define INTC_IRQS		64
+
+#define CK_INTC_ICR		0x00
+#define CK_INTC_PEN31_00	0x14
+#define CK_INTC_PEN63_32	0x2c
+#define CK_INTC_NEN31_00	0x10
+#define CK_INTC_NEN63_32	0x28
+#define CK_INTC_IFR31_00	0x08
+#define CK_INTC_IFR63_32	0x20
+#define CK_INTC_SOURCE		0x40
+#define CK_INTC_DUAL_BASE	0x100
+
+#define GX_INTC_PEN31_00	0x00
+#define GX_INTC_PEN63_32	0x04
+#define GX_INTC_NEN31_00	0x40
+#define GX_INTC_NEN63_32	0x44
+#define GX_INTC_NMASK31_00	0x50
+#define GX_INTC_NMASK63_32	0x54
+#define GX_INTC_SOURCE		0x60
+
+static void __iomem *reg_base;
+static struct irq_domain *root_domain;
+
+static int nr_irq = INTC_IRQS;
+
+static void __init ck_set_gc(void __iomem *reg_base, u32 mask_reg, u32 irq_base)
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
+static inline u32 build_channel_val(u32 idx, u32 magic)
+{
+	u32 res;
+
+	/*
+	 * Set the same index for each channel
+	 */
+	res = idx | (idx << 8) | (idx << 16) | (idx << 24);
+
+	/*
+	 * Set the channel magic number in descending order.
+	 * The magic is 0x00010203 for ck-intc
+	 * The magic is 0x03020100 for gx6605s-intc
+	 */
+	return res | magic;
+}
+
+static inline void setup_irq_channel(u32 magic, void __iomem *reg_addr)
+{
+	u32 i;
+
+	/* Setup 64 channel slots */
+	for (i = 0; i < INTC_IRQS; i += 4) {
+		writel_relaxed(build_channel_val(i, magic), reg_addr + i);
+	}
+}
+
+static int __init
+ck_intc_init_comm(struct device_node *node, struct device_node *parent)
+{
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
+	root_domain = irq_domain_add_linear(node, nr_irq, &irq_generic_chip_ops, NULL);
+	if (!root_domain) {
+		pr_err("C-SKY Intc irq_domain_add failed.\n");
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(root_domain, 32, 1,
+					     "csky_intc", handle_level_irq,
+					     IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN,
+					     0, 0);
+	if (ret) {
+		pr_err("C-SKY Intc irq_alloc_gc failed.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline int handle_irq_perbit(struct pt_regs *regs, u32 hwirq, u32 irq_base)
+{
+	u32 irq;
+
+	if (hwirq == 0) return 0;
+
+	while (hwirq) {
+		irq = __ffs(hwirq);
+		hwirq &= ~BIT(irq);
+		handle_domain_irq(root_domain, irq_base + irq, regs);
+	}
+
+	return 1;
+}
+
+/* gx6605s 64 irqs interrupt controller */
+static void gx_irq_handler(struct pt_regs *regs)
+{
+	int ret;
+
+	do {
+		ret  = handle_irq_perbit(regs ,readl_relaxed(reg_base + GX_INTC_PEN31_00), 0);
+		ret |= handle_irq_perbit(regs ,readl_relaxed(reg_base + GX_INTC_PEN63_32), 32);
+	} while(ret);
+}
+
+static int __init
+gx_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret;
+
+	ret = ck_intc_init_comm(node, parent);
+	if (ret)
+		return ret;
+
+	/* Initial enable reg to disable all interrupts */
+	writel_relaxed(0x0, reg_base + GX_INTC_NEN31_00);
+	writel_relaxed(0x0, reg_base + GX_INTC_NEN63_32);
+
+	/* Initial mask reg with all unmasked, becasue we only use enalbe reg */
+	writel_relaxed(0x0, reg_base + GX_INTC_NMASK31_00);
+	writel_relaxed(0x0, reg_base + GX_INTC_NMASK63_32);
+
+	setup_irq_channel(0x03020100, reg_base + GX_INTC_SOURCE);
+
+	ck_set_gc(reg_base, GX_INTC_NEN31_00, 0);
+	ck_set_gc(reg_base, GX_INTC_NEN63_32, 32);
+
+	set_handle_irq(gx_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(csky_gx6605s_intc, "csky,gx6605s-intc", gx_intc_init);
+
+/* C-SKY simple 64 irqs interrupt controller, dual-together could support 128 irqs */
+static void ck_irq_handler(struct pt_regs *regs)
+{
+	int ret;
+
+	do {
+		/* handle 0 - 31 irqs */
+		ret  = handle_irq_perbit(regs, readl_relaxed(reg_base + CK_INTC_PEN31_00), 0);
+		ret |= handle_irq_perbit(regs, readl_relaxed(reg_base + CK_INTC_PEN63_32), 32);
+
+		writel_relaxed(0, reg_base + CK_INTC_IFR31_00);
+		writel_relaxed(0, reg_base + CK_INTC_IFR63_32);
+
+		if (nr_irq == INTC_IRQS) continue;
+
+		/* handle 64 - 127 irqs */
+		ret |= handle_irq_perbit(regs,
+			   readl_relaxed(reg_base + CK_INTC_PEN31_00 + CK_INTC_DUAL_BASE), 64);
+		ret |= handle_irq_perbit(regs,
+			   readl_relaxed(reg_base + CK_INTC_PEN63_32 + CK_INTC_DUAL_BASE), 96);
+
+		writel_relaxed(0, reg_base + CK_INTC_IFR63_32 + CK_INTC_DUAL_BASE);
+		writel_relaxed(0, reg_base + CK_INTC_IFR31_00 + CK_INTC_DUAL_BASE);
+	} while(ret);
+}
+
+static int __init
+ck_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret;
+
+	ret = ck_intc_init_comm(node, parent);
+	if (ret)
+		return ret;
+
+	/* Initial enable reg to disable all interrupts */
+	writel_relaxed(0, reg_base + CK_INTC_NEN31_00);
+	writel_relaxed(0, reg_base + CK_INTC_NEN63_32);
+
+	/* Enable irq intc */
+	writel_relaxed(BIT(31), reg_base + CK_INTC_ICR);
+
+	ck_set_gc(reg_base, CK_INTC_NEN31_00, 0);
+	ck_set_gc(reg_base, CK_INTC_NEN63_32, 32);
+
+	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE);
+
+	set_handle_irq(ck_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ck_intc, "csky,apb-intc", ck_intc_init);
+
+static int __init
+ck_dual_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret;
+
+	/* dual-apb-intc up to 128 irq sources*/
+	nr_irq = INTC_IRQS * 2;
+
+	ret = ck_intc_init(node, parent);
+	if (ret)
+		return ret;
+
+	/* Initial enable reg to disable all interrupts */
+	writel_relaxed(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
+	writel_relaxed(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
+
+	ck_set_gc(reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 64);
+	ck_set_gc(reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 96);
+
+	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE + CK_INTC_DUAL_BASE);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ck_dual_intc, "csky,dual-apb-intc", ck_dual_intc_init);
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
new file mode 100644
index 0000000..2b2f75c
--- /dev/null
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
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
+#define INTCL_HPPIR	0x68
+#define INTCL_RDYIR	0x6c
+#define INTCL_SENR	0xa0
+#define INTCL_CENR	0xa4
+#define INTCL_CACR	0xb4
+
+#define INTC_IRQS	256
+
+static DEFINE_PER_CPU(void __iomem *, intcl_reg);
+
+static void csky_mpintc_handler(struct pt_regs *regs)
+{
+	void __iomem *reg_base = this_cpu_read(intcl_reg);
+
+	do {
+		handle_domain_irq(NULL,
+				  readl_relaxed(reg_base + INTCL_RDYIR),
+				  regs);
+	} while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
+}
+
+static void csky_mpintc_enable(struct irq_data *d)
+{
+	void __iomem *reg_base = this_cpu_read(intcl_reg);
+
+	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
+}
+
+static void csky_mpintc_disable(struct irq_data *d)
+{
+	void __iomem *reg_base = this_cpu_read(intcl_reg);
+
+	writel_relaxed(d->hwirq, reg_base + INTCL_CENR);
+}
+
+static void csky_mpintc_eoi(struct irq_data *d)
+{
+	void __iomem *reg_base = this_cpu_read(intcl_reg);
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
+	unsigned int offset = 4 * (d->hwirq - COMM_IRQ_BASE);
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
+	writel_relaxed(cpu, INTCG_base + INTCG_CIDSTR + offset);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip csky_irq_chip = {
+	.name           = "C-SKY SMP Intc V2",
+	.irq_eoi	= csky_mpintc_eoi,
+	.irq_enable	= csky_mpintc_enable,
+	.irq_disable	= csky_mpintc_disable,
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
+	} else {
+		irq_set_chip_and_handler(irq, &csky_irq_chip, handle_fasteoi_irq);
+	}
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
+static void csky_mpintc_send_ipi(const unsigned long *mask, unsigned long irq)
+{
+	void __iomem *reg_base = this_cpu_read(intcl_reg);
+
+	/*
+	 * INTCL_SIGR[3:0] INTID
+	 * INTCL_SIGR[8:15] CPUMASK
+	 */
+	writel_relaxed((*mask) << 8 | irq, reg_base + INTCL_SIGR);
+}
+#endif
+
+/* C-SKY multi processor interrupt controller */
+static int __init
+csky_mpintc_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *root_domain;
+	unsigned int cpu, nr_irq;
+	int ret;
+
+	if (parent)
+		return 0;
+
+	ret = of_property_read_u32(node, "csky,num-irqs", &nr_irq);
+	if (ret < 0) {
+		nr_irq = INTC_IRQS;
+	}
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
+	root_domain = irq_domain_add_linear(node, nr_irq, &csky_irqdomain_ops,
+					    NULL);
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
+	set_handle_irq(&csky_mpintc_handler);
+
+#ifdef CONFIG_SMP
+	set_send_ipi(&csky_mpintc_send_ipi);
+#endif
+
+	return 0;
+}
+IRQCHIP_DECLARE(csky_mpintc, "csky,mpintc", csky_mpintc_init);
-- 
2.7.4
