From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 14/41] arm64: take fetching compat reg out of pt_regs into a new helper
Date: Mon, 29 Jun 2020 19:26:01 +0100
Message-ID: <20200629182628.529995-14-viro@ZenIV.linux.org.uk>
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
 arch/arm64/kernel/ptrace.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 68b7f34a08f5..5b837741ab76 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1237,6 +1237,22 @@ enum compat_regset {
 	REGSET_COMPAT_VFP,
 };
 
+static inline compat_ulong_t compat_get_user_reg(struct task_struct *task, int idx)
+{
+	struct pt_regs *regs = task_pt_regs(task);
+
+	switch (idx) {
+	case 15:
+		return regs->pc;
+	case 16:
+		return pstate_to_compat_psr(regs->pstate);
+	case 17:
+		return regs->orig_x0;
+	default:
+		return regs->regs[idx];
+	}
+}
+
 static int compat_gpr_get(struct task_struct *target,
 			  const struct user_regset *regset,
 			  unsigned int pos, unsigned int count,
@@ -1255,23 +1271,7 @@ static int compat_gpr_get(struct task_struct *target,
 		return -EIO;
 
 	for (i = 0; i < num_regs; ++i) {
-		unsigned int idx = start + i;
-		compat_ulong_t reg;
-
-		switch (idx) {
-		case 15:
-			reg = task_pt_regs(target)->pc;
-			break;
-		case 16:
-			reg = task_pt_regs(target)->pstate;
-			reg = pstate_to_compat_psr(reg);
-			break;
-		case 17:
-			reg = task_pt_regs(target)->orig_x0;
-			break;
-		default:
-			reg = task_pt_regs(target)->regs[idx];
-		}
+		compat_ulong_t reg = compat_get_user_reg(target, start + i);
 
 		if (kbuf) {
 			memcpy(kbuf, &reg, sizeof(reg));
-- 
2.11.0
