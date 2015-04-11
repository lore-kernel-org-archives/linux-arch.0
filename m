From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 19/24] unicore32: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:58 +0200
Message-ID: <1428785283-20501-20-git-send-email-richard@nod.at>
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
 arch/unicore32/include/asm/thread_info.h | 3 ---
 arch/unicore32/kernel/asm-offsets.c      | 1 -
 arch/unicore32/kernel/signal.c           | 7 -------
 3 files changed, 11 deletions(-)

diff --git a/arch/unicore32/include/asm/thread_info.h b/arch/unicore32/include/asm/thread_info.h
index 63e2839..e79ad6d 100644
--- a/arch/unicore32/include/asm/thread_info.h
+++ b/arch/unicore32/include/asm/thread_info.h
@@ -24,7 +24,6 @@
 #ifndef __ASSEMBLY__
 
 struct task_struct;
-struct exec_domain;
 
 #include <asm/types.h>
 
@@ -71,7 +70,6 @@ struct thread_info {
 						/* <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	__u32			cpu;		/* cpu */
 	struct cpu_context_save	cpu_context;	/* cpu context */
 	__u32			syscall;	/* syscall number */
@@ -84,7 +82,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)						\
 {									\
 	.task		= &tsk,						\
-	.exec_domain	= &default_exec_domain,				\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
diff --git a/arch/unicore32/kernel/asm-offsets.c b/arch/unicore32/kernel/asm-offsets.c
index ffcbe75..80d50c4 100644
--- a/arch/unicore32/kernel/asm-offsets.c
+++ b/arch/unicore32/kernel/asm-offsets.c
@@ -42,7 +42,6 @@ int main(void)
 	DEFINE(TI_PREEMPT,	offsetof(struct thread_info, preempt_count));
 	DEFINE(TI_ADDR_LIMIT,	offsetof(struct thread_info, addr_limit));
 	DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-	DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
 	DEFINE(TI_CPU_SAVE,	offsetof(struct thread_info, cpu_context));
 	DEFINE(TI_USED_CP,	offsetof(struct thread_info, used_cp));
diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
index d329f85..4ae51cf 100644
--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -330,13 +330,6 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs,
 	}
 
 	/*
-	 * translate the signal
-	 */
-	if (usig < 32 && thread->exec_domain
-			&& thread->exec_domain->signal_invmap)
-		usig = thread->exec_domain->signal_invmap[usig];
-
-	/*
 	 * Set up the stack frame
 	 */
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-- 
1.8.4.5
