From: guoren@kernel.org
Subject: [PATCH 04/10] irqchip/csky: Optimize remove unnecessary loop irq handle
Date: Tue, 29 Jan 2019 20:24:23 +0800
Message-ID: <1548764669-16656-4-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Here is the previous interrupt processing flow:
while (pending) {
^^^^^^^^^^^^^^^ It's unnecessary!
	get irq
	handle_level/fasteoi_irq {
		mask irq
		driver irq handler
		unmask irq
	}
	irq_exit {
		preempt_count_sub(HARDIRQ_OFFSET);
		if (!in_interrupt() && local_softirq_pending())
			invoke_softirq();
Because:		^^^^^^^^^^^^^^^^ linux enable irq Here!
	}
}

Because linux enable the irq in irq_exit() before ret, we needn't loop
read pending register again for next irq which is done during irq_exit().

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-apb-intc.c | 36 ++++++++++++++++++------------------
 drivers/irqchip/irq-csky-mpintc.c   |  8 ++------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index fcc5444..ae4c59b 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -150,7 +150,7 @@ ck_intc_init_comm(struct device_node *node, struct device_node *parent)
 	return 0;
 }
 
-static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
+static inline bool handle_irq_onebit(struct pt_regs *regs, u32 hwirq,
 				     u32 irq_base)
 {
 	if (hwirq == 0)
@@ -166,16 +166,15 @@ static void gx_irq_handler(struct pt_regs *regs)
 {
 	bool ret;
 
-retry:
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_base + GX_INTC_PEN63_32), 32);
 	if (ret)
-		goto retry;
+		return;
 
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_base + GX_INTC_PEN31_00), 0);
-	if (ret)
-		goto retry;
+	if (!ret)
+		pr_err("%s: none irq pending!\n", __func__);
 }
 
 static int __init
@@ -277,29 +276,30 @@ static void ck_irq_handler(struct pt_regs *regs)
 	void __iomem *reg_pen_lo = reg_base + CK_INTC_PEN31_00;
 	void __iomem *reg_pen_hi = reg_base + CK_INTC_PEN63_32;
 
-retry:
 	/* handle 0 - 63 irqs */
-	ret = handle_irq_perbit(regs, readl(reg_pen_hi), 32);
+	ret = handle_irq_onebit(regs, readl(reg_pen_hi), 32);
 	if (ret)
-		goto retry;
+		return;
 
-	ret = handle_irq_perbit(regs, readl(reg_pen_lo), 0);
+	ret = handle_irq_onebit(regs, readl(reg_pen_lo), 0);
 	if (ret)
-		goto retry;
+		return;
 
-	if (nr_irq == INTC_IRQS)
+	if (nr_irq == INTC_IRQS) {
+		pr_err("%s: none irq pending!\n", __func__);
 		return;
+	}
 
 	/* handle 64 - 127 irqs */
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_pen_hi + CK_INTC_DUAL_BASE), 96);
 	if (ret)
-		goto retry;
+		return;
 
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_pen_lo + CK_INTC_DUAL_BASE), 64);
-	if (ret)
-		goto retry;
+	if (!ret)
+		pr_err("%s: none irq pending!\n", __func__);
 }
 
 static int __init
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index c67c961..99d3f3f 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -33,7 +33,6 @@ static void __iomem *INTCL_base;
 
 #define INTCL_PICTLR	0x0
 #define INTCL_SIGR	0x60
-#define INTCL_HPPIR	0x68
 #define INTCL_RDYIR	0x6c
 #define INTCL_SENR	0xa0
 #define INTCL_CENR	0xa4
@@ -45,11 +44,8 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
-	do {
-		handle_domain_irq(root_domain,
-				  readl_relaxed(reg_base + INTCL_RDYIR),
-				  regs);
-	} while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
+	handle_domain_irq(root_domain,
+		readl_relaxed(reg_base + INTCL_RDYIR), regs);
 }
 
 static void csky_mpintc_enable(struct irq_data *d)
-- 
2.7.4
