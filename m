From: guoren@kernel.org
Subject: [PATCH] csky: fixup dead loop in show_stack
Date: Thu, 31 Jan 2019 15:02:42 +0800
Message-ID: <1548918162-2728-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, lu.baoquan@intellif.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

When STACKTRACE is enabled, we must pass fp as stack for unwind,
otherwise random value in stack will casue a dead loop.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Lu Baoquan <lu.baoquan@intellif.com>
---
 arch/csky/kernel/dumpstack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index 659253e..d67f977 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -38,7 +38,11 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		if (task)
 			stack = (unsigned long *)thread_saved_fp(task);
 		else
+#ifdef CONFIG_STACKTRACE
+			asm volatile("mov %0, r8\n":"=r"(stack)::"memory");
+#else
 			stack = (unsigned long *)&stack;
+#endif
 	}
 
 	show_trace(stack);
-- 
2.7.4
