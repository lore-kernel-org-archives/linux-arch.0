From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] arch: remove unused *_segments() macros/functions
Date: Fri, 22 Sep 2017 09:42:42 +0200
Message-ID: <20170922074242.20868-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-metag@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Some architectures define the no-op macros/functions copy_segments,
release_segments and forget_segments. These are used nowhere in the
tree, so removed them.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arc/include/asm/processor.h        |  3 ---
 arch/c6x/include/asm/processor.h        |  3 ---
 arch/frv/include/asm/processor.h        |  4 ----
 arch/m32r/include/asm/processor.h       |  8 --------
 arch/metag/include/asm/processor.h      |  3 ---
 arch/mn10300/kernel/process.c           | 12 ------------
 arch/sh/include/asm/processor_32.h      |  4 ----
 arch/sh/include/asm/processor_64.h      |  4 ----
 arch/um/include/asm/processor-generic.h |  5 -----
 arch/xtensa/include/asm/processor.h     |  5 -----
 10 files changed, 51 deletions(-)

diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
index d400a2161935..8ee41e988169 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -78,9 +78,6 @@ struct task_struct;
 
 #endif
 
-#define copy_segments(tsk, mm)      do { } while (0)
-#define release_segments(mm)        do { } while (0)
-
 #define KSTK_EIP(tsk)   (task_pt_regs(tsk)->ret)
 #define KSTK_ESP(tsk)   (task_pt_regs(tsk)->sp)
 
diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
index 7c87b5be53b5..8f7cce829f8e 100644
--- a/arch/c6x/include/asm/processor.h
+++ b/arch/c6x/include/asm/processor.h
@@ -92,9 +92,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 /*
  * saved kernel SP and DP of a blocked thread.
  */
diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
index e4d08d74ed9f..021cce78b401 100644
--- a/arch/frv/include/asm/processor.h
+++ b/arch/frv/include/asm/processor.h
@@ -92,10 +92,6 @@ static inline void release_thread(struct task_struct *dead_task)
 extern asmlinkage void save_user_regs(struct user_context *target);
 extern asmlinkage void *restore_user_regs(const struct user_context *target, ...);
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-#define forget_segments()		do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define	KSTK_EIP(tsk)	((tsk)->thread.frame0->pc)
diff --git a/arch/m32r/include/asm/processor.h b/arch/m32r/include/asm/processor.h
index 657874eeeccc..c70fa9ac7169 100644
--- a/arch/m32r/include/asm/processor.h
+++ b/arch/m32r/include/asm/processor.h
@@ -118,14 +118,6 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-/* Copy and release all segment info associated with a VM */
-extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
-extern void release_segments(struct mm_struct * mm);
-
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm)  do { } while (0)
-#define release_segments(mm)  do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)  ((tsk)->thread.lr)
 #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
diff --git a/arch/metag/include/asm/processor.h b/arch/metag/include/asm/processor.h
index ec6a49076980..8ae92d6abfd2 100644
--- a/arch/metag/include/asm/processor.h
+++ b/arch/metag/include/asm/processor.h
@@ -131,9 +131,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 /*
  * Return saved PC of a blocked thread.
  */
diff --git a/arch/mn10300/kernel/process.c b/arch/mn10300/kernel/process.c
index 89e8027e07fb..7c475fd99c46 100644
--- a/arch/mn10300/kernel/process.c
+++ b/arch/mn10300/kernel/process.c
@@ -59,10 +59,6 @@ void arch_cpu_idle(void)
 }
 #endif
 
-void release_segments(struct mm_struct *mm)
-{
-}
-
 void machine_restart(char *cmd)
 {
 #ifdef CONFIG_KERNEL_DEBUGGER
@@ -113,14 +109,6 @@ void release_thread(struct task_struct *dead_task)
 }
 
 /*
- * we do not have to muck with descriptors here, that is
- * done in switch_mm() as needed.
- */
-void copy_segments(struct task_struct *p, struct mm_struct *new_mm)
-{
-}
-
-/*
  * this gets called so that we can store lazy state into memory and copy the
  * current task into the new thread.
  */
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 18e0377f72bb..88ce1e22237b 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -136,10 +136,6 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_pc, unsigned lo
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm)	do { } while(0)
-#define release_segments(mm)	do { } while(0)
-
 /*
  * FPU lazy state save handling.
  */
diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
index eedd4f625d07..777a16318aff 100644
--- a/arch/sh/include/asm/processor_64.h
+++ b/arch/sh/include/asm/processor_64.h
@@ -170,10 +170,6 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm)	do { } while (0)
-#define release_segments(mm)	do { } while (0)
-#define forget_segments()	do { } while (0)
 /*
  * FPU lazy state save handling.
  */
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index f6d1a3f747a9..86942a492454 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -58,11 +58,6 @@ static inline void release_thread(struct task_struct *task)
 {
 }
 
-static inline void mm_copy_segments(struct mm_struct *from_mm,
-				    struct mm_struct *new_mm)
-{
-}
-
 #define init_stack	(init_thread_union.stack)
 
 /*
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 30ee8c608853..5b0027d4ecc0 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -208,11 +208,6 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm)	do { } while(0)
-#define release_segments(mm)	do { } while(0)
-#define forget_segments()	do { } while (0)
-
 extern unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
-- 
2.13.0
