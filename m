Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:18139 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbbBOHt4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Feb 2015 02:49:56 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 05/15] h8300: Process and signal
Date: Sun, 15 Feb 2015 16:49:23 +0900
Message-ID: <1423986573-2329-6-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150215074923.ip0r6E_AIRtxmwdcjGu3ii40W0uFUyeHymRoqXLeBpk@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/process.c | 170 +++++++++++++++++++++++
 arch/h8300/kernel/ptrace.c  | 203 +++++++++++++++++++++++++++
 arch/h8300/kernel/signal.c  | 326 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 699 insertions(+)
 create mode 100644 arch/h8300/kernel/process.c
 create mode 100644 arch/h8300/kernel/ptrace.c
 create mode 100644 arch/h8300/kernel/signal.c

diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
new file mode 100644
index 0000000..c0f7511
--- /dev/null
+++ b/arch/h8300/kernel/process.c
@@ -0,0 +1,170 @@
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
+	printk("\nPC: %08lx  Status: %02x",
+	       regs->pc, regs->ccr);
+	printk("\nORIG_ER0: %08lx ER0: %08lx ER1: %08lx",
+	       regs->orig_er0, regs->er0, regs->er1);
+	printk("\nER2: %08lx ER3: %08lx ER4: %08lx ER5: %08lx",
+	       regs->er2, regs->er3, regs->er4, regs->er5);
+	printk("\nER6' %08lx ", regs->er6);
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
index 0000000..d27d00b
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
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
new file mode 100644
index 0000000..1222783
--- /dev/null
+++ b/arch/h8300/kernel/signal.c
@@ -0,0 +1,326 @@
+/*
+ *  linux/arch/h8300/kernel/signal.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+/*
+ * uClinux H8/300 support by Yoshinori Sato <ysato@users.sourceforge.jp>
+ *                and David McCullough <davidm@snapgear.com>
+ *
+ * Based on
+ * Linux/m68k by Hamish Macdonald
+ */
+
+/*
+ * ++roman (07/09/96): implemented signal stacks (specially for tosemu on
+ * Atari :-) Current limitation: Only one sigstack can be active at one time.
+ * If a second signal with SA_ONSTACK set arrives while working on a sigstack,
+ * SA_ONSTACK is ignored. This behaviour avoids lots of trouble with nested
+ * signal handlers!
+ */
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#include <linux/ptrace.h>
+#include <linux/unistd.h>
+#include <linux/stddef.h>
+#include <linux/highuid.h>
+#include <linux/personality.h>
+#include <linux/tty.h>
+#include <linux/binfmts.h>
+#include <linux/tracehook.h>
+
+#include <asm/setup.h>
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+#include <asm/traps.h>
+#include <asm/ucontext.h>
+
+/*
+ * Do a signal return; undo the signal stack.
+ *
+ * Keep the return code on the stack quadword aligned!
+ * That makes the cache flush below easier.
+ */
+
+struct rt_sigframe {
+	long dummy_er0;
+	long dummy_vector;
+#if defined(CONFIG_CPU_H8S)
+	short dummy_exr;
+#endif
+	long dummy_pc;
+	char *pretcode;
+	struct siginfo *pinfo;
+	void *puc;
+	unsigned char retcode[8];
+	struct siginfo info;
+	struct ucontext uc;
+	int sig;
+} __packed __aligned(2);
+
+static inline int
+restore_sigcontext(struct sigcontext *usc, int *pd0)
+{
+	struct pt_regs *regs = current_pt_regs();
+	int err = 0;
+	unsigned int ccr;
+	unsigned int usp;
+	unsigned int er0;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
+#define COPY(r) err |= __get_user(regs->r, &usc->sc_##r)    /* restore passed registers */
+	COPY(er1);
+	COPY(er2);
+	COPY(er3);
+	COPY(er5);
+	COPY(pc);
+	ccr = regs->ccr & 0x10;
+	COPY(ccr);
+#undef COPY
+	regs->ccr &= 0xef;
+	regs->ccr |= ccr;
+	regs->orig_er0 = -1;		/* disable syscall checks */
+	err |= __get_user(usp, &usc->sc_usp);
+	wrusp(usp);
+
+	err |= __get_user(er0, &usc->sc_er0);
+	*pd0 = er0;
+	return err;
+}
+
+asmlinkage int sys_rt_sigreturn(void)
+{
+	unsigned long usp = rdusp();
+	struct rt_sigframe *frame = (struct rt_sigframe *)(usp - 4);
+	sigset_t set;
+	int er0;
+
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (restore_sigcontext(&frame->uc.uc_mcontext, &er0))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return er0;
+
+badframe:
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+static int setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
+			     unsigned long mask)
+{
+	int err = 0;
+
+	err |= __put_user(regs->er0, &sc->sc_er0);
+	err |= __put_user(regs->er1, &sc->sc_er1);
+	err |= __put_user(regs->er2, &sc->sc_er2);
+	err |= __put_user(regs->er3, &sc->sc_er3);
+	err |= __put_user(regs->er4, &sc->sc_er4);
+	err |= __put_user(regs->er5, &sc->sc_er5);
+	err |= __put_user(regs->er6, &sc->sc_er6);
+	err |= __put_user(rdusp(),   &sc->sc_usp);
+	err |= __put_user(regs->pc,  &sc->sc_pc);
+	err |= __put_user(regs->ccr, &sc->sc_ccr);
+	err |= __put_user(mask,      &sc->sc_mask);
+
+	return err;
+}
+
+static inline void *
+get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
+{
+	unsigned long usp;
+
+	/* Default to using normal stack.  */
+	usp = rdusp();
+
+	/* This is the X/Open sanctioned signal stack switching.  */
+	if (ka->sa.sa_flags & SA_ONSTACK) {
+		if (!sas_ss_flags(usp))
+			usp = current->sas_ss_sp + current->sas_ss_size;
+	}
+	return (void *)((usp - frame_size) & -8UL);
+}
+
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
+{
+	struct rt_sigframe *frame;
+	int err = 0;
+	int usig;
+	int sig = ksig->sig;
+	unsigned char *ret;
+
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		return -EFAULT;
+
+	usig = current_thread_info()->exec_domain
+		&& current_thread_info()->exec_domain->signal_invmap
+		&& sig < 32
+		? current_thread_info()->exec_domain->signal_invmap[sig]
+		: sig;
+
+	err |= __put_user(usig, &frame->sig);
+	if (err)
+		return -EFAULT;
+
+	err |= __put_user(&frame->info, &frame->pinfo);
+	err |= __put_user(&frame->uc, &frame->puc);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
+	if (err)
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(0, &frame->uc.uc_link);
+	err |= __save_altstack(&frame->uc.uc_stack, rdusp());
+	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, set->sig[0]);
+	err |= copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	if (err)
+		return -EFAULTl
+
+	/* Set up to return from userspace.  */
+	ret = frame->retcode;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		ret = (unsigned char *)(ksig->ka.sa.sa_restorer);
+	else {
+		/* sub.l er0,er0; mov.b #__NR_rt_sigreturn,r0l; trapa #0 */
+		err |= __put_user(0x1a80f800 + (__NR_rt_sigreturn & 0xff),
+				  (unsigned long *)(frame->retcode + 0));
+		err |= __put_user(0x5700,
+				  (unsigned short *)(frame->retcode + 4));
+	}
+	err |= __put_user(ret, &frame->pretcode);
+
+	if (err)
+		goto give_sigsegv;
+
+	/* Set up registers for signal handler */
+	wrusp((unsigned long) frame);
+	regs->pc  = (unsigned long) ksig->ka.sa.sa_handler;
+	regs->er0 = (current_thread_info()->exec_domain
+		     && current_thread_info()->exec_domain->signal_invmap
+		     && sig < 32
+		     ? current_thread_info()->exec_domain->signal_invmap[sig]
+		     : sig);
+	regs->er1 = (unsigned long)&(frame->info);
+	regs->er2 = (unsigned long)&frame->uc;
+	regs->er5 = current->mm->start_data;	/* GOT base */
+
+	return 0;
+}
+
+static void
+handle_restart(struct pt_regs *regs, struct k_sigaction *ka)
+{
+	switch (regs->er0) {
+	case -ERESTARTNOHAND:
+		if (!ka)
+			goto do_restart;
+		regs->er0 = -EINTR;
+		break;
+	case -ERESTART_RESTARTBLOCK:
+		if (!ka) {
+			regs->er0 = __NR_restart_syscall;
+			regs->pc -= 2;
+		} else
+			regs->er0 = -EINTR;
+		break;
+	case -ERESTARTSYS:
+		if (!(ka->sa.sa_flags & SA_RESTART)) {
+			regs->er0 = -EINTR;
+			break;
+		}
+		/* fallthrough */
+	case -ERESTARTNOINTR:
+do_restart:
+		regs->er0 = regs->orig_er0;
+		regs->pc -= 2;
+		break;
+	}
+}
+
+/*
+ * OK, we're invoking a handler
+ */
+static void
+handle_signal(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *oldset = sigmask_to_save();
+	int ret;
+	/* are we from a system call? */
+	if (regs->orig_er0 >= 0)
+		handle_restart(regs, &ksig->ka);
+
+	ret = setup_rt_frame(ksig, oldset, regs);
+
+	signal_setup_done(ret, ksig, 0);
+}
+
+/*
+ * Note that 'init' is a special process: it doesn't get signals it doesn't
+ * want to handle. Thus you cannot kill init even with a SIGKILL even by
+ * mistake.
+ */
+static void do_signal(struct pt_regs *regs)
+{
+	struct ksignal ksig;
+
+	/*
+	 * We want the common case to go fast, which
+	 * is why we may in certain cases get here from
+	 * kernel mode. Just return without doing anything
+	 * if so.
+	 */
+	if ((regs->ccr & 0x10))
+		return;
+
+	current->thread.esp0 = (unsigned long) regs;
+
+	if (get_signal(&ksig)) {
+		/* Whee!  Actually deliver the signal.  */
+		handle_signal(&ksig, regs);
+		return;
+	}
+	/* Did we come from a system call? */
+	if (regs->orig_er0 >= 0)
+		handle_restart(regs, NULL);
+
+	/* If there's no signal to deliver, we just restore the saved mask.  */
+	restore_saved_sigmask();
+}
+
+asmlinkage void do_notify_resume(struct pt_regs *regs, u32 thread_info_flags)
+{
+	if (thread_info_flags & _TIF_SIGPENDING)
+		do_signal(regs);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
+}
-- 
2.1.4

