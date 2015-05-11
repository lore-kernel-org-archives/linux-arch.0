From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v12 12/21] h8300: process helpers
Date: Mon, 11 May 2015 15:26:31 +0900
Message-ID: <1431325600-12333-13-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/process.c  | 171 +++++++++++++++++++++++++++++
 arch/h8300/kernel/ptrace.c   | 203 ++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/ptrace_h.c | 256 +++++++++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/ptrace_s.c |  44 ++++++++
 4 files changed, 674 insertions(+)
 create mode 100644 arch/h8300/kernel/process.c
 create mode 100644 arch/h8300/kernel/ptrace.c
 create mode 100644 arch/h8300/kernel/ptrace_h.c
 create mode 100644 arch/h8300/kernel/ptrace_s.c

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
diff --git a/arch/h8300/kernel/ptrace_h.c b/arch/h8300/kernel/ptrace_h.c
new file mode 100644
index 0000000..fe3b567
--- /dev/null
+++ b/arch/h8300/kernel/ptrace_h.c
@@ -0,0 +1,256 @@
+/*
+ *    ptrace cpu depend helper functions
+ *
+ *  Copyright 2003, 2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of
+ * this archive for more details.
+ */
+
+#include <linux/linkage.h>
+#include <linux/sched.h>
+#include <asm/ptrace.h>
+
+#define BREAKINST 0x5730 /* trapa #3 */
+
+/* disable singlestep */
+void user_disable_single_step(struct task_struct *child)
+{
+	if ((long)child->thread.breakinfo.addr != -1L) {
+		*(child->thread.breakinfo.addr) = child->thread.breakinfo.inst;
+		child->thread.breakinfo.addr = (unsigned short *)-1L;
+	}
+}
+
+/* calculate next pc */
+enum jump_type {none,	 /* normal instruction */
+		jabs,	 /* absolute address jump */
+		ind,	 /* indirect address jump */
+		ret,	 /* return to subrutine */
+		reg,	 /* register indexed jump */
+		relb,	 /* pc relative jump (byte offset) */
+		relw,	 /* pc relative jump (word offset) */
+	       };
+
+/* opcode decode table define
+   ptn: opcode pattern
+   msk: opcode bitmask
+   len: instruction length (<0 next table index)
+   jmp: jump operation mode */
+struct optable {
+	unsigned char bitpattern;
+	unsigned char bitmask;
+	signed char length;
+	signed char type;
+} __packed __aligned(1);
+
+#define OPTABLE(ptn, msk, len, jmp)	\
+	{				\
+		.bitpattern = ptn,	\
+		.bitmask    = msk,	\
+		.length	    = len,	\
+		.type	    = jmp,	\
+	}
+
+static const struct optable optable_0[] = {
+	OPTABLE(0x00, 0xff,  1, none), /* 0x00 */
+	OPTABLE(0x01, 0xff, -1, none), /* 0x01 */
+	OPTABLE(0x02, 0xfe,  1, none), /* 0x02-0x03 */
+	OPTABLE(0x04, 0xee,  1, none), /* 0x04-0x05/0x14-0x15 */
+	OPTABLE(0x06, 0xfe,  1, none), /* 0x06-0x07 */
+	OPTABLE(0x08, 0xea,  1, none), /* 0x08-0x09/0x0c-0x0d/0x18-0x19/0x1c-0x1d */
+	OPTABLE(0x0a, 0xee,  1, none), /* 0x0a-0x0b/0x1a-0x1b */
+	OPTABLE(0x0e, 0xee,  1, none), /* 0x0e-0x0f/0x1e-0x1f */
+	OPTABLE(0x10, 0xfc,  1, none), /* 0x10-0x13 */
+	OPTABLE(0x16, 0xfe,  1, none), /* 0x16-0x17 */
+	OPTABLE(0x20, 0xe0,  1, none), /* 0x20-0x3f */
+	OPTABLE(0x40, 0xf0,  1, relb), /* 0x40-0x4f */
+	OPTABLE(0x50, 0xfc,  1, none), /* 0x50-0x53 */
+	OPTABLE(0x54, 0xfd,  1, ret), /* 0x54/0x56 */
+	OPTABLE(0x55, 0xff,  1, relb), /* 0x55 */
+	OPTABLE(0x57, 0xff,  1, none), /* 0x57 */
+	OPTABLE(0x58, 0xfb,  2, relw), /* 0x58/0x5c */
+	OPTABLE(0x59, 0xfb,  1, reg), /* 0x59/0x5b */
+	OPTABLE(0x5a, 0xfb,  2, jabs), /* 0x5a/0x5e */
+	OPTABLE(0x5b, 0xfb,  2, ind), /* 0x5b/0x5f */
+	OPTABLE(0x60, 0xe8,  1, none), /* 0x60-0x67/0x70-0x77 */
+	OPTABLE(0x68, 0xfa,  1, none), /* 0x68-0x69/0x6c-0x6d */
+	OPTABLE(0x6a, 0xfe, -2, none), /* 0x6a-0x6b */
+	OPTABLE(0x6e, 0xfe,  2, none), /* 0x6e-0x6f */
+	OPTABLE(0x78, 0xff,  4, none), /* 0x78 */
+	OPTABLE(0x79, 0xff,  2, none), /* 0x79 */
+	OPTABLE(0x7a, 0xff,  3, none), /* 0x7a */
+	OPTABLE(0x7b, 0xff,  2, none), /* 0x7b */
+	OPTABLE(0x7c, 0xfc,  2, none), /* 0x7c-0x7f */
+	OPTABLE(0x80, 0x80,  1, none), /* 0x80-0xff */
+};
+
+static const struct optable optable_1[] = {
+	OPTABLE(0x00, 0xff, -3, none), /* 0x0100 */
+	OPTABLE(0x40, 0xf0, -3, none), /* 0x0140-0x14f */
+	OPTABLE(0x80, 0xf0,  1, none), /* 0x0180-0x018f */
+	OPTABLE(0xc0, 0xc0,  2, none), /* 0x01c0-0x01ff */
+};
+
+static const struct optable optable_2[] = {
+	OPTABLE(0x00, 0x20,  2, none), /* 0x6a0?/0x6a8?/0x6b0?/0x6b8? */
+	OPTABLE(0x20, 0x20,  3, none), /* 0x6a2?/0x6aa?/0x6b2?/0x6ba? */
+};
+
+static const struct optable optable_3[] = {
+	OPTABLE(0x69, 0xfb,  2, none), /* 0x010069/0x01006d/014069/0x01406d */
+	OPTABLE(0x6b, 0xff, -4, none), /* 0x01006b/0x01406b */
+	OPTABLE(0x6f, 0xff,  3, none), /* 0x01006f/0x01406f */
+	OPTABLE(0x78, 0xff,  5, none), /* 0x010078/0x014078 */
+};
+
+static const struct optable optable_4[] = {
+/* 0x0100690?/0x01006d0?/0140690?/0x01406d0?/
+   0x0100698?/0x01006d8?/0140698?/0x01406d8? */
+	OPTABLE(0x00, 0x78, 3, none),
+/* 0x0100692?/0x01006d2?/0140692?/0x01406d2?/
+   0x010069a?/0x01006da?/014069a?/0x01406da? */
+	OPTABLE(0x20, 0x78, 4, none),
+};
+
+static const struct optables_list {
+	const struct optable *ptr;
+	int size;
+} optables[] = {
+#define OPTABLES(no)                                                   \
+	{                                                              \
+		.ptr  = optable_##no,                                  \
+		.size = sizeof(optable_##no) / sizeof(struct optable), \
+	}
+	OPTABLES(0),
+	OPTABLES(1),
+	OPTABLES(2),
+	OPTABLES(3),
+	OPTABLES(4),
+
+};
+
+const unsigned char condmask[] = {
+	0x00, 0x40, 0x01, 0x04, 0x02, 0x08, 0x10, 0x20
+};
+
+static int isbranch(struct task_struct *task, int reson)
+{
+	unsigned char cond = h8300_get_reg(task, PT_CCR);
+
+	/* encode complex conditions */
+	/* B4: N^V
+	   B5: Z|(N^V)
+	   B6: C|Z */
+	__asm__("bld #3,%w0\n\t"
+		"bxor #1,%w0\n\t"
+		"bst #4,%w0\n\t"
+		"bor #2,%w0\n\t"
+		"bst #5,%w0\n\t"
+		"bld #2,%w0\n\t"
+		"bor #0,%w0\n\t"
+		"bst #6,%w0\n\t"
+		: "=&r"(cond) : "0"(cond) : "cc");
+	cond &= condmask[reson >> 1];
+	if (!(reson & 1))
+		return cond == 0;
+	else
+		return cond != 0;
+}
+
+static unsigned short *decode(struct task_struct *child,
+			      const struct optable *op,
+			      char *fetch_p, unsigned short *pc,
+			      unsigned char inst)
+{
+	unsigned long addr;
+	unsigned long *sp;
+	int regno;
+
+	switch (op->type) {
+	case none:
+		return (unsigned short *)pc + op->length;
+	case jabs:
+		addr = *(unsigned long *)pc;
+		return (unsigned short *)(addr & 0x00ffffff);
+	case ind:
+		addr = *pc & 0xff;
+		return (unsigned short *)(*(unsigned long *)addr);
+	case ret:
+		sp = (unsigned long *)h8300_get_reg(child, PT_USP);
+		/* user stack frames
+		   |   er0  | temporary saved
+		   +--------+
+		   |   exp  | exception stack frames
+		   +--------+
+		   | ret pc | userspace return address
+		*/
+		return (unsigned short *)(*(sp+2) & 0x00ffffff);
+	case reg:
+		regno = (*pc >> 4) & 0x07;
+		if (regno == 0)
+			addr = h8300_get_reg(child, PT_ER0);
+		else
+			addr = h8300_get_reg(child, regno-1 + PT_ER1);
+		return (unsigned short *)addr;
+	case relb:
+		if (inst == 0x55 || isbranch(child, inst & 0x0f))
+			pc = (unsigned short *)((unsigned long)pc +
+						((signed char)(*fetch_p)));
+		return pc+1; /* skip myself */
+	case relw:
+		if (inst == 0x5c || isbranch(child, (*fetch_p & 0xf0) >> 4))
+			pc = (unsigned short *)((unsigned long)pc +
+						((signed short)(*(pc+1))));
+		return pc+2; /* skip myself */
+	default:
+		return NULL;
+	}
+}
+
+static unsigned short *nextpc(struct task_struct *child, unsigned short *pc)
+{
+	const struct optable *op;
+	unsigned char *fetch_p;
+	int op_len;
+	unsigned char inst;
+
+	op = optables[0].ptr;
+	op_len = optables[0].size;
+	fetch_p = (unsigned char *)pc;
+	inst = *fetch_p++;
+	do {
+		if ((inst & op->bitmask) == op->bitpattern) {
+			if (op->length < 0) {
+				op = optables[-op->length].ptr;
+				op_len = optables[-op->length].size + 1;
+				inst = *fetch_p++;
+			} else
+				return decode(child, op, fetch_p, pc, inst);
+		} else
+			op++;
+	} while (--op_len > 0);
+	return NULL;
+}
+
+/* Set breakpoint(s) to simulate a single step from the current PC.  */
+
+void user_enable_single_step(struct task_struct *child)
+{
+	unsigned short *next;
+
+	next = nextpc(child, (unsigned short *)h8300_get_reg(child, PT_PC));
+	child->thread.breakinfo.addr = next;
+	child->thread.breakinfo.inst = *next;
+	*next = BREAKINST;
+}
+
+asmlinkage void trace_trap(unsigned long bp)
+{
+	if ((unsigned long)current->thread.breakinfo.addr == bp) {
+		user_disable_single_step(current);
+		force_sig(SIGTRAP, current);
+	} else
+		force_sig(SIGILL, current);
+}
diff --git a/arch/h8300/kernel/ptrace_s.c b/arch/h8300/kernel/ptrace_s.c
new file mode 100644
index 0000000..ef5a9c1
--- /dev/null
+++ b/arch/h8300/kernel/ptrace_s.c
@@ -0,0 +1,44 @@
+/*
+ *  linux/arch/h8300/kernel/ptrace_h8s.c
+ *    ptrace cpu depend helper functions
+ *
+ *  Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of
+ * this archive for more details.
+ */
+
+#include <linux/linkage.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <asm/ptrace.h>
+
+#define CCR_MASK  0x6f
+#define EXR_TRACE 0x80
+
+/* disable singlestep */
+void user_disable_single_step(struct task_struct *child)
+{
+	unsigned char exr;
+
+	exr = h8300_get_reg(child, PT_EXR);
+	exr &= ~EXR_TRACE;
+	h8300_put_reg(child, PT_EXR, exr);
+}
+
+/* enable singlestep */
+void user_enable_single_step(struct task_struct *child)
+{
+	unsigned char exr;
+
+	exr = h8300_get_reg(child, PT_EXR);
+	exr |= EXR_TRACE;
+	h8300_put_reg(child, PT_EXR, exr);
+}
+
+asmlinkage void trace_trap(unsigned long bp)
+{
+	(void)bp;
+	force_sig(SIGTRAP, current);
+}
-- 
2.1.4
