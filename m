From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 29/41] c6x: switch to ->get2()
Date: Mon, 29 Jun 2020 19:26:16 +0100
Message-ID: <20200629182628.529995-29-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/c6x/kernel/ptrace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/kernel/ptrace.c b/arch/c6x/kernel/ptrace.c
index 67af1562da86..d2402de2bc14 100644
--- a/arch/c6x/kernel/ptrace.c
+++ b/arch/c6x/kernel/ptrace.c
@@ -57,14 +57,9 @@ static inline int put_reg(struct task_struct *task,
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	struct pt_regs *regs = task_pt_regs(target);
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   regs,
-				   0, sizeof(*regs));
+	return membuf_write(&to, task_pt_regs(target), sizeof(struct pt_regs));
 }
 
 enum c6x_regset {
@@ -77,7 +72,7 @@ static const struct user_regset c6x_regsets[] = {
 		.n = ELF_NGREG,
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = gpr_get,
+		.get2 = gpr_get,
 	},
 };
 
-- 
2.11.0
