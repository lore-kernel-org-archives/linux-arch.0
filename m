Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f66.google.com ([74.125.82.66]:53800 "EHLO
	mail-wg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbbBLRqW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 12:46:22 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 03/14] clocksource: Add ARM System timer driver
Date: Thu, 12 Feb 2015 18:45:53 +0100
Message-Id: <1423763164-5606-4-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

This patch adds clocksource support for ARMv7-M's System timer,
also known as SysTick.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/arm/system_timer.txt       | 15 +++++
 drivers/clocksource/Kconfig                        |  7 ++
 drivers/clocksource/Makefile                       |  1 +
 drivers/clocksource/arm_system_timer.c             | 74 ++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/system_timer.txt
 create mode 100644 drivers/clocksource/arm_system_timer.c

diff --git a/Documentation/devicetree/bindings/arm/system_timer.txt b/Documentation/devicetree/bindings/arm/system_timer.txt
new file mode 100644
index 0000000..35268b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/system_timer.txt
@@ -0,0 +1,15 @@
+* ARM System Timer
+
+ARMv7-M includes a system timer, known as SysTick. Current driver only
+implements the clocksource feature.
+
+Required properties:
+- compatible : Should be "arm,armv7m-systick"
+- reg	     : The address range of the timer
+- clocks     : The input clock of the timer
+
+systick: system-timer {
+	compatible = "arm,armv7m-systick";
+	reg = <0xe000e010 0x10>;
+	clocks = <&clk_systick>;
+};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index fc01ec2..f9fe4ac 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -124,6 +124,13 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	help
 	 Use ARM global timer clock source as sched_clock
 
+config ARM_SYSTEM_TIMER
+	bool
+	select CLKSRC_OF if OF
+	select CLKSRC_MMIO
+	help
+	  This options enables support for the ARM system timer unit
+
 config ATMEL_PIT
 	select CLKSRC_OF if OF
 	def_bool SOC_AT91SAM9 || SOC_SAMA5
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 94d90b2..194400b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
+obj-$(CONFIG_ARM_SYSTEM_TIMER)		+= arm_system_timer.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
diff --git a/drivers/clocksource/arm_system_timer.c b/drivers/clocksource/arm_system_timer.c
new file mode 100644
index 0000000..69e6ef9
--- /dev/null
+++ b/drivers/clocksource/arm_system_timer.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk.h>
+#include <linux/bitops.h>
+
+#define SYST_CSR	0x00
+#define SYST_RVR	0x04
+#define SYST_CVR	0x08
+#define SYST_CALIB	0x0c
+
+#define SYST_CSR_ENABLE BIT(0)
+
+#define SYSTICK_LOAD_RELOAD_MASK 0x00FFFFFF
+
+static void __init system_timer_of_register(struct device_node *np)
+{
+	struct clk *clk;
+	void __iomem *base;
+	unsigned long rate;
+	int ret;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_warn("system-timer: invalid base address\n");
+		return;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_warn("system-timer: clk not found\n");
+		ret = PTR_ERR(clk);
+		goto out_unmap;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto out_clk_put;
+
+	rate = clk_get_rate(clk);
+
+	writel_relaxed(SYSTICK_LOAD_RELOAD_MASK, base + SYST_RVR);
+	writel_relaxed(SYST_CSR_ENABLE, base + SYST_CSR);
+
+	ret = clocksource_mmio_init(base + SYST_CVR, "arm_system_timer", rate,
+			200, 24, clocksource_mmio_readl_down);
+	if (ret) {
+		pr_err("failed to init clocksource (%d)\n", ret);
+		goto out_clk_disable;
+	}
+
+	pr_info("ARM System timer initialized as clocksource\n");
+
+	return;
+
+out_clk_disable:
+	clk_disable_unprepare(clk);
+out_clk_put:
+	clk_put(clk);
+out_unmap:
+	iounmap(base);
+	WARN(ret, "ARM System timer register failed (%d)\n", ret);
+}
+
+CLOCKSOURCE_OF_DECLARE(arm_systick, "arm,armv7m-systick",
+			system_timer_of_register);
-- 
1.9.1

