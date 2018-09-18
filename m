From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 1/2] clocksource: add gx6605s SOC system timer
Date: Tue, 18 Sep 2018 21:48:54 +0800
Message-ID: <4d409a1fdecf1c376e8cc6b55308cd3c522047b0.1537276815.git.ren_guo@c-sky.com>
References: <cover.1537276815.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537276815.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276815.git.ren_guo@c-sky.com>
References: <cover.1537276815.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Changelog:
 - Add License and Copyright
 - Use timer-of framework
 - Change name with upstream feedback
 - Use clksource_mmio framework

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/Kconfig         |   8 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-gx6605s.c | 150 ++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/clocksource/timer-gx6605s.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba..6d0f18d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -620,4 +620,12 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config GX6605S_TIMER
+	bool "Gx6605s SOC system timer driver"
+	depends on CSKY
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  This option enables support for gx6605s SOC's timer.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b24..dc5621d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -79,3 +79,4 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
+obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
new file mode 100644
index 0000000..10194c9
--- /dev/null
+++ b/drivers/clocksource/timer-gx6605s.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+
+#include "timer-of.h"
+
+#define CLKSRC_OFFSET	0x40
+
+#define TIMER_STATUS	0x00
+#define TIMER_VALUE	0x04
+#define TIMER_CONTRL	0x10
+#define TIMER_CONFIG	0x20
+#define TIMER_DIV	0x24
+#define TIMER_INI	0x28
+
+#define GX6605S_STATUS_CLR	BIT(0)
+#define GX6605S_CONTRL_RST	BIT(0)
+#define GX6605S_CONTRL_START	BIT(1)
+#define GX6605S_CONFIG_EN	BIT(0)
+#define GX6605S_CONFIG_IRQ_EN	BIT(1)
+
+static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
+{
+	struct clock_event_device *ce = (struct clock_event_device *) dev;
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	writel_relaxed(GX6605S_STATUS_CLR, base + TIMER_STATUS);
+
+	ce->event_handler(ce);
+
+	return IRQ_HANDLED;
+}
+
+static int gx6605s_timer_set_oneshot(struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	/* reset and stop counter */
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	/* enable with irq and start */
+	writel_relaxed(GX6605S_CONFIG_EN | GX6605S_CONFIG_IRQ_EN, base + TIMER_CONFIG);
+
+	return 0;
+}
+
+static int gx6605s_timer_set_next_event(unsigned long delta, struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	/* use reset to pause timer */
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	/* config next timeout value */
+	writel_relaxed(ULONG_MAX - delta, base + TIMER_INI);
+	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
+
+	return 0;
+}
+
+static int gx6605s_timer_shutdown(struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	writel_relaxed(0, base + TIMER_CONTRL);
+	writel_relaxed(0, base + TIMER_CONFIG);
+
+	return 0;
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.rating			= 300,
+		.features		= CLOCK_EVT_FEAT_DYNIRQ |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown	= gx6605s_timer_shutdown,
+		.set_state_oneshot	= gx6605s_timer_set_oneshot,
+		.set_next_event		= gx6605s_timer_set_next_event,
+		.cpumask		= cpu_possible_mask,
+	},
+	.of_irq = {
+		.handler		= gx6605s_timer_interrupt,
+		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+	},
+};
+
+static u64 notrace gx6605s_sched_clock_read(void)
+{
+	void __iomem *base;
+
+	base = timer_of_base(&to) + CLKSRC_OFFSET;
+
+	return (u64) readl_relaxed(base + TIMER_VALUE);
+}
+
+static void gx6605s_clkevt_init(void __iomem *base)
+{
+	writel_relaxed(0, base + TIMER_DIV);
+	writel_relaxed(0, base + TIMER_CONFIG);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 2, ULONG_MAX);
+}
+
+static int gx6605s_clksrc_init(void __iomem *base)
+{
+	writel_relaxed(0, base + TIMER_DIV);
+	writel_relaxed(0, base + TIMER_INI);
+
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	writel_relaxed(GX6605S_CONFIG_EN, base + TIMER_CONFIG);
+
+	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
+
+	sched_clock_register(gx6605s_sched_clock_read, 32, timer_of_rate(&to));
+
+	return clocksource_mmio_init(base + TIMER_VALUE, "gx6605s", timer_of_rate(&to),
+				     200, 32, clocksource_mmio_readl_up);
+}
+
+static int __init gx6605s_timer_init(struct device_node *np)
+{
+	int ret;
+
+	/*
+	 * The timer driver is for nationalchip gx6605s SOC and there are two same timer
+	 * in gx6605s. We use one for clkevt and another for clksrc.
+	 *
+	 * The timer is mmio map to access, so we need give mmio addres in dts.
+	 *
+	 * It provides a 32bit countup timer and interrupt will be caused by count-overflow.
+	 * So we need set-next-event by ULONG_MAX - delta in TIMER_INI reg.
+	 *
+	 * The counter at 0x0  offset is clock event.
+	 * The counter at 0x40 offset is clock source.
+	 * They are the same in hardware, just different used by driver.
+	 */
+	ret = timer_of_init(np, &to);
+	if (ret)
+		return ret;
+
+	gx6605s_clkevt_init(timer_of_base(&to));
+
+	return gx6605s_clksrc_init(timer_of_base(&to) + CLKSRC_OFFSET);
+}
+TIMER_OF_DECLARE(csky_gx6605s_timer, "csky,gx6605s-timer", gx6605s_timer_init);
-- 
2.7.4
