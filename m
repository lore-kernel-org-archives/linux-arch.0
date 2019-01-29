From: guoren@kernel.org
Subject: [PATCH 08/10] csky: coding convention: Use task_stack_page
Date: Tue, 29 Jan 2019 20:24:27 +0800
Message-ID: <1548764669-16656-8-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Use task_stack_page instead of p->stack to get stack. Follow the coding
convention style. Also for init_stack, the same with other archs.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/processor.h | 4 ++--
 arch/csky/kernel/smp.c            | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 8f45481..21e0bd5 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -49,7 +49,7 @@ struct thread_struct {
 };
 
 #define INIT_THREAD  { \
-	.ksp = (unsigned long) init_thread_union.stack + THREAD_SIZE, \
+	.ksp = sizeof(init_stack) + (unsigned long) &init_stack, \
 	.sr = DEFAULT_PSR_VALUE, \
 }
 
@@ -95,7 +95,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->usp)
 
 #define task_pt_regs(p) \
-	((struct pt_regs *)(THREAD_SIZE + p->stack) - 1)
+	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
 
 #define cpu_relax() barrier()
 
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index ddc4dd7..b07a534 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -160,7 +160,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	unsigned long mask = 1 << cpu;
 
-	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE - 8;
+	secondary_stack =
+		(unsigned int) task_stack_page(tidle) + THREAD_SIZE - 8;
 	secondary_hint = mfcr("cr31");
 	secondary_ccr  = mfcr("cr18");
 
-- 
2.7.4
