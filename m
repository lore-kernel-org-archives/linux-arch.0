From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v10 16/19] h8300: clock driver
Date: Mon,  4 May 2015 19:41:59 +0900
Message-ID: <1430736122-20929-18-git-send-email-ysato@users.sourceforge.jp>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:59226 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbbEDKnJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 06:43:09 -0400
In-Reply-To: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

H8/300 clock driver
clk-div: common clock divier
clk-h8s2678: PLL driver

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/clock/renesas,h8300-div-clock.txt     |  24 ++++
 .../bindings/clock/renesas,h8s2678-pll-clock.txt   |  23 ++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/h8300/Makefile                         |   2 +
 drivers/clk/h8300/clk-div.c                        |  53 ++++++++
 drivers/clk/h8300/clk-h8s2678.c                    | 147 +++++++++++++++++++++
 6 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
 create mode 100644 drivers/clk/h8300/Makefile
 create mode 100644 drivers/clk/h8300/clk-div.c
 create mode 100644 drivers/clk/h8300/clk-h8s2678.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt b/Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
new file mode 100644
index 0000000..36c2b52
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
@@ -0,0 +1,24 @@
+* Renesas H8/300 divider clock
+
+Required Properties:
+
+  - compatible: Must be "renesas,sh73a0-h8300-div-clock"
+
+  - clocks: Reference to the parent clocks ("extal1" and "extal2")
+
+  - #clock-cells: Must be 1
+
+  - reg: Base address and length of the divide rate selector
+
+  - renesas,width: bit width of selector
+
+Example
+-------
+
+		cclk: cclk {
+			compatible = "renesas,h8300-div-clock";
+			clocks = <&xclk>;
+			#clock-cells = <0>;
+			reg = <0xfee01b 2>;
+			renesas,width = <2>;
+		};
diff --git a/Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt b/Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
new file mode 100644
index 0000000..500cdadb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
@@ -0,0 +1,23 @@
+Renesas H8S2678 PLL clock
+
+This device is Clock multiplyer
+
+Required Properties:
+
+  - compatible: Must be "renesas,h8s2678-pll-clock"
+
+  - clocks: Reference to the parent clocks
+
+  - #clock-cells: Must be 0
+
+  - reg: Two rate selector (Multiply / Divide) register address
+
+Example
+-------
+
+		pllclk: pllclk {
+			compatible = "renesas,h8s2678-pll-clock";
+			clocks = <&xclk>;
+			#clock-cells = <0>;
+			reg = <0xfee03b 2>, <0xfee045 2>;
+		};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3d00c25..9df871d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -73,3 +73,4 @@ obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_H8300)		+= h8300/
diff --git a/drivers/clk/h8300/Makefile b/drivers/clk/h8300/Makefile
new file mode 100644
index 0000000..b86427c3
--- /dev/null
+++ b/drivers/clk/h8300/Makefile
@@ -0,0 +1,2 @@
+obj-y += clk-div.o
+obj-$(CONFIG_H8S2678) += clk-h8s2678.o
diff --git a/drivers/clk/h8300/clk-div.c b/drivers/clk/h8300/clk-div.c
new file mode 100644
index 0000000..56f9eba
--- /dev/null
+++ b/drivers/clk/h8300/clk-div.c
@@ -0,0 +1,53 @@
+/*
+ * H8/300 divide clock driver
+ *
+ * Copyright 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+static DEFINE_SPINLOCK(clklock);
+
+static void __init h8300_div_clk_setup(struct device_node *node)
+{
+	unsigned int num_parents;
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	void __iomem *divcr = NULL;
+	int width;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: no parent found", clk_name);
+		return;
+	}
+
+	divcr = of_iomap(node, 0);
+	if (divcr == NULL) {
+		pr_err("%s: failed to map divide register", clk_name);
+		goto error;
+	}
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	of_property_read_u32(node, "renesas,width", &width);
+	clk = clk_register_divider(NULL, clk_name, parent_name,
+				   CLK_SET_RATE_GATE, divcr, 0, width,
+				   CLK_DIVIDER_POWER_OF_TWO, &clklock);
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return;
+	}
+	pr_err("%s: failed to register %s div clock (%ld)\n",
+	       __func__, clk_name, PTR_ERR(clk));
+error:
+	if (divcr)
+		iounmap(divcr);
+}
+
+CLK_OF_DECLARE(h8300_div_clk, "renesas,h8300-div-clock", h8300_div_clk_setup);
diff --git a/drivers/clk/h8300/clk-h8s2678.c b/drivers/clk/h8300/clk-h8s2678.c
new file mode 100644
index 0000000..4de7ee5
--- /dev/null
+++ b/drivers/clk/h8300/clk-h8s2678.c
@@ -0,0 +1,147 @@
+/*
+ * H8S2678 clock driver
+ *
+ * Copyright 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/of_address.h>
+
+static DEFINE_SPINLOCK(clklock);
+
+#define MAX_FREQ 33333333
+#define MIN_FREQ  8000000
+
+struct pll_clock {
+	struct clk_hw hw;
+	void __iomem *sckcr;
+	void __iomem *pllcr;
+};
+
+#define to_pll_clock(_hw) container_of(_hw, struct pll_clock, hw)
+
+static unsigned long pll_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct pll_clock *pll_clock = to_pll_clock(hw);
+	int mul = 1 << (ctrl_inb((unsigned long)pll_clock->pllcr) & 3);
+
+	return parent_rate * mul;
+}
+
+static long pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	int i, m = -1;
+	long offset[3];
+
+	if (rate > MAX_FREQ)
+		rate = MAX_FREQ;
+	if (rate < MIN_FREQ)
+		rate = MIN_FREQ;
+
+	for (i = 0; i < 3; i++)
+		offset[i] = abs(rate - (*prate * (1 << i)));
+	for (i = 0; i < 3; i++)
+		if (m < 0)
+			m = i;
+		else
+			m = (offset[i] < offset[m])?i:m;
+
+	return *prate * (1 << m);
+}
+
+static int pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	int pll;
+	unsigned char val;
+	unsigned long flags;
+	struct pll_clock *pll_clock = to_pll_clock(hw);
+
+	pll = ((rate / parent_rate) / 2) & 0x03;
+	spin_lock_irqsave(&clklock, flags);
+	val = ctrl_inb((unsigned long)pll_clock->sckcr);
+	val |= 0x08;
+	ctrl_outb(val, (unsigned long)pll_clock->sckcr);
+	val = ctrl_inb((unsigned long)pll_clock->pllcr);
+	val &= ~0x03;
+	val |= pll;
+	ctrl_outb(val, (unsigned long)pll_clock->pllcr);
+	spin_unlock_irqrestore(&clklock, flags);
+	return 0;
+}
+
+static const struct clk_ops pll_ops = {
+	.recalc_rate = pll_recalc_rate,
+	.round_rate = pll_round_rate,
+	.set_rate = pll_set_rate,
+};
+
+static void __init h8s2678_pll_clk_setup(struct device_node *node)
+{
+	unsigned int num_parents;
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	struct pll_clock *pll_clock;
+	struct clk_init_data init;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: no parent found", clk_name);
+		return;
+	}
+
+
+	pll_clock = kzalloc(sizeof(struct pll_clock), GFP_KERNEL);
+	if (!pll_clock) {
+		pr_err("%s: failed to alloc memory", clk_name);
+		return;
+	}
+
+	pll_clock->sckcr = of_iomap(node, 0);
+	if (pll_clock->sckcr == NULL) {
+		pr_err("%s: failed to map divide register", clk_name);
+		goto error;
+	}
+
+	pll_clock->pllcr = of_iomap(node, 1);
+	if (pll_clock->pllcr == NULL) {
+		pr_err("%s: failed to map multiply register", clk_name);
+		goto error;
+	}
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.name = clk_name;
+	init.ops = &pll_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	pll_clock->hw.init = &init;
+
+	clk = clk_register(NULL, &pll_clock->hw);
+	if (IS_ERR(clk))
+		kfree(pll_clock);
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return;
+	}
+	pr_err("%s: failed to register %s div clock (%ld)\n",
+	       __func__, clk_name, PTR_ERR(clk));
+error:
+	if (pll_clock) {
+		if (pll_clock->sckcr)
+			iounmap(pll_clock->sckcr);
+		if (pll_clock->pllcr)
+			iounmap(pll_clock->pllcr);
+		kfree(pll_clock);
+	}
+}
+
+CLK_OF_DECLARE(h8s2678_div_clk, "renesas,h8s2678-pll-clock",
+	       h8s2678_pll_clk_setup);
-- 
2.1.4
