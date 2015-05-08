From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 10/19] h8300: Process and signal
Date: Sat,  9 May 2015 00:04:30 +0900
Message-ID: <1431097479-21101-11-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/process.c | 171 +++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/ptrace.c  | 203 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 374 insertions(+)
 create mode 100644 arch/h8300/kernel/process.c
 create mode 100644 arch/h8300/kernel/ptrace.c

diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
new file mode 100644
index 0000000..dee4125
--- /dev/null
+++ b/arch/h8300/kernel/process.c
@@ -0,0 +1,171 @@
+/*
+ *  linux/arch/h8300/kernel/process.c
+ *
+ * Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ *  Based on:
+ *
+ *  linux/arch/m68knommu/kernel/process.c
+ *
+ *  Copyright (C) 1998  D. Jeff Dionne <jeff@ryeham.ee.ryerson.ca>,
+ *                      Kenneth Albanowski <kjahds@kjahds.com>,
+ *                      The Silver Hammer Group, Ltd.
+ *
+ *  linux/arch/m68k/kernel/process.c
+ *
+ *  Copyright (C) 1995  Hamish Macdonald
+ *
+ *  68060 fixes by Jesper Skov
+ */
+
+/*
+ * This file handles the architecture-dependent parts of process handling..
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/user.h>
+#include <linux/interrupt.h>
+#include <linux/reboot.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/rcupdate.h>
+
+#include <asm/uaccess.h>
+#include <asm/traps.h>
+#include <asm/setup.h>
+#include <asm/pgtable.h>
+
+void (*pm_power_off)(void) = NULL;
+EXPORT_SYMBOL(pm_power_off);
+
+asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_kernel_thread(void);
+
+/*
+ * The idle loop on an H8/300..
+ */
+void arch_cpu_idle(void)
+{
+	local_irq_enable();
+	__asm__("sleep");
+}
+
+void machine_restart(char *__unused)
+{
+	local_irq_disable();
+	__asm__("jmp @@0");
+}
+
+void machine_halt(void)
+{
+	local_irq_disable();
+	__asm__("sleep");
+	for (;;)
+		;
+}
+
+void machine_power_off(void)
+{
+	local_irq_disable();
+	__asm__("sleep");
+	for (;;)
+		;
+}
+
+void show_regs(struct pt_regs *regs)
+{
+	show_regs_print_info(KERN_DEFAULT);
+
+	pr_notice("\n");
+	pr_notice("PC: %08lx  Status: %02x\n",
+	       regs->pc, regs->ccr);
+	pr_notice("ORIG_ER0: %08lx ER0: %08lx ER1: %08lx\n",
+	       regs->orig_er0, regs->er0, regs->er1);
+	pr_notice("ER2: %08lx ER3: %08lx ER4: %08lx ER5: %08lx\n",
+	       regs->er2, regs->er3, regs->er4, regs->er5);
+	pr_notice("ER6' %08lx ", regs->er6);
+	if (user_mode(regs))
+		printk("USP: %08lx\n", rdusp());
+	else
+		printk("\n");
+}
+
+void flush_thread(void)
+{
+}
+
+int copy_thread(unsigned long clone_flags,
+		unsigned long usp, unsigned long topstk,
+		struct task_struct *p)
+{
+	struct pt_regs *childregs;
+
+	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
+
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		memset(childregs, 0, sizeof(struct pt_regs));
+		childregs->retpc = (unsigned long) ret_from_kernel_thread;
+		childregs->er4 = topstk; /* arg */
+		childregs->er5 = usp; /* fn */
+	}  else {
+		*childregs = *current_pt_regs();
+		childregs->er0 = 0;
+		childregs->retpc = (unsigned long) ret_from_fork;
+		p->thread.usp = usp ?: rdusp();
+	}
+	p->thread.ksp = (unsigned long)childregs;
+
+	return 0;
+}
+
+unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+	return ((struct pt_regs *)tsk->thread.esp0)->pc;
+}
+
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long fp, pc;
+	unsigned long stack_page;
+	int count = 0;
+
+	if (!p || p == current || p->state == TASK_RUNNING)
+		return 0;
+
+	stack_page = (unsigned long)p;
+	fp = ((struct pt_regs *)p->thread.ksp)->er6;
+	do {
+		if (fp < stack_page+sizeof(struct thread_info) ||
+		    fp >= 8184+stack_page)
+			return 0;
+		pc = ((unsigned long *)fp)[1];
+		if (!in_sched_functions(pc))
+			return pc;
+		fp = *(unsigned long *) fp;
+	} while (count++ < 16);
+	return 0;
+}
+
+/* generic sys_clone is not enough registers */
+asmlinkage int sys_clone(unsigned long __user *args)
+{
+	unsigned long clone_flags;
+	unsigned long  newsp;
+	uintptr_t parent_tidptr;
+	uintptr_t child_tidptr;
+
+	get_user(clone_flags, &args[0]);
+	get_user(newsp, &args[1]);
+	get_user(parent_tidptr, &args[2]);
+	get_user(child_tidptr, &args[3]);
+	return do_fork(clone_flags, newsp, 0,
+		       (int __user *)parent_tidptr, (int __user *)child_tidptr);
+}
diff --git a/arch/h8300/kernel/ptrace.c b/arch/h8300/kernel/ptrace.c
new file mode 100644
index 0000000..9207554
--- /dev/null
+++ b/arch/h8300/kernel/ptrace.c
@@ -0,0 +1,203 @@
+/*
+ *  linux/arch/h8300/kernel/ptrace.c
+ *
+ *  Copyright 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of
+ * this archive for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/audit.h>
+#include <linux/tracehook.h>
+#include <linux/regset.h>
+#include <linux/elf.h>
+
+#define CCR_MASK 0x6f    /* mode/imask not set */
+#define EXR_MASK 0x80    /* modify only T */
+
+#define PT_REG(r) offsetof(struct pt_regs, r)
+
+extern void user_disable_single_step(struct task_struct *child);
+
+/* Mapping from PT_xxx to the stack offset at which the register is
+   saved.  Notice that usp has no stack-slot and needs to be treated
+   specially (see get_reg/put_reg below). */
+static const int register_offset[] = {
+	PT_REG(er1), PT_REG(er2), PT_REG(er3), PT_REG(er4),
+	PT_REG(er5), PT_REG(er6), PT_REG(er0), -1,
+	PT_REG(orig_er0), PT_REG(ccr), PT_REG(pc),
+#if defined(CONFIG_CPU_H8S)
+	PT_REG(exr),
+#endif
+};
+
+/* read register */
+long h8300_get_reg(struct task_struct *task, int regno)
+{
+	switch (regno) {
+	case PT_USP:
+		return task->thread.usp + sizeof(long)*2;
+	case PT_CCR:
+	case PT_EXR:
+	    return *(unsigned short *)(task->thread.esp0 +
+				       register_offset[regno]);
+	default:
+	    return *(unsigned long *)(task->thread.esp0 +
+				      register_offset[regno]);
+	}
+}
+
+int h8300_put_reg(struct task_struct *task, int regno, unsigned long data)
+{
+	unsigned short oldccr;
+	unsigned short oldexr;
+
+	switch (regno) {
+	case PT_USP:
+		task->thread.usp = data - sizeof(long)*2;
+	case PT_CCR:
+		oldccr = *(unsigned short *)(task->thread.esp0 +
+					     register_offset[regno]);
+		oldccr &= ~CCR_MASK;
+		data &= CCR_MASK;
+		data |= oldccr;
+		*(unsigned short *)(task->thread.esp0 +
+				    register_offset[regno]) = data;
+		break;
+	case PT_EXR:
+		oldexr = *(unsigned short *)(task->thread.esp0 +
+					     register_offset[regno]);
+		oldccr &= ~EXR_MASK;
+		data &= EXR_MASK;
+		data |= oldexr;
+		*(unsigned short *)(task->thread.esp0 +
+				    register_offset[regno]) = data;
+		break;
+	default:
+		*(unsigned long *)(task->thread.esp0 +
+				   register_offset[regno]) = data;
+		break;
+	}
+	return 0;
+}
+
+static int regs_get(struct task_struct *target,
+		    const struct user_regset *regset,
+		    unsigned int pos, unsigned int count,
+		    void *kbuf, void __user *ubuf)
+{
+	int r;
+	struct user_regs_struct regs;
+	long *reg = (long *)&regs;
+
+	/* build user regs in buffer */
+	for (r = 0; r < ARRAY_SIZE(register_offset); r++)
+		*reg++ = h8300_get_reg(target, r);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &regs, 0, sizeof(regs));
+}
+
+static int regs_set(struct task_struct *target,
+		    const struct user_regset *regset,
+		    unsigned int pos, unsigned int count,
+		    const void *kbuf, const void __user *ubuf)
+{
+	int r;
+	int ret;
+	struct user_regs_struct regs;
+	long *reg;
+
+	/* build user regs in buffer */
+	for (reg = (long *)&regs, r = 0; r < ARRAY_SIZE(register_offset); r++)
+		*reg++ = h8300_get_reg(target, r);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &regs, 0, sizeof(regs));
+	if (ret)
+		return ret;
+
+	/* write back to pt_regs */
+	for (reg = (long *)&regs, r = 0; r < ARRAY_SIZE(register_offset); r++)
+		h8300_put_reg(target, r, *reg++);
+	return 0;
+}
+
+enum h8300_regset {
+	REGSET_GENERAL,
+};
+
+static const struct user_regset h8300_regsets[] = {
+	[REGSET_GENERAL] = {
+		.core_note_type	= NT_PRSTATUS,
+		.n		= ELF_NGREG,
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.get		= regs_get,
+		.set		= regs_set,
+	},
+};
+
+static const struct user_regset_view user_h8300_native_view = {
+	.name = "h8300",
+	.e_machine = EM_H8_300,
+	.regsets = h8300_regsets,
+	.n = ARRAY_SIZE(h8300_regsets),
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_h8300_native_view;
+}
+
+void ptrace_disable(struct task_struct *child)
+{
+	user_disable_single_step(child);
+}
+
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
+{
+	int ret;
+
+	switch (request) {
+	default:
+		ret = ptrace_request(child, request, addr, data);
+		break;
+	}
+	return ret;
+}
+
+asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
+{
+	long ret = 0;
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall_entry(regs))
+		/*
+		 * Tracing decided this syscall should not happen.
+		 * We'll return a bogus call number to get an ENOSYS
+		 * error, but leave the original number in regs->regs[0].
+		 */
+		ret = -1L;
+
+	audit_syscall_entry(regs->er1, regs->er2, regs->er3,
+			    regs->er4, regs->er5);
+
+	return ret ?: regs->er0;
+}
+
+asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
+{
+	int step;
+
+	audit_syscall_exit(regs);
+
+	step = test_thread_flag(TIF_SINGLESTEP);
+	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, step);
+}
-- 
2.1.4
