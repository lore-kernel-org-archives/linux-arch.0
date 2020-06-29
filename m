From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 32/41] h8300: switch to ->get2()
Date: Mon, 29 Jun 2020 19:26:19 +0100
Message-ID: <20200629182628.529995-32-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgF2Smn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:43 -0400
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/h8300/kernel/ptrace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/h8300/kernel/ptrace.c b/arch/h8300/kernel/ptrace.c
index 0dc1c8f622bc..a99cbe91a6d3 100644
--- a/arch/h8300/kernel/ptrace.c
+++ b/arch/h8300/kernel/ptrace.c
@@ -87,20 +87,15 @@ int h8300_put_reg(struct task_struct *task, int regno, unsigned long data)
 
 static int regs_get(struct task_struct *target,
 		    const struct user_regset *regset,
-		    unsigned int pos, unsigned int count,
-		    void *kbuf, void __user *ubuf)
+		    struct membuf to)
 {
 	int r;
-	struct user_regs_struct regs;
-	long *reg = (long *)&regs;
 
-	/* build user regs in buffer */
-	BUILD_BUG_ON(sizeof(regs) % sizeof(long) != 0);
-	for (r = 0; r < sizeof(regs) / sizeof(long); r++)
-		*reg++ = h8300_get_reg(target, r);
+	BUILD_BUG_ON(sizeof(struct user_regs_struct) % sizeof(long) != 0);
+	for (r = 0; r < ELF_NGREG; r++)
+		membuf_store(&to, h8300_get_reg(target, r));
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &regs, 0, sizeof(regs));
+	return 0;
 }
 
 static int regs_set(struct task_struct *target,
@@ -139,7 +134,7 @@ static const struct user_regset h8300_regsets[] = {
 		.n		= ELF_NGREG,
 		.size		= sizeof(long),
 		.align		= sizeof(long),
-		.get		= regs_get,
+		.get2		= regs_get,
 		.set		= regs_set,
 	},
 };
-- 
2.11.0
