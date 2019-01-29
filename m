From: guoren@kernel.org
Subject: [PATCH 01/10] irqchip/csky: Support csky,dh7k SOC intc driver
Date: Tue, 29 Jan 2019 20:24:20 +0800
Message-ID: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

C-SKY dh7k SOC use simple APB interrupt controller and most of driver's
implementation codes could be reused in csky-apb-intc.c. So merge them
together.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/irqchip/irq-csky-apb-intc.c | 95 +++++++++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 5a2ec43..fcc5444 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <asm/irq.h>
+#include <asm/traps.h>
 
 #define INTC_IRQS		64
 
@@ -31,6 +32,17 @@
 #define GX_INTC_NMASK63_32	0x54
 #define GX_INTC_SOURCE		0x60
 
+#define DH_INTC_CLR		0x10
+#define DH_INTC_INIT		0x34
+#define DH_INTC_NMASK31_00	0x08
+#define DH_INTC_NMASK63_32	0x68
+#define DH_INTC_SOURCE31_00	0x14
+#define DH_INTC_SOURCE63_32	0x6c
+#define DH_INTC_EDGE31_00	0x00
+#define DH_INTC_EDGE63_32	0x60
+#define DH_INTC_POLL31_00	0x04
+#define DH_INTC_POLL63_32	0x64
+
 static void __iomem *reg_base;
 static struct irq_domain *root_domain;
 
@@ -58,15 +70,21 @@ static void irq_ck_mask_set_bit(struct irq_data *d)
 }
 
 static void __init ck_set_gc(struct device_node *node, void __iomem *reg_base,
-			     u32 mask_reg, u32 irq_base)
+				u32 en_off, u32 mask_off, u32 irq_base)
 {
 	struct irq_chip_generic *gc;
 
 	gc = irq_get_domain_generic_chip(root_domain, irq_base);
 	gc->reg_base = reg_base;
-	gc->chip_types[0].regs.mask = mask_reg;
-	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
-	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+	if (en_off) {
+		gc->chip_types[0].regs.mask = en_off;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+	} else if (mask_off) {
+		gc->chip_types[0].regs.mask = mask_off;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
+	}
 
 	if (of_find_property(node, "csky,support-pulse-signal", NULL))
 		gc->chip_types[0].chip.irq_unmask = irq_ck_mask_set_bit;
@@ -183,8 +201,8 @@ gx_intc_init(struct device_node *node, struct device_node *parent)
 
 	setup_irq_channel(0x03020100, reg_base + GX_INTC_SOURCE);
 
-	ck_set_gc(node, reg_base, GX_INTC_NEN31_00, 0);
-	ck_set_gc(node, reg_base, GX_INTC_NEN63_32, 32);
+	ck_set_gc(node, reg_base, GX_INTC_NEN31_00, 0, 0);
+	ck_set_gc(node, reg_base, GX_INTC_NEN63_32, 0, 32);
 
 	set_handle_irq(gx_irq_handler);
 
@@ -192,6 +210,63 @@ gx_intc_init(struct device_node *node, struct device_node *parent)
 }
 IRQCHIP_DECLARE(csky_gx6605s_intc, "csky,gx6605s-intc", gx_intc_init);
 
+static void dh_irq_handler(struct pt_regs *regs)
+{
+	u32 tmp;
+	unsigned long vector = (mfcr("psr") >> 16) & 0xff;
+
+	tmp = readl(reg_base + DH_INTC_CLR);
+	tmp |= BIT(2);
+	writel(tmp, reg_base + DH_INTC_CLR);
+
+	handle_domain_irq(root_domain, vector - 32, regs);
+}
+
+extern void csky_irq(void);
+
+static int __init
+dh_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret, i;
+
+	ret = ck_intc_init_comm(node, parent);
+	if (ret)
+		return ret;
+
+	/* set default mode */
+	writel(0xffffffff, reg_base + DH_INTC_EDGE31_00);
+	writel(0xffffffff, reg_base + DH_INTC_EDGE63_32);
+	writel(0xffffffff, reg_base + DH_INTC_POLL31_00);
+	writel(0xffffffff, reg_base + DH_INTC_POLL63_32);
+
+	writel(BIT(1) | BIT(6), reg_base + DH_INTC_INIT);
+
+	/* Setup  0-31 channel slots */
+	for (i = 0; i < INTC_IRQS/2; i += 4)
+		writel(build_channel_val(i, 0x03020100) + 0x40404040,
+				reg_base + DH_INTC_SOURCE31_00 + i);
+
+	/* Setup 32-63 channel slots */
+	for (i = 0; i < INTC_IRQS/2; i += 4)
+		writel(build_channel_val(i, 0x03020100) + 0x40404040,
+				reg_base + DH_INTC_SOURCE63_32 + i);
+
+	/* mask all interrrupts */
+	writel(0xffffffff, reg_base + DH_INTC_NMASK31_00);
+	writel(0xffffffff, reg_base + DH_INTC_NMASK63_32);
+
+	ck_set_gc(node, reg_base, 0, DH_INTC_NMASK31_00, 0);
+	ck_set_gc(node, reg_base, 0, DH_INTC_NMASK63_32, 32);
+
+	for (i = 32; i < 128; i++)
+		VEC_INIT(i, csky_irq);
+
+	set_handle_irq(dh_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(csky_dh7k_intc, "csky,dh7k-intc", dh_intc_init);
+
 /*
  * C-SKY simple 64 irqs interrupt controller, dual-together could support 128
  * irqs.
@@ -243,8 +318,8 @@ ck_intc_init(struct device_node *node, struct device_node *parent)
 	/* Enable irq intc */
 	writel(BIT(31), reg_base + CK_INTC_ICR);
 
-	ck_set_gc(node, reg_base, CK_INTC_NEN31_00, 0);
-	ck_set_gc(node, reg_base, CK_INTC_NEN63_32, 32);
+	ck_set_gc(node, reg_base, CK_INTC_NEN31_00, 0, 0);
+	ck_set_gc(node, reg_base, CK_INTC_NEN63_32, 0, 32);
 
 	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE);
 
@@ -270,8 +345,8 @@ ck_dual_intc_init(struct device_node *node, struct device_node *parent)
 	writel(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
 	writel(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
 
-	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 64);
-	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 96);
+	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 0, 64);
+	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 0, 96);
 
 	setup_irq_channel(0x00010203,
 			  reg_base + CK_INTC_SOURCE + CK_INTC_DUAL_BASE);
-- 
2.7.4
