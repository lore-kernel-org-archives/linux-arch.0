From: Rick Chen <rickchen36@gmail.com>
Subject: [PATCH v5 1/3] clocksource/drivers/atcpit100: Add andestech atcpit100 timer
Date: Tue, 12 Dec 2017 13:46:59 +0800
Message-ID: <1513057621-19084-2-git-send-email-rickchen36@gmail.com>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rickchen36@gmail.com, rick@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@linaro.org, daniel.lezcano@linaro.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, linux-serial@vger.kernel.org
Cc: Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

ATCPIT100 is often used on the Andes architecture,
This timer provide 4 PIT channels. Each PIT channel is a
multi-function timer, can be configured as 32,16,8 bit timers
or PWM as well.

For system timer it will set channel 1 32-bit timer0 as clock
source and count downwards until underflow and restart again.

It also set channel 0 32-bit timer0 as clock event and count
downwards until condition match. It will generate an interrupt
for handling periodically.

Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/Kconfig           |   7 +
 drivers/clocksource/Makefile          |   1 +
 drivers/clocksource/timer-atcpit100.c | 255 ++++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/clocksource/timer-atcpit100.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cc60620..8c57ef2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -615,4 +615,11 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config CLKSRC_ATCPIT100
+	bool "Clocksource for AE3XX platform"
+	depends on NDS32 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This option enables support for the Andestech AE3XX platform timers.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 72711f1..7d072f5 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -75,3 +75,4 @@ obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
+obj-$(CONFIG_CLKSRC_ATCPIT100)		+= timer-atcpit100.o
diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
new file mode 100644
index 0000000..0077fdb
--- /dev/null
+++ b/drivers/clocksource/timer-atcpit100.c
@@ -0,0 +1,255 @@
+/*
+ *  Andestech ATCPIT100 Timer Device Driver Implementation
+ *
+ * Copyright (C) 2017 Andes Technology Corporation
+ * Rick Chen, Andes Technology Corporation <rick@andestech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ */
+
+#include <linux/irq.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/cpufreq.h>
+#include <linux/sched.h>
+#include <linux/sched_clock.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include "timer-of.h"
+
+/*
+ * Definition of register offsets
+ */
+
+/* ID and Revision Register */
+#define ID_REV		0x0
+
+/* Configuration Register */
+#define CFG		0x10
+
+/* Interrupt Enable Register */
+#define INT_EN		0x14
+#define CH_INT_EN(c, i)	((1<<i)<<(4*c))
+#define CH0INT0EN	0x01
+
+/* Interrupt Status Register */
+#define INT_STA		0x18
+#define CH0INT0		0x01
+
+/* Channel Enable Register */
+#define CH_EN		0x1C
+#define CH0TMR0EN	0x1
+#define CH1TMR0EN	0x10
+
+/* Channel 0 , 1 Control Register */
+#define CH0_CTL		(0x20)
+#define CH1_CTL		(0x20 + 0x10)
+
+/* Channel clock source , bit 3 , 0:External clock , 1:APB clock */
+#define APB_CLK		BIT(3)
+
+/* Channel mode , bit 0~2 */
+#define TMR_32		0x1
+#define TMR_16		0x2
+#define TMR_8		0x3
+
+/* Channel 0 , 1 Reload Register */
+#define CH0_REL		(0x24)
+#define CH1_REL		(0x24 + 0x10)
+
+/* Channel 0 , 1 Counter Register */
+#define CH0_CNT		(0x28)
+#define CH1_CNT		(0x28 + 0x10)
+
+#define TIMER_SYNC_TICKS	3
+
+static void atcpit100_ch1_tmr0_en(void __iomem *base)
+{
+	writel(~0, base + CH1_REL);
+	writel(APB_CLK|TMR_32, base + CH1_CTL);
+}
+
+static void atcpit100_ch0_tmr0_en(void __iomem *base)
+{
+	writel(APB_CLK|TMR_32, base + CH0_CTL);
+}
+
+static void atcpit100_clkevt_time_setup(void __iomem *base, unsigned long delay)
+{
+	writel(delay, base + CH0_CNT);
+	writel(delay, base + CH0_REL);
+}
+
+static void atcpit100_timer_clear_interrupt(void __iomem *base)
+{
+	u32 val;
+
+	val = readl(base + INT_STA);
+	writel(val | CH0INT0, base + INT_STA);
+}
+
+static void atcpit100_clocksource_start(void __iomem *base)
+{
+	u32 val;
+
+	val = readl(base + CH_EN);
+	writel(val | CH1TMR0EN, base + CH_EN);
+}
+
+static void atcpit100_clkevt_time_start(void __iomem *base)
+{
+	u32 val;
+
+	val = readl(base + CH_EN);
+	writel(val | CH0TMR0EN, base + CH_EN);
+}
+
+static void atcpit100_clkevt_time_stop(void __iomem *base)
+{
+	u32 val;
+
+	atcpit100_timer_clear_interrupt(base);
+	val = readl(base + CH_EN);
+	writel(val & ~CH0TMR0EN, base + CH_EN);
+}
+
+static int atcpit100_clkevt_next_event(unsigned long evt,
+	struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	writel(evt, timer_of_base(to) + CH0_REL);
+
+	return 0;
+}
+
+static int atcpit100_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	atcpit100_clkevt_time_setup(timer_of_base(to), timer_of_period(to));
+	atcpit100_clkevt_time_start(timer_of_base(to));
+
+	return 0;
+}
+static int atcpit100_clkevt_shutdown(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	atcpit100_clkevt_time_stop(timer_of_base(to));
+
+	return 0;
+}
+static int atcpit100_clkevt_set_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+	u32 val;
+
+	writel(~0x0, timer_of_base(to) + CH0_REL);
+	val = readl(timer_of_base(to) + CH_EN);
+	writel(val | CH0TMR0EN, timer_of_base(to) + CH_EN);
+
+	return 0;
+}
+
+static irqreturn_t atcpit100_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(evt);
+
+	atcpit100_timer_clear_interrupt(timer_of_base(to));
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
+
+	.clkevt = {
+		.name = "atcpit100_tick",
+		.rating = 300,
+		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown = atcpit100_clkevt_shutdown,
+		.set_state_periodic = atcpit100_clkevt_set_periodic,
+		.set_state_oneshot = atcpit100_clkevt_set_oneshot,
+		.tick_resume = atcpit100_clkevt_shutdown,
+		.set_next_event = atcpit100_clkevt_next_event,
+		.cpumask = cpu_all_mask,
+	},
+
+	.of_irq = {
+		.handler = atcpit100_timer_interrupt,
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+	},
+
+	/*
+	 * FIXME: we currently only support clocking using PCLK
+	 * and using EXTCLK is not supported in the driver.
+	 */
+	.of_clk = {
+		.name = "PCLK",
+	}
+};
+
+static u64 notrace atcpit100_timer_sched_read(void)
+{
+	return ~readl(timer_of_base(&to) + CH1_CNT);
+}
+
+static int __init atcpit100_timer_init(struct device_node *node)
+{
+	int ret;
+	u32 val;
+	void __iomem *base;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		return ret;
+
+	base = timer_of_base(&to);
+
+	sched_clock_register(atcpit100_timer_sched_read, 32,
+		timer_of_rate(&to));
+
+	ret = clocksource_mmio_init(base + CH1_CNT,
+		node->name, timer_of_rate(&to), 300, 32,
+		clocksource_mmio_readl_down);
+
+	if (ret) {
+		pr_err("Failed to register clocksource\n");
+		return ret;
+	}
+
+	/* clear channel 0 timer0 interrupt */
+	atcpit100_timer_clear_interrupt(base);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+	atcpit100_ch0_tmr0_en(base);
+	atcpit100_ch1_tmr0_en(base);
+	atcpit100_clocksource_start(base);
+	atcpit100_clkevt_time_start(base);
+
+	/* Enable channel 0 timer0 interrupt */
+	val = readl(base + INT_EN);
+	writel(val | CH0INT0EN, base + INT_EN);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(atcpit100, "andestech,atcpit100", atcpit100_timer_init);
-- 
2.7.4
