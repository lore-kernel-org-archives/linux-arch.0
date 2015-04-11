From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 17/24] tile: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:56 +0200
Message-ID: <1428785283-20501-18-git-send-email-richard@nod.at>
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
 arch/tile/include/asm/thread_info.h | 2 --
 arch/tile/kernel/compat_signal.c    | 9 +--------
 arch/tile/kernel/signal.c           | 9 +--------
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/tile/include/asm/thread_info.h b/arch/tile/include/asm/thread_info.h
index 96c14c1..98ee10a 100644
--- a/arch/tile/include/asm/thread_info.h
+++ b/arch/tile/include/asm/thread_info.h
@@ -26,7 +26,6 @@
  */
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			homecache_cpu;	/* CPU we are homecached on */
@@ -51,7 +50,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/tile/kernel/compat_signal.c b/arch/tile/kernel/compat_signal.c
index 8c5abf2..5cbc864 100644
--- a/arch/tile/kernel/compat_signal.c
+++ b/arch/tile/kernel/compat_signal.c
@@ -196,19 +196,12 @@ int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	unsigned long restorer;
 	struct compat_rt_sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
-	int usig;
 
 	frame = compat_get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto err;
 
-	usig = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
 	/* Always write at least the signal number for the stack backtracer. */
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 		/* At sigreturn time, restore the callee-save registers too. */
@@ -243,7 +236,7 @@ int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	regs->ex1 = PL_ICS_EX1(USER_PL, 1); /* set crit sec in handler */
 	regs->sp = ptr_to_compat_reg(frame);
 	regs->lr = restorer;
-	regs->regs[0] = (unsigned long) usig;
+	regs->regs[0] = (unsigned long) sig;
 	regs->regs[1] = ptr_to_compat_reg(&frame->info);
 	regs->regs[2] = ptr_to_compat_reg(&frame->uc);
 	regs->flags |= PT_FLAGS_CALLER_SAVES;
diff --git a/arch/tile/kernel/signal.c b/arch/tile/kernel/signal.c
index 8a524e3..87299a6 100644
--- a/arch/tile/kernel/signal.c
+++ b/arch/tile/kernel/signal.c
@@ -151,19 +151,12 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	unsigned long restorer;
 	struct rt_sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
-	int usig;
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto err;
 
-	usig = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
 	/* Always write at least the signal number for the stack backtracer. */
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 		/* At sigreturn time, restore the callee-save registers too. */
@@ -198,7 +191,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	regs->ex1 = PL_ICS_EX1(USER_PL, 1); /* set crit sec in handler */
 	regs->sp = (unsigned long) frame;
 	regs->lr = restorer;
-	regs->regs[0] = (unsigned long) usig;
+	regs->regs[0] = (unsigned long) sig;
 	regs->regs[1] = (unsigned long) &frame->info;
 	regs->regs[2] = (unsigned long) &frame->uc;
 	regs->flags |= PT_FLAGS_CALLER_SAVES;
-- 
1.8.4.5
