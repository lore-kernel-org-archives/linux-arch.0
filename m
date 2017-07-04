From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 5/9] RISC-V: Task implementation
Date: Tue,  4 Jul 2017 12:50:58 -0700
Message-ID: <20170704195102.3974-6-palmer@dabbelt.com>
References: <20170704195102.3974-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36057 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbdGDTvc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2017 15:51:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id u36so28484605pgn.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Jul 2017 12:51:31 -0700 (PDT)
In-Reply-To: <20170704195102.3974-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>

This patch contains the implementation of tasks on RISC-V, most of which
is involved in task switching.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/asm-offsets.h |   1 +
 arch/riscv/include/asm/current.h     |  44 ++++
 arch/riscv/include/asm/kprobes.h     |  22 ++
 arch/riscv/include/asm/processor.h   |  97 ++++++++
 arch/riscv/include/asm/switch_to.h   |  69 ++++++
 arch/riscv/include/asm/thread_info.h |  93 ++++++++
 arch/riscv/kernel/asm-offsets.c      | 318 +++++++++++++++++++++++++
 arch/riscv/kernel/entry.S            | 450 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/process.c          | 132 ++++++++++
 9 files changed, 1226 insertions(+)
 create mode 100644 arch/riscv/include/asm/asm-offsets.h
 create mode 100644 arch/riscv/include/asm/current.h
 create mode 100644 arch/riscv/include/asm/kprobes.h
 create mode 100644 arch/riscv/include/asm/processor.h
 create mode 100644 arch/riscv/include/asm/switch_to.h
 create mode 100644 arch/riscv/include/asm/thread_info.h
 create mode 100644 arch/riscv/kernel/asm-offsets.c
 create mode 100644 arch/riscv/kernel/entry.S
 create mode 100644 arch/riscv/kernel/process.c

diff --git a/arch/riscv/include/asm/asm-offsets.h b/arch/riscv/include/asm/asm-offsets.h
new file mode 100644
index 000000000000..d370ee36a182
--- /dev/null
+++ b/arch/riscv/include/asm/asm-offsets.h
@@ -0,0 +1 @@
+#include <generated/asm-offsets.h>
diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
new file mode 100644
index 000000000000..353a7c9f3c9e
--- /dev/null
+++ b/arch/riscv/include/asm/current.h
@@ -0,0 +1,44 @@
+/*
+ * Based on arm/arm64/include/asm/current.h
+ *
+ * Copyright (C) 2016 ARM
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
+
+#ifndef __ASM_CURRENT_H
+#define __ASM_CURRENT_H
+
+#include <linux/compiler.h>
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+
+/*
+ * This only works because "struct thread_info" is at offset 0 from "struct
+ * task_struct".  This constraint seems to be necessary on other architectures
+ * as well, but __switch_to enforces it.  We can't check TASK_TI here because
+ * <asm/asm-offsets.h> includes this, and I can't get the definition of "struct
+ * task_struct" here due to some header ordering problems.
+ */
+static __always_inline struct task_struct *get_current(void)
+{
+	register struct task_struct *tp __asm__("tp");
+	return tp;
+}
+
+#define current get_current()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_CURRENT_H */
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
new file mode 100644
index 000000000000..c7eb010d1528
--- /dev/null
+++ b/arch/riscv/include/asm/kprobes.h
@@ -0,0 +1,22 @@
+/*
+ * Copied from arch/arm64/include/asm/kprobes.h
+ *
+ * Copyright (C) 2013 Linaro Limited
+ * Copyright (C) 2017 SiFive
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _RISCV_KPROBES_H
+#define _RISCV_KPROBES_H
+
+#include <asm-generic/kprobes.h>
+
+#endif /* _RISCV_KPROBES_H */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
new file mode 100644
index 000000000000..3fe4af8147d2
--- /dev/null
+++ b/arch/riscv/include/asm/processor.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
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
+#ifndef _ASM_RISCV_PROCESSOR_H
+#define _ASM_RISCV_PROCESSOR_H
+
+#include <linux/const.h>
+
+#include <asm/ptrace.h>
+
+/*
+ * This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE >> 1)
+
+#define STACK_TOP		TASK_SIZE
+#define STACK_TOP_MAX		STACK_TOP
+#define STACK_ALIGN		16
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+struct pt_regs;
+
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr()	({ __label__ _l; _l: &&_l; })
+
+/* CPU-specific state of a task */
+struct thread_struct {
+	/* Callee-saved registers */
+	unsigned long ra;
+	unsigned long sp;	/* Kernel mode stack */
+	unsigned long s[12];	/* s[0]: frame pointer */
+	struct __riscv_d_ext_state fstate;
+};
+
+#define INIT_THREAD {					\
+	.sp = sizeof(init_stack) + (long)&init_stack,	\
+}
+
+#define task_pt_regs(tsk)						\
+	((struct pt_regs *)(task_stack_page(tsk) + THREAD_SIZE		\
+			    - ALIGN(sizeof(struct pt_regs), STACK_ALIGN)))
+
+#define KSTK_EIP(tsk)		(task_pt_regs(tsk)->sepc)
+#define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
+
+
+/* Do necessary setup to start up a newly executed thread. */
+extern void start_thread(struct pt_regs *regs,
+			unsigned long pc, unsigned long sp);
+
+/* Free all resources held by a thread. */
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+extern unsigned long get_wchan(struct task_struct *p);
+
+
+static inline void cpu_relax(void)
+{
+#ifdef __riscv_muldiv
+	int dummy;
+	/* In lieu of a halt instruction, induce a long-latency stall. */
+	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
+#endif
+	barrier();
+}
+
+static inline void wait_for_interrupt(void)
+{
+	__asm__ __volatile__ ("wfi");
+}
+
+struct device_node;
+extern int riscv_of_processor_hart(struct device_node *node);
+
+extern void riscv_fill_hwcap(void);
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
new file mode 100644
index 000000000000..dd6b05bff75b
--- /dev/null
+++ b/arch/riscv/include/asm/switch_to.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
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
+#ifndef _ASM_RISCV_SWITCH_TO_H
+#define _ASM_RISCV_SWITCH_TO_H
+
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/csr.h>
+
+extern void __fstate_save(struct task_struct *save_to);
+extern void __fstate_restore(struct task_struct *restore_from);
+
+static inline void __fstate_clean(struct pt_regs *regs)
+{
+	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
+}
+
+static inline void fstate_save(struct task_struct *task,
+			       struct pt_regs *regs)
+{
+	if ((regs->sstatus & SR_FS) == SR_FS_DIRTY) {
+		__fstate_save(task);
+		__fstate_clean(regs);
+	}
+}
+
+static inline void fstate_restore(struct task_struct *task,
+				  struct pt_regs *regs)
+{
+	if ((regs->sstatus & SR_FS) != SR_FS_OFF) {
+		__fstate_restore(task);
+		__fstate_clean(regs);
+	}
+}
+
+static inline void __switch_to_aux(struct task_struct *prev,
+				   struct task_struct *next)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(prev);
+	if (unlikely(regs->sstatus & SR_SD))
+		fstate_save(prev, regs);
+	fstate_restore(next, task_pt_regs(next));
+}
+
+extern struct task_struct *__switch_to(struct task_struct *,
+				       struct task_struct *);
+
+#define switch_to(prev, next, last)			\
+do {							\
+	struct task_struct *__prev = (prev);		\
+	struct task_struct *__next = (next);		\
+	__switch_to_aux(__prev, __next);		\
+	((last) = __switch_to(__prev, __next));		\
+} while (0)
+
+#endif /* _ASM_RISCV_SWITCH_TO_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
new file mode 100644
index 000000000000..ad13bea17b5d
--- /dev/null
+++ b/arch/riscv/include/asm/thread_info.h
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
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
+#ifndef _ASM_RISCV_THREAD_INFO_H
+#define _ASM_RISCV_THREAD_INFO_H
+
+#include <asm/page.h>
+#include <linux/const.h>
+
+/* thread information allocation */
+#define THREAD_SIZE_ORDER	(1)
+#define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
+
+#ifndef __ASSEMBLY__
+
+#include <asm/processor.h>
+#include <asm/csr.h>
+
+typedef unsigned long mm_segment_t;
+
+/*
+ * low level task data that entry.S needs immediate access to
+ * - this struct should fit entirely inside of one cache line
+ * - if the members of this struct changes, the assembly constants
+ *   in asm-offsets.c must be updated accordingly
+ * - thread_info is included in task_struct at an offset of 0.  This means that
+ *   tp points to both thread_info and task_struct.
+ */
+struct thread_info {
+	unsigned long		flags;		/* low level flags */
+	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	mm_segment_t		addr_limit;
+	/*
+	 * These stack pointers are overwritten on every system call or
+	 * exception.  SP is also saved to the stack it can be recovered when
+	 * overwritten.
+	 */
+	long			kernel_sp;	/* Kernel stack pointer */
+	long			user_sp;	/* User stack pointer */
+};
+
+/*
+ * macros/functions for gaining access to the thread information structure
+ *
+ * preempt_count needs to be 1 initially, until the scheduler is functional.
+ */
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.flags		= 0,			\
+	.preempt_count	= INIT_PREEMPT_COUNT,	\
+	.addr_limit	= KERNEL_DS,		\
+}
+
+#define init_stack		(init_thread_union.stack)
+
+#endif /* !__ASSEMBLY__ */
+
+/*
+ * thread information flags
+ * - these are process state flags that various assembly files may need to
+ *   access
+ * - pending work-to-be-done flags are in lowest half-word
+ * - other flags in upper half-word(s)
+ */
+#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
+#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
+#define TIF_SIGPENDING		2	/* signal pending */
+#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
+#define TIF_MEMDIE		5	/* is terminating due to OOM killer */
+#define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
+
+#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+
+#define _TIF_WORK_MASK \
+	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED)
+
+#endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
new file mode 100644
index 000000000000..3dc7f9d52cb1
--- /dev/null
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -0,0 +1,318 @@
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
+#include <linux/kbuild.h>
+#include <linux/sched.h>
+#include <asm/thread_info.h>
+#include <asm/ptrace.h>
+
+void asm_offsets(void)
+{
+	OFFSET(TASK_THREAD_RA, task_struct, thread.ra);
+	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
+	OFFSET(TASK_THREAD_S0, task_struct, thread.s[0]);
+	OFFSET(TASK_THREAD_S1, task_struct, thread.s[1]);
+	OFFSET(TASK_THREAD_S2, task_struct, thread.s[2]);
+	OFFSET(TASK_THREAD_S3, task_struct, thread.s[3]);
+	OFFSET(TASK_THREAD_S4, task_struct, thread.s[4]);
+	OFFSET(TASK_THREAD_S5, task_struct, thread.s[5]);
+	OFFSET(TASK_THREAD_S6, task_struct, thread.s[6]);
+	OFFSET(TASK_THREAD_S7, task_struct, thread.s[7]);
+	OFFSET(TASK_THREAD_S8, task_struct, thread.s[8]);
+	OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
+	OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
+	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
+	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
+	OFFSET(TASK_STACK, task_struct, stack);
+	OFFSET(TASK_TI, task_struct, thread_info);
+	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
+	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
+	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
+
+	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
+	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
+	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
+	OFFSET(TASK_THREAD_F3,  task_struct, thread.fstate.f[3]);
+	OFFSET(TASK_THREAD_F4,  task_struct, thread.fstate.f[4]);
+	OFFSET(TASK_THREAD_F5,  task_struct, thread.fstate.f[5]);
+	OFFSET(TASK_THREAD_F6,  task_struct, thread.fstate.f[6]);
+	OFFSET(TASK_THREAD_F7,  task_struct, thread.fstate.f[7]);
+	OFFSET(TASK_THREAD_F8,  task_struct, thread.fstate.f[8]);
+	OFFSET(TASK_THREAD_F9,  task_struct, thread.fstate.f[9]);
+	OFFSET(TASK_THREAD_F10, task_struct, thread.fstate.f[10]);
+	OFFSET(TASK_THREAD_F11, task_struct, thread.fstate.f[11]);
+	OFFSET(TASK_THREAD_F12, task_struct, thread.fstate.f[12]);
+	OFFSET(TASK_THREAD_F13, task_struct, thread.fstate.f[13]);
+	OFFSET(TASK_THREAD_F14, task_struct, thread.fstate.f[14]);
+	OFFSET(TASK_THREAD_F15, task_struct, thread.fstate.f[15]);
+	OFFSET(TASK_THREAD_F16, task_struct, thread.fstate.f[16]);
+	OFFSET(TASK_THREAD_F17, task_struct, thread.fstate.f[17]);
+	OFFSET(TASK_THREAD_F18, task_struct, thread.fstate.f[18]);
+	OFFSET(TASK_THREAD_F19, task_struct, thread.fstate.f[19]);
+	OFFSET(TASK_THREAD_F20, task_struct, thread.fstate.f[20]);
+	OFFSET(TASK_THREAD_F21, task_struct, thread.fstate.f[21]);
+	OFFSET(TASK_THREAD_F22, task_struct, thread.fstate.f[22]);
+	OFFSET(TASK_THREAD_F23, task_struct, thread.fstate.f[23]);
+	OFFSET(TASK_THREAD_F24, task_struct, thread.fstate.f[24]);
+	OFFSET(TASK_THREAD_F25, task_struct, thread.fstate.f[25]);
+	OFFSET(TASK_THREAD_F26, task_struct, thread.fstate.f[26]);
+	OFFSET(TASK_THREAD_F27, task_struct, thread.fstate.f[27]);
+	OFFSET(TASK_THREAD_F28, task_struct, thread.fstate.f[28]);
+	OFFSET(TASK_THREAD_F29, task_struct, thread.fstate.f[29]);
+	OFFSET(TASK_THREAD_F30, task_struct, thread.fstate.f[30]);
+	OFFSET(TASK_THREAD_F31, task_struct, thread.fstate.f[31]);
+	OFFSET(TASK_THREAD_FCSR, task_struct, thread.fstate.fcsr);
+
+	DEFINE(PT_SIZE, sizeof(struct pt_regs));
+	OFFSET(PT_SEPC, pt_regs, sepc);
+	OFFSET(PT_RA, pt_regs, ra);
+	OFFSET(PT_FP, pt_regs, s0);
+	OFFSET(PT_S0, pt_regs, s0);
+	OFFSET(PT_S1, pt_regs, s1);
+	OFFSET(PT_S2, pt_regs, s2);
+	OFFSET(PT_S3, pt_regs, s3);
+	OFFSET(PT_S4, pt_regs, s4);
+	OFFSET(PT_S5, pt_regs, s5);
+	OFFSET(PT_S6, pt_regs, s6);
+	OFFSET(PT_S7, pt_regs, s7);
+	OFFSET(PT_S8, pt_regs, s8);
+	OFFSET(PT_S9, pt_regs, s9);
+	OFFSET(PT_S10, pt_regs, s10);
+	OFFSET(PT_S11, pt_regs, s11);
+	OFFSET(PT_SP, pt_regs, sp);
+	OFFSET(PT_TP, pt_regs, tp);
+	OFFSET(PT_A0, pt_regs, a0);
+	OFFSET(PT_A1, pt_regs, a1);
+	OFFSET(PT_A2, pt_regs, a2);
+	OFFSET(PT_A3, pt_regs, a3);
+	OFFSET(PT_A4, pt_regs, a4);
+	OFFSET(PT_A5, pt_regs, a5);
+	OFFSET(PT_A6, pt_regs, a6);
+	OFFSET(PT_A7, pt_regs, a7);
+	OFFSET(PT_T0, pt_regs, t0);
+	OFFSET(PT_T1, pt_regs, t1);
+	OFFSET(PT_T2, pt_regs, t2);
+	OFFSET(PT_T3, pt_regs, t3);
+	OFFSET(PT_T4, pt_regs, t4);
+	OFFSET(PT_T5, pt_regs, t5);
+	OFFSET(PT_T6, pt_regs, t6);
+	OFFSET(PT_GP, pt_regs, gp);
+	OFFSET(PT_SSTATUS, pt_regs, sstatus);
+	OFFSET(PT_SBADADDR, pt_regs, sbadaddr);
+	OFFSET(PT_SCAUSE, pt_regs, scause);
+
+	/*
+	 * THREAD_{F,X}* might be larger than a S-type offset can handle, but
+	 * these are used in performance-sensitive assembly so we can't resort
+	 * to loading the long immediate every time.
+	 */
+	DEFINE(TASK_THREAD_RA_RA,
+		  offsetof(struct task_struct, thread.ra)
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_SP_RA,
+		  offsetof(struct task_struct, thread.sp)
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S0_RA,
+		  offsetof(struct task_struct, thread.s[0])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S1_RA,
+		  offsetof(struct task_struct, thread.s[1])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S2_RA,
+		  offsetof(struct task_struct, thread.s[2])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S3_RA,
+		  offsetof(struct task_struct, thread.s[3])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S4_RA,
+		  offsetof(struct task_struct, thread.s[4])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S5_RA,
+		  offsetof(struct task_struct, thread.s[5])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S6_RA,
+		  offsetof(struct task_struct, thread.s[6])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S7_RA,
+		  offsetof(struct task_struct, thread.s[7])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S8_RA,
+		  offsetof(struct task_struct, thread.s[8])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S9_RA,
+		  offsetof(struct task_struct, thread.s[9])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S10_RA,
+		  offsetof(struct task_struct, thread.s[10])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S11_RA,
+		  offsetof(struct task_struct, thread.s[11])
+		- offsetof(struct task_struct, thread.ra)
+	);
+
+	DEFINE(TASK_THREAD_F0_F0,
+		  offsetof(struct task_struct, thread.fstate.f[0])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F1_F0,
+		  offsetof(struct task_struct, thread.fstate.f[1])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F2_F0,
+		  offsetof(struct task_struct, thread.fstate.f[2])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F3_F0,
+		  offsetof(struct task_struct, thread.fstate.f[3])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F4_F0,
+		  offsetof(struct task_struct, thread.fstate.f[4])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F5_F0,
+		  offsetof(struct task_struct, thread.fstate.f[5])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F6_F0,
+		  offsetof(struct task_struct, thread.fstate.f[6])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F7_F0,
+		  offsetof(struct task_struct, thread.fstate.f[7])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F8_F0,
+		  offsetof(struct task_struct, thread.fstate.f[8])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F9_F0,
+		  offsetof(struct task_struct, thread.fstate.f[9])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F10_F0,
+		  offsetof(struct task_struct, thread.fstate.f[10])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F11_F0,
+		  offsetof(struct task_struct, thread.fstate.f[11])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F12_F0,
+		  offsetof(struct task_struct, thread.fstate.f[12])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F13_F0,
+		  offsetof(struct task_struct, thread.fstate.f[13])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F14_F0,
+		  offsetof(struct task_struct, thread.fstate.f[14])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F15_F0,
+		  offsetof(struct task_struct, thread.fstate.f[15])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F16_F0,
+		  offsetof(struct task_struct, thread.fstate.f[16])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F17_F0,
+		  offsetof(struct task_struct, thread.fstate.f[17])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F18_F0,
+		  offsetof(struct task_struct, thread.fstate.f[18])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F19_F0,
+		  offsetof(struct task_struct, thread.fstate.f[19])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F20_F0,
+		  offsetof(struct task_struct, thread.fstate.f[20])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F21_F0,
+		  offsetof(struct task_struct, thread.fstate.f[21])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F22_F0,
+		  offsetof(struct task_struct, thread.fstate.f[22])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F23_F0,
+		  offsetof(struct task_struct, thread.fstate.f[23])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F24_F0,
+		  offsetof(struct task_struct, thread.fstate.f[24])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F25_F0,
+		  offsetof(struct task_struct, thread.fstate.f[25])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F26_F0,
+		  offsetof(struct task_struct, thread.fstate.f[26])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F27_F0,
+		  offsetof(struct task_struct, thread.fstate.f[27])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F28_F0,
+		  offsetof(struct task_struct, thread.fstate.f[28])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F29_F0,
+		  offsetof(struct task_struct, thread.fstate.f[29])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F30_F0,
+		  offsetof(struct task_struct, thread.fstate.f[30])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F31_F0,
+		  offsetof(struct task_struct, thread.fstate.f[31])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_FCSR_F0,
+		  offsetof(struct task_struct, thread.fstate.fcsr)
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+
+	/* The assembler needs access to THREAD_SIZE as well. */
+	DEFINE(ASM_THREAD_SIZE, THREAD_SIZE);
+
+	/*
+	 * We allocate a pt_regs on the stack when entering the kernel.  This
+	 * ensures the alignment is sane.
+	 */
+	DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
+}
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
new file mode 100644
index 000000000000..7208fcec0cf4
--- /dev/null
+++ b/arch/riscv/kernel/entry.S
@@ -0,0 +1,450 @@
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
+#include <linux/init.h>
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/unistd.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+
+	.text
+	.altmacro
+
+/*
+ * Prepares to enter a system call or exception by saving all registers to the
+ * stack.
+ */
+	.macro SAVE_ALL
+	LOCAL _restore_kernel_tpsp
+	LOCAL _save_context
+
+	/*
+	 * If coming from userspace, preserve the user thread pointer and load
+	 * the kernel thread pointer.  If we came from the kernel, sscratch
+	 * will contain 0, and we should continue on the current TP.
+	 */
+	csrrw tp, sscratch, tp
+	bnez tp, _save_context
+
+_restore_kernel_tpsp:
+	csrr tp, sscratch
+	REG_S sp, TASK_TI_KERNEL_SP(tp)
+_save_context:
+	REG_S sp, TASK_TI_USER_SP(tp)
+	REG_L sp, TASK_TI_KERNEL_SP(tp)
+	addi sp, sp, -(PT_SIZE_ON_STACK)
+	REG_S x1,  PT_RA(sp)
+	REG_S x3,  PT_GP(sp)
+	REG_S x5,  PT_T0(sp)
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
+	REG_S x10, PT_A0(sp)
+	REG_S x11, PT_A1(sp)
+	REG_S x12, PT_A2(sp)
+	REG_S x13, PT_A3(sp)
+	REG_S x14, PT_A4(sp)
+	REG_S x15, PT_A5(sp)
+	REG_S x16, PT_A6(sp)
+	REG_S x17, PT_A7(sp)
+	REG_S x18, PT_S2(sp)
+	REG_S x19, PT_S3(sp)
+	REG_S x20, PT_S4(sp)
+	REG_S x21, PT_S5(sp)
+	REG_S x22, PT_S6(sp)
+	REG_S x23, PT_S7(sp)
+	REG_S x24, PT_S8(sp)
+	REG_S x25, PT_S9(sp)
+	REG_S x26, PT_S10(sp)
+	REG_S x27, PT_S11(sp)
+	REG_S x28, PT_T3(sp)
+	REG_S x29, PT_T4(sp)
+	REG_S x30, PT_T5(sp)
+	REG_S x31, PT_T6(sp)
+
+	/*
+	 * Disable FPU to detect illegal usage of
+	 * floating point in kernel space
+	 */
+	li t0, SR_FS
+
+	REG_L s0, TASK_TI_USER_SP(tp)
+	csrrc s1, sstatus, t0
+	csrr s2, sepc
+	csrr s3, sbadaddr
+	csrr s4, scause
+	csrr s5, sscratch
+	REG_S s0, PT_SP(sp)
+	REG_S s1, PT_SSTATUS(sp)
+	REG_S s2, PT_SEPC(sp)
+	REG_S s3, PT_SBADADDR(sp)
+	REG_S s4, PT_SCAUSE(sp)
+	REG_S s5, PT_TP(sp)
+	.endm
+
+/*
+ * Prepares to return from a system call or exception by restoring all
+ * registers from the stack.
+ */
+	.macro RESTORE_ALL
+	REG_L a0, PT_SSTATUS(sp)
+	REG_L a2, PT_SEPC(sp)
+	csrw sstatus, a0
+	csrw sepc, a2
+
+	REG_L x1,  PT_RA(sp)
+	REG_L x3,  PT_GP(sp)
+	REG_L x4,  PT_TP(sp)
+	REG_L x5,  PT_T0(sp)
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
+	REG_L x10, PT_A0(sp)
+	REG_L x11, PT_A1(sp)
+	REG_L x12, PT_A2(sp)
+	REG_L x13, PT_A3(sp)
+	REG_L x14, PT_A4(sp)
+	REG_L x15, PT_A5(sp)
+	REG_L x16, PT_A6(sp)
+	REG_L x17, PT_A7(sp)
+	REG_L x18, PT_S2(sp)
+	REG_L x19, PT_S3(sp)
+	REG_L x20, PT_S4(sp)
+	REG_L x21, PT_S5(sp)
+	REG_L x22, PT_S6(sp)
+	REG_L x23, PT_S7(sp)
+	REG_L x24, PT_S8(sp)
+	REG_L x25, PT_S9(sp)
+	REG_L x26, PT_S10(sp)
+	REG_L x27, PT_S11(sp)
+	REG_L x28, PT_T3(sp)
+	REG_L x29, PT_T4(sp)
+	REG_L x30, PT_T5(sp)
+	REG_L x31, PT_T6(sp)
+
+	REG_L x2,  PT_SP(sp)
+	.endm
+
+ENTRY(handle_exception)
+	SAVE_ALL
+
+	/*
+	 * Set sscratch register to 0, so that if a recursive exception
+	 * occurs, the exception vector knows it came from the kernel
+	 */
+	csrw sscratch, x0
+
+	la gp, __global_pointer$
+
+	la ra, ret_from_exception
+	/*
+	 * MSB of cause differentiates between
+	 * interrupts and exceptions
+	 */
+	bge s4, zero, 1f
+
+	/* Handle interrupts */
+	slli a0, s4, 1
+	srli a0, a0, 1
+	move a1, sp /* pt_regs */
+	tail do_IRQ
+1:
+	/* Handle syscalls */
+	li t0, EXC_SYSCALL
+	beq s4, t0, handle_syscall
+
+	/* Handle other exceptions */
+	slli t0, s4, RISCV_LGPTR
+	la t1, excp_vect_table
+	la t2, excp_vect_table_end
+	move a0, sp /* pt_regs */
+	add t0, t1, t0
+	/* Check if exception code lies within bounds */
+	bgeu t0, t2, 1f
+	REG_L t0, 0(t0)
+	jr t0
+1:
+	tail do_trap_unknown
+
+handle_syscall:
+	/*
+	 * Advance SEPC to avoid executing the original
+	 * scall instruction on sret
+	 */
+	addi s2, s2, 0x4
+	REG_S s2, PT_SEPC(sp)
+	/* System calls run with interrupts enabled */
+	csrs sstatus, SR_IE
+	/* Trace syscalls, but only if requested by the user. */
+	REG_L t0, TASK_TI_FLAGS(tp)
+	andi t0, t0, _TIF_SYSCALL_TRACE
+	bnez t0, handle_syscall_trace_enter
+check_syscall_nr:
+	/* Check to make sure we don't jump to a bogus syscall number. */
+	li t0, __NR_syscalls
+	la s0, sys_ni_syscall
+	/* Syscall number held in a7 */
+	bgeu a7, t0, 1f
+	la s0, sys_call_table
+	slli t0, a7, RISCV_LGPTR
+	add s0, s0, t0
+	REG_L s0, 0(s0)
+1:
+	jalr s0
+
+ret_from_syscall:
+	/* Set user a0 to kernel a0 */
+	REG_S a0, PT_A0(sp)
+	/* Trace syscalls, but only if requested by the user. */
+	REG_L t0, TASK_TI_FLAGS(tp)
+	andi t0, t0, _TIF_SYSCALL_TRACE
+	bnez t0, handle_syscall_trace_exit
+
+ret_from_exception:
+	REG_L s0, PT_SSTATUS(sp)
+	csrc sstatus, SR_IE
+	andi s0, s0, SR_PS
+	bnez s0, restore_all
+
+resume_userspace:
+	/* Interrupts must be disabled here so flags are checked atomically */
+	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
+	andi s1, s0, _TIF_WORK_MASK
+	bnez s1, work_pending
+
+	/* Save unwound kernel stack pointer in thread_info */
+	addi s0, sp, PT_SIZE_ON_STACK
+	REG_S s0, TASK_TI_KERNEL_SP(tp)
+
+	/*
+	 * Save TP into sscratch, so we can find the kernel data structures
+	 * again.
+	 */
+	csrw sscratch, tp
+
+restore_all:
+	RESTORE_ALL
+	sret
+
+work_pending:
+	/* Enter slow path for supplementary processing */
+	la ra, ret_from_exception
+	andi s1, s0, _TIF_NEED_RESCHED
+	bnez s1, work_resched
+work_notifysig:
+	/* Handle pending signals and notify-resume requests */
+	csrs sstatus, SR_IE /* Enable interrupts for do_notify_resume() */
+	move a0, sp /* pt_regs */
+	move a1, s0 /* current_thread_info->flags */
+	tail do_notify_resume
+work_resched:
+	tail schedule
+
+/* Slow paths for ptrace. */
+handle_syscall_trace_enter:
+	move a0, sp
+	call do_syscall_trace_enter
+	REG_L a0, PT_A0(sp)
+	REG_L a1, PT_A1(sp)
+	REG_L a2, PT_A2(sp)
+	REG_L a3, PT_A3(sp)
+	REG_L a4, PT_A4(sp)
+	REG_L a5, PT_A5(sp)
+	REG_L a6, PT_A6(sp)
+	REG_L a7, PT_A7(sp)
+	j check_syscall_nr
+handle_syscall_trace_exit:
+	move a0, sp
+	call do_syscall_trace_exit
+	j ret_from_exception
+
+END(handle_exception)
+
+ENTRY(ret_from_fork)
+	la ra, ret_from_exception
+	tail schedule_tail
+ENDPROC(ret_from_fork)
+
+ENTRY(ret_from_kernel_thread)
+	call schedule_tail
+	/* Call fn(arg) */
+	la ra, ret_from_exception
+	move a0, s1
+	jr s0
+ENDPROC(ret_from_kernel_thread)
+
+
+/*
+ * Integer register context switch
+ * The callee-saved registers must be saved and restored.
+ *
+ *   a0: previous task_struct (must be preserved across the switch)
+ *   a1: next task_struct
+ */
+ENTRY(__switch_to)
+	/* Save context into prev->thread */
+	li    a2,  TASK_THREAD_RA
+	add   a0, a0, a2
+	add   a2, a1, a2
+	REG_S ra,  TASK_THREAD_RA_RA(a0)
+	REG_S sp,  TASK_THREAD_SP_RA(a0)
+	REG_S s0,  TASK_THREAD_S0_RA(a0)
+	REG_S s1,  TASK_THREAD_S1_RA(a0)
+	REG_S s2,  TASK_THREAD_S2_RA(a0)
+	REG_S s3,  TASK_THREAD_S3_RA(a0)
+	REG_S s4,  TASK_THREAD_S4_RA(a0)
+	REG_S s5,  TASK_THREAD_S5_RA(a0)
+	REG_S s6,  TASK_THREAD_S6_RA(a0)
+	REG_S s7,  TASK_THREAD_S7_RA(a0)
+	REG_S s8,  TASK_THREAD_S8_RA(a0)
+	REG_S s9,  TASK_THREAD_S9_RA(a0)
+	REG_S s10, TASK_THREAD_S10_RA(a0)
+	REG_S s11, TASK_THREAD_S11_RA(a0)
+	/* Restore context from next->thread */
+	REG_L ra,  TASK_THREAD_RA_RA(a2)
+	REG_L sp,  TASK_THREAD_SP_RA(a2)
+	REG_L s0,  TASK_THREAD_S0_RA(a2)
+	REG_L s1,  TASK_THREAD_S1_RA(a2)
+	REG_L s2,  TASK_THREAD_S2_RA(a2)
+	REG_L s3,  TASK_THREAD_S3_RA(a2)
+	REG_L s4,  TASK_THREAD_S4_RA(a2)
+	REG_L s5,  TASK_THREAD_S5_RA(a2)
+	REG_L s6,  TASK_THREAD_S6_RA(a2)
+	REG_L s7,  TASK_THREAD_S7_RA(a2)
+	REG_L s8,  TASK_THREAD_S8_RA(a2)
+	REG_L s9,  TASK_THREAD_S9_RA(a2)
+	REG_L s10, TASK_THREAD_S10_RA(a2)
+	REG_L s11, TASK_THREAD_S11_RA(a2)
+#if TASK_TI != 0
+#error "TASK_TI != 0: tp will contain a 'struct thread_info', not a 'struct task_struct' so get_current() won't work."
+	addi tp, a1, TASK_TI
+#else
+	move tp, a1
+#endif
+	ret
+ENDPROC(__switch_to)
+
+ENTRY(__fstate_save)
+	li  a2,  TASK_THREAD_F0
+	add a0, a0, a2
+	li t1, SR_FS
+	csrs sstatus, t1
+	frcsr t0
+	fsd f0,  TASK_THREAD_F0_F0(a0)
+	fsd f1,  TASK_THREAD_F1_F0(a0)
+	fsd f2,  TASK_THREAD_F2_F0(a0)
+	fsd f3,  TASK_THREAD_F3_F0(a0)
+	fsd f4,  TASK_THREAD_F4_F0(a0)
+	fsd f5,  TASK_THREAD_F5_F0(a0)
+	fsd f6,  TASK_THREAD_F6_F0(a0)
+	fsd f7,  TASK_THREAD_F7_F0(a0)
+	fsd f8,  TASK_THREAD_F8_F0(a0)
+	fsd f9,  TASK_THREAD_F9_F0(a0)
+	fsd f10, TASK_THREAD_F10_F0(a0)
+	fsd f11, TASK_THREAD_F11_F0(a0)
+	fsd f12, TASK_THREAD_F12_F0(a0)
+	fsd f13, TASK_THREAD_F13_F0(a0)
+	fsd f14, TASK_THREAD_F14_F0(a0)
+	fsd f15, TASK_THREAD_F15_F0(a0)
+	fsd f16, TASK_THREAD_F16_F0(a0)
+	fsd f17, TASK_THREAD_F17_F0(a0)
+	fsd f18, TASK_THREAD_F18_F0(a0)
+	fsd f19, TASK_THREAD_F19_F0(a0)
+	fsd f20, TASK_THREAD_F20_F0(a0)
+	fsd f21, TASK_THREAD_F21_F0(a0)
+	fsd f22, TASK_THREAD_F22_F0(a0)
+	fsd f23, TASK_THREAD_F23_F0(a0)
+	fsd f24, TASK_THREAD_F24_F0(a0)
+	fsd f25, TASK_THREAD_F25_F0(a0)
+	fsd f26, TASK_THREAD_F26_F0(a0)
+	fsd f27, TASK_THREAD_F27_F0(a0)
+	fsd f28, TASK_THREAD_F28_F0(a0)
+	fsd f29, TASK_THREAD_F29_F0(a0)
+	fsd f30, TASK_THREAD_F30_F0(a0)
+	fsd f31, TASK_THREAD_F31_F0(a0)
+	sw t0, TASK_THREAD_FCSR_F0(a0)
+	csrc sstatus, t1
+	ret
+ENDPROC(__fstate_save)
+
+ENTRY(__fstate_restore)
+	li  a2,  TASK_THREAD_F0
+	add a0, a0, a2
+	li t1, SR_FS
+	lw t0, TASK_THREAD_FCSR_F0(a0)
+	csrs sstatus, t1
+	fld f0,  TASK_THREAD_F0_F0(a0)
+	fld f1,  TASK_THREAD_F1_F0(a0)
+	fld f2,  TASK_THREAD_F2_F0(a0)
+	fld f3,  TASK_THREAD_F3_F0(a0)
+	fld f4,  TASK_THREAD_F4_F0(a0)
+	fld f5,  TASK_THREAD_F5_F0(a0)
+	fld f6,  TASK_THREAD_F6_F0(a0)
+	fld f7,  TASK_THREAD_F7_F0(a0)
+	fld f8,  TASK_THREAD_F8_F0(a0)
+	fld f9,  TASK_THREAD_F9_F0(a0)
+	fld f10, TASK_THREAD_F10_F0(a0)
+	fld f11, TASK_THREAD_F11_F0(a0)
+	fld f12, TASK_THREAD_F12_F0(a0)
+	fld f13, TASK_THREAD_F13_F0(a0)
+	fld f14, TASK_THREAD_F14_F0(a0)
+	fld f15, TASK_THREAD_F15_F0(a0)
+	fld f16, TASK_THREAD_F16_F0(a0)
+	fld f17, TASK_THREAD_F17_F0(a0)
+	fld f18, TASK_THREAD_F18_F0(a0)
+	fld f19, TASK_THREAD_F19_F0(a0)
+	fld f20, TASK_THREAD_F20_F0(a0)
+	fld f21, TASK_THREAD_F21_F0(a0)
+	fld f22, TASK_THREAD_F22_F0(a0)
+	fld f23, TASK_THREAD_F23_F0(a0)
+	fld f24, TASK_THREAD_F24_F0(a0)
+	fld f25, TASK_THREAD_F25_F0(a0)
+	fld f26, TASK_THREAD_F26_F0(a0)
+	fld f27, TASK_THREAD_F27_F0(a0)
+	fld f28, TASK_THREAD_F28_F0(a0)
+	fld f29, TASK_THREAD_F29_F0(a0)
+	fld f30, TASK_THREAD_F30_F0(a0)
+	fld f31, TASK_THREAD_F31_F0(a0)
+	fscsr t0
+	csrc sstatus, t1
+	ret
+ENDPROC(__fstate_restore)
+
+
+	.section ".rodata"
+	/* Exception vector table */
+ENTRY(excp_vect_table)
+	RISCV_PTR do_trap_insn_misaligned
+	RISCV_PTR do_trap_insn_fault
+	RISCV_PTR do_trap_insn_illegal
+	RISCV_PTR do_trap_break
+	RISCV_PTR do_trap_load_misaligned
+	RISCV_PTR do_trap_load_fault
+	RISCV_PTR do_trap_store_misaligned
+	RISCV_PTR do_trap_store_fault
+	RISCV_PTR do_trap_ecall_u /* system call, gets intercepted */
+	RISCV_PTR do_trap_ecall_s
+	RISCV_PTR do_trap_unknown
+	RISCV_PTR do_trap_ecall_m
+	RISCV_PTR do_page_fault   /* instruction page fault */
+	RISCV_PTR do_page_fault   /* load page fault */
+	RISCV_PTR do_trap_unknown
+	RISCV_PTR do_page_fault   /* store page fault */
+excp_vect_table_end:
+END(excp_vect_table)
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
new file mode 100644
index 000000000000..7d539d64bf1a
--- /dev/null
+++ b/arch/riscv/kernel/process.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/tick.h>
+#include <linux/ptrace.h>
+
+#include <asm/unistd.h>
+#include <asm/uaccess.h>
+#include <asm/processor.h>
+#include <asm/csr.h>
+#include <asm/string.h>
+#include <asm/switch_to.h>
+
+extern asmlinkage void ret_from_fork(void);
+extern asmlinkage void ret_from_kernel_thread(void);
+
+void arch_cpu_idle(void)
+{
+	wait_for_interrupt();
+	local_irq_enable();
+}
+
+void show_regs(struct pt_regs *regs)
+{
+	show_regs_print_info(KERN_DEFAULT);
+
+	pr_cont("sepc: " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
+		regs->sepc, regs->ra, regs->sp);
+	pr_cont(" gp : " REG_FMT " tp : " REG_FMT " t0 : " REG_FMT "\n",
+		regs->gp, regs->tp, regs->t0);
+	pr_cont(" t1 : " REG_FMT " t2 : " REG_FMT " s0 : " REG_FMT "\n",
+		regs->t1, regs->t2, regs->s0);
+	pr_cont(" s1 : " REG_FMT " a0 : " REG_FMT " a1 : " REG_FMT "\n",
+		regs->s1, regs->a0, regs->a1);
+	pr_cont(" a2 : " REG_FMT " a3 : " REG_FMT " a4 : " REG_FMT "\n",
+		regs->a2, regs->a3, regs->a4);
+	pr_cont(" a5 : " REG_FMT " a6 : " REG_FMT " a7 : " REG_FMT "\n",
+		regs->a5, regs->a6, regs->a7);
+	pr_cont(" s2 : " REG_FMT " s3 : " REG_FMT " s4 : " REG_FMT "\n",
+		regs->s2, regs->s3, regs->s4);
+	pr_cont(" s5 : " REG_FMT " s6 : " REG_FMT " s7 : " REG_FMT "\n",
+		regs->s5, regs->s6, regs->s7);
+	pr_cont(" s8 : " REG_FMT " s9 : " REG_FMT " s10: " REG_FMT "\n",
+		regs->s8, regs->s9, regs->s10);
+	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
+		regs->s11, regs->t3, regs->t4);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
+		regs->t5, regs->t6);
+
+	pr_cont("sstatus: " REG_FMT " sbadaddr: " REG_FMT " scause: " REG_FMT "\n",
+		regs->sstatus, regs->sbadaddr, regs->scause);
+}
+
+void start_thread(struct pt_regs *regs, unsigned long pc,
+	unsigned long sp)
+{
+	regs->sstatus = SR_PIE /* User mode, irqs on */ | SR_FS_INITIAL;
+#ifndef CONFIG_RV_PUM
+	regs->sstatus |= SR_SUM;
+#endif
+	regs->sepc = pc;
+	regs->sp = sp;
+	set_fs(USER_DS);
+}
+
+void flush_thread(void)
+{
+	/*
+	 * Reset FPU context
+	 *	frm: round to nearest, ties to even (IEEE default)
+	 *	fflags: accrued exceptions cleared
+	 */
+	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
+}
+
+int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
+{
+	fstate_save(src, task_pt_regs(src));
+	*dst = *src;
+	return 0;
+}
+
+int copy_thread(unsigned long clone_flags, unsigned long usp,
+	unsigned long arg, struct task_struct *p)
+{
+	struct pt_regs *childregs = task_pt_regs(p);
+
+	/* p->thread holds context to be restored by __switch_to() */
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* Kernel thread */
+		const register unsigned long gp __asm__ ("gp");
+		memset(childregs, 0, sizeof(struct pt_regs));
+		childregs->gp = gp;
+		childregs->sstatus = SR_PS | SR_PIE; /* Supervisor, irqs on */
+
+		p->thread.ra = (unsigned long)ret_from_kernel_thread;
+		p->thread.s[0] = usp; /* fn */
+		p->thread.s[1] = arg;
+	} else {
+		*childregs = *(current_pt_regs());
+		if (usp) /* User fork */
+			childregs->sp = usp;
+		if (clone_flags & CLONE_SETTLS)
+			childregs->tp = childregs->a5;
+		childregs->a0 = 0; /* Return value of fork() */
+		p->thread.ra = (unsigned long)ret_from_fork;
+	}
+	p->thread.sp = (unsigned long)childregs; /* kernel sp */
+	return 0;
+}
-- 
2.13.0
