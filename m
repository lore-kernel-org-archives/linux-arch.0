From: guoren@kernel.org
Subject: [PATCH 5/5] irqchip/csky: fixup handle_irq_perbit break irq
Date: Wed,  9 Jan 2019 00:26:38 +0800
Message-ID: <1546964798-30067-5-git-send-email-guoren@kernel.org>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, marc.zyngier@arm.com, arnd@arndb.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mhocko@kernel.org, torvalds@linux-foundation.org, linux@roeck-us.net, Guo Ren <ren_guo@c-sky.com>, Lu Baoquan <lu.baoquan@intellif.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The handle_irq_perbit function loop every bit in hwirq local variable.

handle_irq_perbit(hwirq) {
  for_everyt_bit_in(hwirq) {
	handle_domain_irq()
		->irq_exit()
		->invoke_softirq()
		->__do_softirq()
		->local_irq_enable() // Here will cause new interrupt.
  }
}

When new interrupt coming at local_irq_enable, it will finish another
interrupt handler and pull down the interrupt source. But hwirq is the
local variable for handle_irq_perbit(), it can't get new interrupt
controller pending reg status. So we need update hwirq with pending reg
in every loop.

Also change write_relax to writel could prevent stw from fast retire.
When local_irq is enabled, intc regs is really set-in.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Lu Baoquan <lu.baoquan@intellif.com>
---
 drivers/irqchip/irq-csky-apb-intc.c | 77 ++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 2543bab..5a2ec43 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -95,7 +95,7 @@ static inline void setup_irq_channel(u32 magic, void __iomem *reg_addr)
 
 	/* Setup 64 channel slots */
 	for (i = 0; i < INTC_IRQS; i += 4)
-		writel_relaxed(build_channel_val(i, magic), reg_addr + i);
+		writel(build_channel_val(i, magic), reg_addr + i);
 }
 
 static int __init
@@ -135,16 +135,10 @@ ck_intc_init_comm(struct device_node *node, struct device_node *parent)
 static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
 				     u32 irq_base)
 {
-	u32 irq;
-
 	if (hwirq == 0)
 		return 0;
 
-	while (hwirq) {
-		irq = __ffs(hwirq);
-		hwirq &= ~BIT(irq);
-		handle_domain_irq(root_domain, irq_base + irq, regs);
-	}
+	handle_domain_irq(root_domain, irq_base + __fls(hwirq), regs);
 
 	return 1;
 }
@@ -154,12 +148,16 @@ static void gx_irq_handler(struct pt_regs *regs)
 {
 	bool ret;
 
-	do {
-		ret  = handle_irq_perbit(regs,
-				readl_relaxed(reg_base + GX_INTC_PEN31_00), 0);
-		ret |= handle_irq_perbit(regs,
-				readl_relaxed(reg_base + GX_INTC_PEN63_32), 32);
-	} while (ret);
+retry:
+	ret = handle_irq_perbit(regs,
+			readl(reg_base + GX_INTC_PEN63_32), 32);
+	if (ret)
+		goto retry;
+
+	ret = handle_irq_perbit(regs,
+			readl(reg_base + GX_INTC_PEN31_00), 0);
+	if (ret)
+		goto retry;
 }
 
 static int __init
@@ -174,14 +172,14 @@ gx_intc_init(struct device_node *node, struct device_node *parent)
 	/*
 	 * Initial enable reg to disable all interrupts
 	 */
-	writel_relaxed(0x0, reg_base + GX_INTC_NEN31_00);
-	writel_relaxed(0x0, reg_base + GX_INTC_NEN63_32);
+	writel(0x0, reg_base + GX_INTC_NEN31_00);
+	writel(0x0, reg_base + GX_INTC_NEN63_32);
 
 	/*
 	 * Initial mask reg with all unmasked, because we only use enalbe reg
 	 */
-	writel_relaxed(0x0, reg_base + GX_INTC_NMASK31_00);
-	writel_relaxed(0x0, reg_base + GX_INTC_NMASK63_32);
+	writel(0x0, reg_base + GX_INTC_NMASK31_00);
+	writel(0x0, reg_base + GX_INTC_NMASK63_32);
 
 	setup_irq_channel(0x03020100, reg_base + GX_INTC_SOURCE);
 
@@ -204,20 +202,29 @@ static void ck_irq_handler(struct pt_regs *regs)
 	void __iomem *reg_pen_lo = reg_base + CK_INTC_PEN31_00;
 	void __iomem *reg_pen_hi = reg_base + CK_INTC_PEN63_32;
 
-	do {
-		/* handle 0 - 31 irqs */
-		ret  = handle_irq_perbit(regs, readl_relaxed(reg_pen_lo), 0);
-		ret |= handle_irq_perbit(regs, readl_relaxed(reg_pen_hi), 32);
+retry:
+	/* handle 0 - 63 irqs */
+	ret = handle_irq_perbit(regs, readl(reg_pen_hi), 32);
+	if (ret)
+		goto retry;
 
-		if (nr_irq == INTC_IRQS)
-			continue;
+	ret = handle_irq_perbit(regs, readl(reg_pen_lo), 0);
+	if (ret)
+		goto retry;
+
+	if (nr_irq == INTC_IRQS)
+		return;
 
-		/* handle 64 - 127 irqs */
-		ret |= handle_irq_perbit(regs,
-			readl_relaxed(reg_pen_lo + CK_INTC_DUAL_BASE), 64);
-		ret |= handle_irq_perbit(regs,
-			readl_relaxed(reg_pen_hi + CK_INTC_DUAL_BASE), 96);
-	} while (ret);
+	/* handle 64 - 127 irqs */
+	ret = handle_irq_perbit(regs,
+			readl(reg_pen_hi + CK_INTC_DUAL_BASE), 96);
+	if (ret)
+		goto retry;
+
+	ret = handle_irq_perbit(regs,
+			readl(reg_pen_lo + CK_INTC_DUAL_BASE), 64);
+	if (ret)
+		goto retry;
 }
 
 static int __init
@@ -230,11 +237,11 @@ ck_intc_init(struct device_node *node, struct device_node *parent)
 		return ret;
 
 	/* Initial enable reg to disable all interrupts */
-	writel_relaxed(0, reg_base + CK_INTC_NEN31_00);
-	writel_relaxed(0, reg_base + CK_INTC_NEN63_32);
+	writel(0, reg_base + CK_INTC_NEN31_00);
+	writel(0, reg_base + CK_INTC_NEN63_32);
 
 	/* Enable irq intc */
-	writel_relaxed(BIT(31), reg_base + CK_INTC_ICR);
+	writel(BIT(31), reg_base + CK_INTC_ICR);
 
 	ck_set_gc(node, reg_base, CK_INTC_NEN31_00, 0);
 	ck_set_gc(node, reg_base, CK_INTC_NEN63_32, 32);
@@ -260,8 +267,8 @@ ck_dual_intc_init(struct device_node *node, struct device_node *parent)
 		return ret;
 
 	/* Initial enable reg to disable all interrupts */
-	writel_relaxed(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
-	writel_relaxed(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
+	writel(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
+	writel(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
 
 	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 64);
 	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 96);
-- 
2.7.4
