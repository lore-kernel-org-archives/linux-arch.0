From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 05/19] csky: Process management
Date: Mon, 19 Mar 2018 03:51:27 +0800
Message-ID: <a5f4764c8843b2c11d68f282d07564a694b577f4.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/mmu_context.h | 140 ++++++++++++++++++++++++++++++++++
 arch/csky/include/asm/processor.h   | 140 ++++++++++++++++++++++++++++++++++
 arch/csky/include/asm/thread_info.h |  77 +++++++++++++++++++
 arch/csky/kernel/process.c          | 147 ++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/time.c             |  15 ++++
 5 files changed, 519 insertions(+)
 create mode 100644 arch/csky/include/asm/mmu_context.h
 create mode 100644 arch/csky/include/asm/processor.h
 create mode 100644 arch/csky/include/asm/thread_info.h
 create mode 100644 arch/csky/kernel/process.c
 create mode 100644 arch/csky/kernel/time.c

diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
new file mode 100644
index 0000000..6eeea85
--- /dev/null
+++ b/arch/csky/include/asm/mmu_context.h
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_MMU_CONTEXT_H
+#define __ASM_CSKY_MMU_CONTEXT_H
+
+#include <asm-generic/mm_hooks.h>
+#include <asm/setup.h>
+#include <asm/page.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <abi/ckmmu.h>
+
+/*
+ * For the fast tlb miss handlers, we currently keep a per cpu array
+ * of pointers to the current pgd for each processor. Also, the proc.
+ * id is stuffed into the context register. This should be changed to
+ * use the processor id via current->processor, where current is stored
+ * in watch hi/lo. The context register should be used to contiguously
+ * map the page tables.
+ */
+#define TLBMISS_HANDLER_SETUP_PGD(pgd) tlbmiss_handler_setup_pgd((unsigned long)pgd)
+
+#define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
+#define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
+#define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
+
+#define ASID_INC		0x1
+#define ASID_MASK		0xff
+#define ASID_VERSION_MASK	0xffffff00
+#define ASID_FIRST_VERSION	0x100
+
+#define destroy_context(mm)		do{}while(0)
+#define enter_lazy_tlb(mm,tsk)		do{}while(0)
+#define deactivate_mm(tsk,mm)		do{}while(0)
+
+/*
+ *  All unused by hardware upper bits will be considered
+ *  as a software asid extension.
+ */
+static inline void
+get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
+{
+	unsigned long asid = asid_cache(cpu);
+
+	if (! ((asid += ASID_INC) & ASID_MASK) ) {
+		flush_tlb_all();	/* start new asid cycle */
+		if (!asid)		/* fix version if needed */
+			asid = ASID_FIRST_VERSION;
+	}
+	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
+}
+
+/*
+ * Initialize the context related info for a new mm_struct
+ * instance.
+ */
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	int i;
+
+	for_each_online_cpu(i)
+		cpu_context(i, mm) = 0;
+	return 0;
+}
+
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+                             struct task_struct *tsk)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/* Check if our ASID is of an older version and thus invalid */
+	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
+		get_new_mmu_context(next, cpu);
+	write_mmu_entryhi(cpu_context(cpu, next));
+	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+
+	/*
+	 * Mark current->active_mm as not "active" anymore.
+	 * We don't want to mislead possible IPI tlb flush routines.
+	 */
+	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
+	local_irq_restore(flags);
+}
+
+/*
+ * After we have set current->mm to a new value, this activates
+ * the context for the new mm so we see the new mappings.
+ */
+static inline void
+activate_mm(struct mm_struct *prev, struct mm_struct *next)
+{
+	unsigned long flags;
+	int cpu = smp_processor_id();
+
+	local_irq_save(flags);
+
+	/* Unconditionally get a new ASID.  */
+	get_new_mmu_context(next, cpu);
+
+	write_mmu_entryhi(cpu_context(cpu, next));
+	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+
+	/* mark mmu ownership change */
+	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
+	local_irq_restore(flags);
+}
+
+/*
+ * If mm is currently active_mm, we can't really drop it. Instead,
+ * we will get a new one for it.
+ */
+static inline void
+drop_mmu_context(struct mm_struct *mm, unsigned cpu)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
+		get_new_mmu_context(mm, cpu);
+		write_mmu_entryhi(cpu_asid(cpu, mm));
+	} else {
+		/* will get a new context next time */
+		cpu_context(cpu, mm) = 0;
+	}
+
+	local_irq_restore(flags);
+}
+
+#endif /* __ASM_CSKY_MMU_CONTEXT_H */
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
new file mode 100644
index 0000000..adebea7
--- /dev/null
+++ b/arch/csky/include/asm/processor.h
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_PROCESSOR_H
+#define __ASM_CSKY_PROCESSOR_H
+
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr() ({ __label__ _l; _l: &&_l;})
+
+#include <linux/bitops.h>
+#include <asm/segment.h>
+#include <asm/ptrace.h>
+#include <asm/current.h>
+#include <asm/cache.h>
+#include <abi/regdef.h>
+#include <abi/reg_ops.h>
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+#endif
+
+struct cpuinfo_csky {
+	unsigned long udelay_val;
+	unsigned long asid_cache;
+	/*
+	 * Capability and feature descriptor structure for CSKY CPU
+	 */
+	unsigned long options;
+	unsigned int processor_id[4];
+	unsigned int fpu_id;
+} __attribute__((aligned(SMP_CACHE_BYTES)));
+
+extern struct cpuinfo_csky cpu_data[];
+
+/*
+ * User space process size: 2GB. This is hardcoded into a few places,
+ * so don't change it unless you know what you are doing.  TASK_SIZE
+ * for a 64 bit kernel expandable to 8192EB, of which the current CSKY
+ * implementations will "only" be able to use 1TB ...
+ */
+#define TASK_SIZE       0x7fff8000UL
+
+#ifdef __KERNEL__
+#define STACK_TOP       TASK_SIZE
+#define STACK_TOP_MAX   STACK_TOP
+#endif
+
+/* This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define TASK_UNMAPPED_BASE      (TASK_SIZE / 3)
+
+struct thread_struct {
+	unsigned long  ksp;       /* kernel stack pointer */
+	unsigned long  usp;       /* user stack pointer */
+	unsigned long  sr;        /* saved status register */
+	unsigned long  esp0;      /* points to SR of stack frame */
+	/* FPU regs */
+	unsigned long  fcr;       /* fpu control reg */
+	unsigned long  fsr;       /* fpu status reg, nothing in CPU_CSKYV2 */
+	unsigned long  fesr;      /* fpu exception status reg */
+	unsigned long  fp[32];    /* fpu general regs.
+ 				      In CPU_CSKYV1(FPU): 32 regs of 32 bits
+ 				        fp[0] store fr0,
+				        fp[1] store fr1...
+ 				      In CPU_CSKYV2(VFP): 16 regs of 64 bits
+				        fp[0] store vr0 low 32 bits,
+				        fp[1] store vr0 high 32 bits... */
+
+	unsigned long  hi;
+	unsigned long  lo;
+	unsigned long  dspcsr;
+
+	/* Other stuff associated with the thread. */
+	unsigned long address;      /* Last user fault */
+	unsigned long error_code;
+	unsigned long trap_no;
+};
+
+#define INIT_THREAD  { \
+	.ksp = (unsigned long) init_thread_union.stack + THREAD_SIZE, \
+	.sr = DEFAULT_PSR_VALUE, \
+}
+
+/*
+ * Do necessary setup to start up a newly executed thread.
+ *
+ * pass the data segment into user programs if it exists,
+ * it can't hurt anything as far as I can tell
+ */
+#define start_thread(_regs, _pc, _usp)					\
+do {									\
+	set_fs(USER_DS); /* reads from user space */			\
+	(_regs)->pc = (_pc);						\
+	(_regs)->regs[1] = 0; /* ABIV1 is R7, uClibc_main rtdl arg */	\
+	(_regs)->regs[2] = 0;						\
+	(_regs)->regs[3] = 0; /* ABIV2 is R7, use it? */		\
+	(_regs)->sr &= ~PS_S;						\
+	wrusp(_usp);							\
+} while(0)
+
+/* Forward declaration, a strange C thing */
+struct task_struct;
+
+/* Free all resources held by a thread. */
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+/* Prepare to copy thread state - unlazy all lazy status */
+#define prepare_to_copy(tsk)    do { } while (0)
+
+extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
+
+#define copy_segments(tsk, mm)		do { } while (0)
+#define release_segments(mm)		do { } while (0)
+#define forget_segments()		do { } while (0)
+
+extern unsigned long thread_saved_pc(struct task_struct *tsk);
+
+unsigned long get_wchan(struct task_struct *p);
+
+#define	KSTK_EIP(tsk)							\
+({									\
+	unsigned long eip = 0;						\
+	if ((tsk)->thread.esp0 > PAGE_SIZE &&				\
+	     MAP_NR((tsk)->thread.esp0) < max_mapnr)			\
+		eip = ((struct pt_regs *) (tsk)->thread.esp0)->pc;	\
+		eip;							\
+})
+
+#define	KSTK_ESP(tsk) ((tsk) == current ? rdusp() : (tsk)->thread.usp)
+
+#define task_pt_regs(p) \
+	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
+
+#define cpu_relax() barrier()
+
+#endif /* __ASM_CSKY_PROCESSOR_H */
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
new file mode 100644
index 0000000..af05d37
--- /dev/null
+++ b/arch/csky/include/asm/thread_info.h
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef _ASM_CSKY_THREAD_INFO_H
+#define _ASM_CSKY_THREAD_INFO_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/types.h>
+#include <asm/page.h>
+#include <abi/regdef.h>
+#include <asm/processor.h>
+
+struct thread_info {
+	struct task_struct	*task;
+	void			*dump_exec_domain;
+	unsigned long		flags;
+	int			preempt_count;
+	unsigned long		tp_value;
+	mm_segment_t		addr_limit;
+	struct restart_block	restart_block;
+	struct pt_regs		*regs;
+};
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.task		= &tsk,			\
+	.preempt_count  = INIT_PREEMPT_COUNT,	\
+	.addr_limit     = KERNEL_DS,		\
+	.restart_block = {			\
+		.fn = do_no_restart_syscall,	\
+	},					\
+}
+
+#define THREAD_SIZE_ORDER (13 - PAGE_SHIFT)
+
+#ifdef COMPAT_KERNEL_4_9
+#define init_thread_info	(init_thread_union.thread_info)
+#define init_stack		(init_thread_union.stack)
+#endif
+
+static inline struct thread_info *current_thread_info(void)
+{
+	unsigned long sp;
+
+	asm volatile("mov %0, sp\n":"=r"(sp));
+
+	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
+}
+
+#endif /* !__ASSEMBLY__ */
+
+/* entry.S relies on these definitions!
+ * bits 0-5 are tested at every exception exit
+ */
+#define TIF_SIGPENDING		0	/* signal pending */
+#define TIF_NOTIFY_RESUME	1       /* callback before returning to user */
+#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
+#define TIF_SYSCALL_TRACE	5	/* syscall trace active */
+#define TIF_DELAYED_TRACE	14	/* single step a syscall */
+#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		18      /* is terminating due to OOM killer */
+#define TIF_FREEZE		19	/* thread is freezing for suspend */
+#define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
+#define TIF_SECCOMP		21	/* secure computing */
+
+#define _TIF_SIGPENDING         (1 << TIF_SIGPENDING)
+#define _TIF_NOTIFY_RESUME      (1 << TIF_NOTIFY_RESUME)
+#define _TIF_NEED_RESCHED       (1 << TIF_NEED_RESCHED)
+#define _TIF_SYSCALL_TRACE      (1 << TIF_SYSCALL_TRACE)
+#define _TIF_DELAYED_TRACE	(1 << TIF_DELAYED_TRACE)
+#define _TIF_POLLING_NRFLAG     (1 << TIF_POLLING_NRFLAG)
+#define _TIF_MEMDIE		(1 << TIF_MEMDIE)
+#define _TIF_FREEZE             (1 << TIF_FREEZE)
+#define _TIF_RESTORE_SIGMASK    (1 << TIF_RESTORE_SIGMASK)
+#define _TIF_SECCOMP            (1 << TIF_SECCOMP)
+
+#endif	/* _ASM_CSKY_THREAD_INFO_H */
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
new file mode 100644
index 0000000..a7464a4
--- /dev/null
+++ b/arch/csky/kernel/process.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/sched.h>
+#ifndef COMPAT_KERNEL_4_9
+#include <linux/sched/task_stack.h>
+#include <linux/sched/debug.h>
+#endif
+#include <linux/delay.h>
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
+#include <asm/elf.h>
+#include <linux/ptrace.h>
+
+struct cpuinfo_csky cpu_data[NR_CPUS];
+
+asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_kernel_thread(void);
+
+/*
+ * Some archs flush debug and FPU info here
+ */
+void flush_thread(void){}
+
+/*
+ * Return saved PC from a blocked thread
+ */
+unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
+
+	return sw->r15;
+}
+
+int copy_thread(unsigned long clone_flags,
+		unsigned long usp,
+		unsigned long kthread_arg,
+		struct task_struct *p)
+{
+	struct switch_stack * childstack;
+	unsigned long reg_psr = 0;
+	struct pt_regs *childregs = task_pt_regs(p);
+
+	preempt_disable();
+
+	asm volatile("mfcr %0, psr\n":"=r"(reg_psr));
+
+#ifdef CONFIG_CPU_HAS_FPU
+	save_fp_to_thread(p->thread.fp, &p->thread.fcr, &p->thread.fsr,
+	     &p->thread.fesr);
+#endif
+#ifdef CONFIG_CPU_HAS_HILO
+	asm volatile(
+		"mfhi	%0 \n"
+		"mflo	%1 \n"
+		:"=r"(p->thread.hi),"=r"(p->thread.lo));
+#endif
+	preempt_enable();
+
+	childstack = ((struct switch_stack *) childregs) - 1;
+	memset(childstack, 0, sizeof(struct switch_stack));
+
+	/* setup ksp for switch_to !!! */
+	p->thread.ksp = (unsigned long)childstack;
+
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		memset(childregs, 0, sizeof(struct pt_regs));
+		childstack->r15 = (unsigned long) ret_from_kernel_thread;
+		childstack->r8 = kthread_arg;
+		childstack->r9 = usp;
+		childregs->sr = reg_psr;
+
+		return 0;
+	} else {
+		*childregs = *(current_pt_regs());
+		childstack->r15 = (unsigned long) ret_from_fork;
+	}
+
+	/* Return 0 for subprocess when return from fork(),vfork(),clone() */
+	childregs->a0 = 0;
+
+	if (usp != 0)
+		p->thread.usp = usp;
+	else
+		p->thread.usp = rdusp();
+
+	if (clone_flags & CLONE_SETTLS) {
+		task_thread_info(p)->tp_value = (current_pt_regs())->regs[0];
+#ifdef __CSKYABIV2__
+		childregs->exregs[15] = task_thread_info(p)->tp_value;
+#endif
+	}
+
+	return 0;
+}
+
+/* Fill in the fpu structure for a core dump.  */
+int dump_fpu (struct pt_regs *regs, struct user_cskyfp_struct *fpu)
+{
+	memcpy(fpu, &current->thread.fcr, sizeof(*fpu));
+	return 1;
+}
+EXPORT_SYMBOL(dump_fpu);
+
+int dump_task_regs(struct task_struct *tsk, elf_gregset_t *pr_regs)
+{
+	struct pt_regs *regs = (struct pt_regs *)(tsk->thread.esp0);
+
+	/* NOTE: usp is error value. */
+	ELF_CORE_COPY_REGS ((*pr_regs), regs)
+
+	/* Now fix usp in pr_regs, usp is in pr_regs[2] */
+#if defined(__CSKYABIV2__)
+	(*pr_regs)[16] = tsk->thread.usp;
+#else
+	(*pr_regs)[2] = tsk->thread.usp;
+#endif
+
+	return 1;
+}
+
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long esp, pc;
+	unsigned long stack_page;
+	int count = 0;
+	if (!p || p == current || p->state == TASK_RUNNING)
+		return 0;
+
+	stack_page = (unsigned long)p;
+	esp = p->thread.esp0;
+	do {
+		if (esp < stack_page+sizeof(struct task_struct) ||
+		    esp >= 8184+stack_page)
+			return 0;
+		/*FIXME: There's may be error here!*/
+		pc = ((unsigned long *)esp)[1];
+		/* FIXME: This depends on the order of these functions. */
+		if (!in_sched_functions(pc))
+			return pc;
+		esp = *(unsigned long *) esp;
+	} while (count++ < 16);
+	return 0;
+}
+
+EXPORT_SYMBOL(get_wchan);
diff --git a/arch/csky/kernel/time.c b/arch/csky/kernel/time.c
new file mode 100644
index 0000000..4d9bc05
--- /dev/null
+++ b/arch/csky/kernel/time.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+
+void __init time_init(void)
+{
+	of_clk_init(NULL);
+#ifdef COMPAT_KERNEL_4_9
+	clocksource_probe();
+#else
+	timer_probe();
+#endif
+}
+
-- 
2.7.4
