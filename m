From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 4/5] clk: sunxi: Use CLK_IS_CRITICAL flag for critical clks
Date: Tue,  2 Jan 2018 17:35:15 -0800
Message-ID: <20180103013516.18844-5-sboyd@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeACBfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 20:35:21 -0500
In-Reply-To: <20180103013516.18844-1-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>

We'd like to privatize __clk_get(), but the sunxi clk driver is
calling this function to keep a reference held on the clk and
call clk_prepare_enable() on it. We support this design in the
clk core now with the CLK_IS_CRITICAL flag, so let's just use
that instead.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/sunxi/clk-factors.c    | 26 +++++++++++++++++++++-----
 drivers/clk/sunxi/clk-factors.h    |  4 ++++
 drivers/clk/sunxi/clk-mod0.c       |  9 ++-------
 drivers/clk/sunxi/clk-sun8i-mbus.c |  7 ++-----
 drivers/clk/sunxi/clk-sun9i-core.c |  9 ++-------
 drivers/clk/sunxi/clk-sunxi.c      | 36 +++++++++++++-----------------------
 6 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 856fef65433b..f6f4757d2dd1 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -176,10 +176,10 @@ static const struct clk_ops clk_factors_ops = {
 	.set_rate = clk_factors_set_rate,
 };
 
-struct clk *sunxi_factors_register(struct device_node *node,
-				   const struct factors_data *data,
-				   spinlock_t *lock,
-				   void __iomem *reg)
+struct clk *__sunxi_factors_register(struct device_node *node,
+				     const struct factors_data *data,
+				     spinlock_t *lock, void __iomem *reg,
+				     unsigned long flags)
 {
 	struct clk *clk;
 	struct clk_factors *factors;
@@ -249,7 +249,7 @@ struct clk *sunxi_factors_register(struct device_node *node,
 			parents, i,
 			mux_hw, &clk_mux_ops,
 			&factors->hw, &clk_factors_ops,
-			gate_hw, &clk_gate_ops, 0);
+			gate_hw, &clk_gate_ops, CLK_IS_CRITICAL);
 	if (IS_ERR(clk))
 		goto err_register;
 
@@ -272,6 +272,22 @@ struct clk *sunxi_factors_register(struct device_node *node,
 	return NULL;
 }
 
+struct clk *sunxi_factors_register(struct device_node *node,
+				   const struct factors_data *data,
+				   spinlock_t *lock,
+				   void __iomem *reg)
+{
+	return __sunxi_factors_register(node, data, lock, reg, 0);
+}
+
+struct clk *sunxi_factors_register_critical(struct device_node *node,
+					    const struct factors_data *data,
+					    spinlock_t *lock,
+					    void __iomem *reg)
+{
+	return __sunxi_factors_register(node, data, lock, reg, CLK_IS_CRITICAL);
+}
+
 void sunxi_factors_unregister(struct device_node *node, struct clk *clk)
 {
 	struct clk_hw *hw = __clk_get_hw(clk);
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 824f746b2567..7ad2ca924d0d 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -55,6 +55,10 @@ struct clk *sunxi_factors_register(struct device_node *node,
 				   const struct factors_data *data,
 				   spinlock_t *lock,
 				   void __iomem *reg);
+struct clk *sunxi_factors_register_critical(struct device_node *node,
+					    const struct factors_data *data,
+					    spinlock_t *lock,
+					    void __iomem *reg);
 
 void sunxi_factors_unregister(struct device_node *node, struct clk *clk);
 
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 4417ae129ac7..a27c264cc9b4 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -155,7 +154,6 @@ static DEFINE_SPINLOCK(sun5i_a13_mbus_lock);
 
 static void __init sun5i_a13_mbus_setup(struct device_node *node)
 {
-	struct clk *mbus;
 	void __iomem *reg;
 
 	reg = of_iomap(node, 0);
@@ -164,12 +162,9 @@ static void __init sun5i_a13_mbus_setup(struct device_node *node)
 		return;
 	}
 
-	mbus = sunxi_factors_register(node, &sun4i_a10_mod0_data,
-				      &sun5i_a13_mbus_lock, reg);
-
 	/* The MBUS clocks needs to be always enabled */
-	__clk_get(mbus);
-	clk_prepare_enable(mbus);
+	sunxi_factors_register_critical(node, &sun4i_a10_mod0_data,
+					&sun5i_a13_mbus_lock, reg);
 }
 CLK_OF_DECLARE(sun5i_a13_mbus, "allwinner,sun5i-a13-mbus-clk", sun5i_a13_mbus_setup);
 
diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
index b200ebf159ee..56db89b6979f 100644
--- a/drivers/clk/sunxi/clk-sun8i-mbus.c
+++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -82,11 +81,12 @@ static void __init sun8i_a23_mbus_setup(struct device_node *node)
 	mux->mask = SUN8I_MBUS_MUX_MASK;
 	mux->lock = &sun8i_a23_mbus_lock;
 
+	/* The MBUS clocks needs to be always enabled */
 	clk = clk_register_composite(NULL, clk_name, parents, num_parents,
 				     &mux->hw, &clk_mux_ops,
 				     &div->hw, &clk_divider_ops,
 				     &gate->hw, &clk_gate_ops,
-				     0);
+				     CLK_IS_CRITICAL);
 	if (IS_ERR(clk))
 		goto err_free_gate;
 
@@ -95,9 +95,6 @@ static void __init sun8i_a23_mbus_setup(struct device_node *node)
 		goto err_unregister_clk;
 
 	kfree(parents); /* parents is deep copied */
-	/* The MBUS clocks needs to be always enabled */
-	__clk_get(clk);
-	clk_prepare_enable(clk);
 
 	return;
 
diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index 43f014f85803..e9295c286d5d 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -140,7 +139,6 @@ static DEFINE_SPINLOCK(sun9i_a80_gt_lock);
 static void __init sun9i_a80_gt_setup(struct device_node *node)
 {
 	void __iomem *reg;
-	struct clk *gt;
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
@@ -149,12 +147,9 @@ static void __init sun9i_a80_gt_setup(struct device_node *node)
 		return;
 	}
 
-	gt = sunxi_factors_register(node, &sun9i_a80_gt_data,
-				    &sun9i_a80_gt_lock, reg);
-
 	/* The GT bus clock needs to be always enabled */
-	__clk_get(gt);
-	clk_prepare_enable(gt);
+	sunxi_factors_register_critical(node, &sun9i_a80_gt_data,
+					&sun9i_a80_gt_lock, reg);
 }
 CLK_OF_DECLARE(sun9i_a80_gt, "allwinner,sun9i-a80-gt-clk", sun9i_a80_gt_setup);
 
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index aa4add580516..012714d94b42 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -656,7 +656,8 @@ static const struct mux_data sun8i_h3_ahb2_mux_data __initconst = {
 };
 
 static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
-					       const struct mux_data *data)
+					       const struct mux_data *data,
+					       unsigned long flags)
 {
 	struct clk *clk;
 	const char *clk_name = node->name;
@@ -678,7 +679,7 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
 	}
 
 	clk = clk_register_mux(NULL, clk_name, parents, i,
-			       CLK_SET_RATE_PARENT, reg,
+			       CLK_SET_RATE_PARENT | flags, reg,
 			       data->shift, SUNXI_MUX_GATE_WIDTH,
 			       0, &clk_lock);
 
@@ -703,29 +704,22 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
 
 static void __init sun4i_cpu_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
-
-	clk = sunxi_mux_clk_setup(node, &sun4i_cpu_mux_data);
-	if (!clk)
-		return;
-
 	/* Protect CPU clock */
-	__clk_get(clk);
-	clk_prepare_enable(clk);
+	sunxi_mux_clk_setup(node, &sun4i_cpu_mux_data, CLK_IS_CRITICAL);
 }
 CLK_OF_DECLARE(sun4i_cpu, "allwinner,sun4i-a10-cpu-clk",
 	       sun4i_cpu_clk_setup);
 
 static void __init sun6i_ahb1_mux_clk_setup(struct device_node *node)
 {
-	sunxi_mux_clk_setup(node, &sun6i_a31_ahb1_mux_data);
+	sunxi_mux_clk_setup(node, &sun6i_a31_ahb1_mux_data, 0);
 }
 CLK_OF_DECLARE(sun6i_ahb1_mux, "allwinner,sun6i-a31-ahb1-mux-clk",
 	       sun6i_ahb1_mux_clk_setup);
 
 static void __init sun8i_ahb2_clk_setup(struct device_node *node)
 {
-	sunxi_mux_clk_setup(node, &sun8i_h3_ahb2_mux_data);
+	sunxi_mux_clk_setup(node, &sun8i_h3_ahb2_mux_data, 0);
 }
 CLK_OF_DECLARE(sun8i_ahb2, "allwinner,sun8i-h3-ahb2-clk",
 	       sun8i_ahb2_clk_setup);
@@ -900,6 +894,7 @@ struct divs_data {
 		u8 shift; /* otherwise it's a normal divisor with this shift */
 		u8 pow;   /* is it power-of-two based? */
 		u8 gate;  /* is it independently gateable? */
+		bool critical;
 	} div[SUNXI_DIVS_MAX_QTY];
 };
 
@@ -915,7 +910,8 @@ static const struct divs_data pll5_divs_data __initconst = {
 	.factors = &sun4i_pll5_data,
 	.ndivs = 2,
 	.div = {
-		{ .shift = 0, .pow = 0, }, /* M, DDR */
+		/* Protect PLL5_DDR */
+		{ .shift = 0, .pow = 0, .critical = true }, /* M, DDR */
 		{ .shift = 16, .pow = 1, }, /* P, other */
 		/* No output for the base factor clock */
 	}
@@ -1089,7 +1085,9 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 						 NULL, NULL,
 						 rate_hw, rate_ops,
 						 gate_hw, &clk_gate_ops,
-						 clkflags);
+						 clkflags |
+						 data->div[i].critical ?
+							CLK_IS_CRITICAL : 0);
 
 		WARN_ON(IS_ERR(clk_data->clks[i]));
 	}
@@ -1117,15 +1115,7 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 
 static void __init sun4i_pll5_clk_setup(struct device_node *node)
 {
-	struct clk **clks;
-
-	clks = sunxi_divs_clk_setup(node, &pll5_divs_data);
-	if (!clks)
-		return;
-
-	/* Protect PLL5_DDR */
-	__clk_get(clks[0]);
-	clk_prepare_enable(clks[0]);
+	sunxi_divs_clk_setup(node, &pll5_divs_data);
 }
 CLK_OF_DECLARE(sun4i_pll5, "allwinner,sun4i-a10-pll5-clk",
 	       sun4i_pll5_clk_setup);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
