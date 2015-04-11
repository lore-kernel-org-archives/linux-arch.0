From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 11/24] m68k: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:50 +0200
Message-ID: <1428785283-20501-12-git-send-email-richard@nod.at>
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
 arch/m68k/include/asm/thread_info.h |  2 --
 arch/m68k/kernel/signal.c           | 14 ++------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
index c54256e..cee13c2 100644
--- a/arch/m68k/include/asm/thread_info.h
+++ b/arch/m68k/include/asm/thread_info.h
@@ -26,7 +26,6 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;
-	struct exec_domain	*exec_domain;	/* execution domain */
 	mm_segment_t		addr_limit;	/* thread address space */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u32			cpu;		/* should always be 0 on m68k */
@@ -37,7 +36,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.addr_limit	= KERNEL_DS,		\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index d717928..af1c4f3 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -863,12 +863,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
 
-	err |= __put_user((current_thread_info()->exec_domain
-			   && current_thread_info()->exec_domain->signal_invmap
-			   && sig < 32
-			   ? current_thread_info()->exec_domain->signal_invmap[sig]
-			   : sig),
-			  &frame->sig);
+	err |= __put_user(sig, &frame->sig);
 
 	err |= __put_user(regs->vector, &frame->code);
 	err |= __put_user(&frame->sc, &frame->psc);
@@ -948,12 +943,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);
 
-	err |= __put_user((current_thread_info()->exec_domain
-			   && current_thread_info()->exec_domain->signal_invmap
-			   && sig < 32
-			   ? current_thread_info()->exec_domain->signal_invmap[sig]
-			   : sig),
-			  &frame->sig);
+	err |= __put_user(sig, &frame->sig);
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-- 
1.8.4.5
