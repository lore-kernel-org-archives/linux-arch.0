From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 12/24] microblaze: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:51 +0200
Message-ID: <1428785283-20501-13-git-send-email-richard@nod.at>
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
 arch/microblaze/include/asm/thread_info.h | 2 --
 arch/microblaze/kernel/signal.c           | 9 +--------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index b699fbd..383f387 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -65,7 +65,6 @@ typedef struct {
 
 struct thread_info {
 	struct task_struct	*task; /* main task structure */
-	struct exec_domain	*exec_domain; /* execution domain */
 	unsigned long		flags; /* low level flags */
 	unsigned long		status; /* thread-synchronous flags */
 	__u32			cpu; /* current CPU */
@@ -81,7 +80,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index a1cbaf9..cf7d8a3 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -158,7 +158,6 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 {
 	struct rt_sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
-	unsigned long signal;
 	unsigned long address = 0;
 #ifdef CONFIG_MMU
 	pmd_t *pmdp;
@@ -170,12 +169,6 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	signal = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: (unsigned long)sig;
-
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
@@ -230,7 +223,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	regs->r1 = (unsigned long) frame;
 
 	/* Signal handler args: */
-	regs->r5 = signal; /* arg 0: signum */
+	regs->r5 = sig; /* arg 0: signum */
 	regs->r6 = (unsigned long) &frame->info; /* arg 1: siginfo */
 	regs->r7 = (unsigned long) &frame->uc; /* arg2: ucontext */
 	/* Offset to handle microblaze rtid r14, 0 */
-- 
1.8.4.5
