Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:38205 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbbBTSBn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Feb 2015 13:01:43 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v2 04/18] clocksource: Add ARM System timer driver
Date: Fri, 20 Feb 2015 19:01:03 +0100
Message-Id: <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

This patch adds clocksource support for ARMv7-M's System timer,
also known as SysTick.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/clocksource/Kconfig          |  7 ++++
 drivers/clocksource/Makefile         |  1 +
 drivers/clocksource/armv7m_systick.c | 78 ++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/clocksource/armv7m_systick.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index fc01ec2..fb6011e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -124,6 +124,13 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	help
 	 Use ARM global timer clock source as sched_clock
 
+config ARMV7M_SYSTICK
+	bool
+	select CLKSRC_OF if OF
+	select CLKSRC_MMIO
+	help
+	  This options enables support for the ARMv7M system timer unit
+
 config ATMEL_PIT
 	select CLKSRC_OF if OF
 	def_bool SOC_AT91SAM9 || SOC_SAMA5
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 94d90b2..eeea736 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
+obj-$(CONFIG_ARMV7M_SYSTICK)		+= armv7m_systick.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
diff --git a/drivers/clocksource/armv7m_systick.c b/drivers/clocksource/armv7m_systick.c
new file mode 100644
index 0000000..23d8249
--- /dev/null
+++ b/drivers/clocksource/armv7m_systick.c
@@ -0,0 +1,78 @@
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
+	u32 rate = 0;
+	int ret;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_warn("system-timer: invalid base address\n");
+		return;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			clk_put(clk);
+			goto out_unmap;
+		}
+
+		rate = clk_get_rate(clk);
+	}
+
+	/* If no clock found, try to get clock-frequency property */
+	if (!rate) {
+		ret = of_property_read_u32(np, "clock-frequency", &rate);
+		if (ret)
+			goto out_unmap;
+	}
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
+	if (!IS_ERR(clk))
+		clk_disable_unprepare(clk);
+out_unmap:
+	iounmap(base);
+	WARN(ret, "ARM System timer register failed (%d)\n", ret);
+}
+
+CLOCKSOURCE_OF_DECLARE(arm_systick, "arm,armv7m-systick",
+			system_timer_of_register);
-- 
1.9.1

