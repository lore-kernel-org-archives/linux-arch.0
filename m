From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 21/24] xtensa: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:48:00 +0200
Message-ID: <1428785283-20501-22-git-send-email-richard@nod.at>
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
 arch/xtensa/include/asm/thread_info.h |  2 --
 arch/xtensa/kernel/signal.c           | 11 ++---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index a9b5d3b..d120278 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -44,7 +44,6 @@ typedef struct xtregs_coprocessor {
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
@@ -83,7 +82,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 3d733ba..1785c4d 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -336,7 +336,6 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 {
 	struct rt_sigframe *frame;
 	int err = 0, sig = ksig->sig;
-	int signal;
 	unsigned long sp, ra, tp;
 
 	sp = regs->areg[1];
@@ -354,12 +353,6 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	signal = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	}
@@ -400,7 +393,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	 * Note: PS.CALLINC is set to one by start_thread
 	 */
 	regs->areg[4] = (((unsigned long) ra) & 0x3fffffff) | 0x40000000;
-	regs->areg[6] = (unsigned long) signal;
+	regs->areg[6] = (unsigned long) sig;
 	regs->areg[7] = (unsigned long) &frame->info;
 	regs->areg[8] = (unsigned long) &frame->uc;
 	regs->threadptr = tp;
@@ -412,7 +405,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 
 #if DEBUG_SIG
 	printk("SIG rt deliver (%s:%d): signal=%d sp=%p pc=%08x\n",
-		current->comm, current->pid, signal, frame, regs->pc);
+		current->comm, current->pid, sig, frame, regs->pc);
 #endif
 
 	return 0;
-- 
1.8.4.5
