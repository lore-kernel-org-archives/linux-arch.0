Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:18154 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbbBOHt6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Feb 2015 02:49:58 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 11/15] h8300: clock driver
Date: Sun, 15 Feb 2015 16:49:29 +0900
Message-ID: <1423986573-2329-12-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150215074929.rWXJl14pveRZMi428uo9vLii7FvZ3BijOfrkvyqz-78@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/clk/Makefile            |   1 +
 drivers/clk/h8300/Makefile      |   2 +
 drivers/clk/h8300/clk-h83069.c  |  73 ++++++++++++++++++
 drivers/clk/h8300/clk-h8s2678.c | 165 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h    |  12 +++
 5 files changed, 253 insertions(+)
 create mode 100644 drivers/clk/h8300/Makefile
 create mode 100644 drivers/clk/h8300/clk-h83069.c
 create mode 100644 drivers/clk/h8300/clk-h8s2678.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..37b6e87 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_H8300)		+= h8300/
diff --git a/drivers/clk/h8300/Makefile b/drivers/clk/h8300/Makefile
new file mode 100644
index 0000000..82eab42
--- /dev/null
+++ b/drivers/clk/h8300/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_H83069) += clk-h83069.o
+obj-$(CONFIG_H8S2678) += clk-h8s2678.o
diff --git a/drivers/clk/h8300/clk-h83069.c b/drivers/clk/h8300/clk-h83069.c
new file mode 100644
index 0000000..3334f49
--- /dev/null
+++ b/drivers/clk/h8300/clk-h83069.c
@@ -0,0 +1,73 @@
+/*
+ * H8/3069 clock driver
+ *
+ * Copyright 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+static DEFINE_SPINLOCK(clklock);
+
+#define DIVCR (unsigned char *)0xfee01b
+#define DEVNAME "h83069-cpg"
+
+static int clk_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+	int *hz = dev_get_platdata(&pdev->dev);
+
+	clk = clk_register_fixed_rate(&pdev->dev, "master_clk", NULL,
+				      CLK_IS_ROOT, *hz);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to register clock");
+		return PTR_ERR(clk);
+	}
+	clk_register_clkdev(clk, "master_clk", DEVNAME ".%d", 0);
+
+	clk = clk_register_divider(&pdev->dev, "core_clk", "master_clk",
+				   CLK_SET_RATE_GATE, DIVCR, 0, 2,
+				   CLK_DIVIDER_POWER_OF_TWO, &clklock);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to register clock");
+		return PTR_ERR(clk);
+	}
+	clk_register_clkdev(clk, "core_clk", DEVNAME ".%d", 0);
+
+	clk_add_alias("peripheral_clk", NULL, "core_clk", &pdev->dev);
+	return 0;
+}
+
+static struct platform_driver cpg_driver = {
+	.driver = {
+		.name = DEVNAME,
+	},
+	.probe = clk_probe,
+};
+
+early_platform_init(DEVNAME, &cpg_driver);
+
+static struct platform_device clk_device = {
+	.name		= DEVNAME,
+	.id		= 0,
+};
+
+static struct platform_device *devices[] __initdata = {
+	&clk_device,
+};
+
+int __init h8300_clk_init(int hz)
+{
+	static int master_hz;
+	master_hz = hz;
+	clk_device.dev.platform_data = &master_hz;
+	early_platform_add_devices(devices,
+				   ARRAY_SIZE(devices));
+	early_platform_driver_register_all(DEVNAME);
+	early_platform_driver_probe(DEVNAME, 1, 0);
+	return 0;
+}
diff --git a/drivers/clk/h8300/clk-h8s2678.c b/drivers/clk/h8300/clk-h8s2678.c
new file mode 100644
index 0000000..98cb28f
--- /dev/null
+++ b/drivers/clk/h8300/clk-h8s2678.c
@@ -0,0 +1,165 @@
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
+#include <linux/platform_device.h>
+
+static DEFINE_SPINLOCK(clklock);
+
+#define SCKCR 0xffff3b
+#define PLLCR 0xffff45
+#define DEVNAME "h8s2679-cpg"
+#define MAX_FREQ 33333333
+#define MIN_FREQ  8000000
+
+static unsigned long pll_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	int mul = 1 << (ctrl_inb(PLLCR) & 3);
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
+
+	pll = ((rate / parent_rate) / 2) & 0x03;
+	spin_lock_irqsave(&clklock, flags);
+	val = ctrl_inb(SCKCR);
+	val |= 0x08;
+	ctrl_outb(val, SCKCR);
+	val = ctrl_inb(PLLCR);
+	val &= ~0x03;
+	val |= pll;
+	ctrl_outb(val, PLLCR);
+	spin_unlock_irqrestore(&clklock, flags);
+	return 0;
+}
+
+const static struct clk_ops pll_ops = {
+	.recalc_rate = pll_recalc_rate,
+	.round_rate = pll_round_rate,
+	.set_rate = pll_set_rate,
+};
+
+static struct clk *pll_clk_register(struct device *dev, const char *name,
+				const char *parent)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
+	if (!hw) {
+		dev_err(dev, "failed to allocate hw\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	init.name = name;
+	init.ops = &pll_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent;
+	init.num_parents = 1;
+	hw->init = &init;
+
+	clk = clk_register(dev, hw);
+	if (IS_ERR(clk))
+		kfree(hw);
+
+	return clk;
+}
+	
+static int clk_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+	int *hz = dev_get_platdata(&pdev->dev);
+
+	clk = clk_register_fixed_rate(&pdev->dev, "master_clk", NULL,
+				      CLK_IS_ROOT, *hz);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to register clock");
+		return PTR_ERR(clk);
+	}
+	clk_register_clkdev(clk, "master_clk", DEVNAME ".%d", 0);
+
+	clk = pll_clk_register(&pdev->dev, "pll_clk", "master_clk");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to register clock");
+		return PTR_ERR(clk);
+	}
+	clk_register_clkdev(clk, "pll_clk", DEVNAME ".%d", 0);
+	
+	clk = clk_register_divider(&pdev->dev, "core_clk", "pll_clk",
+				   CLK_SET_RATE_GATE, (unsigned char *)SCKCR,
+				   0, 3, CLK_DIVIDER_POWER_OF_TWO, &clklock);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to register clock");
+		return PTR_ERR(clk);
+	}
+	clk_register_clkdev(clk, "core_clk", DEVNAME ".%d", 0);
+
+	clk_add_alias("peripheral_clk", NULL, "core_clk", &pdev->dev);
+	return 0;
+}
+
+static struct platform_driver cpg_driver = {
+	.driver = {
+		.name = DEVNAME,
+	},
+	.probe = clk_probe,
+};
+
+early_platform_init(DEVNAME, &cpg_driver);
+
+static struct platform_device clk_device = {
+	.name		= DEVNAME,
+	.id		= 0,
+};
+
+static struct platform_device *devices[] __initdata = {
+	&clk_device,
+};
+
+int __init h8300_clk_init(int hz)
+{
+	static int master_hz;
+	master_hz = hz;
+	clk_device.dev.platform_data = &master_hz;
+	early_platform_add_devices(devices,
+				   ARRAY_SIZE(devices));
+	early_platform_driver_register_all(DEVNAME);
+	early_platform_driver_probe(DEVNAME, 1, 0);
+	return 0;
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d936409..d4a41b5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -635,6 +635,18 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
 	iowrite32be(val, reg);
 }
 
+#elif IS_ENABLED(CONFIG_H8300)
+
+static inline u32 clk_readl(u32 __iomem *reg)
+{
+	return readb(reg);
+}
+
+static inline void clk_writel(u32 val, u32 __iomem *reg)
+{
+	writeb(val, reg);
+}
+
 #else	/* platform dependent I/O accessors */
 
 static inline u32 clk_readl(u32 __iomem *reg)
-- 
2.1.4

