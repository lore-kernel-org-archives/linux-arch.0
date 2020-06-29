From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 35/41] nds32: switch to ->get2()
Date: Mon, 29 Jun 2020 19:26:22 +0100
Message-ID: <20200629182628.529995-35-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/nds32/kernel/ptrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/nds32/kernel/ptrace.c b/arch/nds32/kernel/ptrace.c
index eaaf7a999b20..feaf9b33f517 100644
--- a/arch/nds32/kernel/ptrace.c
+++ b/arch/nds32/kernel/ptrace.c
@@ -13,11 +13,10 @@ enum nds32_regset {
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user * ubuf)
+		   struct membuf to)
 {
-	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
+	return membuf_write(&to, &task_pt_regs(target)->user_regs,
+				sizeof(struct user_pt_regs));
 }
 
 static int gpr_set(struct task_struct *target, const struct user_regset *regset,
@@ -41,7 +40,7 @@ static const struct user_regset nds32_regsets[] = {
 			.n = sizeof(struct user_pt_regs) / sizeof(u32),
 			.size = sizeof(elf_greg_t),
 			.align = sizeof(elf_greg_t),
-			.get = gpr_get,
+			.get2 = gpr_get,
 			.set = gpr_set}
 };
 
-- 
2.11.0
