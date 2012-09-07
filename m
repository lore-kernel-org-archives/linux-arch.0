Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34604 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab2IGQ16 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:58 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 23/31] arm64: Debugging support
Date: Fri,  7 Sep 2012 17:26:58 +0100
Message-ID: <1347035226-18649-24-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162658.jdpWexHXE8po3UpHqdoIDTEEstzeEoceT8e-o9djiWM@z>

From: Will Deacon <will.deacon@arm.com>

This patch adds ptrace, debug monitors and hardware breakpoints support.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/debug-monitors.h |   88 +++
 arch/arm64/include/asm/hw_breakpoint.h  |  137 ++++
 arch/arm64/kernel/debug-monitors.c      |  288 ++++++++
 arch/arm64/kernel/hw_breakpoint.c       |  880 ++++++++++++++++++++++++
 arch/arm64/kernel/ptrace.c              | 1126 +++++++++++++++++++++++++++=
++++
 include/linux/elf.h                     |    3 +
 6 files changed, 2522 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/debug-monitors.h
 create mode 100644 arch/arm64/include/asm/hw_breakpoint.h
 create mode 100644 arch/arm64/kernel/debug-monitors.c
 create mode 100644 arch/arm64/kernel/hw_breakpoint.c
 create mode 100644 arch/arm64/kernel/ptrace.c

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
new file mode 100644
index 0000000..7eaa0b3
--- /dev/null
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -0,0 +1,88 @@
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
+#ifndef __ASM_DEBUG_MONITORS_H
+#define __ASM_DEBUG_MONITORS_H
+
+#ifdef __KERNEL__
+
+#define=09DBG_ESR_EVT(x)=09=09(((x) >> 27) & 0x7)
+
+/* AArch64 */
+#define DBG_ESR_EVT_HWBP=090x0
+#define DBG_ESR_EVT_HWSS=090x1
+#define DBG_ESR_EVT_HWWP=090x2
+#define DBG_ESR_EVT_BRK=09=090x6
+
+enum debug_el {
+=09DBG_ACTIVE_EL0 =3D 0,
+=09DBG_ACTIVE_EL1,
+};
+
+/* AArch32 */
+#define DBG_ESR_EVT_BKPT=090x4
+#define DBG_ESR_EVT_VECC=090x5
+
+#define AARCH32_BREAK_ARM=090x07f001f0
+#define AARCH32_BREAK_THUMB=090xde01
+#define AARCH32_BREAK_THUMB2_LO=090xf7f0
+#define AARCH32_BREAK_THUMB2_HI=090xa000
+
+#ifndef __ASSEMBLY__
+struct task_struct;
+
+#define local_dbg_save(flags)=09=09=09=09=09=09=09\
+=09do {=09=09=09=09=09=09=09=09=09\
+=09=09typecheck(unsigned long, flags);=09=09=09=09\
+=09=09asm volatile(=09=09=09=09=09=09=09\
+=09=09"mrs=09%0, daif=09=09=09// local_dbg_save\n"=09\
+=09=09"msr=09daifset, #8"=09=09=09=09=09=09\
+=09=09: "=3Dr" (flags) : : "memory");=09=09=09=09=09\
+=09} while (0)
+
+#define local_dbg_restore(flags)=09=09=09=09=09=09\
+=09do {=09=09=09=09=09=09=09=09=09\
+=09=09typecheck(unsigned long, flags);=09=09=09=09\
+=09=09asm volatile(=09=09=09=09=09=09=09\
+=09=09"msr=09daif, %0=09=09=09// local_dbg_restore\n"=09\
+=09=09: : "r" (flags) : "memory");=09=09=09=09=09\
+=09} while (0)
+
+#define DBG_ARCH_ID_RESERVED=090=09/* In case of ptrace ABI updates. */
+
+u8 debug_monitors_arch(void);
+
+void enable_debug_monitors(enum debug_el el);
+void disable_debug_monitors(enum debug_el el);
+
+void user_rewind_single_step(struct task_struct *task);
+void user_fastforward_single_step(struct task_struct *task);
+
+void kernel_enable_single_step(struct pt_regs *regs);
+void kernel_disable_single_step(void);
+int kernel_active_single_step(void);
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+int reinstall_suspended_bps(struct pt_regs *regs);
+#else
+static inline int reinstall_suspended_bps(struct pt_regs *regs)
+{
+=09return -ENODEV;
+}
+#endif
+
+#endif=09/* __ASSEMBLY */
+#endif=09/* __KERNEL__ */
+#endif=09/* __ASM_DEBUG_MONITORS_H */
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/as=
m/hw_breakpoint.h
new file mode 100644
index 0000000..d064047
--- /dev/null
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -0,0 +1,137 @@
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
+#ifndef __ASM_HW_BREAKPOINT_H
+#define __ASM_HW_BREAKPOINT_H
+
+#ifdef __KERNEL__
+
+struct arch_hw_breakpoint_ctrl {
+=09u32 __reserved=09: 19,
+=09len=09=09: 8,
+=09type=09=09: 2,
+=09privilege=09: 2,
+=09enabled=09=09: 1;
+};
+
+struct arch_hw_breakpoint {
+=09u64 address;
+=09u64 trigger;
+=09struct arch_hw_breakpoint_ctrl ctrl;
+};
+
+static inline u32 encode_ctrl_reg(struct arch_hw_breakpoint_ctrl ctrl)
+{
+=09return (ctrl.len << 5) | (ctrl.type << 3) | (ctrl.privilege << 1) |
+=09=09ctrl.enabled;
+}
+
+static inline void decode_ctrl_reg(u32 reg,
+=09=09=09=09   struct arch_hw_breakpoint_ctrl *ctrl)
+{
+=09ctrl->enabled=09=3D reg & 0x1;
+=09reg >>=3D 1;
+=09ctrl->privilege=09=3D reg & 0x3;
+=09reg >>=3D 2;
+=09ctrl->type=09=3D reg & 0x3;
+=09reg >>=3D 2;
+=09ctrl->len=09=3D reg & 0xff;
+}
+
+/* Breakpoint */
+#define ARM_BREAKPOINT_EXECUTE=090
+
+/* Watchpoints */
+#define ARM_BREAKPOINT_LOAD=091
+#define ARM_BREAKPOINT_STORE=092
+#define AARCH64_ESR_ACCESS_MASK=09(1 << 6)
+
+/* Privilege Levels */
+#define AARCH64_BREAKPOINT_EL1=091
+#define AARCH64_BREAKPOINT_EL0=092
+
+/* Lengths */
+#define ARM_BREAKPOINT_LEN_1=090x1
+#define ARM_BREAKPOINT_LEN_2=090x3
+#define ARM_BREAKPOINT_LEN_4=090xf
+#define ARM_BREAKPOINT_LEN_8=090xff
+
+/* Kernel stepping */
+#define ARM_KERNEL_STEP_NONE=090
+#define ARM_KERNEL_STEP_ACTIVE=091
+#define ARM_KERNEL_STEP_SUSPEND=092
+
+/*
+ * Limits.
+ * Changing these will require modifications to the register accessors.
+ */
+#define ARM_MAX_BRP=09=0916
+#define ARM_MAX_WRP=09=0916
+#define ARM_MAX_HBP_SLOTS=09(ARM_MAX_BRP + ARM_MAX_WRP)
+
+/* Virtual debug register bases. */
+#define AARCH64_DBG_REG_BVR=090
+#define AARCH64_DBG_REG_BCR=09(AARCH64_DBG_REG_BVR + ARM_MAX_BRP)
+#define AARCH64_DBG_REG_WVR=09(AARCH64_DBG_REG_BCR + ARM_MAX_BRP)
+#define AARCH64_DBG_REG_WCR=09(AARCH64_DBG_REG_WVR + ARM_MAX_WRP)
+
+/* Debug register names. */
+#define AARCH64_DBG_REG_NAME_BVR=09"bvr"
+#define AARCH64_DBG_REG_NAME_BCR=09"bcr"
+#define AARCH64_DBG_REG_NAME_WVR=09"wvr"
+#define AARCH64_DBG_REG_NAME_WCR=09"wcr"
+
+/* Accessor macros for the debug registers. */
+#define AARCH64_DBG_READ(N, REG, VAL) do {\
+=09asm volatile("mrs %0, dbg" REG #N "_el1" : "=3Dr" (VAL));\
+} while (0)
+
+#define AARCH64_DBG_WRITE(N, REG, VAL) do {\
+=09asm volatile("msr dbg" REG #N "_el1, %0" :: "r" (VAL));\
+} while (0)
+
+struct task_struct;
+struct notifier_block;
+struct perf_event;
+struct pmu;
+
+extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
+=09=09=09=09  int *gen_len, int *gen_type);
+extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+=09=09=09=09=09   unsigned long val, void *data);
+
+extern int arch_install_hw_breakpoint(struct perf_event *bp);
+extern void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+extern void hw_breakpoint_pmu_read(struct perf_event *bp);
+extern int hw_breakpoint_slots(int type);
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+extern void hw_breakpoint_thread_switch(struct task_struct *next);
+extern void ptrace_hw_copy_thread(struct task_struct *task);
+#else
+static inline void hw_breakpoint_thread_switch(struct task_struct *next)
+{
+}
+static inline void ptrace_hw_copy_thread(struct task_struct *task)
+{
+}
+#endif
+
+extern struct pmu perf_ops_bp;
+
+#endif=09/* __KERNEL__ */
+#endif=09/* __ASM_BREAKPOINT_H */
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
new file mode 100644
index 0000000..0c3ba9f
--- /dev/null
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -0,0 +1,288 @@
+/*
+ * ARMv8 single-step debug support and mdscr context switching.
+ *
+ * Copyright (C) 2012 ARM Limited
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
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/cpu.h>
+#include <linux/debugfs.h>
+#include <linux/hardirq.h>
+#include <linux/init.h>
+#include <linux/ptrace.h>
+#include <linux/stat.h>
+
+#include <asm/debug-monitors.h>
+#include <asm/local.h>
+#include <asm/cputype.h>
+#include <asm/system_misc.h>
+
+/* Low-level stepping controls. */
+#define DBG_MDSCR_SS=09=09(1 << 0)
+#define DBG_SPSR_SS=09=09(1 << 21)
+
+/* MDSCR_EL1 enabling bits */
+#define DBG_MDSCR_KDE=09=09(1 << 13)
+#define DBG_MDSCR_MDE=09=09(1 << 15)
+#define DBG_MDSCR_MASK=09=09~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
+
+/* Determine debug architecture. */
+u8 debug_monitors_arch(void)
+{
+=09return read_cpuid(ID_AA64DFR0_EL1) & 0xf;
+}
+
+/*
+ * MDSCR access routines.
+ */
+static void mdscr_write(u32 mdscr)
+{
+=09unsigned long flags;
+=09local_dbg_save(flags);
+=09asm volatile("msr mdscr_el1, %0" :: "r" (mdscr));
+=09local_dbg_restore(flags);
+}
+
+static u32 mdscr_read(void)
+{
+=09u32 mdscr;
+=09asm volatile("mrs %0, mdscr_el1" : "=3Dr" (mdscr));
+=09return mdscr;
+}
+
+/*
+ * Allow root to disable self-hosted debug from userspace.
+ * This is useful if you want to connect an external JTAG debugger.
+ */
+static u32 debug_enabled =3D 1;
+
+static int create_debug_debugfs_entry(void)
+{
+=09debugfs_create_bool("debug_enabled", 0644, NULL, &debug_enabled);
+=09return 0;
+}
+fs_initcall(create_debug_debugfs_entry);
+
+static int __init early_debug_disable(char *buf)
+{
+=09debug_enabled =3D 0;
+=09return 0;
+}
+
+early_param("nodebugmon", early_debug_disable);
+
+/*
+ * Keep track of debug users on each core.
+ * The ref counts are per-cpu so we use a local_t type.
+ */
+static DEFINE_PER_CPU(local_t, mde_ref_count);
+static DEFINE_PER_CPU(local_t, kde_ref_count);
+
+void enable_debug_monitors(enum debug_el el)
+{
+=09u32 mdscr, enable =3D 0;
+
+=09WARN_ON(preemptible());
+
+=09if (local_inc_return(&__get_cpu_var(mde_ref_count)) =3D=3D 1)
+=09=09enable =3D DBG_MDSCR_MDE;
+
+=09if (el =3D=3D DBG_ACTIVE_EL1 &&
+=09    local_inc_return(&__get_cpu_var(kde_ref_count)) =3D=3D 1)
+=09=09enable |=3D DBG_MDSCR_KDE;
+
+=09if (enable && debug_enabled) {
+=09=09mdscr =3D mdscr_read();
+=09=09mdscr |=3D enable;
+=09=09mdscr_write(mdscr);
+=09}
+}
+
+void disable_debug_monitors(enum debug_el el)
+{
+=09u32 mdscr, disable =3D 0;
+
+=09WARN_ON(preemptible());
+
+=09if (local_dec_and_test(&__get_cpu_var(mde_ref_count)))
+=09=09disable =3D ~DBG_MDSCR_MDE;
+
+=09if (el =3D=3D DBG_ACTIVE_EL1 &&
+=09    local_dec_and_test(&__get_cpu_var(kde_ref_count)))
+=09=09disable &=3D ~DBG_MDSCR_KDE;
+
+=09if (disable) {
+=09=09mdscr =3D mdscr_read();
+=09=09mdscr &=3D disable;
+=09=09mdscr_write(mdscr);
+=09}
+}
+
+/*
+ * OS lock clearing.
+ */
+static void clear_os_lock(void *unused)
+{
+=09asm volatile("msr mdscr_el1, %0" : : "r" (0));
+=09isb();
+=09asm volatile("msr oslar_el1, %0" : : "r" (0));
+=09isb();
+}
+
+static int __cpuinit os_lock_notify(struct notifier_block *self,
+=09=09=09=09    unsigned long action, void *data)
+{
+=09int cpu =3D (unsigned long)data;
+=09if (action =3D=3D CPU_ONLINE)
+=09=09smp_call_function_single(cpu, clear_os_lock, NULL, 1);
+=09return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata os_lock_nb =3D {
+=09.notifier_call =3D os_lock_notify,
+};
+
+static int __cpuinit debug_monitors_init(void)
+{
+=09/* Clear the OS lock. */
+=09smp_call_function(clear_os_lock, NULL, 1);
+=09clear_os_lock(NULL);
+
+=09/* Register hotplug handler. */
+=09register_cpu_notifier(&os_lock_nb);
+=09return 0;
+}
+postcore_initcall(debug_monitors_init);
+
+/*
+ * Single step API and exception handling.
+ */
+static void set_regs_spsr_ss(struct pt_regs *regs)
+{
+=09unsigned long spsr;
+
+=09spsr =3D regs->pstate;
+=09spsr &=3D ~DBG_SPSR_SS;
+=09spsr |=3D DBG_SPSR_SS;
+=09regs->pstate =3D spsr;
+}
+
+static void clear_regs_spsr_ss(struct pt_regs *regs)
+{
+=09unsigned long spsr;
+
+=09spsr =3D regs->pstate;
+=09spsr &=3D ~DBG_SPSR_SS;
+=09regs->pstate =3D spsr;
+}
+
+static int single_step_handler(unsigned long addr, unsigned int esr,
+=09=09=09       struct pt_regs *regs)
+{
+=09siginfo_t info;
+
+=09/*
+=09 * If we are stepping a pending breakpoint, call the hw_breakpoint
+=09 * handler first.
+=09 */
+=09if (!reinstall_suspended_bps(regs))
+=09=09return 0;
+
+=09if (user_mode(regs)) {
+=09=09info.si_signo =3D SIGTRAP;
+=09=09info.si_errno =3D 0;
+=09=09info.si_code  =3D TRAP_HWBKPT;
+=09=09info.si_addr  =3D (void __user *)instruction_pointer(regs);
+=09=09force_sig_info(SIGTRAP, &info, current);
+
+=09=09/*
+=09=09 * ptrace will disable single step unless explicitly
+=09=09 * asked to re-enable it. For other clients, it makes
+=09=09 * sense to leave it enabled (i.e. rewind the controls
+=09=09 * to the active-not-pending state).
+=09=09 */
+=09=09user_rewind_single_step(current);
+=09} else {
+=09=09/* TODO: route to KGDB */
+=09=09pr_warning("Unexpected kernel single-step exception at EL1\n");
+=09=09/*
+=09=09 * Re-enable stepping since we know that we will be
+=09=09 * returning to regs.
+=09=09 */
+=09=09set_regs_spsr_ss(regs);
+=09}
+
+=09return 0;
+}
+
+static int __init single_step_init(void)
+{
+=09hook_debug_fault_code(DBG_ESR_EVT_HWSS, single_step_handler, SIGTRAP,
+=09=09=09      TRAP_HWBKPT, "single-step handler");
+=09return 0;
+}
+arch_initcall(single_step_init);
+
+/* Re-enable single step for syscall restarting. */
+void user_rewind_single_step(struct task_struct *task)
+{
+=09/*
+=09 * If single step is active for this thread, then set SPSR.SS
+=09 * to 1 to avoid returning to the active-pending state.
+=09 */
+=09if (test_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP))
+=09=09set_regs_spsr_ss(task_pt_regs(task));
+}
+
+void user_fastforward_single_step(struct task_struct *task)
+{
+=09if (test_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP))
+=09=09clear_regs_spsr_ss(task_pt_regs(task));
+}
+
+/* Kernel API */
+void kernel_enable_single_step(struct pt_regs *regs)
+{
+=09WARN_ON(!irqs_disabled());
+=09set_regs_spsr_ss(regs);
+=09mdscr_write(mdscr_read() | DBG_MDSCR_SS);
+=09enable_debug_monitors(DBG_ACTIVE_EL1);
+}
+
+void kernel_disable_single_step(void)
+{
+=09WARN_ON(!irqs_disabled());
+=09mdscr_write(mdscr_read() & ~DBG_MDSCR_SS);
+=09disable_debug_monitors(DBG_ACTIVE_EL1);
+}
+
+int kernel_active_single_step(void)
+{
+=09WARN_ON(!irqs_disabled());
+=09return mdscr_read() & DBG_MDSCR_SS;
+}
+
+/* ptrace API */
+void user_enable_single_step(struct task_struct *task)
+{
+=09set_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
+=09set_regs_spsr_ss(task_pt_regs(task));
+}
+
+void user_disable_single_step(struct task_struct *task)
+{
+=09clear_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
+}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
new file mode 100644
index 0000000..5ab825c
--- /dev/null
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -0,0 +1,880 @@
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility=
,
+ * using the CPU's debug registers.
+ *
+ * Copyright (C) 2012 ARM Limited
+ * Author: Will Deacon <will.deacon@arm.com>
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
+#define pr_fmt(fmt) "hw-breakpoint: " fmt
+
+#include <linux/errno.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/ptrace.h>
+#include <linux/smp.h>
+
+#include <asm/compat.h>
+#include <asm/current.h>
+#include <asm/debug-monitors.h>
+#include <asm/hw_breakpoint.h>
+#include <asm/kdebug.h>
+#include <asm/traps.h>
+#include <asm/cputype.h>
+#include <asm/system_misc.h>
+
+/* Breakpoint currently in use for each BRP. */
+static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
+
+/* Watchpoint currently in use for each WRP. */
+static DEFINE_PER_CPU(struct perf_event *, wp_on_reg[ARM_MAX_WRP]);
+
+/* Currently stepping a per-CPU kernel breakpoint. */
+static DEFINE_PER_CPU(int, stepping_kernel_bp);
+
+/* Number of BRP/WRP registers on this CPU. */
+static int core_num_brps;
+static int core_num_wrps;
+
+/* Determine number of BRP registers available. */
+static int get_num_brps(void)
+{
+=09return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
+}
+
+/* Determine number of WRP registers available. */
+static int get_num_wrps(void)
+{
+=09return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
+}
+
+int hw_breakpoint_slots(int type)
+{
+=09/*
+=09 * We can be called early, so don't rely on
+=09 * our static variables being initialised.
+=09 */
+=09switch (type) {
+=09case TYPE_INST:
+=09=09return get_num_brps();
+=09case TYPE_DATA:
+=09=09return get_num_wrps();
+=09default:
+=09=09pr_warning("unknown slot type: %d\n", type);
+=09=09return 0;
+=09}
+}
+
+#define READ_WB_REG_CASE(OFF, N, REG, VAL)=09\
+=09case (OFF + N):=09=09=09=09\
+=09=09AARCH64_DBG_READ(N, REG, VAL);=09\
+=09=09break
+
+#define WRITE_WB_REG_CASE(OFF, N, REG, VAL)=09\
+=09case (OFF + N):=09=09=09=09\
+=09=09AARCH64_DBG_WRITE(N, REG, VAL);=09\
+=09=09break
+
+#define GEN_READ_WB_REG_CASES(OFF, REG, VAL)=09\
+=09READ_WB_REG_CASE(OFF,  0, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  1, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  2, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  3, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  4, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  5, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  6, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  7, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  8, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF,  9, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF, 10, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF, 11, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF, 12, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF, 13, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF, 14, REG, VAL);=09\
+=09READ_WB_REG_CASE(OFF, 15, REG, VAL)
+
+#define GEN_WRITE_WB_REG_CASES(OFF, REG, VAL)=09\
+=09WRITE_WB_REG_CASE(OFF,  0, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  1, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  2, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  3, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  4, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  5, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  6, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  7, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  8, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF,  9, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF, 10, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF, 11, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF, 12, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF, 13, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF, 14, REG, VAL);=09\
+=09WRITE_WB_REG_CASE(OFF, 15, REG, VAL)
+
+static u64 read_wb_reg(int reg, int n)
+{
+=09u64 val =3D 0;
+
+=09switch (reg + n) {
+=09GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, va=
l);
+=09GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_BCR, AARCH64_DBG_REG_NAME_BCR, va=
l);
+=09GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, va=
l);
+=09GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, va=
l);
+=09default:
+=09=09pr_warning("attempt to read from unknown breakpoint register %d\n", =
n);
+=09}
+
+=09return val;
+}
+
+static void write_wb_reg(int reg, int n, u64 val)
+{
+=09switch (reg + n) {
+=09GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, v=
al);
+=09GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BCR, AARCH64_DBG_REG_NAME_BCR, v=
al);
+=09GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, v=
al);
+=09GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, v=
al);
+=09default:
+=09=09pr_warning("attempt to write to unknown breakpoint register %d\n", n=
);
+=09}
+=09isb();
+}
+
+/*
+ * Convert a breakpoint privilege level to the corresponding exception
+ * level.
+ */
+static enum debug_el debug_exception_level(int privilege)
+{
+=09switch (privilege) {
+=09case AARCH64_BREAKPOINT_EL0:
+=09=09return DBG_ACTIVE_EL0;
+=09case AARCH64_BREAKPOINT_EL1:
+=09=09return DBG_ACTIVE_EL1;
+=09default:
+=09=09pr_warning("invalid breakpoint privilege level %d\n", privilege);
+=09=09return -EINVAL;
+=09}
+}
+
+/*
+ * Install a perf counter breakpoint.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+=09struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
+=09struct perf_event **slot, **slots;
+=09struct debug_info *debug_info =3D &current->thread.debug;
+=09int i, max_slots, ctrl_reg, val_reg, reg_enable;
+=09u32 ctrl;
+
+=09if (info->ctrl.type =3D=3D ARM_BREAKPOINT_EXECUTE) {
+=09=09/* Breakpoint */
+=09=09ctrl_reg =3D AARCH64_DBG_REG_BCR;
+=09=09val_reg =3D AARCH64_DBG_REG_BVR;
+=09=09slots =3D __get_cpu_var(bp_on_reg);
+=09=09max_slots =3D core_num_brps;
+=09=09reg_enable =3D !debug_info->bps_disabled;
+=09} else {
+=09=09/* Watchpoint */
+=09=09ctrl_reg =3D AARCH64_DBG_REG_WCR;
+=09=09val_reg =3D AARCH64_DBG_REG_WVR;
+=09=09slots =3D __get_cpu_var(wp_on_reg);
+=09=09max_slots =3D core_num_wrps;
+=09=09reg_enable =3D !debug_info->wps_disabled;
+=09}
+
+=09for (i =3D 0; i < max_slots; ++i) {
+=09=09slot =3D &slots[i];
+
+=09=09if (!*slot) {
+=09=09=09*slot =3D bp;
+=09=09=09break;
+=09=09}
+=09}
+
+=09if (WARN_ONCE(i =3D=3D max_slots, "Can't find any breakpoint slot"))
+=09=09return -ENOSPC;
+
+=09/* Ensure debug monitors are enabled at the correct exception level.  *=
/
+=09enable_debug_monitors(debug_exception_level(info->ctrl.privilege));
+
+=09/* Setup the address register. */
+=09write_wb_reg(val_reg, i, info->address);
+
+=09/* Setup the control register. */
+=09ctrl =3D encode_ctrl_reg(info->ctrl);
+=09write_wb_reg(ctrl_reg, i, reg_enable ? ctrl | 0x1 : ctrl & ~0x1);
+
+=09return 0;
+}
+
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+=09struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
+=09struct perf_event **slot, **slots;
+=09int i, max_slots, base;
+
+=09if (info->ctrl.type =3D=3D ARM_BREAKPOINT_EXECUTE) {
+=09=09/* Breakpoint */
+=09=09base =3D AARCH64_DBG_REG_BCR;
+=09=09slots =3D __get_cpu_var(bp_on_reg);
+=09=09max_slots =3D core_num_brps;
+=09} else {
+=09=09/* Watchpoint */
+=09=09base =3D AARCH64_DBG_REG_WCR;
+=09=09slots =3D __get_cpu_var(wp_on_reg);
+=09=09max_slots =3D core_num_wrps;
+=09}
+
+=09/* Remove the breakpoint. */
+=09for (i =3D 0; i < max_slots; ++i) {
+=09=09slot =3D &slots[i];
+
+=09=09if (*slot =3D=3D bp) {
+=09=09=09*slot =3D NULL;
+=09=09=09break;
+=09=09}
+=09}
+
+=09if (WARN_ONCE(i =3D=3D max_slots, "Can't find any breakpoint slot"))
+=09=09return;
+
+=09/* Reset the control register. */
+=09write_wb_reg(base, i, 0);
+
+=09/* Release the debug monitors for the correct exception level.  */
+=09disable_debug_monitors(debug_exception_level(info->ctrl.privilege));
+}
+
+static int get_hbp_len(u8 hbp_len)
+{
+=09unsigned int len_in_bytes =3D 0;
+
+=09switch (hbp_len) {
+=09case ARM_BREAKPOINT_LEN_1:
+=09=09len_in_bytes =3D 1;
+=09=09break;
+=09case ARM_BREAKPOINT_LEN_2:
+=09=09len_in_bytes =3D 2;
+=09=09break;
+=09case ARM_BREAKPOINT_LEN_4:
+=09=09len_in_bytes =3D 4;
+=09=09break;
+=09case ARM_BREAKPOINT_LEN_8:
+=09=09len_in_bytes =3D 8;
+=09=09break;
+=09}
+
+=09return len_in_bytes;
+}
+
+/*
+ * Check whether bp virtual address is in kernel space.
+ */
+int arch_check_bp_in_kernelspace(struct perf_event *bp)
+{
+=09unsigned int len;
+=09unsigned long va;
+=09struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
+
+=09va =3D info->address;
+=09len =3D get_hbp_len(info->ctrl.len);
+
+=09return (va >=3D TASK_SIZE) && ((va + len - 1) >=3D TASK_SIZE);
+}
+
+/*
+ * Extract generic type and length encodings from an arch_hw_breakpoint_ct=
rl.
+ * Hopefully this will disappear when ptrace can bypass the conversion
+ * to generic breakpoint descriptions.
+ */
+int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
+=09=09=09   int *gen_len, int *gen_type)
+{
+=09/* Type */
+=09switch (ctrl.type) {
+=09case ARM_BREAKPOINT_EXECUTE:
+=09=09*gen_type =3D HW_BREAKPOINT_X;
+=09=09break;
+=09case ARM_BREAKPOINT_LOAD:
+=09=09*gen_type =3D HW_BREAKPOINT_R;
+=09=09break;
+=09case ARM_BREAKPOINT_STORE:
+=09=09*gen_type =3D HW_BREAKPOINT_W;
+=09=09break;
+=09case ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE:
+=09=09*gen_type =3D HW_BREAKPOINT_RW;
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09/* Len */
+=09switch (ctrl.len) {
+=09case ARM_BREAKPOINT_LEN_1:
+=09=09*gen_len =3D HW_BREAKPOINT_LEN_1;
+=09=09break;
+=09case ARM_BREAKPOINT_LEN_2:
+=09=09*gen_len =3D HW_BREAKPOINT_LEN_2;
+=09=09break;
+=09case ARM_BREAKPOINT_LEN_4:
+=09=09*gen_len =3D HW_BREAKPOINT_LEN_4;
+=09=09break;
+=09case ARM_BREAKPOINT_LEN_8:
+=09=09*gen_len =3D HW_BREAKPOINT_LEN_8;
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
+/*
+ * Construct an arch_hw_breakpoint from a perf_event.
+ */
+static int arch_build_bp_info(struct perf_event *bp)
+{
+=09struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
+
+=09/* Type */
+=09switch (bp->attr.bp_type) {
+=09case HW_BREAKPOINT_X:
+=09=09info->ctrl.type =3D ARM_BREAKPOINT_EXECUTE;
+=09=09break;
+=09case HW_BREAKPOINT_R:
+=09=09info->ctrl.type =3D ARM_BREAKPOINT_LOAD;
+=09=09break;
+=09case HW_BREAKPOINT_W:
+=09=09info->ctrl.type =3D ARM_BREAKPOINT_STORE;
+=09=09break;
+=09case HW_BREAKPOINT_RW:
+=09=09info->ctrl.type =3D ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09/* Len */
+=09switch (bp->attr.bp_len) {
+=09case HW_BREAKPOINT_LEN_1:
+=09=09info->ctrl.len =3D ARM_BREAKPOINT_LEN_1;
+=09=09break;
+=09case HW_BREAKPOINT_LEN_2:
+=09=09info->ctrl.len =3D ARM_BREAKPOINT_LEN_2;
+=09=09break;
+=09case HW_BREAKPOINT_LEN_4:
+=09=09info->ctrl.len =3D ARM_BREAKPOINT_LEN_4;
+=09=09break;
+=09case HW_BREAKPOINT_LEN_8:
+=09=09info->ctrl.len =3D ARM_BREAKPOINT_LEN_8;
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09/*
+=09 * On AArch64, we only permit breakpoints of length 4, whereas
+=09 * AArch32 also requires breakpoints of length 2 for Thumb.
+=09 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
+=09 */
+=09if (info->ctrl.type =3D=3D ARM_BREAKPOINT_EXECUTE) {
+=09=09if (is_compat_task()) {
+=09=09=09if (info->ctrl.len !=3D ARM_BREAKPOINT_LEN_2 &&
+=09=09=09    info->ctrl.len !=3D ARM_BREAKPOINT_LEN_4)
+=09=09=09=09return -EINVAL;
+=09=09} else if (info->ctrl.len !=3D ARM_BREAKPOINT_LEN_4) {
+=09=09=09/*
+=09=09=09 * FIXME: Some tools (I'm looking at you perf) assume
+=09=09=09 *=09  that breakpoints should be sizeof(long). This
+=09=09=09 *=09  is nonsense. For now, we fix up the parameter
+=09=09=09 *=09  but we should probably return -EINVAL instead.
+=09=09=09 */
+=09=09=09info->ctrl.len =3D ARM_BREAKPOINT_LEN_4;
+=09=09}
+=09}
+
+=09/* Address */
+=09info->address =3D bp->attr.bp_addr;
+
+=09/*
+=09 * Privilege
+=09 * Note that we disallow combined EL0/EL1 breakpoints because
+=09 * that would complicate the stepping code.
+=09 */
+=09if (arch_check_bp_in_kernelspace(bp))
+=09=09info->ctrl.privilege =3D AARCH64_BREAKPOINT_EL1;
+=09else
+=09=09info->ctrl.privilege =3D AARCH64_BREAKPOINT_EL0;
+
+=09/* Enabled? */
+=09info->ctrl.enabled =3D !bp->attr.disabled;
+
+=09return 0;
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings.
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp)
+{
+=09struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
+=09int ret;
+=09u64 alignment_mask, offset;
+
+=09/* Build the arch_hw_breakpoint. */
+=09ret =3D arch_build_bp_info(bp);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Check address alignment.
+=09 * We don't do any clever alignment correction for watchpoints
+=09 * because using 64-bit unaligned addresses is deprecated for
+=09 * AArch64.
+=09 *
+=09 * AArch32 tasks expect some simple alignment fixups, so emulate
+=09 * that here.
+=09 */
+=09if (is_compat_task()) {
+=09=09if (info->ctrl.len =3D=3D ARM_BREAKPOINT_LEN_8)
+=09=09=09alignment_mask =3D 0x7;
+=09=09else
+=09=09=09alignment_mask =3D 0x3;
+=09=09offset =3D info->address & alignment_mask;
+=09=09switch (offset) {
+=09=09case 0:
+=09=09=09/* Aligned */
+=09=09=09break;
+=09=09case 1:
+=09=09=09/* Allow single byte watchpoint. */
+=09=09=09if (info->ctrl.len =3D=3D ARM_BREAKPOINT_LEN_1)
+=09=09=09=09break;
+=09=09case 2:
+=09=09=09/* Allow halfword watchpoints and breakpoints. */
+=09=09=09if (info->ctrl.len =3D=3D ARM_BREAKPOINT_LEN_2)
+=09=09=09=09break;
+=09=09default:
+=09=09=09return -EINVAL;
+=09=09}
+
+=09=09info->address &=3D ~alignment_mask;
+=09=09info->ctrl.len <<=3D offset;
+=09} else {
+=09=09if (info->ctrl.type =3D=3D ARM_BREAKPOINT_EXECUTE)
+=09=09=09alignment_mask =3D 0x3;
+=09=09else
+=09=09=09alignment_mask =3D 0x7;
+=09=09if (info->address & alignment_mask)
+=09=09=09return -EINVAL;
+=09}
+
+=09/*
+=09 * Disallow per-task kernel breakpoints since these would
+=09 * complicate the stepping code.
+=09 */
+=09if (info->ctrl.privilege =3D=3D AARCH64_BREAKPOINT_EL1 && bp->hw.bp_tar=
get)
+=09=09return -EINVAL;
+
+=09return 0;
+}
+
+/*
+ * Enable/disable all of the breakpoints active at the specified
+ * exception level at the register level.
+ * This is used when single-stepping after a breakpoint exception.
+ */
+static void toggle_bp_registers(int reg, enum debug_el el, int enable)
+{
+=09int i, max_slots, privilege;
+=09u32 ctrl;
+=09struct perf_event **slots;
+
+=09switch (reg) {
+=09case AARCH64_DBG_REG_BCR:
+=09=09slots =3D __get_cpu_var(bp_on_reg);
+=09=09max_slots =3D core_num_brps;
+=09=09break;
+=09case AARCH64_DBG_REG_WCR:
+=09=09slots =3D __get_cpu_var(wp_on_reg);
+=09=09max_slots =3D core_num_wrps;
+=09=09break;
+=09default:
+=09=09return;
+=09}
+
+=09for (i =3D 0; i < max_slots; ++i) {
+=09=09if (!slots[i])
+=09=09=09continue;
+
+=09=09privilege =3D counter_arch_bp(slots[i])->ctrl.privilege;
+=09=09if (debug_exception_level(privilege) !=3D el)
+=09=09=09continue;
+
+=09=09ctrl =3D read_wb_reg(reg, i);
+=09=09if (enable)
+=09=09=09ctrl |=3D 0x1;
+=09=09else
+=09=09=09ctrl &=3D ~0x1;
+=09=09write_wb_reg(reg, i, ctrl);
+=09}
+}
+
+/*
+ * Debug exception handlers.
+ */
+static int breakpoint_handler(unsigned long unused, unsigned int esr,
+=09=09=09      struct pt_regs *regs)
+{
+=09int i, step =3D 0, *kernel_step;
+=09u32 ctrl_reg;
+=09u64 addr, val;
+=09struct perf_event *bp, **slots;
+=09struct debug_info *debug_info;
+=09struct arch_hw_breakpoint_ctrl ctrl;
+
+=09slots =3D (struct perf_event **)__get_cpu_var(bp_on_reg);
+=09addr =3D instruction_pointer(regs);
+=09debug_info =3D &current->thread.debug;
+
+=09for (i =3D 0; i < core_num_brps; ++i) {
+=09=09rcu_read_lock();
+
+=09=09bp =3D slots[i];
+
+=09=09if (bp =3D=3D NULL)
+=09=09=09goto unlock;
+
+=09=09/* Check if the breakpoint value matches. */
+=09=09val =3D read_wb_reg(AARCH64_DBG_REG_BVR, i);
+=09=09if (val !=3D (addr & ~0x3))
+=09=09=09goto unlock;
+
+=09=09/* Possible match, check the byte address select to confirm. */
+=09=09ctrl_reg =3D read_wb_reg(AARCH64_DBG_REG_BCR, i);
+=09=09decode_ctrl_reg(ctrl_reg, &ctrl);
+=09=09if (!((1 << (addr & 0x3)) & ctrl.len))
+=09=09=09goto unlock;
+
+=09=09counter_arch_bp(bp)->trigger =3D addr;
+=09=09perf_bp_event(bp, regs);
+
+=09=09/* Do we need to handle the stepping? */
+=09=09if (!bp->overflow_handler)
+=09=09=09step =3D 1;
+unlock:
+=09=09rcu_read_unlock();
+=09}
+
+=09if (!step)
+=09=09return 0;
+
+=09if (user_mode(regs)) {
+=09=09debug_info->bps_disabled =3D 1;
+=09=09toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL0, 0);
+
+=09=09/* If we're already stepping a watchpoint, just return. */
+=09=09if (debug_info->wps_disabled)
+=09=09=09return 0;
+
+=09=09if (test_thread_flag(TIF_SINGLESTEP))
+=09=09=09debug_info->suspended_step =3D 1;
+=09=09else
+=09=09=09user_enable_single_step(current);
+=09} else {
+=09=09toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL1, 0);
+=09=09kernel_step =3D &__get_cpu_var(stepping_kernel_bp);
+
+=09=09if (*kernel_step !=3D ARM_KERNEL_STEP_NONE)
+=09=09=09return 0;
+
+=09=09if (kernel_active_single_step()) {
+=09=09=09*kernel_step =3D ARM_KERNEL_STEP_SUSPEND;
+=09=09} else {
+=09=09=09*kernel_step =3D ARM_KERNEL_STEP_ACTIVE;
+=09=09=09kernel_enable_single_step(regs);
+=09=09}
+=09}
+
+=09return 0;
+}
+
+static int watchpoint_handler(unsigned long addr, unsigned int esr,
+=09=09=09      struct pt_regs *regs)
+{
+=09int i, step =3D 0, *kernel_step, access;
+=09u32 ctrl_reg;
+=09u64 val, alignment_mask;
+=09struct perf_event *wp, **slots;
+=09struct debug_info *debug_info;
+=09struct arch_hw_breakpoint *info;
+=09struct arch_hw_breakpoint_ctrl ctrl;
+
+=09slots =3D (struct perf_event **)__get_cpu_var(wp_on_reg);
+=09debug_info =3D &current->thread.debug;
+
+=09for (i =3D 0; i < core_num_wrps; ++i) {
+=09=09rcu_read_lock();
+
+=09=09wp =3D slots[i];
+
+=09=09if (wp =3D=3D NULL)
+=09=09=09goto unlock;
+
+=09=09info =3D counter_arch_bp(wp);
+=09=09/* AArch32 watchpoints are either 4 or 8 bytes aligned. */
+=09=09if (is_compat_task()) {
+=09=09=09if (info->ctrl.len =3D=3D ARM_BREAKPOINT_LEN_8)
+=09=09=09=09alignment_mask =3D 0x7;
+=09=09=09else
+=09=09=09=09alignment_mask =3D 0x3;
+=09=09} else {
+=09=09=09alignment_mask =3D 0x7;
+=09=09}
+
+=09=09/* Check if the watchpoint value matches. */
+=09=09val =3D read_wb_reg(AARCH64_DBG_REG_WVR, i);
+=09=09if (val !=3D (addr & ~alignment_mask))
+=09=09=09goto unlock;
+
+=09=09/* Possible match, check the byte address select to confirm. */
+=09=09ctrl_reg =3D read_wb_reg(AARCH64_DBG_REG_WCR, i);
+=09=09decode_ctrl_reg(ctrl_reg, &ctrl);
+=09=09if (!((1 << (addr & alignment_mask)) & ctrl.len))
+=09=09=09goto unlock;
+
+=09=09/*
+=09=09 * Check that the access type matches.
+=09=09 * 0 =3D> load, otherwise =3D> store
+=09=09 */
+=09=09access =3D (esr & AARCH64_ESR_ACCESS_MASK) ? HW_BREAKPOINT_W :
+=09=09=09 HW_BREAKPOINT_R;
+=09=09if (!(access & hw_breakpoint_type(wp)))
+=09=09=09goto unlock;
+
+=09=09info->trigger =3D addr;
+=09=09perf_bp_event(wp, regs);
+
+=09=09/* Do we need to handle the stepping? */
+=09=09if (!wp->overflow_handler)
+=09=09=09step =3D 1;
+
+unlock:
+=09=09rcu_read_unlock();
+=09}
+
+=09if (!step)
+=09=09return 0;
+
+=09/*
+=09 * We always disable EL0 watchpoints because the kernel can
+=09 * cause these to fire via an unprivileged access.
+=09 */
+=09toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 0);
+
+=09if (user_mode(regs)) {
+=09=09debug_info->wps_disabled =3D 1;
+
+=09=09/* If we're already stepping a breakpoint, just return. */
+=09=09if (debug_info->bps_disabled)
+=09=09=09return 0;
+
+=09=09if (test_thread_flag(TIF_SINGLESTEP))
+=09=09=09debug_info->suspended_step =3D 1;
+=09=09else
+=09=09=09user_enable_single_step(current);
+=09} else {
+=09=09toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL1, 0);
+=09=09kernel_step =3D &__get_cpu_var(stepping_kernel_bp);
+
+=09=09if (*kernel_step !=3D ARM_KERNEL_STEP_NONE)
+=09=09=09return 0;
+
+=09=09if (kernel_active_single_step()) {
+=09=09=09*kernel_step =3D ARM_KERNEL_STEP_SUSPEND;
+=09=09} else {
+=09=09=09*kernel_step =3D ARM_KERNEL_STEP_ACTIVE;
+=09=09=09kernel_enable_single_step(regs);
+=09=09}
+=09}
+
+=09return 0;
+}
+
+/*
+ * Handle single-step exception.
+ */
+int reinstall_suspended_bps(struct pt_regs *regs)
+{
+=09struct debug_info *debug_info =3D &current->thread.debug;
+=09int handled_exception =3D 0, *kernel_step;
+
+=09kernel_step =3D &__get_cpu_var(stepping_kernel_bp);
+
+=09/*
+=09 * Called from single-step exception handler.
+=09 * Return 0 if execution can resume, 1 if a SIGTRAP should be
+=09 * reported.
+=09 */
+=09if (user_mode(regs)) {
+=09=09if (debug_info->bps_disabled) {
+=09=09=09debug_info->bps_disabled =3D 0;
+=09=09=09toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL0, 1);
+=09=09=09handled_exception =3D 1;
+=09=09}
+
+=09=09if (debug_info->wps_disabled) {
+=09=09=09debug_info->wps_disabled =3D 0;
+=09=09=09toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 1);
+=09=09=09handled_exception =3D 1;
+=09=09}
+
+=09=09if (handled_exception) {
+=09=09=09if (debug_info->suspended_step) {
+=09=09=09=09debug_info->suspended_step =3D 0;
+=09=09=09=09/* Allow exception handling to fall-through. */
+=09=09=09=09handled_exception =3D 0;
+=09=09=09} else {
+=09=09=09=09user_disable_single_step(current);
+=09=09=09}
+=09=09}
+=09} else if (*kernel_step !=3D ARM_KERNEL_STEP_NONE) {
+=09=09toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL1, 1);
+=09=09toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL1, 1);
+
+=09=09if (!debug_info->wps_disabled)
+=09=09=09toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 1);
+
+=09=09if (*kernel_step !=3D ARM_KERNEL_STEP_SUSPEND) {
+=09=09=09kernel_disable_single_step();
+=09=09=09handled_exception =3D 1;
+=09=09} else {
+=09=09=09handled_exception =3D 0;
+=09=09}
+
+=09=09*kernel_step =3D ARM_KERNEL_STEP_NONE;
+=09}
+
+=09return !handled_exception;
+}
+
+/*
+ * Context-switcher for restoring suspended breakpoints.
+ */
+void hw_breakpoint_thread_switch(struct task_struct *next)
+{
+=09/*
+=09 *           current        next
+=09 * disabled: 0              0     =3D> The usual case, NOTIFY_DONE
+=09 *           0              1     =3D> Disable the registers
+=09 *           1              0     =3D> Enable the registers
+=09 *           1              1     =3D> NOTIFY_DONE. per-task bps will
+=09 *                                   get taken care of by perf.
+=09 */
+
+=09struct debug_info *current_debug_info, *next_debug_info;
+
+=09current_debug_info =3D &current->thread.debug;
+=09next_debug_info =3D &next->thread.debug;
+
+=09/* Update breakpoints. */
+=09if (current_debug_info->bps_disabled !=3D next_debug_info->bps_disabled=
)
+=09=09toggle_bp_registers(AARCH64_DBG_REG_BCR,
+=09=09=09=09    DBG_ACTIVE_EL0,
+=09=09=09=09    !next_debug_info->bps_disabled);
+
+=09/* Update watchpoints. */
+=09if (current_debug_info->wps_disabled !=3D next_debug_info->wps_disabled=
)
+=09=09toggle_bp_registers(AARCH64_DBG_REG_WCR,
+=09=09=09=09    DBG_ACTIVE_EL0,
+=09=09=09=09    !next_debug_info->wps_disabled);
+}
+
+/*
+ * CPU initialisation.
+ */
+static void reset_ctrl_regs(void *unused)
+{
+=09int i;
+
+=09for (i =3D 0; i < core_num_brps; ++i) {
+=09=09write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
+=09=09write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
+=09}
+
+=09for (i =3D 0; i < core_num_wrps; ++i) {
+=09=09write_wb_reg(AARCH64_DBG_REG_WCR, i, 0UL);
+=09=09write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
+=09}
+}
+
+static int __cpuinit hw_breakpoint_reset_notify(struct notifier_block *sel=
f,
+=09=09=09=09=09=09unsigned long action,
+=09=09=09=09=09=09void *hcpu)
+{
+=09int cpu =3D (long)hcpu;
+=09if (action =3D=3D CPU_ONLINE)
+=09=09smp_call_function_single(cpu, reset_ctrl_regs, NULL, 1);
+=09return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata hw_breakpoint_reset_nb =3D {
+=09.notifier_call =3D hw_breakpoint_reset_notify,
+};
+
+/*
+ * One-time initialisation.
+ */
+static int __init arch_hw_breakpoint_init(void)
+{
+=09core_num_brps =3D get_num_brps();
+=09core_num_wrps =3D get_num_wrps();
+
+=09pr_info("found %d breakpoint and %d watchpoint registers.\n",
+=09=09core_num_brps, core_num_wrps);
+
+=09/*
+=09 * Reset the breakpoint resources. We assume that a halting
+=09 * debugger will leave the world in a nice state for us.
+=09 */
+=09smp_call_function(reset_ctrl_regs, NULL, 1);
+=09reset_ctrl_regs(NULL);
+
+=09/* Register debug fault handlers. */
+=09hook_debug_fault_code(DBG_ESR_EVT_HWBP, breakpoint_handler, SIGTRAP,
+=09=09=09      TRAP_HWBKPT, "hw-breakpoint handler");
+=09hook_debug_fault_code(DBG_ESR_EVT_HWWP, watchpoint_handler, SIGTRAP,
+=09=09=09      TRAP_HWBKPT, "hw-watchpoint handler");
+
+=09/* Register hotplug notifier. */
+=09register_cpu_notifier(&hw_breakpoint_reset_nb);
+
+=09return 0;
+}
+arch_initcall(arch_hw_breakpoint_init);
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+}
+
+/*
+ * Dummy function to register with die_notifier.
+ */
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+=09=09=09=09    unsigned long val, void *data)
+{
+=09return NOTIFY_DONE;
+}
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
new file mode 100644
index 0000000..9e1e200
--- /dev/null
+++ b/arch/arm64/kernel/ptrace.c
@@ -0,0 +1,1126 @@
+/*
+ * Based on arch/arm/kernel/ptrace.c
+ *
+ * By Ross Biro 1/23/92
+ * edited by Linus Torvalds
+ * ARM modifications Copyright (C) 2000 Russell King
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
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/ptrace.h>
+#include <linux/user.h>
+#include <linux/security.h>
+#include <linux/init.h>
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <linux/perf_event.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/regset.h>
+#include <linux/tracehook.h>
+#include <linux/elf.h>
+
+#include <asm/compat.h>
+#include <asm/debug-monitors.h>
+#include <asm/pgtable.h>
+#include <asm/traps.h>
+#include <asm/system_misc.h>
+
+/*
+ * TODO: does not yet catch signals sent when the child dies.
+ * in exit.c or in signal.c.
+ */
+
+/*
+ * Called by kernel/ptrace.c when detaching..
+ */
+void ptrace_disable(struct task_struct *child)
+{
+}
+
+/*
+ * Handle hitting a breakpoint.
+ */
+static int ptrace_break(struct pt_regs *regs)
+{
+=09siginfo_t info =3D {
+=09=09.si_signo =3D SIGTRAP,
+=09=09.si_errno =3D 0,
+=09=09.si_code  =3D TRAP_BRKPT,
+=09=09.si_addr  =3D (void __user *)instruction_pointer(regs),
+=09};
+
+=09force_sig_info(SIGTRAP, &info, current);
+=09return 0;
+}
+
+static int arm64_break_trap(unsigned long addr, unsigned int esr,
+=09=09=09    struct pt_regs *regs)
+{
+=09return ptrace_break(regs);
+}
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+/*
+ * Handle hitting a HW-breakpoint.
+ */
+static void ptrace_hbptriggered(struct perf_event *bp,
+=09=09=09=09struct perf_sample_data *data,
+=09=09=09=09struct pt_regs *regs)
+{
+=09struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
+=09siginfo_t info =3D {
+=09=09.si_signo=09=3D SIGTRAP,
+=09=09.si_errno=09=3D 0,
+=09=09.si_code=09=3D TRAP_HWBKPT,
+=09=09.si_addr=09=3D (void __user *)(bkpt->trigger),
+=09};
+
+#ifdef CONFIG_AARCH32_EMULATION
+=09int i;
+
+=09if (!is_compat_task())
+=09=09goto send_sig;
+
+=09for (i =3D 0; i < ARM_MAX_BRP; ++i) {
+=09=09if (current->thread.debug.hbp_break[i] =3D=3D bp) {
+=09=09=09info.si_errno =3D (i << 1) + 1;
+=09=09=09break;
+=09=09}
+=09}
+=09for (i =3D ARM_MAX_BRP; i < ARM_MAX_HBP_SLOTS && !bp; ++i) {
+=09=09if (current->thread.debug.hbp_watch[i] =3D=3D bp) {
+=09=09=09info.si_errno =3D -((i << 1) + 1);
+=09=09=09break;
+=09=09}
+=09}
+
+send_sig:
+#endif
+=09force_sig_info(SIGTRAP, &info, current);
+}
+
+/*
+ * Unregister breakpoints from this task and reset the pointers in
+ * the thread_struct.
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+=09int i;
+=09struct thread_struct *t =3D &tsk->thread;
+
+=09for (i =3D 0; i < ARM_MAX_BRP; i++) {
+=09=09if (t->debug.hbp_break[i]) {
+=09=09=09unregister_hw_breakpoint(t->debug.hbp_break[i]);
+=09=09=09t->debug.hbp_break[i] =3D NULL;
+=09=09}
+=09}
+
+=09for (i =3D 0; i < ARM_MAX_WRP; i++) {
+=09=09if (t->debug.hbp_watch[i]) {
+=09=09=09unregister_hw_breakpoint(t->debug.hbp_watch[i]);
+=09=09=09t->debug.hbp_watch[i] =3D NULL;
+=09=09}
+=09}
+}
+
+void ptrace_hw_copy_thread(struct task_struct *tsk)
+{
+=09memset(&tsk->thread.debug, 0, sizeof(struct debug_info));
+}
+
+static struct perf_event *ptrace_hbp_get_event(unsigned int note_type,
+=09=09=09=09=09       struct task_struct *tsk,
+=09=09=09=09=09       unsigned long idx)
+{
+=09struct perf_event *bp =3D ERR_PTR(-EINVAL);
+
+=09switch (note_type) {
+=09case NT_ARM_HW_BREAK:
+=09=09if (idx < ARM_MAX_BRP)
+=09=09=09bp =3D tsk->thread.debug.hbp_break[idx];
+=09=09break;
+=09case NT_ARM_HW_WATCH:
+=09=09if (idx < ARM_MAX_WRP)
+=09=09=09bp =3D tsk->thread.debug.hbp_watch[idx];
+=09=09break;
+=09}
+
+=09return bp;
+}
+
+static int ptrace_hbp_set_event(unsigned int note_type,
+=09=09=09=09struct task_struct *tsk,
+=09=09=09=09unsigned long idx,
+=09=09=09=09struct perf_event *bp)
+{
+=09int err =3D -EINVAL;
+
+=09switch (note_type) {
+=09case NT_ARM_HW_BREAK:
+=09=09if (idx < ARM_MAX_BRP) {
+=09=09=09tsk->thread.debug.hbp_break[idx] =3D bp;
+=09=09=09err =3D 0;
+=09=09}
+=09=09break;
+=09case NT_ARM_HW_WATCH:
+=09=09if (idx < ARM_MAX_WRP) {
+=09=09=09tsk->thread.debug.hbp_watch[idx] =3D bp;
+=09=09=09err =3D 0;
+=09=09}
+=09=09break;
+=09}
+
+=09return err;
+}
+
+static struct perf_event *ptrace_hbp_create(unsigned int note_type,
+=09=09=09=09=09    struct task_struct *tsk,
+=09=09=09=09=09    unsigned long idx)
+{
+=09struct perf_event *bp;
+=09struct perf_event_attr attr;
+=09int err, type;
+
+=09switch (note_type) {
+=09case NT_ARM_HW_BREAK:
+=09=09type =3D HW_BREAKPOINT_X;
+=09=09break;
+=09case NT_ARM_HW_WATCH:
+=09=09type =3D HW_BREAKPOINT_RW;
+=09=09break;
+=09default:
+=09=09return ERR_PTR(-EINVAL);
+=09}
+
+=09ptrace_breakpoint_init(&attr);
+
+=09/*
+=09 * Initialise fields to sane defaults
+=09 * (i.e. values that will pass validation).
+=09 */
+=09attr.bp_addr=09=3D 0;
+=09attr.bp_len=09=3D HW_BREAKPOINT_LEN_4;
+=09attr.bp_type=09=3D type;
+=09attr.disabled=09=3D 1;
+
+=09bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, ts=
k);
+=09if (IS_ERR(bp))
+=09=09return bp;
+
+=09err =3D ptrace_hbp_set_event(note_type, tsk, idx, bp);
+=09if (err)
+=09=09return ERR_PTR(err);
+
+=09return bp;
+}
+
+static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
+=09=09=09=09     struct arch_hw_breakpoint_ctrl ctrl,
+=09=09=09=09     struct perf_event_attr *attr)
+{
+=09int err, len, type;
+
+=09err =3D arch_bp_generic_fields(ctrl, &len, &type);
+=09if (err)
+=09=09return err;
+
+=09switch (note_type) {
+=09case NT_ARM_HW_BREAK:
+=09=09if ((type & HW_BREAKPOINT_X) !=3D type)
+=09=09=09return -EINVAL;
+=09=09break;
+=09case NT_ARM_HW_WATCH:
+=09=09if ((type & HW_BREAKPOINT_RW) !=3D type)
+=09=09=09return -EINVAL;
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09attr->bp_len=09=3D len;
+=09attr->bp_type=09=3D type;
+=09attr->disabled=09=3D !ctrl.enabled;
+
+=09return 0;
+}
+
+static int ptrace_hbp_get_resource_info(unsigned int note_type, u32 *info)
+{
+=09u8 num;
+=09u32 reg =3D 0;
+
+=09switch (note_type) {
+=09case NT_ARM_HW_BREAK:
+=09=09num =3D hw_breakpoint_slots(TYPE_INST);
+=09=09break;
+=09case NT_ARM_HW_WATCH:
+=09=09num =3D hw_breakpoint_slots(TYPE_DATA);
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09reg |=3D debug_monitors_arch();
+=09reg <<=3D 8;
+=09reg |=3D num;
+
+=09*info =3D reg;
+=09return 0;
+}
+
+static int ptrace_hbp_get_ctrl(unsigned int note_type,
+=09=09=09       struct task_struct *tsk,
+=09=09=09       unsigned long idx,
+=09=09=09       u32 *ctrl)
+{
+=09struct perf_event *bp =3D ptrace_hbp_get_event(note_type, tsk, idx);
+
+=09if (IS_ERR(bp))
+=09=09return PTR_ERR(bp);
+
+=09*ctrl =3D bp ? encode_ctrl_reg(counter_arch_bp(bp)->ctrl) : 0;
+=09return 0;
+}
+
+static int ptrace_hbp_get_addr(unsigned int note_type,
+=09=09=09       struct task_struct *tsk,
+=09=09=09       unsigned long idx,
+=09=09=09       u64 *addr)
+{
+=09struct perf_event *bp =3D ptrace_hbp_get_event(note_type, tsk, idx);
+
+=09if (IS_ERR(bp))
+=09=09return PTR_ERR(bp);
+
+=09*addr =3D bp ? bp->attr.bp_addr : 0;
+=09return 0;
+}
+
+static struct perf_event *ptrace_hbp_get_initialised_bp(unsigned int note_=
type,
+=09=09=09=09=09=09=09struct task_struct *tsk,
+=09=09=09=09=09=09=09unsigned long idx)
+{
+=09struct perf_event *bp =3D ptrace_hbp_get_event(note_type, tsk, idx);
+
+=09if (!bp)
+=09=09bp =3D ptrace_hbp_create(note_type, tsk, idx);
+
+=09return bp;
+}
+
+static int ptrace_hbp_set_ctrl(unsigned int note_type,
+=09=09=09       struct task_struct *tsk,
+=09=09=09       unsigned long idx,
+=09=09=09       u32 uctrl)
+{
+=09int err;
+=09struct perf_event *bp;
+=09struct perf_event_attr attr;
+=09struct arch_hw_breakpoint_ctrl ctrl;
+
+=09bp =3D ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
+=09if (IS_ERR(bp)) {
+=09=09err =3D PTR_ERR(bp);
+=09=09return err;
+=09}
+
+=09attr =3D bp->attr;
+=09decode_ctrl_reg(uctrl, &ctrl);
+=09err =3D ptrace_hbp_fill_attr_ctrl(note_type, ctrl, &attr);
+=09if (err)
+=09=09return err;
+
+=09return modify_user_hw_breakpoint(bp, &attr);
+}
+
+static int ptrace_hbp_set_addr(unsigned int note_type,
+=09=09=09       struct task_struct *tsk,
+=09=09=09       unsigned long idx,
+=09=09=09       u64 addr)
+{
+=09int err;
+=09struct perf_event *bp;
+=09struct perf_event_attr attr;
+
+=09bp =3D ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
+=09if (IS_ERR(bp)) {
+=09=09err =3D PTR_ERR(bp);
+=09=09return err;
+=09}
+
+=09attr =3D bp->attr;
+=09attr.bp_addr =3D addr;
+=09err =3D modify_user_hw_breakpoint(bp, &attr);
+=09return err;
+}
+
+#define PTRACE_HBP_ADDR_SZ=09sizeof(u64)
+#define PTRACE_HBP_CTRL_SZ=09sizeof(u32)
+#define PTRACE_HBP_REG_OFF=09sizeof(u32)
+
+static int hw_break_get(struct task_struct *target,
+=09=09=09const struct user_regset *regset,
+=09=09=09unsigned int pos, unsigned int count,
+=09=09=09void *kbuf, void __user *ubuf)
+{
+=09unsigned int note_type =3D regset->core_note_type;
+=09int ret, idx =3D 0, offset =3D PTRACE_HBP_REG_OFF, limit;
+=09u32 info, ctrl;
+=09u64 addr;
+
+=09/* Resource info */
+=09ret =3D ptrace_hbp_get_resource_info(note_type, &info);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, &info, 0, 4);
+=09if (ret)
+=09=09return ret;
+
+=09/* (address, ctrl) registers */
+=09limit =3D regset->n * regset->size;
+=09while (count && offset < limit) {
+=09=09ret =3D ptrace_hbp_get_addr(note_type, target, idx, &addr);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, &addr,
+=09=09=09=09=09  offset, offset + PTRACE_HBP_ADDR_SZ);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09offset +=3D PTRACE_HBP_ADDR_SZ;
+
+=09=09ret =3D ptrace_hbp_get_ctrl(note_type, target, idx, &ctrl);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, &ctrl,
+=09=09=09=09=09  offset, offset + PTRACE_HBP_CTRL_SZ);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09offset +=3D PTRACE_HBP_CTRL_SZ;
+=09=09idx++;
+=09}
+
+=09return 0;
+}
+
+static int hw_break_set(struct task_struct *target,
+=09=09=09const struct user_regset *regset,
+=09=09=09unsigned int pos, unsigned int count,
+=09=09=09const void *kbuf, const void __user *ubuf)
+{
+=09unsigned int note_type =3D regset->core_note_type;
+=09int ret, idx =3D 0, offset =3D PTRACE_HBP_REG_OFF, limit;
+=09u32 ctrl;
+=09u64 addr;
+
+=09/* Resource info */
+=09ret =3D user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0, 4);
+=09if (ret)
+=09=09return ret;
+
+=09/* (address, ctrl) registers */
+=09limit =3D regset->n * regset->size;
+=09while (count && offset < limit) {
+=09=09ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
+=09=09=09=09=09 offset, offset + PTRACE_HBP_ADDR_SZ);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09ret =3D ptrace_hbp_set_addr(note_type, target, idx, addr);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09offset +=3D PTRACE_HBP_ADDR_SZ;
+
+=09=09ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl,
+=09=09=09=09=09 offset, offset + PTRACE_HBP_CTRL_SZ);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09ret =3D ptrace_hbp_set_ctrl(note_type, target, idx, ctrl);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09offset +=3D PTRACE_HBP_CTRL_SZ;
+=09=09idx++;
+=09}
+
+=09return 0;
+}
+#endif=09/* CONFIG_HAVE_HW_BREAKPOINT */
+
+static int gpr_get(struct task_struct *target,
+=09=09   const struct user_regset *regset,
+=09=09   unsigned int pos, unsigned int count,
+=09=09   void *kbuf, void __user *ubuf)
+{
+=09struct user_pt_regs *uregs =3D &task_pt_regs(target)->user_regs;
+=09return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
+}
+
+static int gpr_set(struct task_struct *target, const struct user_regset *r=
egset,
+=09=09   unsigned int pos, unsigned int count,
+=09=09   const void *kbuf, const void __user *ubuf)
+{
+=09int ret;
+=09struct user_pt_regs newregs;
+
+=09ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newregs, 0, -1)=
;
+=09if (ret)
+=09=09return ret;
+
+=09if (!valid_user_regs(&newregs))
+=09=09return -EINVAL;
+
+=09task_pt_regs(target)->user_regs =3D newregs;
+=09return 0;
+}
+
+/*
+ * TODO: update fp accessors for lazy context switching (sync/flush hwstat=
e)
+ */
+static int fpr_get(struct task_struct *target, const struct user_regset *r=
egset,
+=09=09   unsigned int pos, unsigned int count,
+=09=09   void *kbuf, void __user *ubuf)
+{
+=09struct user_fpsimd_state *uregs;
+=09uregs =3D &target->thread.fpsimd_state.user_fpsimd;
+=09return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
+}
+
+static int fpr_set(struct task_struct *target, const struct user_regset *r=
egset,
+=09=09   unsigned int pos, unsigned int count,
+=09=09   const void *kbuf, const void __user *ubuf)
+{
+=09int ret;
+=09struct user_fpsimd_state newstate;
+
+=09ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0, -1=
);
+=09if (ret)
+=09=09return ret;
+
+=09target->thread.fpsimd_state.user_fpsimd =3D newstate;
+=09return ret;
+}
+
+static int tls_get(struct task_struct *target, const struct user_regset *r=
egset,
+=09=09   unsigned int pos, unsigned int count,
+=09=09   void *kbuf, void __user *ubuf)
+{
+=09unsigned long *tls =3D &target->thread.tp_value;
+=09return user_regset_copyout(&pos, &count, &kbuf, &ubuf, tls, 0, -1);
+}
+
+static int tls_set(struct task_struct *target, const struct user_regset *r=
egset,
+=09=09   unsigned int pos, unsigned int count,
+=09=09   const void *kbuf, const void __user *ubuf)
+{
+=09int ret;
+=09unsigned long tls;
+
+=09ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &tls, 0, -1);
+=09if (ret)
+=09=09return ret;
+
+=09target->thread.tp_value =3D tls;
+=09return ret;
+}
+
+enum aarch64_regset {
+=09REGSET_GPR,
+=09REGSET_FPR,
+=09REGSET_TLS,
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+=09REGSET_HW_BREAK,
+=09REGSET_HW_WATCH,
+#endif
+};
+
+static const struct user_regset aarch64_regsets[] =3D {
+=09[REGSET_GPR] =3D {
+=09=09.core_note_type =3D NT_PRSTATUS,
+=09=09.n =3D sizeof(struct user_pt_regs) / sizeof(u64),
+=09=09.size =3D sizeof(u64),
+=09=09.align =3D sizeof(u64),
+=09=09.get =3D gpr_get,
+=09=09.set =3D gpr_set
+=09},
+=09[REGSET_FPR] =3D {
+=09=09.core_note_type =3D NT_PRFPREG,
+=09=09.n =3D sizeof(struct user_fpsimd_state) / sizeof(u32),
+=09=09/*
+=09=09 * We pretend we have 32-bit registers because the fpsr and
+=09=09 * fpcr are 32-bits wide.
+=09=09 */
+=09=09.size =3D sizeof(u32),
+=09=09.align =3D sizeof(u32),
+=09=09.get =3D fpr_get,
+=09=09.set =3D fpr_set
+=09},
+=09[REGSET_TLS] =3D {
+=09=09.core_note_type =3D NT_ARM_TLS,
+=09=09.n =3D 1,
+=09=09.size =3D sizeof(void *),
+=09=09.align =3D sizeof(void *),
+=09=09.get =3D tls_get,
+=09=09.set =3D tls_set,
+=09},
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+=09[REGSET_HW_BREAK] =3D {
+=09=09.core_note_type =3D NT_ARM_HW_BREAK,
+=09=09.n =3D sizeof(struct user_hwdebug_state) / sizeof(u32),
+=09=09.size =3D sizeof(u32),
+=09=09.align =3D sizeof(u32),
+=09=09.get =3D hw_break_get,
+=09=09.set =3D hw_break_set,
+=09},
+=09[REGSET_HW_WATCH] =3D {
+=09=09.core_note_type =3D NT_ARM_HW_WATCH,
+=09=09.n =3D sizeof(struct user_hwdebug_state) / sizeof(u32),
+=09=09.size =3D sizeof(u32),
+=09=09.align =3D sizeof(u32),
+=09=09.get =3D hw_break_get,
+=09=09.set =3D hw_break_set,
+=09},
+#endif
+};
+
+static const struct user_regset_view user_aarch64_view =3D {
+=09.name =3D "aarch64", .e_machine =3D EM_AARCH64,
+=09.regsets =3D aarch64_regsets, .n =3D ARRAY_SIZE(aarch64_regsets)
+};
+
+#ifdef CONFIG_COMPAT
+#include <linux/compat.h>
+
+enum compat_regset {
+=09REGSET_COMPAT_GPR,
+=09REGSET_COMPAT_VFP,
+};
+
+static int compat_gpr_get(struct task_struct *target,
+=09=09=09  const struct user_regset *regset,
+=09=09=09  unsigned int pos, unsigned int count,
+=09=09=09  void *kbuf, void __user *ubuf)
+{
+=09int ret =3D 0;
+=09unsigned int i, start, num_regs;
+
+=09/* Calculate the number of AArch32 registers contained in count */
+=09num_regs =3D count / regset->size;
+
+=09/* Convert pos into an register number */
+=09start =3D pos / regset->size;
+
+=09if (start + num_regs > regset->n)
+=09=09return -EIO;
+
+=09for (i =3D 0; i < num_regs; ++i) {
+=09=09unsigned int idx =3D start + i;
+=09=09void *reg;
+
+=09=09switch (idx) {
+=09=09case 15:
+=09=09=09reg =3D (void *)&task_pt_regs(target)->pc;
+=09=09=09break;
+=09=09case 16:
+=09=09=09reg =3D (void *)&task_pt_regs(target)->pstate;
+=09=09=09break;
+=09=09case 17:
+=09=09=09reg =3D (void *)&task_pt_regs(target)->orig_x0;
+=09=09=09break;
+=09=09default:
+=09=09=09reg =3D (void *)&task_pt_regs(target)->regs[idx];
+=09=09}
+
+=09=09ret =3D copy_to_user(ubuf, reg, sizeof(compat_ulong_t));
+
+=09=09if (ret)
+=09=09=09break;
+=09=09else
+=09=09=09ubuf +=3D sizeof(compat_ulong_t);
+=09}
+
+=09return ret;
+}
+
+static int compat_gpr_set(struct task_struct *target,
+=09=09=09  const struct user_regset *regset,
+=09=09=09  unsigned int pos, unsigned int count,
+=09=09=09  const void *kbuf, const void __user *ubuf)
+{
+=09struct pt_regs newregs;
+=09int ret =3D 0;
+=09unsigned int i, start, num_regs;
+
+=09/* Calculate the number of AArch32 registers contained in count */
+=09num_regs =3D count / regset->size;
+
+=09/* Convert pos into an register number */
+=09start =3D pos / regset->size;
+
+=09if (start + num_regs > regset->n)
+=09=09return -EIO;
+
+=09newregs =3D *task_pt_regs(target);
+
+=09for (i =3D 0; i < num_regs; ++i) {
+=09=09unsigned int idx =3D start + i;
+=09=09void *reg;
+
+=09=09switch (idx) {
+=09=09case 15:
+=09=09=09reg =3D (void *)&newregs.pc;
+=09=09=09break;
+=09=09case 16:
+=09=09=09reg =3D (void *)&newregs.pstate;
+=09=09=09break;
+=09=09case 17:
+=09=09=09reg =3D (void *)&newregs.orig_x0;
+=09=09=09break;
+=09=09default:
+=09=09=09reg =3D (void *)&newregs.regs[idx];
+=09=09}
+
+=09=09ret =3D copy_from_user(reg, ubuf, sizeof(compat_ulong_t));
+
+=09=09if (ret)
+=09=09=09goto out;
+=09=09else
+=09=09=09ubuf +=3D sizeof(compat_ulong_t);
+=09}
+
+=09if (valid_user_regs(&newregs.user_regs))
+=09=09*task_pt_regs(target) =3D newregs;
+=09else
+=09=09ret =3D -EINVAL;
+
+out:
+=09return ret;
+}
+
+static int compat_vfp_get(struct task_struct *target,
+=09=09=09  const struct user_regset *regset,
+=09=09=09  unsigned int pos, unsigned int count,
+=09=09=09  void *kbuf, void __user *ubuf)
+{
+=09struct user_fpsimd_state *uregs;
+=09compat_ulong_t fpscr;
+=09int ret;
+
+=09uregs =3D &target->thread.fpsimd_state.user_fpsimd;
+
+=09/*
+=09 * The VFP registers are packed into the fpsimd_state, so they all sit
+=09 * nicely together for us. We just need to create the fpscr separately.
+=09 */
+=09ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
+=09=09=09=09  VFP_STATE_SIZE - sizeof(compat_ulong_t));
+
+=09if (count && !ret) {
+=09=09fpscr =3D (uregs->fpsr & VFP_FPSCR_STAT_MASK) |
+=09=09=09(uregs->fpcr & VFP_FPSCR_CTRL_MASK);
+=09=09ret =3D put_user(fpscr, (compat_ulong_t *)ubuf);
+=09}
+
+=09return ret;
+}
+
+static int compat_vfp_set(struct task_struct *target,
+=09=09=09  const struct user_regset *regset,
+=09=09=09  unsigned int pos, unsigned int count,
+=09=09=09  const void *kbuf, const void __user *ubuf)
+{
+=09struct user_fpsimd_state *uregs;
+=09compat_ulong_t fpscr;
+=09int ret;
+
+=09if (pos + count > VFP_STATE_SIZE)
+=09=09return -EIO;
+
+=09uregs =3D &target->thread.fpsimd_state.user_fpsimd;
+
+=09ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
+=09=09=09=09 VFP_STATE_SIZE - sizeof(compat_ulong_t));
+
+=09if (count && !ret) {
+=09=09ret =3D get_user(fpscr, (compat_ulong_t *)ubuf);
+=09=09uregs->fpsr =3D fpscr & VFP_FPSCR_STAT_MASK;
+=09=09uregs->fpcr =3D fpscr & VFP_FPSCR_CTRL_MASK;
+=09}
+
+=09return ret;
+}
+
+static const struct user_regset aarch32_regsets[] =3D {
+=09[REGSET_COMPAT_GPR] =3D {
+=09=09.core_note_type =3D NT_PRSTATUS,
+=09=09.n =3D COMPAT_ELF_NGREG,
+=09=09.size =3D sizeof(compat_elf_greg_t),
+=09=09.align =3D sizeof(compat_elf_greg_t),
+=09=09.get =3D compat_gpr_get,
+=09=09.set =3D compat_gpr_set
+=09},
+=09[REGSET_COMPAT_VFP] =3D {
+=09=09.core_note_type =3D NT_ARM_VFP,
+=09=09.n =3D VFP_STATE_SIZE / sizeof(compat_ulong_t),
+=09=09.size =3D sizeof(compat_ulong_t),
+=09=09.align =3D sizeof(compat_ulong_t),
+=09=09.get =3D compat_vfp_get,
+=09=09.set =3D compat_vfp_set
+=09},
+};
+
+static const struct user_regset_view user_aarch32_view =3D {
+=09.name =3D "aarch32", .e_machine =3D EM_ARM,
+=09.regsets =3D aarch32_regsets, .n =3D ARRAY_SIZE(aarch32_regsets)
+};
+
+int aarch32_break_trap(struct pt_regs *regs)
+{
+=09unsigned int instr;
+=09bool bp =3D false;
+=09void __user *pc =3D (void __user *)instruction_pointer(regs);
+
+=09if (compat_thumb_mode(regs)) {
+=09=09/* get 16-bit Thumb instruction */
+=09=09get_user(instr, (u16 __user *)pc);
+=09=09if (instr =3D=3D AARCH32_BREAK_THUMB2_LO) {
+=09=09=09/* get second half of 32-bit Thumb-2 instruction */
+=09=09=09get_user(instr, (u16 __user *)(pc + 2));
+=09=09=09bp =3D instr =3D=3D AARCH32_BREAK_THUMB2_HI;
+=09=09} else {
+=09=09=09bp =3D instr =3D=3D AARCH32_BREAK_THUMB;
+=09=09}
+=09} else {
+=09=09/* 32-bit ARM instruction */
+=09=09get_user(instr, (u32 __user *)pc);
+=09=09bp =3D (instr & ~0xf0000000) =3D=3D AARCH32_BREAK_ARM;
+=09}
+
+=09if (bp)
+=09=09return ptrace_break(regs);
+=09return 1;
+}
+
+static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t=
 off,
+=09=09=09=09   compat_ulong_t __user *ret)
+{
+=09compat_ulong_t tmp;
+
+=09if (off & 3)
+=09=09return -EIO;
+
+=09if (off =3D=3D PT_TEXT_ADDR)
+=09=09tmp =3D tsk->mm->start_code;
+=09else if (off =3D=3D PT_DATA_ADDR)
+=09=09tmp =3D tsk->mm->start_data;
+=09else if (off =3D=3D PT_TEXT_END_ADDR)
+=09=09tmp =3D tsk->mm->end_code;
+=09else if (off < sizeof(compat_elf_gregset_t))
+=09=09return copy_regset_to_user(tsk, &user_aarch32_view,
+=09=09=09=09=09   REGSET_COMPAT_GPR, off,
+=09=09=09=09=09   sizeof(compat_ulong_t), ret);
+=09else if (off >=3D COMPAT_USER_SZ)
+=09=09return -EIO;
+=09else
+=09=09tmp =3D 0;
+
+=09return put_user(tmp, ret);
+}
+
+static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_=
t off,
+=09=09=09=09    compat_ulong_t val)
+{
+=09int ret;
+
+=09if (off & 3 || off >=3D COMPAT_USER_SZ)
+=09=09return -EIO;
+
+=09if (off >=3D sizeof(compat_elf_gregset_t))
+=09=09return 0;
+
+=09ret =3D copy_regset_from_user(tsk, &user_aarch32_view,
+=09=09=09=09    REGSET_COMPAT_GPR, off,
+=09=09=09=09    sizeof(compat_ulong_t),
+=09=09=09=09    &val);
+=09return ret;
+}
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+/*
+ * Convert a virtual register number into an index for a thread_info
+ * breakpoint array. Breakpoints are identified using positive numbers
+ * whilst watchpoints are negative. The registers are laid out as pairs
+ * of (address, control), each pair mapping to a unique hw_breakpoint stru=
ct.
+ * Register 0 is reserved for describing resource information.
+ */
+static int compat_ptrace_hbp_num_to_idx(compat_long_t num)
+{
+=09return (abs(num) - 1) >> 1;
+}
+
+static int compat_ptrace_hbp_get_resource_info(u32 *kdata)
+{
+=09u8 num_brps, num_wrps, debug_arch, wp_len;
+=09u32 reg =3D 0;
+
+=09num_brps=09=3D hw_breakpoint_slots(TYPE_INST);
+=09num_wrps=09=3D hw_breakpoint_slots(TYPE_DATA);
+
+=09debug_arch=09=3D debug_monitors_arch();
+=09wp_len=09=09=3D 8;
+=09reg=09=09|=3D debug_arch;
+=09reg=09=09<<=3D 8;
+=09reg=09=09|=3D wp_len;
+=09reg=09=09<<=3D 8;
+=09reg=09=09|=3D num_wrps;
+=09reg=09=09<<=3D 8;
+=09reg=09=09|=3D num_brps;
+
+=09*kdata =3D reg;
+=09return 0;
+}
+
+static int compat_ptrace_hbp_get(unsigned int note_type,
+=09=09=09=09 struct task_struct *tsk,
+=09=09=09=09 compat_long_t num,
+=09=09=09=09 u32 *kdata)
+{
+=09u64 addr =3D 0;
+=09u32 ctrl =3D 0;
+
+=09int err, idx =3D compat_ptrace_hbp_num_to_idx(num);;
+
+=09if (num & 1) {
+=09=09err =3D ptrace_hbp_get_addr(note_type, tsk, idx, &addr);
+=09=09*kdata =3D (u32)addr;
+=09} else {
+=09=09err =3D ptrace_hbp_get_ctrl(note_type, tsk, idx, &ctrl);
+=09=09*kdata =3D ctrl;
+=09}
+
+=09return err;
+}
+
+static int compat_ptrace_hbp_set(unsigned int note_type,
+=09=09=09=09 struct task_struct *tsk,
+=09=09=09=09 compat_long_t num,
+=09=09=09=09 u32 *kdata)
+{
+=09u64 addr;
+=09u32 ctrl;
+
+=09int err, idx =3D compat_ptrace_hbp_num_to_idx(num);
+
+=09if (num & 1) {
+=09=09addr =3D *kdata;
+=09=09err =3D ptrace_hbp_set_addr(note_type, tsk, idx, addr);
+=09} else {
+=09=09ctrl =3D *kdata;
+=09=09err =3D ptrace_hbp_set_ctrl(note_type, tsk, idx, ctrl);
+=09}
+
+=09return err;
+}
+
+static int compat_ptrace_gethbpregs(struct task_struct *tsk, compat_long_t=
 num,
+=09=09=09=09    compat_ulong_t __user *data)
+{
+=09int ret;
+=09u32 kdata;
+=09mm_segment_t old_fs =3D get_fs();
+
+=09set_fs(KERNEL_DS);
+=09/* Watchpoint */
+=09if (num < 0) {
+=09=09ret =3D compat_ptrace_hbp_get(NT_ARM_HW_WATCH, tsk, num, &kdata);
+=09/* Resource info */
+=09} else if (num =3D=3D 0) {
+=09=09ret =3D compat_ptrace_hbp_get_resource_info(&kdata);
+=09/* Breakpoint */
+=09} else {
+=09=09ret =3D compat_ptrace_hbp_get(NT_ARM_HW_BREAK, tsk, num, &kdata);
+=09}
+=09set_fs(old_fs);
+
+=09if (!ret)
+=09=09ret =3D put_user(kdata, data);
+
+=09return ret;
+}
+
+static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t=
 num,
+=09=09=09=09    compat_ulong_t __user *data)
+{
+=09int ret;
+=09u32 kdata =3D 0;
+=09mm_segment_t old_fs =3D get_fs();
+
+=09if (num =3D=3D 0)
+=09=09return 0;
+
+=09ret =3D get_user(kdata, data);
+=09if (ret)
+=09=09return ret;
+
+=09set_fs(KERNEL_DS);
+=09if (num < 0)
+=09=09ret =3D compat_ptrace_hbp_set(NT_ARM_HW_WATCH, tsk, num, &kdata);
+=09else
+=09=09ret =3D compat_ptrace_hbp_set(NT_ARM_HW_BREAK, tsk, num, &kdata);
+=09set_fs(old_fs);
+
+=09return ret;
+}
+#endif=09/* CONFIG_HAVE_HW_BREAKPOINT */
+
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+=09=09=09compat_ulong_t caddr, compat_ulong_t cdata)
+{
+=09unsigned long addr =3D caddr;
+=09unsigned long data =3D cdata;
+=09void __user *datap =3D compat_ptr(data);
+=09int ret;
+
+=09switch (request) {
+=09=09case PTRACE_PEEKUSR:
+=09=09=09ret =3D compat_ptrace_read_user(child, addr, datap);
+=09=09=09break;
+
+=09=09case PTRACE_POKEUSR:
+=09=09=09ret =3D compat_ptrace_write_user(child, addr, data);
+=09=09=09break;
+
+=09=09case PTRACE_GETREGS:
+=09=09=09ret =3D copy_regset_to_user(child,
+=09=09=09=09=09=09  &user_aarch32_view,
+=09=09=09=09=09=09  REGSET_COMPAT_GPR,
+=09=09=09=09=09=09  0, sizeof(compat_elf_gregset_t),
+=09=09=09=09=09=09  datap);
+=09=09=09break;
+
+=09=09case PTRACE_SETREGS:
+=09=09=09ret =3D copy_regset_from_user(child,
+=09=09=09=09=09=09    &user_aarch32_view,
+=09=09=09=09=09=09    REGSET_COMPAT_GPR,
+=09=09=09=09=09=09    0, sizeof(compat_elf_gregset_t),
+=09=09=09=09=09=09    datap);
+=09=09=09break;
+
+=09=09case PTRACE_GET_THREAD_AREA:
+=09=09=09ret =3D put_user((compat_ulong_t)child->thread.tp_value,
+=09=09=09=09       (compat_ulong_t __user *)datap);
+=09=09=09break;
+
+=09=09case PTRACE_SET_SYSCALL:
+=09=09=09task_pt_regs(child)->syscallno =3D data;
+=09=09=09ret =3D 0;
+=09=09=09break;
+
+=09=09case COMPAT_PTRACE_GETVFPREGS:
+=09=09=09ret =3D copy_regset_to_user(child,
+=09=09=09=09=09=09  &user_aarch32_view,
+=09=09=09=09=09=09  REGSET_COMPAT_VFP,
+=09=09=09=09=09=09  0, VFP_STATE_SIZE,
+=09=09=09=09=09=09  datap);
+=09=09=09break;
+
+=09=09case COMPAT_PTRACE_SETVFPREGS:
+=09=09=09ret =3D copy_regset_from_user(child,
+=09=09=09=09=09=09    &user_aarch32_view,
+=09=09=09=09=09=09    REGSET_COMPAT_VFP,
+=09=09=09=09=09=09    0, VFP_STATE_SIZE,
+=09=09=09=09=09=09    datap);
+=09=09=09break;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+=09=09case PTRACE_GETHBPREGS:
+=09=09=09ret =3D compat_ptrace_gethbpregs(child, addr, datap);
+=09=09=09break;
+
+=09=09case PTRACE_SETHBPREGS:
+=09=09=09ret =3D compat_ptrace_sethbpregs(child, addr, datap);
+=09=09=09break;
+#endif
+
+=09=09default:
+=09=09=09ret =3D compat_ptrace_request(child, request, addr,
+=09=09=09=09=09=09    data);
+=09=09=09break;
+=09}
+
+=09return ret;
+}
+#endif /* CONFIG_COMPAT */
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *t=
ask)
+{
+#ifdef CONFIG_COMPAT
+=09if (is_compat_thread(task_thread_info(task)))
+=09=09return &user_aarch32_view;
+#endif
+=09return &user_aarch64_view;
+}
+
+long arch_ptrace(struct task_struct *child, long request,
+=09=09 unsigned long addr, unsigned long data)
+{
+=09return ptrace_request(child, request, addr, data);
+}
+
+
+static int __init ptrace_break_init(void)
+{
+=09hook_debug_fault_code(DBG_ESR_EVT_BRK, arm64_break_trap, SIGTRAP,
+=09=09=09      TRAP_BRKPT, "ptrace BRK handler");
+=09return 0;
+}
+core_initcall(ptrace_break_init);
+
+
+asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
+{
+=09unsigned long saved_reg;
+
+=09if (!test_thread_flag(TIF_SYSCALL_TRACE))
+=09=09return regs->syscallno;
+
+=09if (is_compat_task()) {
+=09=09/* AArch32 uses ip (r12) for scratch */
+=09=09saved_reg =3D regs->regs[12];
+=09=09regs->regs[12] =3D dir;
+=09} else {
+=09=09/*
+=09=09 * Save X7. X7 is used to denote syscall entry/exit:
+=09=09 *   X7 =3D 0 -> entry, =3D 1 -> exit
+=09=09 */
+=09=09saved_reg =3D regs->regs[7];
+=09=09regs->regs[7] =3D dir;
+=09}
+
+=09if (dir)
+=09=09tracehook_report_syscall_exit(regs, 0);
+=09else if (tracehook_report_syscall_entry(regs))
+=09=09regs->syscallno =3D ~0UL;
+
+=09if (is_compat_task())
+=09=09regs->regs[12] =3D saved_reg;
+=09else
+=09=09regs->regs[7] =3D saved_reg;
+
+=09return regs->syscallno;
+}
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 999b4f5..1e935e4 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -388,6 +388,9 @@ typedef struct elf64_shdr {
 #define NT_S390_LAST_BREAK=090x306=09/* s390 breaking event address */
 #define NT_S390_SYSTEM_CALL=090x307=09/* s390 system call restart data */
 #define NT_ARM_VFP=090x400=09=09/* ARM VFP/NEON registers */
+#define NT_ARM_TLS=090x401=09=09/* ARM TLS register */
+#define NT_ARM_HW_BREAK=090x402=09=09/* ARM hardware breakpoint registers =
*/
+#define NT_ARM_HW_WATCH=090x403=09=09/* ARM hardware watchpoint registers =
*/
=20
=20
 /* Note header in a PT_NOTE section */

