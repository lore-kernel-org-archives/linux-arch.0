From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 31/41] openrisc: switch to ->get2()
Date: Mon, 29 Jun 2020 19:26:18 +0100
Message-ID: <20200629182628.529995-31-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/openrisc/kernel/ptrace.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index c8f47a623754..0b762fc00999 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -44,29 +44,15 @@
  */
 static int genregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user * ubuf)
+		       struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	int ret;
 
 	/* r0 */
-	ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf, 0, 4);
-
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  regs->gpr+1, 4, 4*32);
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &regs->pc, 4*32, 4*33);
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &regs->sr, 4*33, 4*34);
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       4*34, -1);
-
-	return ret;
+	membuf_zero(&to, 4);
+	membuf_write(&to, regs->gpr + 1, 31 * 4);
+	membuf_store(&to, regs->pc);
+	return membuf_store(&to, regs->sr);
 }
 
 /*
@@ -114,7 +100,7 @@ static const struct user_regset or1k_regsets[] = {
 			    .n = ELF_NGREG,
 			    .size = sizeof(long),
 			    .align = sizeof(long),
-			    .get = genregs_get,
+			    .get2 = genregs_get,
 			    .set = genregs_set,
 			    },
 };
-- 
2.11.0
