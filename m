From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 30/41] riscv: switch to ->get2()
Date: Mon, 29 Jun 2020 19:26:17 +0100
Message-ID: <20200629182628.529995-30-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Note: riscv_fpr_get() used to forget to zero-pad at the end.
Not worth -stable...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/riscv/kernel/ptrace.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 444dc7b0fd78..a6896449eff8 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -30,13 +30,10 @@ enum riscv_regset {
 
 static int riscv_gpr_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
-	struct pt_regs *regs;
-
-	regs = task_pt_regs(target);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+	return membuf_write(&to, task_pt_regs(target),
+			    sizeof(struct user_regs_struct));
 }
 
 static int riscv_gpr_set(struct task_struct *target,
@@ -55,21 +52,13 @@ static int riscv_gpr_set(struct task_struct *target,
 #ifdef CONFIG_FPU
 static int riscv_fpr_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
-	int ret;
 	struct __riscv_d_ext_state *fstate = &target->thread.fstate;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, fstate, 0,
-				  offsetof(struct __riscv_d_ext_state, fcsr));
-	if (!ret) {
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, fstate, 0,
-					  offsetof(struct __riscv_d_ext_state, fcsr) +
-					  sizeof(fstate->fcsr));
-	}
-
-	return ret;
+	membuf_write(&to, fstate, offsetof(struct __riscv_d_ext_state, fcsr));
+	membuf_store(&to, fstate->fcsr);
+	return membuf_zero(&to, 4);	// explicitly pad
 }
 
 static int riscv_fpr_set(struct task_struct *target,
@@ -98,8 +87,8 @@ static const struct user_regset riscv_user_regset[] = {
 		.n = ELF_NGREG,
 		.size = sizeof(elf_greg_t),
 		.align = sizeof(elf_greg_t),
-		.get = &riscv_gpr_get,
-		.set = &riscv_gpr_set,
+		.get2 = riscv_gpr_get,
+		.set = riscv_gpr_set,
 	},
 #ifdef CONFIG_FPU
 	[REGSET_F] = {
@@ -107,8 +96,8 @@ static const struct user_regset riscv_user_regset[] = {
 		.n = ELF_NFPREG,
 		.size = sizeof(elf_fpreg_t),
 		.align = sizeof(elf_fpreg_t),
-		.get = &riscv_fpr_get,
-		.set = &riscv_fpr_set,
+		.get2 = riscv_fpr_get,
+		.set = riscv_fpr_set,
 	},
 #endif
 };
-- 
2.11.0
