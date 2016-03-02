From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] kasan: add functions to clear stack poison
Date: Wed,  2 Mar 2016 14:26:16 +0000
Message-ID: <1456928778-22491-2-git-send-email-mark.rutland@arm.com>
References: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456928778-22491-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, catalin.marinas@arm.com, glider@google.com, lorenzo.pieralisi@arm.com, mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com
List-Id: linux-arch.vger.kernel.org

Functions which the compiler has instrumented for ASAN place poison on
the stack shadow upon entry and remove this poison prior to returning.

In some cases (e.g. hotplug and idle), CPUs may exit the kernel a number
of levels deep in C code. If there are any instrumented functions on
this critical path, these will leave portions of the stack shadow
poisoned.

If a CPU returns to the kernel via a different path (e.g. a cold entry),
then depending on stack frame layout subsequent calls to instrumented
functions may use regions of the stack with stale poison, resulting in
(spurious) KASAN splats to the console.

To avoid this, we must clear stale poison from the stack prior to
instrumented functions being called. This patch adds functions to the
KASAN core for removing poison from (portions of) a task's stack. These
will be used by subsequent patches to avoid problems with hotplug and
idle.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/linux/kasan.h |  6 +++++-
 mm/kasan/kasan.c      | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4b9f85c..0fdc798 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_KASAN_H
 #define _LINUX_KASAN_H
 
+#include <linux/sched.h>
 #include <linux/types.h>
 
 struct kmem_cache;
@@ -13,7 +14,6 @@ struct vm_struct;
 
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
-#include <linux/sched.h>
 
 extern unsigned char kasan_zero_page[PAGE_SIZE];
 extern pte_t kasan_zero_pte[PTRS_PER_PTE];
@@ -43,6 +43,8 @@ static inline void kasan_disable_current(void)
 
 void kasan_unpoison_shadow(const void *address, size_t size);
 
+void kasan_unpoison_task_stack(struct task_struct *task);
+
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
@@ -66,6 +68,8 @@ void kasan_free_shadow(const struct vm_struct *vm);
 
 static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
 
+static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
+
 static inline void kasan_enable_current(void) {}
 static inline void kasan_disable_current(void) {}
 
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index bc0a8d8..76cf26cc 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
+#include <linux/linkage.h>
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/mm.h>
@@ -60,6 +61,25 @@ void kasan_unpoison_shadow(const void *address, size_t size)
 	}
 }
 
+static void __kasan_unpoison_stack(struct task_struct *task, void *sp)
+{
+	void *base = task_thread_info(task) + 1;
+	size_t size = sp - base;
+
+	kasan_unpoison_shadow(base, size);
+}
+
+/* Unpoison the entire stack for a task. */
+void kasan_unpoison_task_stack(struct task_struct *task)
+{
+	__kasan_unpoison_stack(task, task_stack_page(task) + THREAD_SIZE);
+}
+
+/* Unpoison the stack for the current task beyond a watermark sp value. */
+asmlinkage void kasan_unpoison_remaining_stack(void *sp)
+{
+	__kasan_unpoison_stack(current, sp);
+}
 
 /*
  * All functions below always inlined so compiler could
-- 
1.9.1
