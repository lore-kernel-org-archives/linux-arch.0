Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55038 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab2HNRxH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:07 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 07/31] arm64: Process management
Date: Tue, 14 Aug 2012 18:52:08 +0100
Message-ID: <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175208.rXnAv3s201cZj-UuPySRabi20_2_8VqUl25IUFaZrw4@z>

The patch adds support for thread creation and context switching. The
context switching CPU specific code is introduced with the CPU support
patch (part of the arch/arm64/mm/proc.S file). AArch64 supports
ASID-tagged TLBs and the ASID can be either 8 or 16-bit wide (detectable
via the ID_AA64AFR0_EL1 register).

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/mmu_context.h |  152 +++++++++++++
 arch/arm64/include/asm/thread_info.h |  124 ++++++++++
 arch/arm64/kernel/process.c          |  416 ++++++++++++++++++++++++++++++=
++++
 arch/arm64/mm/context.c              |  159 +++++++++++++
 4 files changed, 851 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/mmu_context.h
 create mode 100644 arch/arm64/include/asm/thread_info.h
 create mode 100644 arch/arm64/kernel/process.c
 create mode 100644 arch/arm64/mm/context.c

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/=
mmu_context.h
new file mode 100644
index 0000000..f68465d
--- /dev/null
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -0,0 +1,152 @@
+/*
+ * Based on arch/arm/include/asm/mmu_context.h
+ *
+ * Copyright (C) 1996 Russell King.
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
+#ifndef __ASM_MMU_CONTEXT_H
+#define __ASM_MMU_CONTEXT_H
+
+#include <linux/compiler.h>
+#include <linux/sched.h>
+
+#include <asm/cacheflush.h>
+#include <asm/proc-fns.h>
+#include <asm-generic/mm_hooks.h>
+#include <asm/cputype.h>
+#include <asm/pgtable.h>
+
+#define MAX_ASID_BITS=0916
+
+extern unsigned int cpu_last_asid;
+
+void __init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+void __new_context(struct mm_struct *mm);
+
+/*
+ * Set TTBR0 to empty_zero_page. No translations will be possible via TTBR=
0.
+ */
+static inline void cpu_set_reserved_ttbr0(void)
+{
+=09unsigned long ttbr =3D page_to_phys(empty_zero_page);
+
+=09asm(
+=09"=09msr=09ttbr0_el1, %0=09=09=09// set TTBR0\n"
+=09"=09isb"
+=09:
+=09: "r" (ttbr));
+}
+
+static inline void switch_new_context(struct mm_struct *mm)
+{
+=09unsigned long flags;
+
+=09__new_context(mm);
+
+=09local_irq_save(flags);
+=09cpu_switch_mm(mm->pgd, mm);
+=09local_irq_restore(flags);
+}
+
+static inline void check_and_switch_context(struct mm_struct *mm,
+=09=09=09=09=09    struct task_struct *tsk)
+{
+=09/*
+=09 * Required during context switch to avoid speculative page table
+=09 * walking with the wrong TTBR.
+=09 */
+=09cpu_set_reserved_ttbr0();
+
+=09if (!((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS))
+=09=09/*
+=09=09 * The ASID is from the current generation, just switch to the
+=09=09 * new pgd. This condition is only true for calls from
+=09=09 * context_switch() and interrupts are already disabled.
+=09=09 */
+=09=09cpu_switch_mm(mm->pgd, mm);
+=09else if (irqs_disabled())
+=09=09/*
+=09=09 * Defer the new ASID allocation until after the context
+=09=09 * switch critical region since __new_context() cannot be
+=09=09 * called with interrupts disabled.
+=09=09 */
+=09=09set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
+=09else
+=09=09/*
+=09=09 * That is a direct call to switch_mm() or activate_mm() with
+=09=09 * interrupts enabled and a new context.
+=09=09 */
+=09=09switch_new_context(mm);
+}
+
+#define init_new_context(tsk,mm)=09(__init_new_context(tsk,mm),0)
+#define destroy_context(mm)=09=09do { } while(0)
+
+#define finish_arch_post_lock_switch \
+=09finish_arch_post_lock_switch
+static inline void finish_arch_post_lock_switch(void)
+{
+=09if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
+=09=09struct mm_struct *mm =3D current->mm;
+=09=09unsigned long flags;
+
+=09=09__new_context(mm);
+
+=09=09local_irq_save(flags);
+=09=09cpu_switch_mm(mm->pgd, mm);
+=09=09local_irq_restore(flags);
+=09}
+}
+
+/*
+ * This is called when "tsk" is about to enter lazy TLB mode.
+ *
+ * mm:  describes the currently active mm context
+ * tsk: task which is entering lazy tlb
+ * cpu: cpu number which is entering lazy tlb
+ *
+ * tsk->mm will be NULL
+ */
+static inline void
+enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+}
+
+/*
+ * This is the actual mm switch as far as the scheduler
+ * is concerned.  No registers are touched.  We avoid
+ * calling the CPU specific function when the mm hasn't
+ * actually changed.
+ */
+static inline void
+switch_mm(struct mm_struct *prev, struct mm_struct *next,
+=09  struct task_struct *tsk)
+{
+=09unsigned int cpu =3D smp_processor_id();
+
+#ifdef CONFIG_SMP
+=09/* check for possible thread migration */
+=09if (!cpumask_empty(mm_cpumask(next)) &&
+=09    !cpumask_test_cpu(cpu, mm_cpumask(next)))
+=09=09__flush_icache_all();
+#endif
+=09if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev !=3D next)
+=09=09check_and_switch_context(next, tsk);
+}
+
+#define deactivate_mm(tsk,mm)=09do { } while (0)
+#define activate_mm(prev,next)=09switch_mm(prev, next, NULL)
+
+#endif
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/=
thread_info.h
new file mode 100644
index 0000000..4f909a3
--- /dev/null
+++ b/arch/arm64/include/asm/thread_info.h
@@ -0,0 +1,124 @@
+/*
+ * Based on arch/arm/include/asm/thread_info.h
+ *
+ * Copyright (C) 2002 Russell King.
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
+#ifndef __ASM_THREAD_INFO_H
+#define __ASM_THREAD_INFO_H
+
+#ifdef __KERNEL__
+
+#include <linux/compiler.h>
+
+#define THREAD_SIZE_ORDER=091
+#define THREAD_SIZE=09=098192
+#define THREAD_START_SP=09=09(THREAD_SIZE - 16)
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+struct exec_domain;
+
+#include <asm/types.h>
+
+typedef unsigned long mm_segment_t;
+
+/*
+ * low level task data that entry.S needs immediate access to.
+ * __switch_to() assumes cpu_context follows immediately after cpu_domain.
+ */
+struct thread_info {
+=09unsigned long=09=09flags;=09=09/* low level flags */
+=09mm_segment_t=09=09addr_limit;=09/* address limit */
+=09struct task_struct=09*task;=09=09/* main task structure */
+=09struct exec_domain=09*exec_domain;=09/* execution domain */
+=09struct restart_block=09restart_block;
+=09int=09=09=09preempt_count;=09/* 0 =3D> preemptable, <0 =3D> bug */
+=09int=09=09=09cpu;=09=09/* cpu */
+};
+
+#define INIT_THREAD_INFO(tsk)=09=09=09=09=09=09\
+{=09=09=09=09=09=09=09=09=09\
+=09.task=09=09=3D &tsk,=09=09=09=09=09=09\
+=09.exec_domain=09=3D &default_exec_domain,=09=09=09=09\
+=09.flags=09=09=3D 0,=09=09=09=09=09=09\
+=09.preempt_count=09=3D INIT_PREEMPT_COUNT,=09=09=09=09\
+=09.addr_limit=09=3D KERNEL_DS,=09=09=09=09=09\
+=09.restart_block=09=3D {=09=09=09=09=09=09\
+=09=09.fn=09=3D do_no_restart_syscall,=09=09=09\
+=09},=09=09=09=09=09=09=09=09\
+}
+
+#define init_thread_info=09(init_thread_union.thread_info)
+#define init_stack=09=09(init_thread_union.stack)
+
+/*
+ * how to get the thread information struct from C
+ */
+static inline struct thread_info *current_thread_info(void) __attribute_co=
nst__;
+
+static inline struct thread_info *current_thread_info(void)
+{
+=09register unsigned long sp asm ("sp");
+=09return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
+}
+
+#define thread_saved_pc(tsk)=09\
+=09((unsigned long)(tsk->thread.cpu_context.pc))
+#define thread_saved_sp(tsk)=09\
+=09((unsigned long)(tsk->thread.cpu_context.sp))
+#define thread_saved_fp(tsk)=09\
+=09((unsigned long)(tsk->thread.cpu_context.fp))
+
+#endif
+
+/*
+ * We use bit 30 of the preempt_count to indicate that kernel
+ * preemption is occurring.  See <asm/hardirq.h>.
+ */
+#define PREEMPT_ACTIVE=090x40000000
+
+/*
+ * thread information flags:
+ *  TIF_SYSCALL_TRACE=09- syscall trace active
+ *  TIF_SIGPENDING=09- signal pending
+ *  TIF_NEED_RESCHED=09- rescheduling necessary
+ *  TIF_NOTIFY_RESUME=09- callback before returning to user
+ *  TIF_USEDFPU=09=09- FPU was used by this task this quantum (SMP)
+ *  TIF_POLLING_NRFLAG=09- true if poll_idle() is polling TIF_NEED_RESCHED
+ */
+#define TIF_SIGPENDING=09=090
+#define TIF_NEED_RESCHED=091
+#define TIF_NOTIFY_RESUME=092=09/* callback before returning to user */
+#define TIF_SYSCALL_TRACE=098
+#define TIF_POLLING_NRFLAG=0916
+#define TIF_MEMDIE=09=0918=09/* is terminating due to OOM killer */
+#define TIF_FREEZE=09=0919
+#define TIF_RESTORE_SIGMASK=0920
+#define TIF_SINGLESTEP=09=0921
+#define TIF_32BIT=09=0922=09/* 32bit process */
+#define TIF_SWITCH_MM=09=0923=09/* deferred switch_mm */
+
+#define _TIF_SIGPENDING=09=09(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED=09(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_RESUME=09(1 << TIF_NOTIFY_RESUME)
+#define _TIF_32BIT=09=09(1 << TIF_32BIT)
+
+#define _TIF_WORK_MASK=09=09(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
+=09=09=09=09 _TIF_NOTIFY_RESUME)
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
new file mode 100644
index 0000000..c4a4e1c
--- /dev/null
+++ b/arch/arm64/kernel/process.c
@@ -0,0 +1,416 @@
+/*
+ * Based on arch/arm/kernel/process.c
+ *
+ * Original Copyright (C) 1995  Linus Torvalds
+ * Copyright (C) 1996-2000 Russell King - Converted to ARM.
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
+#include <stdarg.h>
+
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/user.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/interrupt.h>
+#include <linux/kallsyms.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/elfcore.h>
+#include <linux/pm.h>
+#include <linux/tick.h>
+#include <linux/utsname.h>
+#include <linux/uaccess.h>
+#include <linux/random.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/personality.h>
+#include <linux/notifier.h>
+
+#include <asm/cacheflush.h>
+#include <asm/processor.h>
+#include <asm/stacktrace.h>
+#include <asm/fpsimd.h>
+
+extern void setup_mm_for_reboot(void);
+
+static void setup_restart(void)
+{
+=09/*
+=09 * Tell the mm system that we are going to reboot -
+=09 * we may need it to insert some 1:1 mappings so that
+=09 * soft boot works.
+=09 */
+=09setup_mm_for_reboot();
+
+=09/* Clean and invalidate caches */
+=09flush_cache_all();
+
+=09/* Turn off caching */
+=09cpu_proc_fin();
+
+=09/* Push out any further dirty data, and ensure cache is empty */
+=09flush_cache_all();
+}
+
+void soft_restart(unsigned long addr)
+{
+=09setup_restart();
+=09cpu_reset(addr);
+}
+
+/*
+ * Function pointers to optional machine specific functions
+ */
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
+void (*pm_restart)(const char *cmd);
+EXPORT_SYMBOL_GPL(pm_restart);
+
+
+/*
+ * This is our default idle handler.
+ */
+static void default_idle(void)
+{
+=09/*
+=09 * This should do all the clock switching and wait for interrupt
+=09 * tricks
+=09 */
+=09cpu_do_idle();
+=09local_irq_enable();
+}
+
+void (*pm_idle)(void) =3D default_idle;
+EXPORT_SYMBOL(pm_idle);
+
+/*
+ * The idle thread, has rather strange semantics for calling pm_idle,
+ * but this is what x86 does and we need to do the same, so that
+ * things like cpuidle get called in the same way.  The only difference
+ * is that we always respect 'hlt_counter' to prevent low power idle.
+ */
+void cpu_idle(void)
+{
+=09local_fiq_enable();
+
+=09/* endless idle loop with no priority at all */
+=09while (1) {
+=09=09tick_nohz_idle_enter();
+=09=09rcu_idle_enter();
+=09=09while (!need_resched()) {
+=09=09=09/*
+=09=09=09 * We need to disable interrupts here to ensure
+=09=09=09 * we don't miss a wakeup call.
+=09=09=09 */
+=09=09=09local_irq_disable();
+=09=09=09if (!need_resched()) {
+=09=09=09=09stop_critical_timings();
+=09=09=09=09pm_idle();
+=09=09=09=09start_critical_timings();
+=09=09=09=09/*
+=09=09=09=09 * pm_idle functions should always return
+=09=09=09=09 * with IRQs enabled.
+=09=09=09=09 */
+=09=09=09=09WARN_ON(irqs_disabled());
+=09=09=09} else {
+=09=09=09=09local_irq_enable();
+=09=09=09}
+=09=09}
+=09=09rcu_idle_exit();
+=09=09tick_nohz_idle_exit();
+=09=09preempt_enable_no_resched();
+=09=09schedule();
+=09=09preempt_disable();
+=09}
+}
+
+void machine_shutdown(void)
+{
+#ifdef CONFIG_SMP
+=09smp_send_stop();
+#endif
+}
+
+void machine_halt(void)
+{
+=09machine_shutdown();
+=09while (1);
+}
+
+void machine_power_off(void)
+{
+=09machine_shutdown();
+=09if (pm_power_off)
+=09=09pm_power_off();
+}
+
+void machine_restart(char *cmd)
+{
+=09machine_shutdown();
+
+=09/* Disable interrupts first */
+=09local_irq_disable();
+=09local_fiq_disable();
+
+=09/* Now call the architecture specific reboot code. */
+=09if (pm_restart)
+=09=09pm_restart(cmd);
+
+=09/*
+=09 * Whoops - the architecture was unable to reboot.
+=09 * Tell the user!
+=09 */
+=09mdelay(1000);
+=09printk("Reboot failed -- System halted\n");
+=09while (1);
+}
+
+void __show_regs(struct pt_regs *regs)
+{
+=09int i;
+
+=09printk("CPU: %d    %s  (%s %.*s)\n",
+=09=09raw_smp_processor_id(), print_tainted(),
+=09=09init_utsname()->release,
+=09=09(int)strcspn(init_utsname()->version, " "),
+=09=09init_utsname()->version);
+=09print_symbol("PC is at %s\n", instruction_pointer(regs));
+=09print_symbol("LR is at %s\n", regs->regs[30]);
+=09printk("pc : [<%016llx>] lr : [<%016llx>] pstate: %08llx\n",
+=09       regs->pc, regs->regs[30], regs->pstate);
+=09printk("sp : %016llx\n", regs->sp);
+=09for (i =3D 29; i >=3D 0; i--) {
+=09=09printk("x%-2d: %016llx ", i, regs->regs[i]);
+=09=09if (i % 2 =3D=3D 0)
+=09=09=09printk("\n");
+=09}
+=09printk("\n");
+}
+
+void show_regs(struct pt_regs * regs)
+{
+=09printk("\n");
+=09printk("Pid: %d, comm: %20s\n", task_pid_nr(current), current->comm);
+=09__show_regs(regs);
+}
+
+/*
+ * Free current thread data structures etc..
+ */
+void exit_thread(void)
+{
+}
+
+void flush_thread(void)
+{
+=09fpsimd_flush_thread();
+=09flush_ptrace_hw_breakpoint(current);
+}
+
+void release_thread(struct task_struct *dead_task)
+{
+}
+
+int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
+{
+=09fpsimd_save_state(&current->thread.fpsimd_state);
+=09*dst =3D *src;
+=09return 0;
+}
+
+asmlinkage void ret_from_fork(void) asm("ret_from_fork");
+
+int copy_thread(unsigned long clone_flags, unsigned long stack_start,
+=09=09unsigned long stk_sz, struct task_struct *p,
+=09=09struct pt_regs *regs)
+{
+=09struct pt_regs *childregs =3D task_pt_regs(p);
+=09unsigned long tls =3D p->thread.tp_value;
+
+=09*childregs =3D *regs;
+=09childregs->regs[0] =3D 0;
+
+#ifdef CONFIG_AARCH32_EMULATION
+=09if (test_ti_thread_flag(task_thread_info(p), TIF_32BIT))
+=09=09childregs->compat_sp =3D stack_start;
+=09else
+#endif
+=09{
+=09=09/*
+=09=09 * Read the current TLS pointer from tpidr_el0 as it may be
+=09=09 * out-of-sync with the saved value.
+=09=09 */
+=09=09asm("mrs %0, tpidr_el0" : "=3Dr" (tls));
+=09=09childregs->sp =3D stack_start;
+=09}
+
+=09memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
+=09p->thread.cpu_context.sp =3D (unsigned long)childregs;
+=09p->thread.cpu_context.pc =3D (unsigned long)ret_from_fork;
+
+=09/* If a TLS pointer was passed to clone, use that for the new thread. *=
/
+=09if (clone_flags & CLONE_SETTLS)
+=09=09tls =3D regs->regs[3];
+=09p->thread.tp_value =3D tls;
+
+=09ptrace_hw_copy_thread(p);
+
+=09return 0;
+}
+
+static void tls_thread_switch(struct task_struct *next)
+{
+=09unsigned long tpidr, tpidrro;
+
+=09if (!test_thread_flag(TIF_32BIT)) {
+=09=09asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
+=09=09current->thread.tp_value =3D tpidr;
+=09}
+
+=09if (test_ti_thread_flag(task_thread_info(next), TIF_32BIT)) {
+=09=09tpidr =3D 0;
+=09=09tpidrro =3D next->thread.tp_value;
+=09} else {
+=09=09tpidr =3D next->thread.tp_value;
+=09=09tpidrro =3D 0;
+=09}
+
+=09asm(
+=09"=09msr=09tpidr_el0, %0\n"
+=09"=09msr=09tpidrro_el0, %1"
+=09: : "r" (tpidr), "r" (tpidrro));
+}
+
+/*
+ * Thread switching.
+ */
+struct task_struct *__switch_to(struct task_struct *prev,
+=09=09=09=09struct task_struct *next)
+{
+=09struct task_struct *last;
+
+=09fpsimd_thread_switch(next);
+=09tls_thread_switch(next);
+=09hw_breakpoint_thread_switch(next);
+
+=09/* the actual thread switch */
+=09last =3D cpu_switch_to(prev, next);
+
+=09return last;
+}
+
+/*
+ * Fill in the task's elfregs structure for a core dump.
+ */
+int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs)
+{
+=09elf_core_copy_regs(elfregs, task_pt_regs(t));
+=09return 1;
+}
+
+/*
+ * fill in the fpe structure for a core dump...
+ */
+int dump_fpu (struct pt_regs *regs, struct user_fp *fp)
+{
+=09return 0;
+}
+EXPORT_SYMBOL(dump_fpu);
+
+/*
+ * Shuffle the argument into the correct register before calling the
+ * thread function.  x1 is the thread argument, x2 is the pointer to
+ * the thread function, and x3 points to the exit function.
+ */
+extern void kernel_thread_helper(void);
+asm(=09".section .text\n"
+"=09.align\n"
+"=09.type=09kernel_thread_helper, #function\n"
+"kernel_thread_helper:\n"
+"=09mov=09x0, x1\n"
+"=09mov=09x30, x3\n"
+"=09br=09x2\n"
+"=09.size=09kernel_thread_helper, . - kernel_thread_helper\n"
+"=09.previous");
+
+#define kernel_thread_exit=09do_exit
+
+/*
+ * Create a kernel thread.
+ */
+pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+{
+=09struct pt_regs regs;
+
+=09memset(&regs, 0, sizeof(regs));
+
+=09regs.regs[1] =3D (unsigned long)arg;
+=09regs.regs[2] =3D (unsigned long)fn;
+=09regs.regs[3] =3D (unsigned long)kernel_thread_exit;
+=09regs.pc =3D (unsigned long)kernel_thread_helper;
+=09regs.pstate =3D PSR_MODE_EL1h;
+
+=09return do_fork(flags|CLONE_VM|CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+}
+EXPORT_SYMBOL(kernel_thread);
+
+unsigned long get_wchan(struct task_struct *p)
+{
+=09struct stackframe frame;
+=09int count =3D 0;
+=09if (!p || p =3D=3D current || p->state =3D=3D TASK_RUNNING)
+=09=09return 0;
+
+=09frame.fp =3D thread_saved_fp(p);
+=09frame.sp =3D thread_saved_sp(p);
+=09frame.pc =3D thread_saved_pc(p);
+=09do {
+=09=09int ret =3D unwind_frame(&frame);
+=09=09if (ret < 0)
+=09=09=09return 0;
+=09=09if (!in_sched_functions(frame.pc))
+=09=09=09return frame.pc;
+=09} while (count ++ < 16);
+=09return 0;
+}
+
+unsigned long arch_align_stack(unsigned long sp)
+{
+=09if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+=09=09sp -=3D get_random_int() & ~PAGE_MASK;
+=09return sp & ~0xf;
+}
+
+static unsigned long randomize_base(unsigned long base)
+{
+=09unsigned long range_end =3D base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
+=09return randomize_range(base, range_end, 0) ? : base;
+}
+
+unsigned long arch_randomize_brk(struct mm_struct *mm)
+{
+=09return randomize_base(mm->brk);
+}
+
+unsigned long randomize_et_dyn(unsigned long base)
+{
+=09return randomize_base(base);
+}
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
new file mode 100644
index 0000000..e06f47a
--- /dev/null
+++ b/arch/arm64/mm/context.c
@@ -0,0 +1,159 @@
+/*
+ * Based on arch/arm/mm/context.c
+ *
+ * Copyright (C) 2002-2003 Deep Blue Solutions Ltd, all rights reserved.
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
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/percpu.h>
+
+#include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
+#include <asm/cachetype.h>
+
+#define asid_bits(reg) \
+=09(((read_cpuid(ID_AA64MMFR0_EL1) & 0xf0) >> 2) + 8)
+
+#define ASID_FIRST_VERSION=09(1 << MAX_ASID_BITS)
+
+static DEFINE_SPINLOCK(cpu_asid_lock);
+unsigned int cpu_last_asid =3D ASID_FIRST_VERSION;
+
+/*
+ * We fork()ed a process, and we need a new context for the child to run i=
n.
+ */
+void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+=09mm->context.id =3D 0;
+=09spin_lock_init(&mm->context.id_lock);
+}
+
+static void flush_context(void)
+{
+=09/* set the reserved TTBR0 before flushing the TLB */
+=09cpu_set_reserved_ttbr0();
+=09flush_tlb_all();
+=09if (icache_is_aivivt())
+=09=09__flush_icache_all();
+}
+
+#ifdef CONFIG_SMP
+
+static void set_mm_context(struct mm_struct *mm, unsigned int asid)
+{
+=09unsigned long flags;
+
+=09/*
+=09 * Locking needed for multi-threaded applications where the same
+=09 * mm->context.id could be set from different CPUs during the
+=09 * broadcast. This function is also called via IPI so the
+=09 * mm->context.id_lock has to be IRQ-safe.
+=09 */
+=09spin_lock_irqsave(&mm->context.id_lock, flags);
+=09if (likely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS)) {
+=09=09/*
+=09=09 * Old version of ASID found. Set the new one and reset
+=09=09 * mm_cpumask(mm).
+=09=09 */
+=09=09mm->context.id =3D asid;
+=09=09cpumask_clear(mm_cpumask(mm));
+=09}
+=09spin_unlock_irqrestore(&mm->context.id_lock, flags);
+
+=09/*
+=09 * Set the mm_cpumask(mm) bit for the current CPU.
+=09 */
+=09cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+}
+
+/*
+ * Reset the ASID on the current CPU. This function call is broadcast from=
 the
+ * CPU handling the ASID rollover and holding cpu_asid_lock.
+ */
+static void reset_context(void *info)
+{
+=09unsigned int asid;
+=09unsigned int cpu =3D smp_processor_id();
+=09struct mm_struct *mm =3D current->active_mm;
+
+=09smp_rmb();
+=09asid =3D cpu_last_asid + cpu;
+
+=09flush_context();
+=09set_mm_context(mm, asid);
+
+=09/* set the new ASID */
+=09cpu_switch_mm(mm->pgd, mm);
+}
+
+#else
+
+static inline void set_mm_context(struct mm_struct *mm, unsigned int asid)
+{
+=09mm->context.id =3D asid;
+=09cpumask_copy(mm_cpumask(mm), cpumask_of(smp_processor_id()));
+}
+
+#endif
+
+void __new_context(struct mm_struct *mm)
+{
+=09unsigned int asid;
+=09unsigned int bits =3D asid_bits();
+
+=09spin_lock(&cpu_asid_lock);
+#ifdef CONFIG_SMP
+=09/*
+=09 * Check the ASID again, in case the change was broadcast from another
+=09 * CPU before we acquired the lock.
+=09 */
+=09if (!unlikely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS)) {
+=09=09cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+=09=09spin_unlock(&cpu_asid_lock);
+=09=09return;
+=09}
+#endif
+=09/*
+=09 * At this point, it is guaranteed that the current mm (with an old
+=09 * ASID) isn't active on any other CPU since the ASIDs are changed
+=09 * simultaneously via IPI.
+=09 */
+=09asid =3D ++cpu_last_asid;
+
+=09/*
+=09 * If we've used up all our ASIDs, we need to start a new version and
+=09 * flush the TLB.
+=09 */
+=09if (unlikely((asid & ((1 << bits) - 1)) =3D=3D 0)) {
+=09=09/* increment the ASID version */
+=09=09cpu_last_asid +=3D (1 << MAX_ASID_BITS) - (1 << bits);
+=09=09if (cpu_last_asid =3D=3D 0)
+=09=09=09cpu_last_asid =3D ASID_FIRST_VERSION;
+=09=09asid =3D cpu_last_asid + smp_processor_id();
+=09=09flush_context();
+#ifdef CONFIG_SMP
+=09=09smp_wmb();
+=09=09smp_call_function(reset_context, NULL, 1);
+#endif
+=09=09cpu_last_asid +=3D NR_CPUS - 1;
+=09}
+
+=09set_mm_context(mm, asid);
+=09spin_unlock(&cpu_asid_lock);
+}

