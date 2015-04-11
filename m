From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 08/24] frv: Remove signal translation and exec_domain
Date: Sat, 11 Apr 2015 22:47:47 +0200
Message-ID: <1428785283-20501-9-git-send-email-richard@nod.at>
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
 arch/blackfin/kernel/signal.c      |  2 +-
 arch/frv/include/asm/thread_info.h |  2 --
 arch/frv/kernel/asm-offsets.c      |  1 -
 arch/frv/kernel/signal.c           | 20 ++++----------------
 4 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/blackfin/kernel/signal.c b/arch/blackfin/kernel/signal.c
index 1982a14..ea570db 100644
--- a/arch/blackfin/kernel/signal.c
+++ b/arch/blackfin/kernel/signal.c
@@ -151,7 +151,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 
 	frame = get_sigframe(ksig, sizeof(*frame));
 
-	err |= __put_user(sig->sig, &frame->sig);
+	err |= __put_user(ksig->sig, &frame->sig);
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
diff --git a/arch/frv/include/asm/thread_info.h b/arch/frv/include/asm/thread_info.h
index 6b917f1..ccba3b6 100644
--- a/arch/frv/include/asm/thread_info.h
+++ b/arch/frv/include/asm/thread_info.h
@@ -31,7 +31,6 @@
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
-	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
@@ -59,7 +58,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
diff --git a/arch/frv/kernel/asm-offsets.c b/arch/frv/kernel/asm-offsets.c
index 446e89d..8414293 100644
--- a/arch/frv/kernel/asm-offsets.c
+++ b/arch/frv/kernel/asm-offsets.c
@@ -34,7 +34,6 @@ void foo(void)
 {
 	/* offsets into the thread_info structure */
 	OFFSET(TI_TASK,			thread_info, task);
-	OFFSET(TI_EXEC_DOMAIN,		thread_info, exec_domain);
 	OFFSET(TI_FLAGS,		thread_info, flags);
 	OFFSET(TI_STATUS,		thread_info, status);
 	OFFSET(TI_CPU,			thread_info, cpu);
diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
index 336713a..75c602d 100644
--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -174,7 +174,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
 static int setup_frame(struct ksignal *ksig, sigset_t *set)
 {
 	struct sigframe __user *frame;
-	int rsig, sig = ksig->sig;
+	int sig = ksig->sig;
 
 	set_fs(USER_DS);
 
@@ -183,13 +183,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set)
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	rsig = sig;
-	if (sig < 32 &&
-	    __current_thread_info->exec_domain &&
-	    __current_thread_info->exec_domain->signal_invmap)
-		rsig = __current_thread_info->exec_domain->signal_invmap[sig];
-
-	if (__put_user(rsig, &frame->sig) < 0)
+	if (__put_user(sig, &frame->sig) < 0)
 		return -EFAULT;
 
 	if (setup_sigcontext(&frame->sc, set->sig[0]))
@@ -255,7 +249,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set)
 static int setup_rt_frame(struct ksignal *ksig, sigset_t *set)
 {
 	struct rt_sigframe __user *frame;
-	int rsig, sig = ksig->sig;
+	int sig = ksig->sig;
 
 	set_fs(USER_DS);
 
@@ -264,13 +258,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set)
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-	rsig = sig;
-	if (sig < 32 &&
-	    __current_thread_info->exec_domain &&
-	    __current_thread_info->exec_domain->signal_invmap)
-		rsig = __current_thread_info->exec_domain->signal_invmap[sig];
-
-	if (__put_user(rsig,		&frame->sig) ||
+	if (__put_user(sig,		&frame->sig) ||
 	    __put_user(&frame->info,	&frame->pinfo) ||
 	    __put_user(&frame->uc,	&frame->puc))
 		return -EFAULT;
-- 
1.8.4.5
