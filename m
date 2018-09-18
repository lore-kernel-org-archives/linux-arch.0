From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 1/2] clocksource: add C-SKY SMP timer
Date: Tue, 18 Sep 2018 21:48:35 +0800
Message-ID: <dce7c1bc36ba39635b0ae5fd3d9b30172936727d.1537276791.git.ren_guo@c-sky.com>
References: <cover.1537276791.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537276791.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276791.git.ren_guo@c-sky.com>
References: <cover.1537276791.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This timer is used by SMP system and use mfcr/mtcr instruction
to access the regs.

Changelog:
 - Support csky mp timer alpha version.
 - Just use low-counter with 32bit width as clocksource.
 - Coding convention with upstream feed-back.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/Kconfig        |   8 ++
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/csky_mptimer.c | 178 +++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/clocksource/csky_mptimer.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba..51286be 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -609,6 +609,14 @@ config ATCPIT100_TIMER
 	help
 	  This option enables support for the Andestech ATCPIT100 timers.
 
+config CSKY_MPTIMER
+	bool "C-SKY Multi Processor Timer"
+	depends on CSKY
+	select TIMER_OF
+	help
+	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
+	  system.
+
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform"
 	depends on RISCV
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b24..848c676 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -79,3 +79,4 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
+obj-$(CONFIG_CSKY_MPTIMER)		+= csky_mptimer.o
diff --git a/drivers/clocksource/csky_mptimer.c b/drivers/clocksource/csky_mptimer.c
new file mode 100644
index 0000000..da2b239
--- /dev/null
+++ b/drivers/clocksource/csky_mptimer.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+#include <linux/cpu.h>
+#include <asm/reg_ops.h>
+
+#include "timer-of.h"
+
+#define PTIM_CCVR	"cr<3, 14>"
+#define PTIM_CTLR	"cr<0, 14>"
+#define PTIM_LVR	"cr<6, 14>"
+#define PTIM_TSR	"cr<1, 14>"
+
+static int csky_mptimer_set_next_event(unsigned long delta, struct clock_event_device *ce)
+{
+	mtcr(PTIM_LVR, delta);
+
+	return 0;
+}
+
+static int csky_mptimer_shutdown(struct clock_event_device *ce)
+{
+	mtcr(PTIM_CTLR, 0);
+
+	return 0;
+}
+
+static int csky_mptimer_oneshot(struct clock_event_device *ce)
+{
+	mtcr(PTIM_CTLR, 1);
+
+	return 0;
+}
+
+static int csky_mptimer_oneshot_stopped(struct clock_event_device *ce)
+{
+	mtcr(PTIM_CTLR, 0);
+
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct timer_of, csky_to) = {
+	.flags					= TIMER_OF_CLOCK,
+	.clkevt = {
+		.rating				= 300,
+		.features			= CLOCK_EVT_FEAT_PERCPU |
+						  CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown		= csky_mptimer_shutdown,
+		.set_state_oneshot		= csky_mptimer_oneshot,
+		.set_state_oneshot_stopped	= csky_mptimer_oneshot_stopped,
+		.set_next_event			= csky_mptimer_set_next_event,
+	},
+	.of_irq = {
+		.flags				= IRQF_TIMER,
+		.percpu				= 1,
+	},
+};
+
+static irqreturn_t timer_interrupt(int irq, void *dev)
+{
+	struct timer_of *to = this_cpu_ptr(&csky_to);
+
+	mtcr(PTIM_TSR, 0);
+
+	to->clkevt.event_handler(&to->clkevt);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * clock event for percpu
+ */
+static int csky_mptimer_starting_cpu(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&csky_to, cpu);
+
+	to->clkevt.cpumask = cpumask_of(cpu);
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to), 2, ULONG_MAX);
+
+	enable_percpu_irq(timer_of_irq(to), 0);
+
+	return 0;
+}
+
+static int csky_mptimer_dying_cpu(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&csky_to, cpu);
+
+	disable_percpu_irq(timer_of_irq(to));
+
+	return 0;
+}
+
+/*
+ * clock source
+ */
+static u64 sched_clock_read(void)
+{
+	return (u64) mfcr(PTIM_CCVR);
+}
+
+static u64 clksrc_read(struct clocksource *c)
+{
+	return (u64) mfcr(PTIM_CCVR);
+}
+
+struct clocksource csky_clocksource = {
+	.name	= "csky",
+	.rating	= 400,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read	= clksrc_read,
+};
+
+#define CPUHP_AP_CSKY_TIMER_STARTING CPUHP_AP_DUMMY_TIMER_STARTING
+
+static int __init csky_mptimer_init(struct device_node *np)
+{
+	int ret, cpu;
+	struct timer_of *to;
+	int rate = 0;
+	int irq	 = 0;
+
+	/*
+	 * Csky_mptimer is designed for C-SKY SMP multi-processors and
+	 * every core has it's own private irq and regs for clkevt and
+	 * clksrc.
+	 *
+	 * The regs is accessed by cpu instruction: mfcr/mtcr instead of
+	 * mmio map style. So we needn't mmio-address in dts, but we still
+	 * need to give clk and irq number.
+	 *
+	 * We use private irq for the mptimer and irq number is the same
+	 * for every core. So we use request_percpu_irq() in timer_of_init.
+	 */
+
+	for_each_possible_cpu(cpu) {
+		to = per_cpu_ptr(&csky_to, cpu);
+
+		if (cpu == 0) {
+			to->flags	  |= TIMER_OF_IRQ;
+			to->of_irq.handler = timer_interrupt;
+
+			ret = timer_of_init(np, to);
+			if (ret)
+				return ret;
+
+			rate	= timer_of_rate(to);
+			irq	= to->of_irq.irq;
+		} else {
+			ret = timer_of_init(np, to);
+			if (ret)
+				return ret;
+
+			to->of_clk.rate	= rate;
+			to->of_irq.irq	= irq;
+		}
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
+				"clockevents/csky/timer:starting",
+				csky_mptimer_starting_cpu,
+				csky_mptimer_dying_cpu);
+	if (ret) {
+		pr_err("%s: Failed to cpuhp_setup_state.\n", __func__);
+		return ret;
+	}
+
+	clocksource_register_hz(&csky_clocksource, rate);
+	sched_clock_register(sched_clock_read, 32, rate);
+
+	return 0;
+}
+TIMER_OF_DECLARE(csky_mptimer, "csky,mptimer", csky_mptimer_init);
-- 
2.7.4
