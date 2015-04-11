From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 04/24] arm: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:43 +0200
Message-ID: <1428785283-20501-5-git-send-email-richard@nod.at>
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
 arch/arm/include/asm/thread_info.h |  3 ---
 arch/arm/kernel/asm-offsets.c      |  1 -
 arch/arm/kernel/signal.c           | 13 +------------
 arch/arm/kernel/traps.c            |  5 ++---
 4 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 72812a1..bd32ede 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -23,7 +23,6 @@
 #ifndef __ASSEMBLY__
 
 struct task_struct;
-struct exec_domain;
 
 #include <asm/types.h>
 #include <asm/domain.h>
@@ -53,7 +52,6 @@ struct thread_info {
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	__u32			cpu;		/* cpu */
 	__u32			cpu_domain;	/* cpu domain */
 	struct cpu_context_save	cpu_context;	/* cpu context */
@@ -73,7 +71,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)						\
 {									\
 	.task		= &tsk,						\
-	.exec_domain	= &default_exec_domain,				\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 2d2d608..70d277c 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -66,7 +66,6 @@ int main(void)
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
   DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-  DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 023ac90..423663e 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -318,17 +318,6 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, int framesize)
 	return frame;
 }
 
-/*
- * translate the signal
- */
-static inline int map_sig(int sig)
-{
-	struct thread_info *thread = current_thread_info();
-	if (sig < 32 && thread->exec_domain && thread->exec_domain->signal_invmap)
-		sig = thread->exec_domain->signal_invmap[sig];
-	return sig;
-}
-
 static int
 setup_return(struct pt_regs *regs, struct ksignal *ksig,
 	     unsigned long __user *rc, void __user *frame)
@@ -412,7 +401,7 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 		}
 	}
 
-	regs->ARM_r0 = map_sig(ksig->sig);
+	regs->ARM_r0 = ksig->sig;
 	regs->ARM_sp = (unsigned long)frame;
 	regs->ARM_lr = retcode;
 	regs->ARM_pc = handler;
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 788e23f..fac2c7e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -508,9 +508,8 @@ static int bad_syscall(int n, struct pt_regs *regs)
 	struct thread_info *thread = current_thread_info();
 	siginfo_t info;
 
-	if ((current->personality & PER_MASK) != PER_LINUX &&
-	    thread->exec_domain->handler) {
-		thread->exec_domain->handler(n, regs);
+	if ((current->personality & PER_MASK) != PER_LINUX) {
+		send_sig(SIGSEGV, current, 1);
 		return regs->ARM_r0;
 	}
 
-- 
1.8.4.5
