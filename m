From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 19/19] irqchip: add irq-nationalchip.c and irq-csky.c
Date: Mon, 19 Mar 2018 03:51:41 +0800
Message-ID: <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-csky.c         | 151 ++++++++++++++++++++++++++++
 drivers/irqchip/irq-nationalchip.c | 196 +++++++++++++++++++++++++++++++++++++
 3 files changed, 348 insertions(+)
 create mode 100644 drivers/irqchip/irq-csky.c
 create mode 100644 drivers/irqchip/irq-nationalchip.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3..7b98917 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -85,3 +85,4 @@ obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
 obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
 obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
+obj-$(CONFIG_CSKY)			+= irq-csky.o irq-nationalchip.o
diff --git a/drivers/irqchip/irq-csky.c b/drivers/irqchip/irq-csky.c
new file mode 100644
index 0000000..77041e3
--- /dev/null
+++ b/drivers/irqchip/irq-csky.c
@@ -0,0 +1,151 @@
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
+
+static unsigned int intc_reg;
+
+#define CK_VA_INTC_ICR		(void *)(intc_reg + 0x00)	/* Interrupt control register(High 16bits) */
+#define CK_VA_INTC_ISR		(void *)(intc_reg + 0x00)	/* Interrupt status register(Low 16bits) */
+#define CK_VA_INTC_NEN31_00	(void *)(intc_reg + 0x10)	/* Normal interrupt enable register Low */
+#define	CK_VA_INTC_NEN63_32	(void *)(intc_reg + 0x28)	/* Normal interrupt enable register High */
+#define CK_VA_INTC_IFR31_00	(void *)(intc_reg + 0x08)	/* Normal interrupt force register Low */
+#define CK_VA_INTC_IFR63_32	(void *)(intc_reg + 0x20)	/* Normal interrupt force register High */
+#define	CK_VA_INTC_SOURCE	(void *)(intc_reg + 0x40)	/* Proiority Level Select Registers 0 */
+
+static void ck_irq_mask(struct irq_data *d)
+{
+	unsigned int temp, irq;
+
+	irq = d->irq;
+
+	if (irq < 32) {
+		temp = __raw_readl(CK_VA_INTC_NEN31_00);
+		temp &= ~(1 << irq);
+		__raw_writel(temp, CK_VA_INTC_NEN31_00);
+	} else {
+		temp = __raw_readl(CK_VA_INTC_NEN63_32);
+		temp &= ~(1 << (irq -32));
+		__raw_writel(temp, CK_VA_INTC_NEN63_32);
+	}
+}
+
+static void ck_irq_unmask(struct irq_data *d)
+{
+	unsigned int temp, irq;
+
+	irq = d->irq;
+
+	/* set IFR to support rising edge triggering */
+	if (irq < 32) {
+		temp = __raw_readl(CK_VA_INTC_IFR31_00);
+		temp &= ~(1 << irq);
+		__raw_writel(temp, CK_VA_INTC_IFR31_00);
+	} else {
+		temp = __raw_readl(CK_VA_INTC_IFR63_32);
+		temp &= ~(1 << (irq -32));
+		__raw_writel(temp, CK_VA_INTC_IFR63_32);
+	}
+
+	if (irq < 32) {
+		temp = __raw_readl(CK_VA_INTC_NEN31_00);
+		temp |= 1 << irq;
+		__raw_writel(temp, CK_VA_INTC_NEN31_00);
+	} else {
+		temp = __raw_readl(CK_VA_INTC_NEN63_32);
+		temp |= 1 << (irq -32);
+		__raw_writel(temp, CK_VA_INTC_NEN63_32);
+	}
+}
+
+static struct irq_chip ck_irq_chip = {
+	.name		= "csky_intc_v1",
+	.irq_mask	= ck_irq_mask,
+	.irq_unmask	= ck_irq_unmask,
+};
+
+static int ck_irq_map(struct irq_domain *h, unsigned int virq,
+				irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &ck_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops ck_irq_ops = {
+	.map	= ck_irq_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+static unsigned int ck_get_irqno(void)
+{
+	unsigned int temp;
+	temp = __raw_readl(CK_VA_INTC_ISR);
+	return temp & 0x3f;
+};
+
+static int __init
+__intc_init(struct device_node *np, struct device_node *parent, bool ave)
+{
+	struct irq_domain *root_domain;
+	int i;
+
+	csky_get_auto_irqno = ck_get_irqno;
+
+	if (parent)
+		panic("pic not a root intc\n");
+
+	intc_reg = (unsigned int)of_iomap(np, 0);
+	if (!intc_reg)
+		panic("%s, of_iomap err.\n", __func__);
+
+	__raw_writel(0, CK_VA_INTC_NEN31_00);
+	__raw_writel(0,	CK_VA_INTC_NEN63_32);
+
+	if (ave == true)
+		__raw_writel( 0xc0000000, CK_VA_INTC_ICR);
+	else
+		__raw_writel( 0x0, CK_VA_INTC_ICR);
+	/*
+	 * csky irq ctrl has 64 sources.
+	 */
+	#define INTC_IRQS 64
+	for (i=0; i<INTC_IRQS; i=i+4)
+		__raw_writel((i+3)|((i+2)<<8)|((i+1)<<16)|(i<<24),
+				CK_VA_INTC_SOURCE + i);
+
+	root_domain = irq_domain_add_legacy(np, INTC_IRQS, 0, 0, &ck_irq_ops, NULL);
+	if (!root_domain)
+		panic("root irq domain not available\n");
+
+	irq_set_default_host(root_domain);
+
+	return 0;
+}
+
+static int __init
+intc_init(struct device_node *np, struct device_node *parent)
+{
+
+	return __intc_init(np, parent, false);
+}
+IRQCHIP_DECLARE(csky_intc_v1, "csky,intc-v1", intc_init);
+
+/*
+ * use auto vector exceptions 10 for interrupt.
+ */
+static int __init
+intc_init_ave(struct device_node *np, struct device_node *parent)
+{
+	return __intc_init(np, parent, true);
+}
+IRQCHIP_DECLARE(csky_intc_v1_ave, "csky,intc-v1,ave", intc_init_ave);
+
diff --git a/drivers/irqchip/irq-nationalchip.c b/drivers/irqchip/irq-nationalchip.c
new file mode 100644
index 0000000..8c09ebd
--- /dev/null
+++ b/drivers/irqchip/irq-nationalchip.c
@@ -0,0 +1,196 @@
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
+
+#define NC_VA_INTC_NINT31_00		(void *)(intc_reg + 0x00)
+#define NC_VA_INTC_NINT63_32		(void *)(intc_reg + 0x04)
+#define NC_VA_INTC_NPEND31_00		(void *)(intc_reg + 0x10)
+#define NC_VA_INTC_NPEND63_32		(void *)(intc_reg + 0x14)
+#define NC_VA_INTC_NENSET31_00		(void *)(intc_reg + 0x20)
+#define NC_VA_INTC_NENSET63_32		(void *)(intc_reg + 0x24)
+#define NC_VA_INTC_NENCLR31_00		(void *)(intc_reg + 0x30)
+#define NC_VA_INTC_NENCLR63_32		(void *)(intc_reg + 0x34)
+#define NC_VA_INTC_NEN31_00		(void *)(intc_reg + 0x40)
+#define NC_VA_INTC_NEN63_32		(void *)(intc_reg + 0x44)
+#define NC_VA_INTC_NMASK31_00		(void *)(intc_reg + 0x50)
+#define NC_VA_INTC_NMASK63_32		(void *)(intc_reg + 0x54)
+#define NC_VA_INTC_SOURCE		(void *)(intc_reg + 0x60)
+
+static unsigned int intc_reg;
+
+static void nc_irq_mask(struct irq_data *d)
+{
+	unsigned int mask, irq;
+
+	irq = d->irq;
+
+	if (irq < 32) {
+		mask = __raw_readl(NC_VA_INTC_NMASK31_00);
+		mask |= 1 << irq;
+		__raw_writel(mask, NC_VA_INTC_NMASK31_00);
+	} else {
+		mask = __raw_readl(NC_VA_INTC_NMASK63_32);
+		mask |= 1 << (irq - 32);
+		__raw_writel(mask, NC_VA_INTC_NMASK63_32);
+	}
+}
+
+static void nc_irq_unmask(struct irq_data *d)
+{
+	unsigned int mask, irq;
+
+	irq = d->irq;
+
+	if (irq < 32) {
+		mask = __raw_readl(NC_VA_INTC_NMASK31_00);
+		mask &= ~( 1 << irq);
+		__raw_writel(mask, NC_VA_INTC_NMASK31_00);
+	} else {
+		mask = __raw_readl( NC_VA_INTC_NMASK63_32);
+		mask &= ~(1 << (irq - 32));
+		__raw_writel(mask, NC_VA_INTC_NMASK63_32);
+	}
+}
+
+static void nc_irq_en(struct irq_data *d)
+{
+	unsigned int mask, irq;
+
+	irq = d->irq;
+
+	if (irq < 32) {
+		mask = 1 << irq;
+		__raw_writel(mask, NC_VA_INTC_NENSET31_00);
+	} else {
+		mask = 1 << (irq - 32);
+		__raw_writel(mask, NC_VA_INTC_NENSET63_32);
+	}
+
+	nc_irq_unmask(d);
+}
+
+static void nc_irq_dis(struct irq_data *d)
+{
+	unsigned int mask, irq;
+
+	irq = d->irq;
+
+	if (irq < 32) {
+		mask = 1 << irq;
+		__raw_writel(mask, NC_VA_INTC_NENCLR31_00);
+	} else {
+		mask = 1 << (irq - 32);
+		__raw_writel(mask, NC_VA_INTC_NENCLR63_32);
+	}
+
+	nc_irq_mask(d);
+}
+
+struct irq_chip nc_irq_chip = {
+	.name =		"nationalchip_intc_v1",
+	.irq_mask =	nc_irq_mask,
+	.irq_unmask =	nc_irq_unmask,
+	.irq_enable =	nc_irq_en,
+	.irq_disable =	nc_irq_dis,
+};
+
+inline int ff1_64(unsigned int hi, unsigned int lo)
+{
+	int result;
+	asm volatile(
+		"ff1 %0\n"
+		:"=r"(hi)
+		:"r"(hi)
+		:
+	);
+
+	asm volatile(
+		"ff1 %0\n"
+		:"=r"(lo)
+		:"r"(lo)
+		:
+	);
+	if( lo != 32 )
+		result = 31-lo;
+	else if( hi != 32 ) result = 31-hi + 32;
+	else {
+		printk("nc_get_irqno error hi:%x, lo:%x.\n", hi, lo);
+		result = NR_IRQS;
+	}
+	return result;
+}
+
+unsigned int nc_get_irqno(void)
+{
+	unsigned int nint64hi, nint64lo, irq_no;
+
+	nint64lo = __raw_readl(NC_VA_INTC_NINT31_00);
+	nint64hi = __raw_readl(NC_VA_INTC_NINT63_32);
+	irq_no = ff1_64(nint64hi, nint64lo);
+
+	return irq_no;
+}
+
+static int irq_map(struct irq_domain *h, unsigned int virq,
+				irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &nc_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops nc_irq_ops = {
+	.map	= irq_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+static int __init
+intc_init(struct device_node *intc, struct device_node *parent)
+{
+	struct irq_domain *root_domain;
+	unsigned int i;
+
+	if (parent)
+		panic("DeviceTree incore intc not a root irq controller\n");
+
+	csky_get_auto_irqno = nc_get_irqno;
+
+	intc_reg = (unsigned int) of_iomap(intc, 0);
+	if (!intc_reg)
+		panic("Nationalchip Intc Reg: %x.\n", intc_reg);
+
+	__raw_writel(0xffffffff, NC_VA_INTC_NENCLR31_00);
+	__raw_writel(0xffffffff, NC_VA_INTC_NENCLR63_32);
+	__raw_writel(0xffffffff, NC_VA_INTC_NMASK31_00);
+	__raw_writel(0xffffffff, NC_VA_INTC_NMASK63_32);
+
+	/*
+	 * nationalchip irq ctrl has 64 sources.
+	 */
+	#define INTC_IRQS 64
+	for (i=0; i<INTC_IRQS; i=i+4)
+		__raw_writel(i|((i+1)<<8)|((i+2)<<16)|((i+3)<<24),
+				NC_VA_INTC_SOURCE + i);
+
+	root_domain = irq_domain_add_legacy(intc, INTC_IRQS, 0, 0,
+			&nc_irq_ops, NULL);
+	if (!root_domain)
+		panic("root irq domain not avail\n");
+
+	irq_set_default_host(root_domain);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(nationalchip_intc_v1_ave, "nationalchip,intc-v1,ave", intc_init);
+
-- 
2.7.4
