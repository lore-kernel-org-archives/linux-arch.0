From: Richard Weinberger <richard@sigma-star.at>
Subject: [PATCH 35/43] hexagon: Use sigsp()
Date: Mon, 21 Jul 2014 16:03:21 +0200
Message-ID: <1405951409-16953-36-git-send-email-richard@sigma-star.at>
References: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, rkuo@codeaurora.org, linux-hexagon@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Richard Weinberger <richard@nod.at>

Use sigsp() instead of the open coded variant.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/hexagon/kernel/signal.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
index 6525358..eadd70e 100644
--- a/arch/hexagon/kernel/signal.c
+++ b/arch/hexagon/kernel/signal.c
@@ -36,18 +36,10 @@ struct rt_sigframe {
 	struct ucontext uc;
 };
 
-static void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 			  size_t frame_size)
 {
-	unsigned long sp = regs->r29;
-
-	/* check if we would overflow the alt stack */
-	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size)))
-		return (void __user __force *)-1UL;
-
-	/* Switch to signal stack if appropriate */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
+	unsigned long sp = sigsp(regs->r29, ksig);
 
 	return (void __user *)((sp - frame_size) & ~(sizeof(long long) - 1));
 }
@@ -119,7 +111,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	struct rt_sigframe __user *frame;
 	struct hexagon_vdso *vdso = current->mm->context.vdso;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe));
+	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(struct rt_sigframe)))
 		return -EFAULT;
-- 
1.8.4.5
