From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 15/24] sh: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:54 +0200
Message-ID: <1428785283-20501-16-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

As execution domain support is gone we can remove
signal translation from the signal code and remove
exec_domain from thread_info.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/sh/include/asm/thread_info.h |  2 --
 arch/sh/kernel/asm-offsets.c      |  1 -
 arch/sh/kernel/irq.c              |  2 --
 arch/sh/kernel/signal_32.c        | 18 ++----------------
 arch/sh/kernel/signal_64.c        | 21 ++++-----------------
 5 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 657c039..2afa321 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -27,7 +27,6 @@
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			status;		/* thread synchronous flags */
 	__u32			cpu;
@@ -56,7 +55,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.status		= 0,			\
 	.cpu		= 0,			\
diff --git a/arch/sh/kernel/asm-offsets.c b/arch/sh/kernel/asm-offsets.c
index 542225f..4bd44da 100644
--- a/arch/sh/kernel/asm-offsets.c
+++ b/arch/sh/kernel/asm-offsets.c
@@ -21,7 +21,6 @@ int main(void)
 {
 	/* offsets into the thread_info struct */
 	DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-	DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_FLAGS,	offsetof(struct thread_info, flags));
 	DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
 	DEFINE(TI_PRE_COUNT,	offsetof(struct thread_info, preempt_count));
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 65a1ecd..eb10ff8 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -124,7 +124,6 @@ void irq_ctx_init(int cpu)
 
 	irqctx = (union irq_ctx *)&hardirq_stack[cpu * THREAD_SIZE];
 	irqctx->tinfo.task		= NULL;
-	irqctx->tinfo.exec_domain	= NULL;
 	irqctx->tinfo.cpu		= cpu;
 	irqctx->tinfo.preempt_count	= HARDIRQ_OFFSET;
 	irqctx->tinfo.addr_limit	= MAKE_MM_SEG(0);
@@ -133,7 +132,6 @@ void irq_ctx_init(int cpu)
 
 	irqctx = (union irq_ctx *)&softirq_stack[cpu * THREAD_SIZE];
 	irqctx->tinfo.task		= NULL;
-	irqctx->tinfo.exec_domain	= NULL;
 	irqctx->tinfo.cpu		= cpu;
 	irqctx->tinfo.preempt_count	= 0;
 	irqctx->tinfo.addr_limit	= MAKE_MM_SEG(0);
diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
index 0b34f2a..ab7b56b 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -267,19 +267,12 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 {
 	struct sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
-	int signal;
 
 	frame = get_sigframe(&ksig->ka, regs->regs[15], sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	signal = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
 	err |= setup_sigcontext(&frame->sc, regs, set->sig[0]);
 
 	if (_NSIG_WORDS > 1)
@@ -313,7 +306,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 
 	/* Set up registers for signal handler */
 	regs->regs[15] = (unsigned long) frame;
-	regs->regs[4] = signal; /* Arg for signal handler */
+	regs->regs[4] = sig; /* Arg for signal handler */
 	regs->regs[5] = 0;
 	regs->regs[6] = (unsigned long) &frame->sc;
 
@@ -342,19 +335,12 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 {
 	struct rt_sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
-	int signal;
 
 	frame = get_sigframe(&ksig->ka, regs->regs[15], sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	signal = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	/* Create the ucontext.  */
@@ -392,7 +378,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 
 	/* Set up registers for signal handler */
 	regs->regs[15] = (unsigned long) frame;
-	regs->regs[4] = signal; /* Arg for signal handler */
+	regs->regs[4] = sig; /* Arg for signal handler */
 	regs->regs[5] = (unsigned long) &frame->info;
 	regs->regs[6] = (unsigned long) &frame->uc;
 
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index 71993c6..76122d6 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -385,12 +385,6 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	signal = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
 	err |= setup_sigcontext(&frame->sc, regs, set->sig[0]);
 
 	/* Give up earlier as i386, in case */
@@ -441,7 +435,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 	 * All edited pointers are subject to NEFF.
 	 */
 	regs->regs[REG_SP] = neff_sign_extend((unsigned long)frame);
-	regs->regs[REG_ARG1] = signal; /* Arg for signal handler */
+	regs->regs[REG_ARG1] = sig; /* Arg for signal handler */
 
         /* FIXME:
            The glibc profiling support for SH-5 needs to be passed a sigcontext
@@ -461,7 +455,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 
 	/* Broken %016Lx */
 	pr_debug("SIG deliver (#%d,%s:%d): sp=%p pc=%08Lx%08Lx link=%08Lx%08Lx\n",
-		 signal, current->comm, current->pid, frame,
+		 sig, current->comm, current->pid, frame,
 		 regs->pc >> 32, regs->pc & 0xffffffff,
 		 DEREF_REG_PR >> 32, DEREF_REG_PR & 0xffffffff);
 
@@ -473,19 +467,12 @@ static int setup_rt_frame(struct ksignal *kig, sigset_t *set,
 {
 	struct rt_sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
-	int signal;
 
 	frame = get_sigframe(&ksig->ka, regs->regs[REG_SP], sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	signal = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
@@ -542,7 +529,7 @@ static int setup_rt_frame(struct ksignal *kig, sigset_t *set,
 	 * All edited pointers are subject to NEFF.
 	 */
 	regs->regs[REG_SP] = neff_sign_extend((unsigned long)frame);
-	regs->regs[REG_ARG1] = signal; /* Arg for signal handler */
+	regs->regs[REG_ARG1] = sig; /* Arg for signal handler */
 	regs->regs[REG_ARG2] = (unsigned long long)(unsigned long)(signed long)&frame->info;
 	regs->regs[REG_ARG3] = (unsigned long long)(unsigned long)(signed long)&frame->uc.uc_mcontext;
 	regs->pc = neff_sign_extend((unsigned long)ksig->ka.sa.sa_handler);
@@ -550,7 +537,7 @@ static int setup_rt_frame(struct ksignal *kig, sigset_t *set,
 	set_fs(USER_DS);
 
 	pr_debug("SIG deliver (#%d,%s:%d): sp=%p pc=%08Lx%08Lx link=%08Lx%08Lx\n",
-		 signal, current->comm, current->pid, frame,
+		 sig, current->comm, current->pid, frame,
 		 regs->pc >> 32, regs->pc & 0xffffffff,
 		 DEREF_REG_PR >> 32, DEREF_REG_PR & 0xffffffff);
 
-- 
1.8.4.5
