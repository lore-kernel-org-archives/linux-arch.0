From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 13/24] mn10300: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:52 +0200
Message-ID: <1428785283-20501-14-git-send-email-richard@nod.at>
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
 arch/mn10300/include/asm/thread_info.h |  2 --
 arch/mn10300/kernel/asm-offsets.c      |  2 --
 arch/mn10300/kernel/signal.c           | 20 ++++----------------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/mn10300/include/asm/thread_info.h b/arch/mn10300/include/asm/thread_info.h
index c1c374f..4861a78 100644
--- a/arch/mn10300/include/asm/thread_info.h
+++ b/arch/mn10300/include/asm/thread_info.h
@@ -40,7 +40,6 @@ typedef struct {
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	struct pt_regs		*frame;		/* current exception frame */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
@@ -74,7 +73,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/mn10300/kernel/asm-offsets.c b/arch/mn10300/kernel/asm-offsets.c
index d780670..e5a61c6 100644
--- a/arch/mn10300/kernel/asm-offsets.c
+++ b/arch/mn10300/kernel/asm-offsets.c
@@ -22,7 +22,6 @@ void foo(void)
 	BLANK();
 
 	OFFSET(TI_task,			thread_info, task);
-	OFFSET(TI_exec_domain,		thread_info, exec_domain);
 	OFFSET(TI_frame,		thread_info, frame);
 	OFFSET(TI_flags,		thread_info, flags);
 	OFFSET(TI_cpu,			thread_info, cpu);
@@ -85,7 +84,6 @@ void foo(void)
 	DEFINE(SIGCHLD_asm,		SIGCHLD);
 	BLANK();
 
-	OFFSET(EXEC_DOMAIN_handler,	exec_domain, handler);
 	OFFSET(RT_SIGFRAME_sigcontext,	rt_sigframe, uc.uc_mcontext);
 
 	DEFINE(PAGE_SIZE_asm,		PAGE_SIZE);
diff --git a/arch/mn10300/kernel/signal.c b/arch/mn10300/kernel/signal.c
index 8609845..dfd0301 100644
--- a/arch/mn10300/kernel/signal.c
+++ b/arch/mn10300/kernel/signal.c
@@ -202,20 +202,14 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
-	int rsig, sig = ksig->sig;
+	int sig = ksig->sig;
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	rsig = sig;
-	if (sig < 32 &&
-	    current_thread_info()->exec_domain &&
-	    current_thread_info()->exec_domain->signal_invmap)
-		rsig = current_thread_info()->exec_domain->signal_invmap[sig];
-
-	if (__put_user(rsig, &frame->sig) < 0 ||
+	if (__put_user(sig, &frame->sig) < 0 ||
 	    __put_user(&frame->sc, &frame->psc) < 0)
 		return -EFAULT;
 
@@ -270,20 +264,14 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
-	int rsig, sig = ksig->sig;
+	int sig = ksig->sig;
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	rsig = sig;
-	if (sig < 32 &&
-	    current_thread_info()->exec_domain &&
-	    current_thread_info()->exec_domain->signal_invmap)
-		rsig = current_thread_info()->exec_domain->signal_invmap[sig];
-
-	if (__put_user(rsig, &frame->sig) ||
+	if (__put_user(sig, &frame->sig) ||
 	    __put_user(&frame->info, &frame->pinfo) ||
 	    __put_user(&frame->uc, &frame->puc) ||
 	    copy_siginfo_to_user(&frame->info, &ksig->info))
-- 
1.8.4.5
