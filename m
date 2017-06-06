From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 09/17] clocksource/timer-riscv: New RISC-V Clocksource
Date: Tue,  6 Jun 2017 15:59:59 -0700
Message-ID: <20170606230007.19101-10-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33229 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdFFXBj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:39 -0400
Received: by mail-pg0-f65.google.com with SMTP id a70so5880665pge.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:38 -0700 (PDT)
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>

The RISC-V ISA defines a single RTC as well as an SBI oneshot timer.
This timer is present on all RISC-V systems.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/clocksource/Kconfig       |   8 +++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/timer-riscv.c | 118 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 drivers/clocksource/timer-riscv.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 545d541ae20e..1c2c6e7c7fab 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -612,4 +612,12 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config CLKSRC_RISCV
+	#bool "Clocksource for the RISC-V platform"
+	def_bool y if RISCV
+	depends on RISCV
+	help
+	  This enables a clocksource based on the RISC-V SBI timer, which is
+	  built in to all RISC-V systems.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 2b5b56a6f00f..408ed9d314dc 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -73,3 +73,4 @@ obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
+obj-$(CONFIG_CLKSRC_RISCV)		+= timer-riscv.o
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
new file mode 100644
index 000000000000..04ef7b9130b3
--- /dev/null
+++ b/drivers/clocksource/timer-riscv.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
+#include <asm/irq.h>
+#include <asm/csr.h>
+#include <asm/sbi.h>
+#include <asm/delay.h>
+
+unsigned long riscv_timebase;
+
+static DEFINE_PER_CPU(struct clock_event_device, clock_event);
+
+static int riscv_timer_set_next_event(unsigned long delta,
+	struct clock_event_device *evdev)
+{
+	sbi_set_timer(get_cycles() + delta);
+	return 0;
+}
+
+static int riscv_timer_set_oneshot(struct clock_event_device *evt)
+{
+	/* no-op; only one mode */
+	return 0;
+}
+
+static int riscv_timer_set_shutdown(struct clock_event_device *evt)
+{
+	/* can't stop the clock! */
+	return 0;
+}
+
+static u64 riscv_rdtime(struct clocksource *cs)
+{
+	return get_cycles();
+}
+
+static struct clocksource riscv_clocksource = {
+	.name = "riscv_clocksource",
+	.rating = 300,
+	.read = riscv_rdtime,
+#ifdef CONFIG_64BITS
+	.mask = CLOCKSOURCE_MASK(64),
+#else
+	.mask = CLOCKSOURCE_MASK(32),
+#endif /* CONFIG_64BITS */
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void riscv_timer_interrupt(void)
+{
+	int cpu = smp_processor_id();
+	struct clock_event_device *evdev = &per_cpu(clock_event, cpu);
+
+	evdev->event_handler(evdev);
+}
+
+void __init init_clockevent(void)
+{
+	int cpu = smp_processor_id();
+	struct clock_event_device *ce = &per_cpu(clock_event, cpu);
+
+	*ce = (struct clock_event_device){
+		.name = "riscv_timer_clockevent",
+		.features = CLOCK_EVT_FEAT_ONESHOT,
+		.rating = 300,
+		.cpumask = cpumask_of(cpu),
+		.set_next_event = riscv_timer_set_next_event,
+		.set_state_oneshot  = riscv_timer_set_oneshot,
+		.set_state_shutdown = riscv_timer_set_shutdown,
+	};
+
+	/* Enable timer interrupts */
+	csr_set(sie, SIE_STIE);
+
+	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
+}
+
+static unsigned long __init of_timebase(void)
+{
+	struct device_node *cpu;
+	const __be32 *prop;
+
+	cpu = of_find_node_by_path("/cpus");
+	if (cpu) {
+		prop = of_get_property(cpu, "timebase-frequency", NULL);
+		if (prop)
+			return be32_to_cpu(*prop);
+	}
+
+	return 10000000;
+}
+
+void __init time_init(void)
+{
+	riscv_timebase = of_timebase();
+	lpj_fine = riscv_timebase / HZ;
+
+	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
+	init_clockevent();
+}
-- 
2.13.0
