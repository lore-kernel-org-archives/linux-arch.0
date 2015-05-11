From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v12 08/21] h8300: Interrupt and exceptions
Date: Mon, 11 May 2015 15:26:27 +0900
Message-ID: <1431325600-12333-9-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/kernel/irq.c    |  97 +++++++++++++++
 arch/h8300/kernel/signal.c | 289 +++++++++++++++++++++++++++++++++++++++++++++
 arch/h8300/kernel/traps.c  | 161 +++++++++++++++++++++++++
 3 files changed, 547 insertions(+)
 create mode 100644 arch/h8300/kernel/irq.c
 create mode 100644 arch/h8300/kernel/signal.c
 create mode 100644 arch/h8300/kernel/traps.c

diff --git a/arch/h8300/kernel/irq.c b/arch/h8300/kernel/irq.c
new file mode 100644
index 0000000..da79f95
--- /dev/null
+++ b/arch/h8300/kernel/irq.c
@@ -0,0 +1,97 @@
+/*
+ * linux/arch/h8300/kernel/irq.c
+ *
+ * Copyright 2014-2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <asm/traps.h>
+
+#ifdef CONFIG_RAMKERNEL
+typedef void (*h8300_vector)(void);
+
+static const h8300_vector __initconst trap_table[] = {
+	0, 0, 0, 0,
+	_trace_break,
+	0, 0,
+	_nmi,
+	_system_call,
+	0, 0,
+	_trace_break,
+};
+
+static unsigned long __init *get_vector_address(void)
+{
+	unsigned long *rom_vector = CPU_VECTOR;
+	unsigned long base, tmp;
+	int vec_no;
+
+	base = rom_vector[EXT_IRQ0] & ADDR_MASK;
+
+	/* check romvector format */
+	for (vec_no = EXT_IRQ0 + 1; vec_no <= EXT_IRQ0+EXT_IRQS; vec_no++) {
+		if ((base+(vec_no - EXT_IRQ0)*4) !=
+		    (rom_vector[vec_no] & ADDR_MASK))
+			return NULL;
+	}
+
+	/* ramvector base address */
+	base -= EXT_IRQ0*4;
+
+	/* writerble? */
+	tmp = ~(*(volatile unsigned long *)base);
+	(*(volatile unsigned long *)base) = tmp;
+	if ((*(volatile unsigned long *)base) != tmp)
+		return NULL;
+	return (unsigned long *)base;
+}
+
+static void __init setup_vector(void)
+{
+	int i;
+	unsigned long *ramvec, *ramvec_p;
+	const h8300_vector *trap_entry;
+
+	ramvec = get_vector_address();
+	if (ramvec == NULL)
+		panic("interrupt vector serup failed.");
+	else
+		pr_debug("virtual vector at 0x%p\n", ramvec);
+
+	/* create redirect table */
+	ramvec_p = ramvec;
+	trap_entry = trap_table;
+	for (i = 0; i < NR_IRQS; i++) {
+		if (i < 12) {
+			if (*trap_entry)
+				*ramvec_p = VECTOR(*trap_entry);
+			ramvec_p++;
+			trap_entry++;
+		} else
+			*ramvec_p++ = REDIRECT(_interrupt_entry);
+	}
+	_interrupt_redirect_table = ramvec;
+}
+#else
+void setup_vector(void)
+{
+	/* noting do */
+}
+#endif
+
+void __init init_IRQ(void)
+{
+	setup_vector();
+	irqchip_init();
+}
+
+asmlinkage void do_IRQ(int irq)
+{
+	irq_enter();
+	generic_handle_irq(irq);
+	irq_exit();
+}
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
new file mode 100644
index 0000000..380fffd
--- /dev/null
+++ b/arch/h8300/kernel/signal.c
@@ -0,0 +1,289 @@
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
+	/* restore passed registers */
+#define COPY(r)  do { err |= get_user(regs->r, &usc->sc_##r); } while (0)
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
+static inline void __user *
+get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size)
+{
+	return (void __user *)((sigsp(rdusp(), ksig) - frame_size) & -8UL);
+}
+
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
+{
+	struct rt_sigframe *frame;
+	int err = 0;
+	unsigned char *ret;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		return -EFAULT;
+
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
+
+	/* Create the ucontext.  */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(0, &frame->uc.uc_link);
+	err |= __save_altstack(&frame->uc.uc_stack, rdusp());
+	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, set->sig[0]);
+	err |= copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	if (err)
+		return -EFAULT;
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
+		return -EFAULT;
+
+	/* Set up registers for signal handler */
+	wrusp((unsigned long) frame);
+	regs->pc  = (unsigned long) ksig->ka.sa.sa_handler;
+	regs->er0 = ksig->sig;
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
diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
new file mode 100644
index 0000000..1b2d7cd
--- /dev/null
+++ b/arch/h8300/kernel/traps.c
@@ -0,0 +1,161 @@
+/*
+ * linux/arch/h8300/boot/traps.c -- general exception handling code
+ * H8/300 support Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * Cloned from Linux/m68k.
+ *
+ * No original Copyright holder listed,
+ * Probable original (C) Roman Zippel (assigned DJD, 1999)
+ *
+ * Copyright 1999-2000 D. Jeff Dionne, <jeff@rt-control.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/bug.h>
+
+#include <asm/irq.h>
+#include <asm/traps.h>
+#include <asm/page.h>
+
+static DEFINE_SPINLOCK(die_lock);
+
+/*
+ * this must be called very early as the kernel might
+ * use some instruction that are emulated on the 060
+ */
+
+void __init base_trap_init(void)
+{
+}
+
+void __init trap_init(void)
+{
+}
+
+asmlinkage void set_esp0(unsigned long ssp)
+{
+	current->thread.esp0 = ssp;
+}
+
+/*
+ *	Generic dumping code. Used for panic and debug.
+ */
+
+static void dump(struct pt_regs *fp)
+{
+	unsigned long	*sp;
+	unsigned char	*tp;
+	int		i;
+
+	pr_info("\nCURRENT PROCESS:\n\n");
+	pr_info("COMM=%s PID=%d\n", current->comm, current->pid);
+	if (current->mm) {
+		pr_info("TEXT=%08x-%08x DATA=%08x-%08x BSS=%08x-%08x\n",
+			(int) current->mm->start_code,
+			(int) current->mm->end_code,
+			(int) current->mm->start_data,
+			(int) current->mm->end_data,
+			(int) current->mm->end_data,
+			(int) current->mm->brk);
+		pr_info("USER-STACK=%08x  KERNEL-STACK=%08lx\n\n",
+			(int) current->mm->start_stack,
+			(int) PAGE_SIZE+(unsigned long)current);
+	}
+
+	show_regs(fp);
+	pr_info("\nCODE:");
+	tp = ((unsigned char *) fp->pc) - 0x20;
+	for (sp = (unsigned long *) tp, i = 0; (i < 0x40);  i += 4) {
+		if ((i % 0x10) == 0)
+			pr_info("\n%08x: ", (int) (tp + i));
+		pr_info("%08x ", (int) *sp++);
+	}
+	pr_info("\n");
+
+	pr_info("\nKERNEL STACK:");
+	tp = ((unsigned char *) fp) - 0x40;
+	for (sp = (unsigned long *) tp, i = 0; (i < 0xc0); i += 4) {
+		if ((i % 0x10) == 0)
+			pr_info("\n%08x: ", (int) (tp + i));
+		pr_info("%08x ", (int) *sp++);
+	}
+	pr_info("\n");
+	if (STACK_MAGIC != *(unsigned long *)((unsigned long)current+PAGE_SIZE))
+		pr_info("(Possibly corrupted stack page??)\n");
+
+	pr_info("\n\n");
+}
+
+void die(const char *str, struct pt_regs *fp, unsigned long err)
+{
+	static int diecount;
+
+	oops_enter();
+
+	console_verbose();
+	spin_lock_irq(&die_lock);
+	report_bug(fp->pc, fp);
+	pr_crit("%s: %04lx [#%d] ", str, err & 0xffff, ++diecount);
+	dump(fp);
+
+	spin_unlock_irq(&die_lock);
+	do_exit(SIGSEGV);
+}
+
+static int kstack_depth_to_print = 24;
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	unsigned long *stack,  addr;
+	int i;
+
+	if (esp == NULL)
+		esp = (unsigned long *) &esp;
+
+	stack = esp;
+
+	pr_info("Stack from %08lx:", (unsigned long)stack);
+	for (i = 0; i < kstack_depth_to_print; i++) {
+		if (((unsigned long)stack & (THREAD_SIZE - 1)) == 0)
+			break;
+		if (i % 8 == 0)
+			pr_info("\n       ");
+		pr_info(" %08lx", *stack++);
+	}
+
+	pr_info("\nCall Trace:");
+	i = 0;
+	stack = esp;
+	while (((unsigned long)stack & (THREAD_SIZE - 1)) != 0) {
+		addr = *stack++;
+		/*
+		 * If the address is either in the text segment of the
+		 * kernel, or in the region which contains vmalloc'ed
+		 * memory, it *may* be the address of a calling
+		 * routine; if so, print it so that someone tracing
+		 * down the cause of the crash will be able to figure
+		 * out the call path that was taken.
+		 */
+		if (check_kernel_text(addr)) {
+			if (i % 4 == 0)
+				pr_info("\n       ");
+			pr_info(" [<%08lx>]", addr);
+			i++;
+		}
+	}
+	pr_info("\n");
+}
+
+void show_trace_task(struct task_struct *tsk)
+{
+	show_stack(tsk, (unsigned long *)tsk->thread.esp0);
+}
-- 
2.1.4
