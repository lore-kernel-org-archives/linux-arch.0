Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53909 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728665AbeJaLDP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Oct 2018 07:03:15 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V13 1/2] clocksource: add C-SKY SMP timer
Date: Wed, 31 Oct 2018 10:06:47 +0800
Message-Id: <94b4dd45fbfebe33ce2085ab4812d7f084c0f956.1540947083.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1540947083.git.ren_guo@c-sky.com>
References: <cover.1540947083.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1540947083.git.ren_guo@c-sky.com>
References: <cover.1540947083.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>

The driver is for C-SKY SMP timer. It only support oneshot event
and 32bit overflow for clocksource. Per cpu core has one timer and
all timers share one clock-counter-input the same clocksource.

This use mfcr&mtcr instructions to access the regs.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
Changelog:
 - Add COMPILE_TEST
 - Fixup smp boot error, cpuhp_setup_state must after timer_of_init()
 - Add rollback for timer_of_cleanup.
 - Use request_percpu_irq separate from time_of.
 - Remove #define CPUHP_AP_CSKY_TIMER_STARTING.
 - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h.
 - Support csky mp timer alpha version.
 - Just use low-counter with 32bit width as clocksource.
 - Coding convention with upstream feed-back.
---
---
 drivers/clocksource/Kconfig         |  10 +++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-mp-csky.c | 173 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h          |   1 +
 4 files changed, 185 insertions(+)
 create mode 100644 drivers/clocksource/timer-mp-csky.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba..591c9a8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -620,4 +620,14 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config CSKY_MP_TIMER
+	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
+	depends on CSKY
+	select TIMER_OF
+	help
+	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
+	  system.
+	  csky,mptimer is not only used in SMP system, it also could be used
+	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b24..5ce82d3 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -79,3 +79,4 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
+obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
diff --git a/drivers/clocksource/timer-mp-csky.c b/drivers/clocksource/timer-mp-csky.c
new file mode 100644
index 0000000..a8acc43
--- /dev/null
+++ b/drivers/clocksource/timer-mp-csky.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+#include <linux/cpu.h>
+#include <linux/of_irq.h>
+#include <asm/reg_ops.h>
+
+#include "timer-of.h"
+
+#define PTIM_CCVR	"cr<3, 14>"
+#define PTIM_CTLR	"cr<0, 14>"
+#define PTIM_LVR	"cr<6, 14>"
+#define PTIM_TSR	"cr<1, 14>"
+
+static int csky_mptimer_irq;
+
+static int csky_mptimer_set_next_event(unsigned long delta,
+				       struct clock_event_device *ce)
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
+};
+
+static irqreturn_t csky_timer_interrupt(int irq, void *dev)
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
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					2, ULONG_MAX);
+
+	enable_percpu_irq(csky_mptimer_irq, 0);
+
+	return 0;
+}
+
+static int csky_mptimer_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(csky_mptimer_irq);
+
+	return 0;
+}
+
+/*
+ * clock source
+ */
+static u64 sched_clock_read(void)
+{
+	return (u64)mfcr(PTIM_CCVR);
+}
+
+static u64 clksrc_read(struct clocksource *c)
+{
+	return (u64)mfcr(PTIM_CCVR);
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
+static int __init csky_mptimer_init(struct device_node *np)
+{
+	int ret, cpu, cpu_rollback;
+	struct timer_of *to = NULL;
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
+	csky_mptimer_irq = irq_of_parse_and_map(np, 0);
+	if (csky_mptimer_irq <= 0)
+		return -EINVAL;
+
+	ret = request_percpu_irq(csky_mptimer_irq, csky_timer_interrupt,
+				 "csky_mp_timer", &csky_to);
+	if (ret)
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		to = per_cpu_ptr(&csky_to, cpu);
+		ret = timer_of_init(np, to);
+		if (ret)
+			goto rollback;
+	}
+
+	clocksource_register_hz(&csky_clocksource, timer_of_rate(to));
+	sched_clock_register(sched_clock_read, 32, timer_of_rate(to));
+
+	ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
+				"clockevents/csky/timer:starting",
+				csky_mptimer_starting_cpu,
+				csky_mptimer_dying_cpu);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+
+rollback:
+	for_each_possible_cpu(cpu_rollback) {
+		if (cpu_rollback == cpu)
+			break;
+
+		to = per_cpu_ptr(&csky_to, cpu_rollback);
+		timer_of_cleanup(to);
+	}
+	return -EINVAL;
+}
+TIMER_OF_DECLARE(csky_mptimer, "csky,mptimer", csky_mptimer_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad..e0cd2ba 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -126,6 +126,7 @@ enum cpuhp_state {
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
+	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
-- 
2.7.4
