From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] arch: remove unused macro/function thread_saved_pc()
Date: Wed, 28 Jun 2017 15:30:02 +0200
Message-ID: <20170628133003.17432-1-tklauser@distanz.ch>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:53780 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdF1NaO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2017 09:30:14 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

The only user of thread_saved_pc() in non-arch-specific code was removed
in commit 8243d5597793 ("sched/core: Remove pointless printout in
sched_show_task()"). Remove the implementations as well.

Some architectures use thread_saved_pc() in their arch-specific code.
Leave their thread_saved_pc() intact.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arc/include/asm/processor.h        |  2 --
 arch/blackfin/include/asm/processor.h   |  5 -----
 arch/c6x/include/asm/processor.h        |  5 -----
 arch/cris/arch-v10/kernel/process.c     |  8 --------
 arch/cris/arch-v32/kernel/process.c     |  8 --------
 arch/cris/include/asm/processor.h       |  2 --
 arch/frv/include/asm/processor.h        |  5 -----
 arch/frv/kernel/process.c               |  9 ---------
 arch/h8300/include/asm/processor.h      |  4 ----
 arch/h8300/kernel/process.c             |  5 -----
 arch/hexagon/include/asm/processor.h    |  3 ---
 arch/hexagon/kernel/process.c           |  8 --------
 arch/ia64/include/asm/processor.h       | 17 -----------------
 arch/m32r/include/asm/processor.h       |  2 --
 arch/m32r/kernel/process.c              |  8 --------
 arch/m68k/include/asm/processor.h       |  2 --
 arch/m68k/kernel/process.c              | 14 --------------
 arch/microblaze/include/asm/processor.h |  6 ------
 arch/microblaze/kernel/process.c        | 17 -----------------
 arch/mn10300/include/asm/processor.h    |  5 -----
 arch/mn10300/kernel/process.c           |  8 --------
 arch/nios2/include/asm/processor.h      |  3 ---
 arch/openrisc/include/asm/processor.h   |  5 -----
 arch/openrisc/kernel/process.c          |  5 -----
 arch/parisc/include/asm/processor.h     |  5 -----
 arch/parisc/kernel/process.c            |  5 -----
 arch/powerpc/include/asm/processor.h    |  6 ------
 arch/s390/include/asm/processor.h       |  5 -----
 arch/s390/kernel/process.c              | 25 -------------------------
 arch/score/include/asm/processor.h      |  1 -
 arch/score/kernel/process.c             |  5 -----
 arch/sparc/include/asm/processor_32.h   |  3 ---
 arch/sparc/include/asm/processor_64.h   |  2 --
 arch/sparc/kernel/process_32.c          |  8 --------
 arch/sparc/kernel/process_64.c          | 19 -------------------
 arch/tile/include/asm/processor.h       |  7 -------
 arch/um/include/asm/processor-generic.h |  2 --
 arch/um/kernel/um_arch.c                |  6 ------
 arch/x86/include/asm/processor.h        |  2 --
 arch/x86/kernel/process.c               | 11 -----------
 arch/xtensa/include/asm/processor.h     |  2 --
 41 files changed, 270 deletions(-)

diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
index 6e1242da0159..4104a0839214 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -86,8 +86,6 @@ struct task_struct;
 #define TSK_K_BLINK(tsk)	TSK_K_REG(tsk, 4)
 #define TSK_K_FP(tsk)		TSK_K_REG(tsk, 0)
 
-#define thread_saved_pc(tsk)	TSK_K_BLINK(tsk)
-
 extern void start_thread(struct pt_regs * regs, unsigned long pc,
 			 unsigned long usp);
 
diff --git a/arch/blackfin/include/asm/processor.h b/arch/blackfin/include/asm/processor.h
index 85d4af97c986..dbdbb8a558df 100644
--- a/arch/blackfin/include/asm/processor.h
+++ b/arch/blackfin/include/asm/processor.h
@@ -75,11 +75,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/*
- * Return saved PC of a blocked thread.
- */
-#define thread_saved_pc(tsk)	(tsk->thread.pc)
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define	KSTK_EIP(tsk)							\
diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
index b9eb3da7f278..7c87b5be53b5 100644
--- a/arch/c6x/include/asm/processor.h
+++ b/arch/c6x/include/asm/processor.h
@@ -96,11 +96,6 @@ static inline void release_thread(struct task_struct *dead_task)
 #define release_segments(mm)		do { } while (0)
 
 /*
- * saved PC of a blocked thread.
- */
-#define thread_saved_pc(tsk) (task_pt_regs(tsk)->pc)
-
-/*
  * saved kernel SP and DP of a blocked thread.
  */
 #ifdef _BIG_ENDIAN
diff --git a/arch/cris/arch-v10/kernel/process.c b/arch/cris/arch-v10/kernel/process.c
index e299d30105b5..a2cdb1521aca 100644
--- a/arch/cris/arch-v10/kernel/process.c
+++ b/arch/cris/arch-v10/kernel/process.c
@@ -69,14 +69,6 @@ void hard_reset_now (void)
 	while(1) /* waiting for RETRIBUTION! */ ;
 }
 
-/*
- * Return saved PC of a blocked thread.
- */
-unsigned long thread_saved_pc(struct task_struct *t)
-{
-	return task_pt_regs(t)->irp;
-}
-
 /* setup the child's kernel stack with a pt_regs and switch_stack on it.
  * it will be un-nested during _resume and _ret_from_sys_call when the
  * new thread is scheduled.
diff --git a/arch/cris/arch-v32/kernel/process.c b/arch/cris/arch-v32/kernel/process.c
index c530a8fa87ce..fe87b383fbf3 100644
--- a/arch/cris/arch-v32/kernel/process.c
+++ b/arch/cris/arch-v32/kernel/process.c
@@ -85,14 +85,6 @@ hard_reset_now(void)
 }
 
 /*
- * Return saved PC of a blocked thread.
- */
-unsigned long thread_saved_pc(struct task_struct *t)
-{
-	return task_pt_regs(t)->erp;
-}
-
-/*
  * Setup the child's kernel stack with a pt_regs and call switch_stack() on it.
  * It will be unnested during _resume and _ret_from_sys_call when the new thread
  * is scheduled.
diff --git a/arch/cris/include/asm/processor.h b/arch/cris/include/asm/processor.h
index 15b815df29c1..bc2729e4b2c9 100644
--- a/arch/cris/include/asm/processor.h
+++ b/arch/cris/include/asm/processor.h
@@ -52,8 +52,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_ESP(tsk)   ((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 /* Free all resources held by a thread. */
 static inline void release_thread(struct task_struct *dead_task)
 {
diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
index ddaeb9cc9143..e4d08d74ed9f 100644
--- a/arch/frv/include/asm/processor.h
+++ b/arch/frv/include/asm/processor.h
@@ -96,11 +96,6 @@ extern asmlinkage void *restore_user_regs(const struct user_context *target, ...
 #define release_segments(mm)		do { } while (0)
 #define forget_segments()		do { } while (0)
 
-/*
- * Return saved PC of a blocked thread.
- */
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define	KSTK_EIP(tsk)	((tsk)->thread.frame0->pc)
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
index 5a4c92abc99e..a957b374e3a6 100644
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -198,15 +198,6 @@ unsigned long get_wchan(struct task_struct *p)
 	return 0;
 }
 
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	/* Check whether the thread is blocked in resume() */
-	if (in_sched_functions(tsk->thread.pc))
-		return ((unsigned long *)tsk->thread.fp)[2];
-	else
-		return tsk->thread.pc;
-}
-
 int elf_check_arch(const struct elf32_hdr *hdr)
 {
 	unsigned long hsr0 = __get_HSR(0);
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index 65132d7ae9e5..afa53147e66a 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -110,10 +110,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/*
- * Return saved PC of a blocked thread.
- */
-unsigned long thread_saved_pc(struct task_struct *tsk);
 unsigned long get_wchan(struct task_struct *p);
 
 #define	KSTK_EIP(tsk)	\
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 0f5db5bb561b..d1ddcabbbe83 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -129,11 +129,6 @@ int copy_thread(unsigned long clone_flags,
 	return 0;
 }
 
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return ((struct pt_regs *)tsk->thread.esp0)->pc;
-}
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
index 45a825402f63..ce67940860a5 100644
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -33,9 +33,6 @@
 /*  task_struct, defined elsewhere, is the "process descriptor" */
 struct task_struct;
 
-/*  this is defined in arch/process.c  */
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 extern void start_thread(struct pt_regs *, unsigned long, unsigned long);
 
 /*
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index de715bab7956..656050c2e6a0 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -61,14 +61,6 @@ void arch_cpu_idle(void)
 }
 
 /*
- *  Return saved PC of a blocked thread
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return 0;
-}
-
-/*
  * Copy architecture-specific thread state
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 26a63d69c599..ab982f07ea68 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -602,23 +602,6 @@ ia64_set_unat (__u64 *unat, void *spill_addr, unsigned long nat)
 }
 
 /*
- * Return saved PC of a blocked thread.
- * Note that the only way T can block is through a call to schedule() -> switch_to().
- */
-static inline unsigned long
-thread_saved_pc (struct task_struct *t)
-{
-	struct unw_frame_info info;
-	unsigned long ip;
-
-	unw_init_from_blocked_task(&info, t);
-	if (unw_unwind(&info) < 0)
-		return 0;
-	unw_get_ip(&info, &ip);
-	return ip;
-}
-
-/*
  * Get the current instruction/program counter value.
  */
 #define current_text_addr() \
diff --git a/arch/m32r/include/asm/processor.h b/arch/m32r/include/asm/processor.h
index 5767367550c6..657874eeeccc 100644
--- a/arch/m32r/include/asm/processor.h
+++ b/arch/m32r/include/asm/processor.h
@@ -122,8 +122,6 @@ extern void release_thread(struct task_struct *);
 extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
 extern void release_segments(struct mm_struct * mm);
 
-extern unsigned long thread_saved_pc(struct task_struct *);
-
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(p, mm)  do { } while (0)
 #define release_segments(mm)  do { } while (0)
diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
index d8ffcfec599c..8cd7e03f4370 100644
--- a/arch/m32r/kernel/process.c
+++ b/arch/m32r/kernel/process.c
@@ -39,14 +39,6 @@
 
 #include <linux/err.h>
 
-/*
- * Return saved PC of a blocked thread.
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return tsk->thread.lr;
-}
-
 void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
 
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index 77239e81379b..94c36030440c 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -130,8 +130,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define	KSTK_EIP(tsk)	\
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index e475c945c8b2..7df92f8b0781 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -40,20 +40,6 @@
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
-
-/*
- * Return saved PC from a blocked thread
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
-	/* Check whether the thread is blocked in resume() */
-	if (in_sched_functions(sw->retpc))
-		return ((unsigned long *)sw->a6)[1];
-	else
-		return sw->retpc;
-}
-
 void arch_cpu_idle(void)
 {
 #if defined(MACH_ATARI_ONLY)
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 37ef196e4519..330d556860ba 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -69,8 +69,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-extern unsigned long thread_saved_pc(struct task_struct *t);
-
 extern unsigned long get_wchan(struct task_struct *p);
 
 # define KSTK_EIP(tsk)	(0)
@@ -121,10 +119,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/* Return saved (kernel) PC of a blocked thread.  */
-#  define thread_saved_pc(tsk)	\
-	((tsk)->thread.regs ? (tsk)->thread.regs->r15 : 0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 /* The size allocated for kernel stacks. This _must_ be a power of two! */
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index e92a817e645f..6527ec22f158 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -119,23 +119,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
-#ifndef CONFIG_MMU
-/*
- * Return saved PC of a blocked thread.
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	struct cpu_context *ctx =
-		&(((struct thread_info *)(tsk->stack))->cpu_context);
-
-	/* Check whether the thread is blocked in resume() */
-	if (in_sched_functions(ctx->r15))
-		return (unsigned long)ctx->r15;
-	else
-		return ctx->r14;
-}
-#endif
-
 unsigned long get_wchan(struct task_struct *p)
 {
 /* TBD (used by procfs) */
diff --git a/arch/mn10300/include/asm/processor.h b/arch/mn10300/include/asm/processor.h
index 18e17abf7664..3ae479117b42 100644
--- a/arch/mn10300/include/asm/processor.h
+++ b/arch/mn10300/include/asm/processor.h
@@ -132,11 +132,6 @@ static inline void start_thread(struct pt_regs *regs,
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-/*
- * Return saved PC of a blocked thread.
- */
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define task_pt_regs(task) ((task)->thread.uregs)
diff --git a/arch/mn10300/kernel/process.c b/arch/mn10300/kernel/process.c
index c9fa42619c6a..89e8027e07fb 100644
--- a/arch/mn10300/kernel/process.c
+++ b/arch/mn10300/kernel/process.c
@@ -40,14 +40,6 @@
 #include "internal.h"
 
 /*
- * return saved PC of a blocked thread.
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return ((unsigned long *) tsk->thread.sp)[3];
-}
-
-/*
  * power off function, if any
  */
 void (*pm_power_off)(void);
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
index 3bbbc3d798e5..4944e2e1d8b0 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -75,9 +75,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/* Return saved PC of a blocked thread. */
-#define thread_saved_pc(tsk)	((tsk)->thread.kregs->ea)
-
 extern unsigned long get_wchan(struct task_struct *p);
 
 #define task_pt_regs(p) \
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index a908e6c30a00..396d8f306c21 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -84,11 +84,6 @@ void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
 void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);
 
-/*
- * Return saved PC of a blocked thread. For now, this is the "user" PC
- */
-extern unsigned long thread_saved_pc(struct task_struct *t);
-
 #define init_stack      (init_thread_union.stack)
 
 #define cpu_relax()     barrier()
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index ccb7d128dd00..8739b6d75005 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -110,11 +110,6 @@ void show_regs(struct pt_regs *regs)
 	show_registers(regs);
 }
 
-unsigned long thread_saved_pc(struct task_struct *t)
-{
-	return (unsigned long)user_regs(t->stack)->pc;
-}
-
 void release_thread(struct task_struct *dead_task)
 {
 }
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index ea4e6ae091d0..b3b66c3d6f3c 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -165,12 +165,7 @@ struct thread_struct {
 	.flags		= 0 \
 	}
 
-/*
- * Return saved PC of a blocked thread.  This is used by ps mostly.
- */
-
 struct task_struct;
-unsigned long thread_saved_pc(struct task_struct *t);
 void show_trace(struct task_struct *task, unsigned long *stack);
 
 /*
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 4516a5b53f38..b64d7d21646e 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -239,11 +239,6 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
-unsigned long thread_saved_pc(struct task_struct *t)
-{
-	return t->thread.regs.kpc;
-}
-
 unsigned long
 get_wchan(struct task_struct *p)
 {
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 074014f185cd..44f9a6124798 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -378,12 +378,6 @@ struct thread_struct {
 }
 #endif
 
-/*
- * Return saved PC of a blocked thread. For now, this is the "user" PC
- */
-#define thread_saved_pc(tsk)    \
-        ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
-
 #define task_pt_regs(tsk)	((struct pt_regs *)(tsk)->thread.regs)
 
 unsigned long get_wchan(struct task_struct *p);
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index f57c017a5c03..4eb9cbb9be7e 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -221,11 +221,6 @@ extern void release_thread(struct task_struct *);
 /* Free guarded storage control block for current */
 void exit_thread_gs(void);
 
-/*
- * Return saved PC of a blocked thread.
- */
-extern unsigned long thread_saved_pc(struct task_struct *t);
-
 unsigned long get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \
         (task_stack_page(tsk) + THREAD_SIZE) - 1)
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 999d7154bbdc..bb32b8618bf6 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -41,31 +41,6 @@
 
 asmlinkage void ret_from_fork(void) asm ("ret_from_fork");
 
-/*
- * Return saved PC of a blocked thread. used in kernel/sched.
- * resume in entry.S does not create a new stack frame, it
- * just stores the registers %r6-%r15 to the frame given by
- * schedule. We want to return the address of the caller of
- * schedule, so we have to walk the backchain one time to
- * find the frame schedule() store its return address.
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	struct stack_frame *sf, *low, *high;
-
-	if (!tsk || !task_stack_page(tsk))
-		return 0;
-	low = task_stack_page(tsk);
-	high = (struct stack_frame *) task_pt_regs(tsk);
-	sf = (struct stack_frame *) tsk->thread.ksp;
-	if (sf <= low || sf > high)
-		return 0;
-	sf = (struct stack_frame *) sf->back_chain;
-	if (sf <= low || sf > high)
-		return 0;
-	return sf->gprs[8];
-}
-
 extern void kernel_thread_starter(void);
 
 /*
diff --git a/arch/score/include/asm/processor.h b/arch/score/include/asm/processor.h
index d9a922d8711b..299274581968 100644
--- a/arch/score/include/asm/processor.h
+++ b/arch/score/include/asm/processor.h
@@ -13,7 +13,6 @@ struct task_struct;
  */
 extern void (*cpu_wait)(void);
 
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
 extern void start_thread(struct pt_regs *regs,
 			unsigned long pc, unsigned long sp);
 extern unsigned long get_wchan(struct task_struct *p);
diff --git a/arch/score/kernel/process.c b/arch/score/kernel/process.c
index eb64d7a677cb..6e20241a1ed4 100644
--- a/arch/score/kernel/process.c
+++ b/arch/score/kernel/process.c
@@ -101,11 +101,6 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *r)
 	return 1;
 }
 
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return task_pt_regs(tsk)->cp0_epc;
-}
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	if (!task || task == current || task->state == TASK_RUNNING)
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index dd27159819eb..b395e5620c0b 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -67,9 +67,6 @@ struct thread_struct {
 	.current_ds = KERNEL_DS, \
 }
 
-/* Return saved PC of a blocked thread. */
-unsigned long thread_saved_pc(struct task_struct *t);
-
 /* Do necessary setup to start up a newly executed thread. */
 static inline void start_thread(struct pt_regs * regs, unsigned long pc,
 				    unsigned long sp)
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index b58ee9018433..f04dc5a43062 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -89,9 +89,7 @@ struct thread_struct {
 #include <linux/types.h>
 #include <asm/fpumacro.h>
 
-/* Return saved PC of a blocked thread. */
 struct task_struct;
-unsigned long thread_saved_pc(struct task_struct *);
 
 /* On Uniprocessor, even in RMO processes see TSO semantics */
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index b6dac8e980f0..9245f93398c7 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -177,14 +177,6 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 }
 
 /*
- * Note: sparc64 has a pretty intricated thread_saved_pc, check it out.
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return task_thread_info(tsk)->kpc;
-}
-
-/*
  * Free current thread data structures etc..
  */
 void exit_thread(struct task_struct *tsk)
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 1badc493e62e..b96104da5bd6 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -400,25 +400,6 @@ core_initcall(sparc_sysrq_init);
 
 #endif
 
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	struct thread_info *ti = task_thread_info(tsk);
-	unsigned long ret = 0xdeadbeefUL;
-	
-	if (ti && ti->ksp) {
-		unsigned long *sp;
-		sp = (unsigned long *)(ti->ksp + STACK_BIAS);
-		if (((unsigned long)sp & (sizeof(long) - 1)) == 0UL &&
-		    sp[14]) {
-			unsigned long *fp;
-			fp = (unsigned long *)(sp[14] + STACK_BIAS);
-			if (((unsigned long)fp & (sizeof(long) - 1)) == 0UL)
-				ret = fp[15];
-		}
-	}
-	return ret;
-}
-
 /* Free current thread data structures etc.. */
 void exit_thread(struct task_struct *tsk)
 {
diff --git a/arch/tile/include/asm/processor.h b/arch/tile/include/asm/processor.h
index 0bc9968b97a1..f71e5206650b 100644
--- a/arch/tile/include/asm/processor.h
+++ b/arch/tile/include/asm/processor.h
@@ -214,13 +214,6 @@ static inline void release_thread(struct task_struct *dead_task)
 
 extern void prepare_exit_to_usermode(struct pt_regs *regs, u32 flags);
 
-
-/*
- * Return saved (kernel) PC of a blocked thread.
- * Only used in a printk() in kernel/sched/core.c, so don't work too hard.
- */
-#define thread_saved_pc(t)   ((t)->thread.pc)
-
 unsigned long get_wchan(struct task_struct *p);
 
 /* Return initial ksp value for given task. */
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 2d1e0dd5bb0b..f6d1a3f747a9 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -58,8 +58,6 @@ static inline void release_thread(struct task_struct *task)
 {
 }
 
-extern unsigned long thread_saved_pc(struct task_struct *t);
-
 static inline void mm_copy_segments(struct mm_struct *from_mm,
 				    struct mm_struct *new_mm)
 {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 64a1fd06f3fd..7b5640117325 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -56,12 +56,6 @@ union thread_union cpu0_irqstack
 	__attribute__((__section__(".data..init_irqstack"))) =
 		{ INIT_THREAD_INFO(init_task) };
 
-unsigned long thread_saved_pc(struct task_struct *task)
-{
-	/* FIXME: Need to look up userspace_pid by cpu */
-	return os_process_pc(userspace_pid[0]);
-}
-
 /* Changed in setup_arch, which is called in early boot */
 static char host_info[(__NEW_UTS_LEN + 1) * 5];
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 84a0f19372e6..028245e1c42b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -868,8 +868,6 @@ extern unsigned long KSTK_ESP(struct task_struct *task);
 
 #endif /* CONFIG_X86_64 */
 
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 					       unsigned long new_sp);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 0bb88428cbf2..3ca198080ea9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -545,17 +545,6 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 }
 
 /*
- * Return saved PC of a blocked thread.
- * What is this good for? it will be always the scheduler or ret_from_fork.
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	struct inactive_task_frame *frame =
-		(struct inactive_task_frame *) READ_ONCE(tsk->thread.sp);
-	return READ_ONCE_NOCHECK(frame->ret_addr);
-}
-
-/*
  * Called from fs/proc with a reference on @p to find the function
  * which called into schedule(). This needs to be done carefully
  * because the task might wake up and we might look at a stack
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 003eeee3fbc6..30ee8c608853 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -213,8 +213,6 @@ struct mm_struct;
 #define release_segments(mm)	do { } while(0)
 #define forget_segments()	do { } while (0)
 
-#define thread_saved_pc(tsk)	(task_pt_regs(tsk)->pc)
-
 extern unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
-- 
2.13.0
