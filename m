From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 20/24] x86: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:59 +0200
Message-ID: <1428785283-20501-21-git-send-email-richard@nod.at>
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
 arch/x86/include/asm/thread_info.h |  3 ---
 arch/x86/kernel/signal.c           | 16 +---------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 1d4e4f2..2df52ba 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -19,13 +19,11 @@
  */
 #ifndef __ASSEMBLY__
 struct task_struct;
-struct exec_domain;
 #include <asm/processor.h>
 #include <linux/atomic.h>
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	__u32			flags;		/* low level flags */
 	__u32			status;		/* thread synchronous flags */
 	__u32			cpu;		/* current CPU */
@@ -39,7 +37,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.saved_preempt_count = INIT_PREEMPT_COUNT,	\
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index e504246..5ddc7ec 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -592,24 +592,10 @@ badframe:
 	return 0;
 }
 
-/*
- * OK, we're invoking a handler:
- */
-static int signr_convert(int sig)
-{
-#ifdef CONFIG_X86_32
-	struct thread_info *info = current_thread_info();
-
-	if (info->exec_domain && info->exec_domain->signal_invmap && sig < 32)
-		return info->exec_domain->signal_invmap[sig];
-#endif /* CONFIG_X86_32 */
-	return sig;
-}
-
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	int usig = signr_convert(ksig->sig);
+	int usig = ksig->sig;
 	sigset_t *set = sigmask_to_save();
 	compat_sigset_t *cset = (compat_sigset_t *) set;
 
-- 
1.8.4.5
