From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 14/24] s390: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:53 +0200
Message-ID: <1428785283-20501-15-git-send-email-richard@nod.at>
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
 arch/s390/include/asm/thread_info.h |  2 --
 arch/s390/kernel/asm-offsets.c      |  1 -
 arch/s390/kernel/compat_signal.c    | 14 ++------------
 arch/s390/kernel/signal.c           | 14 ++------------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index ef1df71..0a6dcff 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -34,7 +34,6 @@
  */
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		sys_call_table;	/* System call table address */
 	unsigned int		cpu;		/* current CPU */
@@ -51,7 +50,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index e07e916..e52a202 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -34,7 +34,6 @@ int main(void)
 	DEFINE(__THREAD_per_paid, offsetof(struct task_struct, thread.per_event.paid));
 	BLANK();
 	DEFINE(__TI_task, offsetof(struct thread_info, task));
-	DEFINE(__TI_domain, offsetof(struct thread_info, exec_domain));
 	DEFINE(__TI_flags, offsetof(struct thread_info, flags));
 	DEFINE(__TI_sysc_table, offsetof(struct thread_info, sys_call_table));
 	DEFINE(__TI_cpu, offsetof(struct thread_info, cpu));
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index bc1df12..fe8d692 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -370,16 +370,6 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
 	return (void __user *)((sp - frame_size) & -8ul);
 }
 
-static inline int map_signal(int sig)
-{
-	if (current_thread_info()->exec_domain
-	    && current_thread_info()->exec_domain->signal_invmap
-	    && sig < 32)
-		return current_thread_info()->exec_domain->signal_invmap[sig];
-        else
-		return sig;
-}
-
 static int setup_frame32(struct ksignal *ksig, sigset_t *set,
 			 struct pt_regs *regs)
 {
@@ -449,7 +439,7 @@ static int setup_frame32(struct ksignal *ksig, sigset_t *set,
 		(regs->psw.mask & ~PSW_MASK_ASC);
 	regs->psw.addr = (__force __u64) ksig->ka.sa.sa_handler;
 
-	regs->gprs[2] = map_signal(sig);
+	regs->gprs[2] = sig;
 	regs->gprs[3] = (__force __u64) &frame->sc;
 
 	/* We forgot to include these in the sigcontext.
@@ -532,7 +522,7 @@ static int setup_rt_frame32(struct ksignal *ksig, sigset_t *set,
 		(regs->psw.mask & ~PSW_MASK_ASC);
 	regs->psw.addr = (__u64 __force) ksig->ka.sa.sa_handler;
 
-	regs->gprs[2] = map_signal(ksig->sig);
+	regs->gprs[2] = ksig->sig;
 	regs->gprs[3] = (__force __u64) &frame->info;
 	regs->gprs[4] = (__force __u64) &frame->uc;
 	regs->gprs[5] = task_thread_info(current)->last_break;
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index b3ae6f7..c3f71c4 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -309,16 +309,6 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
 	return (void __user *)((sp - frame_size) & -8ul);
 }
 
-static inline int map_signal(int sig)
-{
-	if (current_thread_info()->exec_domain
-	    && current_thread_info()->exec_domain->signal_invmap
-	    && sig < 32)
-		return current_thread_info()->exec_domain->signal_invmap[sig];
-	else
-		return sig;
-}
-
 static int setup_frame(int sig, struct k_sigaction *ka,
 		       sigset_t *set, struct pt_regs * regs)
 {
@@ -386,7 +376,7 @@ static int setup_frame(int sig, struct k_sigaction *ka,
 		(regs->psw.mask & ~PSW_MASK_ASC);
 	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
 
-	regs->gprs[2] = map_signal(sig);
+	regs->gprs[2] = sig;
 	regs->gprs[3] = (unsigned long) &frame->sc;
 
 	/* We forgot to include these in the sigcontext.
@@ -468,7 +458,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		(regs->psw.mask & ~PSW_MASK_ASC);
 	regs->psw.addr = (unsigned long) ksig->ka.sa.sa_handler | PSW_ADDR_AMODE;
 
-	regs->gprs[2] = map_signal(ksig->sig);
+	regs->gprs[2] = ksig->sig;
 	regs->gprs[3] = (unsigned long) &frame->info;
 	regs->gprs[4] = (unsigned long) &frame->uc;
 	regs->gprs[5] = task_thread_info(current)->last_break;
-- 
1.8.4.5
