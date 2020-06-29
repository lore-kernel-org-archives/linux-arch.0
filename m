Return-Path: <SRS0=AQMQ=AK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgF2Smn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:43 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 37/41] xtensa: switch to ->get2()
Date: Mon, 29 Jun 2020 19:26:24 +0100
Message-ID: <20200629182628.529995-37-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Message-ID: <20200629182624.-hrJbAKw3NGwEXBiwWxho4IK6IFtBG_h3Lr-43p64mM@z>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/xtensa/kernel/ptrace.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index b4c07bd890fe..d46180b69600 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -37,8 +37,7 @@
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	struct pt_regs *regs = task_pt_regs(target);
 	struct user_pt_regs newregs = {
@@ -60,8 +59,7 @@ static int gpr_get(struct task_struct *target,
 	       regs->areg,
 	       (WSBITS - regs->windowbase) * 16);
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &newregs, 0, -1);
+	return membuf_write(&to, &newregs, sizeof(newregs));
 }
 
 static int gpr_set(struct task_struct *target,
@@ -115,8 +113,7 @@ static int gpr_set(struct task_struct *target,
 
 static int tie_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	int ret;
 	struct pt_regs *regs = task_pt_regs(target);
@@ -141,8 +138,7 @@ static int tie_get(struct task_struct *target,
 	newregs->cp6 = ti->xtregs_cp.cp6;
 	newregs->cp7 = ti->xtregs_cp.cp7;
 #endif
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  newregs, 0, -1);
+	ret = membuf_write(&to, newregs, sizeof(*newregs));
 	kfree(newregs);
 	return ret;
 }
@@ -197,7 +193,7 @@ static const struct user_regset xtensa_regsets[] = {
 		.n = sizeof(struct user_pt_regs) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = gpr_get,
+		.get2 = gpr_get,
 		.set = gpr_set,
 	},
 	[REGSET_TIE] = {
@@ -205,7 +201,7 @@ static const struct user_regset xtensa_regsets[] = {
 		.n = sizeof(elf_xtregs_t) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = tie_get,
+		.get2 = tie_get,
 		.set = tie_set,
 	},
 };
-- 
2.11.0
