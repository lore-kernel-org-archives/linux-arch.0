From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/3] sched/kasan: remove stale KASAN poison after hotplug
Date: Wed,  2 Mar 2016 14:26:17 +0000
Message-ID: <1456928778-22491-3-git-send-email-mark.rutland@arm.com>
References: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, catalin.marinas@arm.com, glider@google.com, lorenzo.pieralisi@arm.com, mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com
List-Id: linux-arch.vger.kernel.org

Functions which the compiler has instrumented for ASAN place poison on
the stack shadow upon entry and remove this poison prior to returning.

In the case of CPU hotplug, CPUs exit the kernel a number of levels deep
in C code. Any instrumented functions on this critical path will leave
portions of the stack shadow poisoned.

When a CPU is subsequently brought back into the kernel via a different
path, depending on stackframe, layout calls to instrumented functions
may hit this stale poison, resulting in (spurious) KASAN splats to the
console.

To avoid this, clear any stale poison from the idle thread for a CPU
prior to bringing a CPU online.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9503d59..41f6b22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -26,6 +26,7 @@
  *              Thomas Gleixner, Mike Kravetz
  */
 
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/nmi.h>
@@ -5096,6 +5097,8 @@ void init_idle(struct task_struct *idle, int cpu)
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
 
+	kasan_unpoison_task_stack(idle);
+
 #ifdef CONFIG_SMP
 	/*
 	 * Its possible that init_idle() gets called multiple times on a task,
-- 
1.9.1
