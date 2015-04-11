From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 05/24] arm64: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:44 +0200
Message-ID: <1428785283-20501-6-git-send-email-richard@nod.at>
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
 arch/arm64/include/asm/thread_info.h | 3 ---
 arch/arm64/kernel/asm-offsets.c      | 1 -
 arch/arm64/kernel/signal.c           | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 702e1e6..dcd06d1 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -33,7 +33,6 @@
 #ifndef __ASSEMBLY__
 
 struct task_struct;
-struct exec_domain;
 
 #include <asm/types.h>
 
@@ -47,7 +46,6 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	int			cpu;		/* cpu */
 };
@@ -55,7 +53,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)						\
 {									\
 	.task		= &tsk,						\
-	.exec_domain	= &default_exec_domain,				\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index f7fa65d..56cadd3 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -38,7 +38,6 @@ int main(void)
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
   DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-  DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 660ccf9..9f28eaa 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -294,12 +294,6 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	int ret;
 
 	/*
-	 * translate the signal
-	 */
-	if (usig < 32 && thread->exec_domain && thread->exec_domain->signal_invmap)
-		usig = thread->exec_domain->signal_invmap[usig];
-
-	/*
 	 * Set up the stack frame
 	 */
 	if (is_compat_task()) {
-- 
1.8.4.5
