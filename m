From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 18/24] um: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:57 +0200
Message-ID: <1428785283-20501-19-git-send-email-richard@nod.at>
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
 arch/um/include/asm/thread_info.h | 2 --
 arch/x86/um/signal.c              | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index e04114c..b30c85b 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -14,7 +14,6 @@
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;  /* 0 => preemptable,
@@ -28,7 +27,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task =		&tsk,			\
-	.exec_domain =	&default_exec_domain,	\
 	.flags =		0,		\
 	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 0c8c32b..592491d 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -549,13 +549,6 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	if (err)
 		return err;
 
-	/* Set up registers for signal handler */
-	{
-		struct exec_domain *ed = current_thread_info()->exec_domain;
-		if (unlikely(ed && ed->signal_invmap && sig < 32))
-			sig = ed->signal_invmap[sig];
-	}
-
 	PT_REGS_SP(regs) = (unsigned long) frame;
 	PT_REGS_DI(regs) = sig;
 	/* In case the signal handler was declared without prototypes */
-- 
1.8.4.5
