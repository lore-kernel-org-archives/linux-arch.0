Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55588 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab2HNRxQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:16 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 28/31] arm64: Generic timers support
Date: Tue, 14 Aug 2012 18:52:29 +0100
Message-ID: <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175229.b5zvJiV3EG9n5WoHUaWoMIHpt4kvpbY4z02-s9MchdU@z>

From: Marc Zyngier <marc.zyngier@arm.com>

This patch adds support for the ARM generic timers with A64 instructions
for accessing the timer registers. It uses the physical counter as the
clock source and the virtual counter as sched_clock.

The timer frequency can be specified via DT or read from the CNTFRQ_EL0
register. The physical counter is also accessible from user space
allowing fast gettimeofday() implementation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/timex.h    |   32 ++++
 arch/arm64/kernel/time.c          |   65 ++++++++
 drivers/clocksource/Kconfig       |    5 +
 drivers/clocksource/Makefile      |    1 +
 drivers/clocksource/arm_generic.c |  309 +++++++++++++++++++++++++++++++++=
++++
 include/clocksource/arm_generic.h |   21 +++
 6 files changed, 433 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/timex.h
 create mode 100644 arch/arm64/kernel/time.c
 create mode 100644 drivers/clocksource/arm_generic.c
 create mode 100644 include/clocksource/arm_generic.h

diff --git a/arch/arm64/include/asm/timex.h b/arch/arm64/include/asm/timex.=
h
new file mode 100644
index 0000000..88f74de
--- /dev/null
+++ b/arch/arm64/include/asm/timex.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_TIMEX_H
+#define __ASM_TIMEX_H
+
+/*
+ * Use the current timer as a cycle counter since this is what we use for
+ * the delay loop.
+ */
+#define get_cycles()=09({ cycles_t c; read_current_timer(&c); c; })
+
+#include <asm-generic/timex.h>
+
+#define ARCH_HAS_READ_CURRENT_TIMER
+
+/* This isn't really used any more */
+#define CLOCK_TICK_RATE 1000
+
+#endif
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
new file mode 100644
index 0000000..3b4b725
--- /dev/null
+++ b/arch/arm64/kernel/time.c
@@ -0,0 +1,65 @@
+/*
+ * Based on arch/arm/kernel/time.c
+ *
+ * Copyright (C) 1991, 1992, 1995  Linus Torvalds
+ * Modifications for ARM (C) 1994-2001 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/timex.h>
+#include <linux/errno.h>
+#include <linux/profile.h>
+#include <linux/syscore_ops.h>
+#include <linux/timer.h>
+#include <linux/irq.h>
+
+#include <clocksource/arm_generic.h>
+
+#include <asm/thread_info.h>
+#include <asm/stacktrace.h>
+
+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+=09struct stackframe frame;
+
+=09if (!in_lock_functions(regs->pc))
+=09=09return regs->pc;
+
+=09frame.fp =3D regs->regs[29];
+=09frame.sp =3D regs->sp;
+=09frame.pc =3D regs->pc;
+=09do {
+=09=09int ret =3D unwind_frame(&frame);
+=09=09if (ret < 0)
+=09=09=09return 0;
+=09} while (in_lock_functions(frame.pc));
+
+=09return frame.pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif
+
+void __init time_init(void)
+{
+=09arm_generic_timer_init();
+}
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d53cd0a..6a78073 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -35,3 +35,8 @@ config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 =09default y
 =09help
 =09  Use the always on PRCMU Timer as sched_clock
+
+config CLKSRC_ARM_GENERIC
+=09def_bool y if ARM64
+=09help
+=09  This option enables support for the ARM generic timer.
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index b65d0c5..6591990 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_DW_APB_TIMER)=09+=3D dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)=09+=3D dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)=09+=3D clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)=09+=3D time-armada-370-xp.o
+obj-$(CONFIG_CLKSRC_ARM_GENERIC)=09+=3D arm_generic.o
diff --git a/drivers/clocksource/arm_generic.c b/drivers/clocksource/arm_ge=
neric.c
new file mode 100644
index 0000000..05c898c
--- /dev/null
+++ b/drivers/clocksource/arm_generic.c
@@ -0,0 +1,309 @@
+/*
+ * Generic timers support
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/jiffies.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+
+#include <clocksource/arm_generic.h>
+
+static u32 arch_timer_rate;
+static u64 sched_clock_mult __read_mostly;
+static DEFINE_PER_CPU(struct clock_event_device, arch_timer_evt);
+static int arch_timer_ppi;
+
+/*
+ * Architected system timer support.
+ */
+
+#define ARCH_TIMER_CTRL_ENABLE=09=09(1 << 0)
+#define ARCH_TIMER_CTRL_IT_MASK=09=09(1 << 1)
+
+#define ARCH_TIMER_REG_CTRL=09=090
+#define ARCH_TIMER_REG_FREQ=09=091
+#define ARCH_TIMER_REG_TVAL=09=092
+
+static void arch_timer_reg_write(int reg, u32 val)
+{
+=09switch (reg) {
+=09case ARCH_TIMER_REG_CTRL:
+=09=09asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
+=09=09break;
+=09case ARCH_TIMER_REG_TVAL:
+=09=09asm volatile("msr cntp_tval_el0, %0" : : "r" (val));
+=09=09break;
+=09default:
+=09=09BUG();
+=09}
+
+=09isb();
+}
+
+static u32 arch_timer_reg_read(int reg)
+{
+=09u32 val;
+
+=09switch (reg) {
+=09case ARCH_TIMER_REG_CTRL:
+=09=09asm volatile("mrs %0,  cntp_ctl_el0" : "=3Dr" (val));
+=09=09break;
+=09case ARCH_TIMER_REG_FREQ:
+=09=09asm volatile("mrs %0,   cntfrq_el0" : "=3Dr" (val));
+=09=09break;
+=09case ARCH_TIMER_REG_TVAL:
+=09=09asm volatile("mrs %0, cntp_tval_el0" : "=3Dr" (val));
+=09=09break;
+=09default:
+=09=09BUG();
+=09}
+
+=09return val;
+}
+
+static irqreturn_t arch_timer_handle_irq(int irq, void *dev_id)
+{
+=09struct clock_event_device *evt =3D dev_id;
+=09unsigned long ctrl;
+
+=09ctrl =3D arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
+=09if (ctrl & 0x4) {
+=09=09ctrl |=3D ARCH_TIMER_CTRL_IT_MASK;
+=09=09arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
+=09=09evt->event_handler(evt);
+=09=09return IRQ_HANDLED;
+=09}
+
+=09return IRQ_NONE;
+}
+
+static void arch_timer_stop(void)
+{
+=09unsigned long ctrl;
+
+=09ctrl =3D arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
+=09ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
+=09arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
+}
+
+static void arch_timer_set_mode(enum clock_event_mode mode,
+=09=09=09=09struct clock_event_device *clk)
+{
+=09switch (mode) {
+=09case CLOCK_EVT_MODE_UNUSED:
+=09case CLOCK_EVT_MODE_SHUTDOWN:
+=09=09arch_timer_stop();
+=09=09break;
+=09default:
+=09=09break;
+=09}
+}
+
+static int arch_timer_set_next_event(unsigned long evt,
+=09=09=09=09     struct clock_event_device *unused)
+{
+=09unsigned long ctrl;
+
+=09ctrl =3D arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
+=09ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
+=09ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
+
+=09arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
+=09arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
+
+=09return 0;
+}
+
+static void __cpuinit arch_counter_enable_user_access(void)
+{
+=09u32 cntkctl;
+
+=09/* Disable user access to the timers and the virtual counter. */
+=09asm volatile("mrs=09%0, cntkctl_el1" : "=3Dr" (cntkctl));
+=09cntkctl &=3D ~((3 << 8) | (1 << 1));
+
+=09/* Enable user access to the physical counter and frequency. */
+=09cntkctl |=3D 1;
+=09asm volatile("msr=09cntkctl_el1, %0" : : "r" (cntkctl));
+}
+
+static void __cpuinit arch_timer_setup(struct clock_event_device *clk)
+{
+=09/* Let's make sure the timer is off before doing anything else */
+=09arch_timer_stop();
+
+=09clk->features =3D CLOCK_EVT_FEAT_ONESHOT;
+=09clk->name =3D "arch_sys_timer";
+=09clk->rating =3D 400;
+=09clk->set_mode =3D arch_timer_set_mode;
+=09clk->set_next_event =3D arch_timer_set_next_event;
+=09clk->irq =3D arch_timer_ppi;
+=09clk->cpumask =3D cpumask_of(smp_processor_id());
+
+=09clockevents_config_and_register(clk, arch_timer_rate,
+=09=09=09=09=090xf, 0x7fffffff);
+
+=09enable_percpu_irq(clk->irq, 0);
+
+=09/* Ensure the physical counter is visible to userspace for the vDSO. */
+=09arch_counter_enable_user_access();
+}
+
+static void __init arch_timer_calibrate(void)
+{
+=09if (arch_timer_rate =3D=3D 0) {
+=09=09arch_timer_reg_write(ARCH_TIMER_REG_CTRL, 0);
+=09=09arch_timer_rate =3D arch_timer_reg_read(ARCH_TIMER_REG_FREQ);
+
+=09=09/* Check the timer frequency. */
+=09=09if (arch_timer_rate =3D=3D 0)
+=09=09=09panic("Architected timer frequency is set to zero.\n"
+=09=09=09      "You must set this in your .dts file\n");
+=09}
+
+=09/* Cache the sched_clock multiplier to save a divide in the hot path. *=
/
+
+=09sched_clock_mult =3D NSEC_PER_SEC / arch_timer_rate;
+
+=09pr_info("Architected local timer running at %u.%02uMHz.\n",
+=09=09 arch_timer_rate / 1000000, (arch_timer_rate / 10000) % 100);
+}
+
+static inline cycle_t arch_counter_get_cntpct(void)
+{
+=09cycle_t cval;
+
+=09asm volatile("mrs %0, cntpct_el0" : "=3Dr" (cval));
+
+=09return cval;
+}
+
+static inline cycle_t arch_counter_get_cntvct(void)
+{
+=09cycle_t cval;
+
+=09asm volatile("mrs %0, cntvct_el0" : "=3Dr" (cval));
+
+=09return cval;
+}
+
+static cycle_t arch_counter_read(struct clocksource *cs)
+{
+=09return arch_counter_get_cntpct();
+}
+
+static struct clocksource clocksource_counter =3D {
+=09.name=09=3D "arch_sys_counter",
+=09.rating=09=3D 400,
+=09.read=09=3D arch_counter_read,
+=09.mask=09=3D CLOCKSOURCE_MASK(56),
+=09.flags=09=3D (CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES)=
,
+};
+
+int read_current_timer(unsigned long *timer_value)
+{
+=09*timer_value =3D arch_counter_get_cntpct();
+=09return 0;
+}
+
+unsigned long long notrace sched_clock(void)
+{
+=09return arch_counter_get_cntvct() * sched_clock_mult;
+}
+
+static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
+=09=09=09=09=09   unsigned long action, void *hcpu)
+{
+=09int cpu =3D (long)hcpu;
+=09struct clock_event_device *clk =3D per_cpu_ptr(&arch_timer_evt, cpu);
+
+=09switch(action) {
+=09case CPU_STARTING:
+=09case CPU_STARTING_FROZEN:
+=09=09arch_timer_setup(clk);
+=09=09break;
+
+=09case CPU_DYING:
+=09case CPU_DYING_FROZEN:
+=09=09pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
+=09=09=09 clk->irq, cpu);
+=09=09disable_percpu_irq(clk->irq);
+=09=09arch_timer_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+=09=09break;
+=09}
+
+=09return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata arch_timer_cpu_nb =3D {
+=09.notifier_call =3D arch_timer_cpu_notify,
+};
+
+static const struct of_device_id arch_timer_of_match[] __initconst =3D {
+=09{ .compatible =3D "arm,armv8-timer" },
+=09{},
+};
+
+int __init arm_generic_timer_init(void)
+{
+=09struct device_node *np;
+=09int err;
+=09u32 freq;
+
+=09np =3D of_find_matching_node(NULL, arch_timer_of_match);
+=09if (!np) {
+=09=09pr_err("arch_timer: can't find DT node\n");
+=09=09return -ENODEV;
+=09}
+
+=09/* Try to determine the frequency from the device tree or CNTFRQ */
+=09if (!of_property_read_u32(np, "clock-frequency", &freq))
+=09=09arch_timer_rate =3D freq;
+=09arch_timer_calibrate();
+
+=09arch_timer_ppi =3D irq_of_parse_and_map(np, 0);
+=09pr_info("arch_timer: found %s irq %d\n", np->name, arch_timer_ppi);
+
+=09err =3D request_percpu_irq(arch_timer_ppi, arch_timer_handle_irq,
+=09=09=09=09 np->name, &arch_timer_evt);
+=09if (err) {
+=09=09pr_err("arch_timer: can't register interrupt %d (%d)\n",
+=09=09       arch_timer_ppi, err);
+=09=09return err;
+=09}
+
+=09clocksource_register_hz(&clocksource_counter, arch_timer_rate);
+
+=09/* Calibrate the delay loop directly */
+=09lpj_fine =3D arch_timer_rate / HZ;
+
+=09/* Immediately configure the timer on the boot CPU */
+=09arch_timer_setup(per_cpu_ptr(&arch_timer_evt, smp_processor_id()));
+
+=09register_cpu_notifier(&arch_timer_cpu_nb);
+
+=09return 0;
+}
diff --git a/include/clocksource/arm_generic.h b/include/clocksource/arm_ge=
neric.h
new file mode 100644
index 0000000..5b41b0d
--- /dev/null
+++ b/include/clocksource/arm_generic.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __CLKSOURCE_ARM_GENERIC_H
+#define __CLKSOURCE_ARM_GENERIC_H
+
+extern int arm_generic_timer_init(void);
+
+#endif

