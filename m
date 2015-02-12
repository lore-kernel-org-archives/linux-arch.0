Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f66.google.com ([74.125.82.66]:63564 "EHLO
	mail-wg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbBLRqe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 12:46:34 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 07/14] clockevent: Add STM32 Timer driver
Date: Thu, 12 Feb 2015 18:45:57 +0100
Message-Id: <1423763164-5606-8-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

STM32 MCUs feature 16 and 32 bits general purpose timers with prescalers.
The drivers detects whether the time is 16 or 32 bits, and applies a
1024 prescaler value if it is 16 bits.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/timer/st,stm32-timer.txt   |  19 +++
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-stm32.c                  | 187 +++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt
 create mode 100644 drivers/clocksource/timer-stm32.c

diff --git a/Documentation/devicetree/bindings/timer/st,stm32-timer.txt b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
new file mode 100644
index 0000000..7fffcd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
@@ -0,0 +1,19 @@
+. STMicroelectronics STM32 timer
+
+The STM32 MCUs family has several general-purpose 16 and 32 bits timers.
+
+Required properties:
+- compatible : Should be st,stm32-timer"
+- reg : Address and length of the register set
+- clocks : Reference on the timer input clock
+- interrupts : Reference to the timer interrupt
+
+Example:
+
+timer5: timer@40000c00 {
+	compatible = "st,stm32-timer";
+	reg = <0x40000c00 0x400>;
+	interrupts = <50>;
+	resets = <&reset_apb1 3>;
+	clocks = <&clk_pmtr1>;
+};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f9fe4ac..74b60a7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -91,6 +91,15 @@ config CLKSRC_EFM32
 	  Support to use the timers of EFM32 SoCs as clock source and clock
 	  event device.
 
+config CLKSRC_STM32
+	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
+	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
+	select CLKSRC_MMIO
+	default ARCH_STM32
+	help
+	  Support to use the timers of STM32 SoCs as clock source and clock
+	  event device.
+
 config ARM_ARCH_TIMER
 	bool
 	select CLKSRC_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 194400b..16a7c6c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_ARCH_NSPIRE)	+= zevio-timer.o
 obj-$(CONFIG_ARCH_BCM_MOBILE)	+= bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
 obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
+obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
 obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
new file mode 100644
index 0000000..9839f57
--- /dev/null
+++ b/drivers/clocksource/timer-stm32.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * Inspired by time-efm32.c from Uwe Kleine-Koenig
+ */
+
+#include <linux/kernel.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+#define TIM_CR1		0x00
+#define TIM_DIER	0x0c
+#define TIM_SR		0x10
+#define TIM_EGR		0x14
+#define TIM_PSC		0x28
+#define TIM_ARR		0x2c
+
+#define TIM_CR1_CEN	BIT(0)
+#define TIM_CR1_OPM	BIT(3)
+#define TIM_CR1_ARPE	BIT(7)
+
+#define TIM_DIER_UIE	BIT(0)
+
+#define TIM_SR_UIF	BIT(0)
+
+#define TIM_EGR_UG	BIT(0)
+
+struct stm32_clock_event_ddata {
+	struct clock_event_device evtdev;
+	unsigned periodic_top;
+	void __iomem *base;
+};
+
+static void stm32_clock_event_set_mode(enum clock_event_mode mode,
+				       struct clock_event_device *evtdev)
+{
+	struct stm32_clock_event_ddata *data =
+		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
+	void *base = data->base;
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		writel_relaxed(data->periodic_top, base + TIM_ARR);
+		writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, base + TIM_CR1);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+	default:
+		writel_relaxed(0, base + TIM_CR1);
+		break;
+	}
+}
+
+static int stm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *evtdev)
+{
+	struct stm32_clock_event_ddata *data =
+		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(evt, data->base + TIM_ARR);
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_OPM | TIM_CR1_CEN,
+		       data->base + TIM_CR1);
+
+	return 0;
+}
+
+static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
+{
+	struct stm32_clock_event_ddata *data = dev_id;
+
+	writel_relaxed(0, data->base + TIM_SR);
+
+	data->evtdev.event_handler(&data->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct stm32_clock_event_ddata clock_event_ddata = {
+	.evtdev = {
+		.name = "stm32 clockevent",
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+		.set_mode = stm32_clock_event_set_mode,
+		.set_next_event = stm32_clock_event_set_next_event,
+		.rating = 200,
+	},
+};
+
+static void __init stm32_clockevent_init(struct device_node *np)
+{
+	struct stm32_clock_event_ddata *data = &clock_event_ddata;
+	struct clk *clk;
+	struct reset_control *rstc;
+	unsigned long rate, max_delta;
+	int irq, ret, bits, prescaler = 1;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("failed to get clock for clockevent (%d)\n", ret);
+		goto err_clk_get;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable timer clock for clockevent (%d)\n",
+		       ret);
+		goto err_clk_enable;
+	}
+
+	rate = clk_get_rate(clk);
+
+	rstc = of_reset_control_get(np, NULL);
+	if (IS_ERR(rstc)) {
+		pr_err("%s: Failed to get reset\n", np->full_name);
+		return;
+	}
+
+	reset_control_assert(rstc);
+	reset_control_deassert(rstc);
+
+	data->base = of_iomap(np, 0);
+	if (!data->base) {
+		pr_err("failed to map registers for clockevent\n");
+		goto err_iomap;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("%s: failed to get irq.\n", np->full_name);
+		goto err_get_irq;
+	}
+
+	/* Detect whether the timer is 16 or 32 bits */
+	writel_relaxed(~0UL, data->base + TIM_ARR);
+	max_delta = readl_relaxed(data->base + TIM_ARR);
+	if (max_delta == ~0UL) {
+		prescaler = 1;
+		bits = 32;
+	} else {
+		prescaler = 1024;
+		bits = 16;
+	}
+	writel_relaxed(0, data->base + TIM_ARR);
+
+	writel_relaxed(prescaler - 1, data->base + TIM_PSC);
+	writel_relaxed(TIM_EGR_UG, data->base + TIM_EGR);
+	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
+	writel_relaxed(0, data->base + TIM_SR);
+
+	data->periodic_top = DIV_ROUND_CLOSEST(rate, prescaler * HZ);
+
+	clockevents_config_and_register(&data->evtdev,
+					DIV_ROUND_CLOSEST(rate, prescaler),
+					0x1, max_delta);
+
+	ret = request_irq(irq, stm32_clock_event_handler, IRQF_TIMER,
+			"stm32 clockevent", data);
+	if (ret) {
+		pr_err("%s: failed to request irq.\n", np->full_name);
+		goto err_get_irq;
+	}
+
+	pr_info("%s: STM32 clockevent driver initialized (%d bits)\n",
+			np->full_name, bits);
+
+	return;
+
+err_get_irq:
+	iounmap(data->base);
+err_iomap:
+	clk_disable_unprepare(clk);
+err_clk_enable:
+	clk_put(clk);
+err_clk_get:
+	return;
+}
+
+CLOCKSOURCE_OF_DECLARE(stm32, "st,stm32-timer", stm32_clockevent_init);
-- 
1.9.1

