From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 22/24] arc: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:48:01 +0200
Message-ID: <1428785283-20501-23-git-send-email-richard@nod.at>
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
 arch/arc/include/asm/thread_info.h |  2 --
 arch/arc/kernel/signal.c           | 14 +-------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index 1163a18..aca0d5a 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -43,7 +43,6 @@ struct thread_info {
 	int preempt_count;		/* 0 => preemptable, <0 => BUG */
 	struct task_struct *task;	/* main task structure */
 	mm_segment_t addr_limit;	/* thread address space */
-	struct exec_domain *exec_domain;/* execution domain */
 	__u32 cpu;			/* current CPU */
 	unsigned long thr_ptr;		/* TLS ptr */
 };
@@ -56,7 +55,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task       = &tsk,			\
-	.exec_domain    = &default_exec_domain,	\
 	.flags      = 0,			\
 	.cpu        = 0,			\
 	.preempt_count  = INIT_PREEMPT_COUNT,	\
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index edda76f..2251fb4 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -171,18 +171,6 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
 	return frame;
 }
 
-/*
- * translate the signal
- */
-static inline int map_sig(int sig)
-{
-	struct thread_info *thread = current_thread_info();
-	if (thread->exec_domain && thread->exec_domain->signal_invmap
-	    && sig < 32)
-		sig = thread->exec_domain->signal_invmap[sig];
-	return sig;
-}
-
 static int
 setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
@@ -231,7 +219,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 		return err;
 
 	/* #1 arg to the user Signal handler */
-	regs->r0 = map_sig(ksig->sig);
+	regs->r0 = ksig->sig;
 
 	/* setup PC of user space signal handler */
 	regs->ret = (unsigned long)ksig->ka.sa.sa_handler;
-- 
1.8.4.5
