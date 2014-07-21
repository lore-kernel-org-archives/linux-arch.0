From: Richard Weinberger <richard@sigma-star.at>
Subject: [PATCH 42/43] openrisc: Use sigsp()
Date: Mon, 21 Jul 2014 16:03:28 +0200
Message-ID: <1405951409-16953-43-git-send-email-richard@sigma-star.at>
References: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, jonas@southpole.se, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

From: Richard Weinberger <richard@nod.at>

Use sigsp() instead of the open coded variant.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/openrisc/kernel/signal.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 66775bc..7d1b823 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -132,30 +132,16 @@ static inline unsigned long align_sigframe(unsigned long sp)
  * or the alternate stack.
  */
 
-static inline void __user *get_sigframe(struct k_sigaction *ka,
+static inline void __user *get_sigframe(struct ksignal *ksig,
 					struct pt_regs *regs, size_t frame_size)
 {
 	unsigned long sp = regs->sp;
-	int onsigstack = on_sig_stack(sp);
 
 	/* redzone */
 	sp -= STACK_FRAME_OVERHEAD;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && !onsigstack) {
-		if (current->sas_ss_size)
-			sp = current->sas_ss_sp + current->sas_ss_size;
-	}
-
+	sp = sigsp(sp, ksig);
 	sp = align_sigframe(sp - frame_size);
 
-	/*
-	 * If we are on the alternate signal stack and would overflow it, don't.
-	 * Return an always-bogus address instead so we will die with SIGSEGV.
-	 */
-	if (onsigstack && !likely(on_sig_stack(sp)))
-		return (void __user *)-1L;
-
 	return (void __user *)sp;
 }
 
@@ -173,7 +159,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	unsigned long return_ip;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
-- 
1.8.4.5
