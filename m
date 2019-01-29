From: guoren@kernel.org
Subject: [PATCH 07/10] csky: Fixup wrong pt_regs size
Date: Tue, 29 Jan 2019 20:24:26 +0800
Message-ID: <1548764669-16656-7-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The bug is from commit 2054f4af1957 ("csky: bugfix gdb coredump error.")

We change the ELF_NGREG to ELF_NGREG - 2 to fit gdb&gcc define, but forgot
modify ptrace regset.
Now coredump use ELF_NRGEG to parse GPRs and ptrace use pt_regs_regset, so
there are two different reg_sets for userspace.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 57f1afe..f2f12ff 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -8,6 +8,7 @@
 #include <linux/ptrace.h>
 #include <linux/regset.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/uaccess.h>
@@ -159,7 +160,7 @@ static int fpr_set(struct task_struct *target,
 static const struct user_regset csky_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = ELF_NGREG,
+		.n = sizeof(struct pt_regs) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
 		.get = &gpr_get,
-- 
2.7.4
