From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 07/24] blackfin: Remove exec_domain usage
Date: Sat, 11 Apr 2015 22:47:46 +0200
Message-ID: <1428785283-20501-8-git-send-email-richard@nod.at>
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
 arch/blackfin/include/asm/thread_info.h | 2 --
 arch/blackfin/kernel/signal.c           | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/blackfin/include/asm/thread_info.h b/arch/blackfin/include/asm/thread_info.h
index 962be3f..2966b93 100644
--- a/arch/blackfin/include/asm/thread_info.h
+++ b/arch/blackfin/include/asm/thread_info.h
@@ -37,7 +37,6 @@ typedef unsigned long mm_segment_t;
 
 struct thread_info {
 	struct task_struct *task;	/* main task structure */
-	struct exec_domain *exec_domain;	/* execution domain */
 	unsigned long flags;	/* low level flags */
 	int cpu;		/* cpu we're on */
 	int preempt_count;	/* 0 => preemptable, <0 => BUG */
@@ -53,7 +52,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/blackfin/kernel/signal.c b/arch/blackfin/kernel/signal.c
index f2a8b54..1982a14 100644
--- a/arch/blackfin/kernel/signal.c
+++ b/arch/blackfin/kernel/signal.c
@@ -151,11 +151,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 
 	frame = get_sigframe(ksig, sizeof(*frame));
 
-	err |= __put_user((current_thread_info()->exec_domain
-			   && current_thread_info()->exec_domain->signal_invmap
-			   && ksig->sig < 32
-			   ? current_thread_info()->exec_domain->
-			   signal_invmap[ksig->sig] : ksig->sig), &frame->sig);
+	err |= __put_user(sig->sig, &frame->sig);
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-- 
1.8.4.5
