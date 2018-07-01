From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 15/19] csky: Debug and Ptrace GDB
Date: Mon,  2 Jul 2018 01:30:18 +0800
Message-ID: <dacbcbeee9dd0370a91414ed453a10ee6c3099fe.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/uapi/asm/ptrace.h | 105 +++++++++++++
 arch/csky/kernel/dumpstack.c        |  65 ++++++++
 arch/csky/kernel/ptrace.c           | 288 ++++++++++++++++++++++++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 arch/csky/include/uapi/asm/ptrace.h
 create mode 100644 arch/csky/kernel/dumpstack.c
 create mode 100644 arch/csky/kernel/ptrace.c

diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
new file mode 100644
index 0000000..f5228dd
--- /dev/null
+++ b/arch/csky/include/uapi/asm/ptrace.h
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef _CSKY_PTRACE_H
+#define _CSKY_PTRACE_H
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	unsigned long	tls;
+	unsigned long	lr;
+	unsigned long	pc;
+	unsigned long	sr;
+	unsigned long	usp;
+
+	/*
+	 * a0, a1, a2, a3:
+	 * abiv1: r2, r3, r4, r5
+	 * abiv2: r0, r1, r2, r3
+	 */
+	unsigned long	orig_a0;
+	unsigned long	a0;
+	unsigned long	a1;
+	unsigned long	a2;
+	unsigned long	a3;
+
+	/*
+	 * ABIV2: r4 ~ r13
+	 * ABIV1: r6 ~ r14, r1
+	 */
+	unsigned long	regs[10];
+
+#if defined(__CSKYABIV2__)
+	/* r16 ~ r30 */
+	unsigned long	exregs[15];
+
+	unsigned long	rhi;
+	unsigned long	rlo;
+	unsigned long	pad; /* reserved */
+#endif
+};
+
+struct user_fp {
+	unsigned long	vr[64];
+	unsigned long	fcr;
+	unsigned long	fesr;
+	unsigned long	fid;
+	unsigned long	reserved;
+};
+
+/*
+ * Switch stack for switch_to after push pt_regs.
+ *
+ * ABI_CSKYV2: r4 ~ r11, r15 ~ r17, r26 ~ r30;
+ * ABI_CSKYV1: r8 ~ r14, r15;
+ */
+struct  switch_stack {
+#if defined(__CSKYABIV2__)
+	unsigned long   r4;
+        unsigned long   r5;
+        unsigned long   r6;
+        unsigned long   r7;
+	unsigned long   r8;
+        unsigned long   r9;
+        unsigned long   r10;
+        unsigned long   r11;
+#else
+	unsigned long   r8;
+        unsigned long   r9;
+        unsigned long   r10;
+        unsigned long   r11;
+        unsigned long   r12;
+        unsigned long   r13;
+        unsigned long   r14;
+#endif
+        unsigned long   r15;
+#if defined(__CSKYABIV2__)
+        unsigned long   r16;
+        unsigned long   r17;
+        unsigned long   r26;
+        unsigned long   r27;
+        unsigned long   r28;
+        unsigned long   r29;
+        unsigned long   r30;
+#endif
+};
+
+#ifdef __KERNEL__
+
+#define PS_S            0x80000000              /* Supervisor Mode */
+
+#define arch_has_single_step() (1)
+#define current_pt_regs() \
+	(struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1
+
+#define user_stack_pointer(regs) ((regs)->usp)
+
+#define user_mode(regs) (!((regs)->sr & PS_S))
+#define instruction_pointer(regs) ((regs)->pc)
+#define profile_pc(regs) instruction_pointer(regs)
+
+void show_regs(struct pt_regs *);
+
+#endif /* __KERNEL__ */
+#endif /* __ASSEMBLY__ */
+#endif /* _CSKY_PTRACE_H */
diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
new file mode 100644
index 0000000..d4be08a
--- /dev/null
+++ b/arch/csky/kernel/dumpstack.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/ptrace.h>
+
+int kstack_depth_to_print = 48;
+
+void show_trace(unsigned long *stack)
+{
+	unsigned long *endstack;
+	unsigned long addr;
+	int i;
+
+	pr_info("Call Trace:");
+	addr = (unsigned long)stack + THREAD_SIZE - 1;
+	endstack = (unsigned long *)(addr & -THREAD_SIZE);
+	i = 0;
+	while (stack + 1 <= endstack) {
+		addr = *stack++;
+		/*
+		 * If the address is either in the text segment of the
+		 * kernel, or in the region which contains vmalloc'ed
+		 * memory, it *may* be the address of a calling
+		 * routine; if so, print it so that someone tracing
+		 * down the cause of the crash will be able to figure
+		 * out the call path that was taken.
+		 */
+		if (__kernel_text_address(addr)) {
+#ifndef CONFIG_KALLSYMS
+			if (i % 5 == 0)
+				pr_cont("\n       ");
+#endif
+			pr_cont(" [<%08lx>] %pS\n", addr, (void *)addr);
+			i++;
+		}
+	}
+	pr_cont("\n");
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	unsigned long *p;
+	unsigned long *endstack;
+	int i;
+
+	if (!stack) {
+		if (task)
+			stack = (unsigned long *)task->thread.esp0;
+		else
+			stack = (unsigned long *)&stack;
+	}
+	endstack = (unsigned long *)(((unsigned long)stack + THREAD_SIZE - 1) & -THREAD_SIZE);
+
+	pr_info("Stack from %08lx:", (unsigned long)stack);
+	p = stack;
+	for (i = 0; i < kstack_depth_to_print; i++) {
+		if (p + 1 > endstack)
+			break;
+		if (i % 8 == 0)
+			pr_cont("\n       ");
+		pr_cont(" %08lx", *p++);
+	}
+	pr_cont("\n");
+	show_trace(stack);
+}
+
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
new file mode 100644
index 0000000..eeaebfe
--- /dev/null
+++ b/arch/csky/kernel/ptrace.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/elf.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/ptrace.h>
+#include <linux/regset.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/smp.h>
+#include <linux/uaccess.h>
+#include <linux/user.h>
+
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/asm-offsets.h>
+
+#include <abi/regdef.h>
+
+/* sets the trace bits. */
+#define TRACE_MODE_SI      1 << 14
+#define TRACE_MODE_RUN     0
+#define TRACE_MODE_MASK    ~(0x3 << 14)
+
+/*
+ * Make sure the single step bit is not set.
+ */
+static void singlestep_disable(struct task_struct *tsk)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(tsk);
+	regs->sr = (regs->sr & TRACE_MODE_MASK) | TRACE_MODE_RUN;
+}
+
+static void singlestep_enable(struct task_struct *tsk)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(tsk);
+	regs->sr = (regs->sr & TRACE_MODE_MASK) | TRACE_MODE_SI;
+}
+
+/*
+ * Make sure the single step bit is set.
+ */
+void user_enable_single_step(struct task_struct *child)
+{
+	if (child->thread.esp0 == 0) return;
+	singlestep_enable(child);
+}
+
+void user_disable_single_step(struct task_struct *child)
+{
+	if (child->thread.esp0 == 0) return;
+	singlestep_disable(child);
+}
+
+enum csky_regset {
+	REGSET_GPR,
+	REGSET_FPR,
+};
+
+static int gpr_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(target);
+
+	/* Abiv1 regs->tls is fake and we need sync here. */
+	regs->tls = task_thread_info(target)->tp_value;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+}
+
+static int gpr_set(struct task_struct *target,
+		    const struct user_regset *regset,
+		    unsigned int pos, unsigned int count,
+		    const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct pt_regs regs;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0, -1);
+	if (ret)
+		return ret;
+
+	regs.sr = task_pt_regs(target)->sr;
+
+	task_thread_info(target)->tp_value = regs.tls;
+
+	*task_pt_regs(target) = regs;
+
+	return 0;
+}
+
+static int fpr_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	struct user_fp *regs;
+
+	regs = (struct user_fp *)&target->thread.user_fp;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+}
+
+static int fpr_set(struct task_struct *target,
+		    const struct user_regset *regset,
+		    unsigned int pos, unsigned int count,
+		    const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct user_fp *regs;
+
+	regs = (struct user_fp *)&target->thread.user_fp;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+
+	return ret;
+}
+
+static const struct user_regset csky_regsets[] = {
+	[REGSET_GPR] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = ELF_NGREG,
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.get = &gpr_get,
+		.set = &gpr_set,
+	},
+	[REGSET_FPR] = {
+		.core_note_type = NT_PRFPREG,
+		.n = sizeof(struct user_fp) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.get = &fpr_get,
+		.set = &fpr_set,
+	},
+};
+
+static const struct user_regset_view user_csky_view = {
+	.name = "csky",
+	.e_machine = ELF_ARCH,
+	.regsets = csky_regsets,
+	.n = ARRAY_SIZE(csky_regsets),
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_csky_view;
+}
+
+void ptrace_disable(struct task_struct *child)
+{
+	singlestep_disable(child);
+}
+
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
+{
+	long ret = -EIO;
+
+	switch (request) {
+	default:
+		ret = ptrace_request(child, request, addr, data);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * If process's system calls is traces, do some corresponding handles in this
+ * fuction before entering system call function and after exiting system call
+ * fuction.
+ */
+asmlinkage void syscall_trace(int why, struct pt_regs * regs)
+{
+	long saved_why;
+	/*
+	 * Save saved_why, why is used to denote syscall entry/exit;
+	 * why = 0:entry, why = 1: exit
+	 */
+	saved_why = regs->regs[SYSTRACE_SAVENUM];
+	regs->regs[SYSTRACE_SAVENUM] = why;
+
+	/* the 0x80 provides a way for the tracing parent to distinguish
+	   between a syscall stop and SIGTRAP delivery */
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				? 0x80 : 0));
+	/*
+	 * this isn't the same as continuing with a signal, but it will do
+	 * for normal use.  strace only continues with a signal if the
+	 * stopping signal is not SIGTRAP.  -brl
+	 */
+	if (current->exit_code) {
+		send_sig(current->exit_code, current, 1);
+		current->exit_code = 0;
+	}
+
+	regs->regs[SYSTRACE_SAVENUM] = saved_why;
+	return;
+}
+
+void show_regs(struct pt_regs *fp)
+{
+	unsigned long   *sp;
+	unsigned char   *tp;
+	int	i;
+
+	pr_info("\nCURRENT PROCESS:\n\n");
+	pr_info("COMM=%s PID=%d\n", current->comm, current->pid);
+
+	if (current->mm) {
+		pr_info("TEXT=%08x-%08x DATA=%08x-%08x BSS=%08x-%08x\n",
+		       (int) current->mm->start_code,
+		       (int) current->mm->end_code,
+		       (int) current->mm->start_data,
+		       (int) current->mm->end_data,
+		       (int) current->mm->end_data,
+		       (int) current->mm->brk);
+		pr_info("USER-STACK=%08x  KERNEL-STACK=%08x\n\n",
+		       (int) current->mm->start_stack,
+		       (int) (((unsigned long) current) + 2 * PAGE_SIZE));
+	}
+
+	pr_info("PC: 0x%08lx\n", (long)fp->pc);
+	pr_info("orig_a0: 0x%08lx\n", fp->orig_a0);
+	pr_info("PSR: 0x%08lx\n", (long)fp->sr);
+
+	pr_info("a0: 0x%08lx  a1: 0x%08lx  a2: 0x%08lx  a3: 0x%08lx\n",
+	       fp->a0, fp->a1, fp->a2, fp->a3);
+#if defined(__CSKYABIV2__)
+	pr_info("r4: 0x%08lx  r5: 0x%08lx    r6: 0x%08lx    r7: 0x%08lx\n",
+	       fp->regs[0], fp->regs[1], fp->regs[2], fp->regs[3]);
+	pr_info("r8: 0x%08lx  r9: 0x%08lx   r10: 0x%08lx   r11: 0x%08lx\n",
+	       fp->regs[4], fp->regs[5], fp->regs[6], fp->regs[7]);
+	pr_info("r12 0x%08lx  r13: 0x%08lx   r15: 0x%08lx\n",
+	       fp->regs[8], fp->regs[9], fp->lr);
+	pr_info("r16:0x%08lx   r17: 0x%08lx   r18: 0x%08lx    r19: 0x%08lx\n",
+	       fp->exregs[0], fp->exregs[1], fp->exregs[2], fp->exregs[3]);
+	pr_info("r20 0x%08lx   r21: 0x%08lx   r22: 0x%08lx    r23: 0x%08lx\n",
+	       fp->exregs[4], fp->exregs[5], fp->exregs[6], fp->exregs[7]);
+	pr_info("r24 0x%08lx   r25: 0x%08lx   r26: 0x%08lx    r27: 0x%08lx\n",
+	       fp->exregs[8], fp->exregs[9], fp->exregs[10], fp->exregs[11]);
+	pr_info("r28 0x%08lx   r29: 0x%08lx   r30: 0x%08lx    tls: 0x%08lx\n",
+	       fp->exregs[12], fp->exregs[13], fp->exregs[14], fp->tls);
+	pr_info("hi 0x%08lx     lo: 0x%08lx \n",
+	       fp->rhi, fp->rlo);
+#else
+	pr_info("r6: 0x%08lx   r7: 0x%08lx   r8: 0x%08lx   r9: 0x%08lx\n",
+	       fp->regs[0], fp->regs[1], fp->regs[2], fp->regs[3]);
+	pr_info("r10: 0x%08lx   r11: 0x%08lx   r12: 0x%08lx   r13: 0x%08lx\n",
+	       fp->regs[4], fp->regs[5], fp->regs[6], fp->regs[7]);
+	pr_info("r14 0x%08lx   r1: 0x%08lx   r15: 0x%08lx\n",
+	       fp->regs[8], fp->regs[9], fp->lr);
+#endif
+
+	pr_info("\nCODE:");
+	tp = ((unsigned char *) fp->pc) - 0x20;
+	tp += ((int)tp % 4) ? 2 : 0;
+	for (sp = (unsigned long *) tp, i = 0; (i < 0x40);  i += 4) {
+		if ((i % 0x10) == 0)
+			pr_cont("\n%08x: ", (int) (tp + i));
+		pr_cont("%08x ", (int) *sp++);
+	}
+	pr_cont("\n");
+
+	pr_info("\nKERNEL STACK:");
+	tp = ((unsigned char *) fp) - 0x40;
+	for (sp = (unsigned long *) tp, i = 0; (i < 0xc0); i += 4) {
+		if ((i % 0x10) == 0)
+			pr_cont("\n%08x: ", (int) (tp + i));
+		pr_cont("%08x ", (int) *sp++);
+	}
+	pr_cont("\n");
+
+	return;
+}
+
-- 
2.7.4
