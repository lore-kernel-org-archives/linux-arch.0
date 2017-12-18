From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v4 10/36] nds32: Process management
Date: Mon, 18 Dec 2017 14:46:22 +0800
Message-ID: <6f26e83869ba69d0a47d92c17eb0dcb4c8e9bb1d.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch includes copy_thread(), start_thread() implementation and cpu_context
structure definition. nds32 uses $r25 to get current task_struct.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/current.h     |   12 ++
 arch/nds32/include/asm/processor.h   |  102 +++++++++++++++++
 arch/nds32/include/asm/thread_info.h |   78 +++++++++++++
 arch/nds32/kernel/process.c          |  204 ++++++++++++++++++++++++++++++++++
 4 files changed, 396 insertions(+)
 create mode 100644 arch/nds32/include/asm/current.h
 create mode 100644 arch/nds32/include/asm/processor.h
 create mode 100644 arch/nds32/include/asm/thread_info.h
 create mode 100644 arch/nds32/kernel/process.c

diff --git a/arch/nds32/include/asm/current.h b/arch/nds32/include/asm/current.h
new file mode 100644
index 0000000..b4dcd22
--- /dev/null
+++ b/arch/nds32/include/asm/current.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef _ASM_NDS32_CURRENT_H
+#define _ASM_NDS32_CURRENT_H
+
+#ifndef __ASSEMBLY__
+register struct task_struct *current asm("$r25");
+#endif /* __ASSEMBLY__ */
+#define tsk $r25
+
+#endif /* _ASM_NDS32_CURRENT_H */
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
new file mode 100644
index 0000000..cad9b8c
--- /dev/null
+++ b/arch/nds32/include/asm/processor.h
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_PROCESSOR_H
+#define __ASM_NDS32_PROCESSOR_H
+
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr() ({ __label__ _l; _l: &&_l;})
+
+#ifdef __KERNEL__
+
+#include <asm/ptrace.h>
+#include <asm/types.h>
+#include <asm/sigcontext.h>
+
+#define KERNEL_STACK_SIZE	PAGE_SIZE
+#define STACK_TOP	TASK_SIZE
+#define STACK_TOP_MAX   TASK_SIZE
+
+struct cpu_context {
+	unsigned long r6;
+	unsigned long r7;
+	unsigned long r8;
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+	unsigned long r12;
+	unsigned long r13;
+	unsigned long r14;
+	unsigned long fp;
+	unsigned long pc;
+	unsigned long sp;
+};
+
+struct thread_struct {
+	struct cpu_context cpu_context;	/* cpu context */
+	/* fault info     */
+	unsigned long address;
+	unsigned long trap_no;
+	unsigned long error_code;
+};
+
+#define INIT_THREAD  {	}
+
+#ifdef __NDS32_EB__
+#define PSW_DE	PSW_mskBE
+#else
+#define PSW_DE	0x0
+#endif
+
+#ifdef CONFIG_WBNA
+#define PSW_valWBNA	PSW_mskWBNA
+#else
+#define PSW_valWBNA	0x0
+#endif
+
+#ifdef CONFIG_HWZOL
+#define	PSW_valINIT (PSW_CPL_ANY | PSW_mskAEN | PSW_valWBNA | PSW_mskDT | PSW_mskIT | PSW_DE | PSW_mskGIE)
+#else
+#define	PSW_valINIT (PSW_CPL_ANY | PSW_valWBNA | PSW_mskDT | PSW_mskIT | PSW_DE | PSW_mskGIE)
+#endif
+
+#define start_thread(regs,pc,stack)			\
+({							\
+	memzero(regs, sizeof(struct pt_regs));		\
+	regs->ipsw = PSW_valINIT;			\
+	regs->ir0 = (PSW_CPL_ANY | PSW_valWBNA | PSW_mskDT | PSW_mskIT | PSW_DE | PSW_SYSTEM | PSW_INTL_1);	\
+	regs->ipc = pc;					\
+	regs->sp = stack;				\
+})
+
+/* Forward declaration, a strange C thing */
+struct task_struct;
+
+/* Free all resources held by a thread. */
+#define release_thread(thread) do { } while(0)
+
+/* Prepare to copy thread state - unlazy all lazy status */
+#define prepare_to_copy(tsk)	do { } while (0)
+
+unsigned long get_wchan(struct task_struct *p);
+
+#define cpu_relax()			barrier()
+
+#define task_pt_regs(task) \
+	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
+		- 8) - 1)
+
+/*
+ * Create a new kernel thread
+ */
+extern int kernel_thread(int (*fn) (void *), void *arg, unsigned long flags);
+
+#define KSTK_EIP(tsk)	instruction_pointer(task_pt_regs(tsk))
+#define KSTK_ESP(tsk)	user_stack_pointer(task_pt_regs(tsk))
+
+#endif
+
+#endif /* __ASM_NDS32_PROCESSOR_H */
diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
new file mode 100644
index 0000000..818e769
--- /dev/null
+++ b/arch/nds32/include/asm/thread_info.h
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_THREAD_INFO_H
+#define __ASM_NDS32_THREAD_INFO_H
+
+#ifdef __KERNEL__
+
+#define THREAD_SIZE_ORDER 	(1)
+#define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+
+#include <asm/ptrace.h>
+#include <asm/types.h>
+
+typedef unsigned long mm_segment_t;
+
+/*
+ * low level task data that entry.S needs immediate access to.
+ * __switch_to() assumes cpu_context follows immediately after cpu_domain.
+ */
+struct thread_info {
+	unsigned long flags;	/* low level flags */
+	__s32 preempt_count;	/* 0 => preemptable, <0 => bug */
+	mm_segment_t addr_limit;	/* address limit */
+};
+#define INIT_THREAD_INFO(tsk)						\
+{									\
+	.preempt_count	= INIT_PREEMPT_COUNT,				\
+	.addr_limit	= KERNEL_DS,					\
+}
+#define init_thread_info	(init_thread_union.thread_info)
+#define init_stack		(init_thread_union.stack)
+#define thread_saved_pc(tsk) ((unsigned long)(tsk->thread.cpu_context.pc))
+#define thread_saved_fp(tsk) ((unsigned long)(tsk->thread.cpu_context.fp))
+#endif
+
+/*
+ * thread information flags:
+ *  TIF_SYSCALL_TRACE	- syscall trace active
+ *  TIF_SIGPENDING	- signal pending
+ *  TIF_NEED_RESCHED	- rescheduling necessary
+ *  TIF_NOTIFY_RESUME	- callback before returning to user
+ *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
+ *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
+ */
+#define TIF_SIGPENDING		1
+#define TIF_NEED_RESCHED	2
+#define TIF_SINGLESTEP		3
+#define TIF_NOTIFY_RESUME	4	/* callback before returning to user */
+#define TIF_SYSCALL_TRACE	8
+#define TIF_USEDFPU             16
+#define TIF_POLLING_NRFLAG	17
+#define TIF_MEMDIE		18
+#define TIF_FREEZE		19
+#define TIF_RESTORE_SIGMASK	20
+
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
+#define _TIF_FREEZE		(1 << TIF_FREEZE)
+#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
+
+/*
+ * Change these and you break ASM code in entry-common.S
+ */
+#define _TIF_WORK_MASK		0x000000ff
+#define _TIF_WORK_SYSCALL_ENTRY (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)
+#define _TIF_WORK_SYSCALL_LEAVE (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_NDS32_THREAD_INFO_H */
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
new file mode 100644
index 0000000..b68cfc4
--- /dev/null
+++ b/arch/nds32/kernel/process.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/delay.h>
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
+#include <asm/elf.h>
+#include <asm/proc-fns.h>
+#include <linux/ptrace.h>
+
+extern void setup_mm_for_reboot(char mode);
+#ifdef CONFIG_PROC_FS
+struct proc_dir_entry *proc_dir_cpu;
+EXPORT_SYMBOL(proc_dir_cpu);
+#endif
+
+extern inline void arch_reset(char mode)
+{
+	if (mode == 's') {
+		/* Use cpu handler, jump to 0 */
+		cpu_reset(0);
+	}
+}
+
+void (*pm_power_off) (void);
+EXPORT_SYMBOL(pm_power_off);
+
+static char reboot_mode = 'h';
+
+int __init reboot_setup(char *str)
+{
+	reboot_mode = str[0];
+	return 1;
+}
+
+static int cpub_pwroff(void)
+{
+	return 0;
+}
+
+__setup("reboot=", reboot_setup);
+
+void machine_halt(void)
+{
+	cpub_pwroff();
+}
+
+EXPORT_SYMBOL(machine_halt);
+
+void machine_power_off(void)
+{
+	if (pm_power_off)
+		pm_power_off();
+}
+
+EXPORT_SYMBOL(machine_power_off);
+
+void machine_restart(char *__unused)
+{
+	/*
+	 * Clean and disable cache, and turn off interrupts
+	 */
+	cpu_proc_fin();
+
+	/*
+	 * Tell the mm system that we are going to reboot -
+	 * we may need it to insert some 1:1 mappings so that
+	 * soft boot works.
+	 */
+	setup_mm_for_reboot(reboot_mode);
+
+	/*
+	 * Now call the architecture specific reboot code.
+	 */
+	arch_reset(reboot_mode);
+
+	/*
+	 * Whoops - the architecture was unable to reboot.
+	 * Tell the user!
+	 */
+	mdelay(1000);
+	pr_info("Reboot failed -- System halted\n");
+	while (1) ;
+}
+
+EXPORT_SYMBOL(machine_restart);
+
+void show_regs(struct pt_regs *regs)
+{
+	print_symbol("PC is at %s\n", instruction_pointer(regs));
+	print_symbol("LP is at %s\n", regs->lp);
+	pr_info("pc : [<%08lx>]    lp : [<%08lx>]    %s\n"
+		"sp : %08lx  fp : %08lx  gp : %08lx\n",
+		instruction_pointer(regs),
+		regs->lp, print_tainted(), regs->sp, regs->fp, regs->gp);
+	pr_info("r25: %08lx  r24: %08lx\n", regs->uregs[25], regs->uregs[24]);
+
+	pr_info("r23: %08lx  r22: %08lx  r21: %08lx  r20: %08lx\n",
+		regs->uregs[23], regs->uregs[22],
+		regs->uregs[21], regs->uregs[20]);
+	pr_info("r19: %08lx  r18: %08lx  r17: %08lx  r16: %08lx\n",
+		regs->uregs[19], regs->uregs[18],
+		regs->uregs[17], regs->uregs[16]);
+	pr_info("r15: %08lx  r14: %08lx  r13: %08lx  r12: %08lx\n",
+		regs->uregs[15], regs->uregs[14],
+		regs->uregs[13], regs->uregs[12]);
+	pr_info("r11: %08lx  r10: %08lx  r9 : %08lx  r8 : %08lx\n",
+		regs->uregs[11], regs->uregs[10],
+		regs->uregs[9], regs->uregs[8]);
+	pr_info("r7 : %08lx  r6 : %08lx  r5 : %08lx  r4 : %08lx\n",
+		regs->uregs[7], regs->uregs[6], regs->uregs[5], regs->uregs[4]);
+	pr_info("r3 : %08lx  r2 : %08lx  r1 : %08lx  r0 : %08lx\n",
+		regs->uregs[3], regs->uregs[2], regs->uregs[1], regs->uregs[0]);
+	pr_info("  IRQs o%s  Segment %s\n",
+		interrupts_enabled(regs) ? "n" : "ff",
+		segment_eq(get_fs(), get_ds())? "kernel" : "user");
+}
+
+EXPORT_SYMBOL(show_regs);
+
+void flush_thread(void)
+{
+}
+
+DEFINE_PER_CPU(struct task_struct *, __entry_task);
+
+asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
+int copy_thread(unsigned long clone_flags, unsigned long stack_start,
+	    unsigned long stk_sz, struct task_struct *p)
+{
+	struct pt_regs *childregs = task_pt_regs(p);
+
+	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
+
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		memset(childregs, 0, sizeof(struct pt_regs));
+		/* kernel thread fn */
+		p->thread.cpu_context.r6 = stack_start;
+		/* kernel thread argument */
+		p->thread.cpu_context.r7 = stk_sz;
+	} else {
+		*childregs = *current_pt_regs();
+		if (stack_start)
+			childregs->sp = stack_start;
+		/* child get zero as ret. */
+		childregs->uregs[0] = 0;
+		childregs->osp = 0;
+		if (clone_flags & CLONE_SETTLS)
+			childregs->uregs[25] = childregs->uregs[3];
+	}
+	/* cpu context switching  */
+	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
+	p->thread.cpu_context.sp = (unsigned long)childregs;
+
+#ifdef CONFIG_HWZOL
+	childregs->lb = 0;
+	childregs->le = 0;
+	childregs->lc = 0;
+#endif
+
+	return 0;
+}
+
+/*
+ * fill in the fpe structure for a core dump...
+ */
+int dump_fpu(struct pt_regs *regs, elf_fpregset_t * fpu)
+{
+	int fpvalid = 0;
+	return fpvalid;
+}
+
+EXPORT_SYMBOL(dump_fpu);
+
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long fp, lr;
+	unsigned long stack_start, stack_end;
+	int count = 0;
+
+	if (!p || p == current || p->state == TASK_RUNNING)
+		return 0;
+
+	if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
+		stack_start = (unsigned long)end_of_stack(p);
+		stack_end = (unsigned long)task_stack_page(p) + THREAD_SIZE;
+
+		fp = thread_saved_fp(p);
+		do {
+			if (fp < stack_start || fp > stack_end)
+				return 0;
+			lr = ((unsigned long *)fp)[0];
+			if (!in_sched_functions(lr))
+				return lr;
+			fp = *(unsigned long *)(fp + 4);
+		} while (count++ < 16);
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(get_wchan);
-- 
1.7.9.5
