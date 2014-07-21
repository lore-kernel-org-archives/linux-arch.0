From: Richard Weinberger <richard@sigma-star.at>
Subject: [PATCH 38/43] metag: Use sigsp()
Date: Mon, 21 Jul 2014 16:03:24 +0200
Message-ID: <1405951409-16953-39-git-send-email-richard@sigma-star.at>
References: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, james.hogan@imgtec.com, linux-metag@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Richard Weinberger <richard@nod.at>

Use sigsp() instead of the open coded variant.

Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/kernel/signal.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/metag/kernel/signal.c b/arch/metag/kernel/signal.c
index b9e4a82..0d100d5 100644
--- a/arch/metag/kernel/signal.c
+++ b/arch/metag/kernel/signal.c
@@ -140,13 +140,9 @@ static int setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 /*
  * Determine which stack to use..
  */
-static void __user *get_sigframe(struct k_sigaction *ka, unsigned long sp,
-				 size_t frame_size)
+static void __user *get_sigframe(struct ksignal *ksig, unsigned long sp)
 {
-	/* Meta stacks grows upwards */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
-		sp = current->sas_ss_sp;
-
+	sp = sigsp(sp, ksig);
 	sp = (sp + 7) & ~7;			/* 8byte align stack */
 
 	return (void __user *)sp;
@@ -159,7 +155,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	int err;
 	unsigned long code;
 
-	frame = get_sigframe(&ksig->ka, regs->REG_SP, sizeof(*frame));
+	frame = get_sigframe(ksig, regs->REG_SP);
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return -EFAULT;
 
-- 
1.8.4.5
