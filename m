Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:5286 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261794AbUCaHfq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2004 02:35:46 -0500
Date: Tue, 30 Mar 2004 23:35:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: generalize/fix wchan calculation via ELF sections
Message-ID: <20040331073539.GX791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

The following patch generalizes/fixes wchan calculations via ELF sections.
I've tried to sweep all arches, which is where arch ppl come in.

Basically, I'm looking to see if I flubbed the patch and may not have
swept all arches properly, or whether arch maintainers dislike whatever
aspects of it since it goes poking around their code. Whatever kind of
feedback may be relevant wrt. methods/cleanliness/etc. is also good.


-- wli


Index: sched-2.6.5-rc3/arch/alpha/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/alpha/kernel/process.c	2004-03-29 19:27:07.000000000 -0800
+++ sched-2.6.5-rc3/arch/alpha/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -513,11 +513,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long
 get_wchan(struct task_struct *p)
 {
@@ -536,7 +531,8 @@
 	 */
 
 	pc = thread_saved_pc(p);
-	if (pc >= first_sched && pc < last_sched) {
+	if (pc >= scheduling_functions_start_here &&
+			pc < scheduling_functions_end_here) {
 		schedule_frame = ((unsigned long *)p->thread_info->pcb.ksp)[6];
 		return ((unsigned long *)schedule_frame)[12];
 	}
Index: sched-2.6.5-rc3/arch/alpha/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/alpha/kernel/semaphore.c	2004-03-29 19:26:17.000000000 -0800
+++ sched-2.6.5-rc3/arch/alpha/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 
 /*
  * This is basically the PPC semaphore scheme ported to use
@@ -60,7 +61,7 @@
  * Either form may be used in conjunction with "up()".
  */
 
-void
+__sched void
 __down_failed(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
@@ -101,7 +102,7 @@
 #endif
 }
 
-int
+__sched int
 __down_failed_interruptible(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
@@ -159,7 +160,7 @@
 	wake_up(&sem->wait);
 }
 
-void
+__sched void
 down(struct semaphore *sem)
 {
 #if WAITQUEUE_DEBUG
@@ -173,7 +174,7 @@
 	__down(sem);
 }
 
-int
+__sched int
 down_interruptible(struct semaphore *sem)
 {
 #if WAITQUEUE_DEBUG
Index: sched-2.6.5-rc3/arch/alpha/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/alpha/kernel/vmlinux.lds.S	2004-03-29 19:26:17.000000000 -0800
+++ sched-2.6.5-rc3/arch/alpha/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -17,6 +17,9 @@
   _text = .;					/* Text and read-only data */
   .text : { 
 	*(.text) 
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
   } :kernel
Index: sched-2.6.5-rc3/arch/arm/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm/kernel/process.c	2004-03-29 19:27:15.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -414,11 +414,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
@@ -433,7 +428,8 @@
 		if (fp < stack_page || fp > 4092+stack_page)
 			return 0;
 		lr = pc_pointer (((unsigned long *)fp)[-1]);
-		if (lr < first_sched || lr > last_sched)
+		if (lr < scheduling_functions_start_here ||
+				lr > scheduling_functions_end_here)
 			return lr;
 		fp = *(unsigned long *) (fp - 12);
 	} while (count ++ < 16);
Index: sched-2.6.5-rc3/arch/arm/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm/kernel/semaphore.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -13,6 +13,7 @@
  */
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -54,7 +55,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -87,7 +88,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -176,7 +177,8 @@
  * registers (r0 to r3 and lr), but not ip, as we use it as a return
  * value in some cases..
  */
-asm("	.align	5				\n\
+asm("	.section .sched.text			\n\
+	.align	5				\n\
 	.globl	__down_failed			\n\
 __down_failed:					\n\
 	stmfd	sp!, {r0 - r3, lr}		\n\
Index: sched-2.6.5-rc3/arch/arm/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm/kernel/vmlinux.lds.S	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -73,6 +73,9 @@
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			__scheduling_functions_start_here = .;
+			*(.sched.text)
+			__scheduling_functions_end_here = .;
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: sched-2.6.5-rc3/arch/arm26/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/process.c	2004-03-29 19:27:14.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -400,11 +400,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
@@ -419,7 +414,8 @@
 		if (fp < stack_page || fp > 4092+stack_page)
 			return 0;
 		lr = pc_pointer (((unsigned long *)fp)[-1]);
-		if (lr < first_sched || lr > last_sched)
+		if (lr < scheduling_functions_start_here ||
+				lr > scheduling_functions_end_here)
 			return lr;
 		fp = *(unsigned long *) (fp - 12);
 	} while (count ++ < 16);
Index: sched-2.6.5-rc3/arch/arm26/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/semaphore.c	2004-03-29 19:25:38.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -56,7 +57,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -89,7 +90,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -178,7 +179,8 @@
  * registers (r0 to r3 and lr), but not ip, as we use it as a return
  * value in some cases..
  */
-asm("	.align	5				\n\
+asm("	.section .sched.text			\n\
+	.align	5				\n\
 	.globl	__down_failed			\n\
 __down_failed:					\n\
 	stmfd	sp!, {r0 - r3, lr}		\n\
Index: sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26-xip.lds.in
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2004-03-29 19:27:04.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26-xip.lds.in	2004-03-30 23:25:36.000000000 -0800
@@ -66,6 +66,9 @@
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			__scheduling_functions_start_here = .;
+			*(.sched.text)
+			__scheduling_functions_end_here = .;
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26.lds.in
===================================================================
--- sched-2.6.5-rc3.orig/arch/arm26/kernel/vmlinux-arm26.lds.in	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/arch/arm26/kernel/vmlinux-arm26.lds.in	2004-03-30 23:25:36.000000000 -0800
@@ -67,6 +67,9 @@
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
+			__scheduling_functions_start_here = .;
+			*(.sched.text)
+			__scheduling_functions_end_here = .;
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: sched-2.6.5-rc3/arch/cris/arch-v10/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/cris/arch-v10/vmlinux.lds.S	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/cris/arch-v10/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -25,6 +25,9 @@
 	__stext = .;
 	.text : {
 		*(.text)
+		__scheduling_functions_start_here = .;
+		*(.sched.text)
+		__scheduling_functions_end_here = .;
 		*(.fixup)
 		*(.text.__*)
 	}
Index: sched-2.6.5-rc3/arch/cris/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/cris/kernel/semaphore.c	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/cris/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -4,6 +4,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 /*
@@ -94,7 +95,7 @@
 	tsk->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	DOWN_VAR
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
@@ -104,7 +105,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
 	DOWN_VAR
Index: sched-2.6.5-rc3/arch/h8300/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/h8300/kernel/process.c	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/h8300/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -264,11 +264,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
 	return ((struct pt_regs *)tsk->thread.esp0)->pc;
@@ -289,8 +284,8 @@
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
Index: sched-2.6.5-rc3/arch/h8300/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/h8300/kernel/semaphore.c	2004-03-29 19:26:29.000000000 -0800
+++ sched-2.6.5-rc3/arch/h8300/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -5,6 +5,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 #ifndef CONFIG_RMW_INSNS
@@ -95,7 +96,7 @@
 	current->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -106,7 +107,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
Index: sched-2.6.5-rc3/arch/h8300/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/h8300/kernel/vmlinux.lds.S	2004-03-29 19:26:29.000000000 -0800
+++ sched-2.6.5-rc3/arch/h8300/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -82,6 +82,9 @@
 #endif
 	__stext = . ;
         	*(.text)
+	__scheduling_functions_start_here = .;
+		*(.sched.text)
+	__scheduling_functions_end_here = .;
 	. = ALIGN(0x4) ;
 		*(.exit.text)
 		*(.text.*)
Index: sched-2.6.5-rc3/arch/i386/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/i386/kernel/process.c	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/i386/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -632,10 +632,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
 #define top_esp                (THREAD_SIZE - sizeof(unsigned long))
 #define top_ebp                (THREAD_SIZE - 2*sizeof(unsigned long))
 
@@ -656,14 +652,13 @@
 		if (ebp < stack_page || ebp > top_ebp+stack_page)
 			return 0;
 		eip = *(unsigned long *) (ebp+4);
-		if (eip < first_sched || eip >= last_sched)
+		if (eip < scheduling_functions_start_here ||
+				eip >= scheduling_functions_end_here)
 			return eip;
 		ebp = *(unsigned long *) ebp;
 	} while (count++ < 16);
 	return 0;
 }
-#undef last_sched
-#undef first_sched
 
 /*
  * sys_alloc_thread_area: get a yet unused TLS descriptor index.
Index: sched-2.6.5-rc3/arch/i386/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/i386/kernel/semaphore.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/i386/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/init.h>
 #include <asm/semaphore.h>
 
 /*
@@ -53,7 +54,7 @@
 	wake_up(&sem->wait);
 }
 
-asmlinkage void __down(struct semaphore * sem)
+__sched asmlinkage void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -90,7 +91,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-asmlinkage int __down_interruptible(struct semaphore * sem)
+__sched asmlinkage int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -187,7 +188,7 @@
  * value..
  */
 asm(
-".text\n"
+".sched.text\n"
 ".align 4\n"
 ".globl __down_failed\n"
 "__down_failed:\n\t"
@@ -210,7 +211,7 @@
 );
 
 asm(
-".text\n"
+".sched.text\n"
 ".align 4\n"
 ".globl __down_failed_interruptible\n"
 "__down_failed_interruptible:\n\t"
@@ -231,7 +232,7 @@
 );
 
 asm(
-".text\n"
+".section .sched.text\n"
 ".align 4\n"
 ".globl __down_failed_trylock\n"
 "__down_failed_trylock:\n\t"
@@ -252,7 +253,7 @@
 );
 
 asm(
-".text\n"
+".section .sched.text\n"
 ".align 4\n"
 ".globl __up_wakeup\n"
 "__up_wakeup:\n\t"
@@ -271,7 +272,7 @@
  */
 #if defined(CONFIG_SMP)
 asm(
-".text\n"
+".section .sched.text\n"
 ".align	4\n"
 ".globl	__write_lock_failed\n"
 "__write_lock_failed:\n\t"
@@ -285,7 +286,7 @@
 );
 
 asm(
-".text\n"
+".section .sched.text\n"
 ".align	4\n"
 ".globl	__read_lock_failed\n"
 "__read_lock_failed:\n\t"
Index: sched-2.6.5-rc3/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/i386/kernel/vmlinux.lds.S	2004-03-29 19:25:34.000000000 -0800
+++ sched-2.6.5-rc3/arch/i386/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -16,6 +16,9 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: sched-2.6.5-rc3/arch/ia64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ia64/kernel/process.c	2004-03-29 19:26:13.000000000 -0800
+++ sched-2.6.5-rc3/arch/ia64/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -660,11 +660,6 @@
 	/*
 	 * These bracket the sleeping functions..
 	 */
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
-#	define first_sched	((unsigned long) scheduling_functions_start_here)
-#	define last_sched	((unsigned long) scheduling_functions_end_here)
-
 	/*
 	 * Note: p may not be a blocked task (it could be current or
 	 * another process running on some other CPU.  Rather than
@@ -678,12 +673,11 @@
 		if (unw_unwind(&info) < 0)
 			return 0;
 		unw_get_ip(&info, &ip);
-		if (ip < first_sched || ip >= last_sched)
+		if (ip < scheduling_functions_start_here ||
+				ip >= scheduling_functions_end_here)
 			return ip;
 	} while (count++ < 16);
 	return 0;
-#	undef first_sched
-#	undef last_sched
 }
 
 void
Index: sched-2.6.5-rc3/arch/ia64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ia64/kernel/semaphore.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/ia64/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -24,6 +24,7 @@
  * <asm/semaphore.h> where we want to avoid any extra jumps and calls.
  */
 #include <linux/sched.h>
+#include <linux/init.h>
 
 #include <asm/errno.h>
 #include <asm/semaphore.h>
@@ -44,7 +45,7 @@
 	wake_up(&sem->wait);
 }
 
-void
+__sched void
 __down (struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
@@ -82,7 +83,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-int
+__sched int
 __down_interruptible (struct semaphore * sem)
 {
 	int retval = 0;
Index: sched-2.6.5-rc3/arch/ia64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/ia64/kernel/vmlinux.lds.S	2004-03-29 19:27:05.000000000 -0800
+++ sched-2.6.5-rc3/arch/ia64/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -41,6 +41,9 @@
     {
 	*(.text.ivt)
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.gnu.linkonce.t*)
     }
   .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
Index: sched-2.6.5-rc3/arch/m68k/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/process.c	2004-03-29 19:27:46.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -65,12 +65,10 @@
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > scheduling_functions_start_here &&
+	    sw->retpc < scheduling_functions_end_here)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
@@ -387,11 +385,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
@@ -407,8 +400,8 @@
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
Index: sched-2.6.5-rc3/arch/m68k/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/semaphore.c	2004-03-29 19:26:54.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -5,6 +5,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 #ifndef CONFIG_RMW_INSNS
@@ -95,7 +96,7 @@
 	current->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -106,7 +107,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
Index: sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-std.lds
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/vmlinux-std.lds	2004-03-29 19:27:14.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-std.lds	2004-03-30 23:25:36.000000000 -0800
@@ -12,6 +12,9 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x4e75
Index: sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-sun3.lds
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68k/kernel/vmlinux-sun3.lds	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68k/kernel/vmlinux-sun3.lds	2004-03-30 23:25:36.000000000 -0800
@@ -13,6 +13,9 @@
   .text : {
 	*(.head)
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x4e75
Index: sched-2.6.5-rc3/arch/m68knommu/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68knommu/kernel/process.c	2004-03-29 19:25:35.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68knommu/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -406,11 +406,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
@@ -426,8 +421,8 @@
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
@@ -439,13 +434,11 @@
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	extern void scheduling_functions_start_here(void);
-	extern void scheduling_functions_end_here(void);
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > scheduling_functions_start_here &&
+	    sw->retpc < scheduling_functions_end_here)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
Index: sched-2.6.5-rc3/arch/m68knommu/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68knommu/kernel/semaphore.c	2004-03-29 19:27:46.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68knommu/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/init.h>
 #include <asm/semaphore-helper.h>
 
 #ifndef CONFIG_RMW_INSNS
@@ -96,7 +97,7 @@
 	current->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -107,7 +108,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
Index: sched-2.6.5-rc3/arch/m68knommu/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/m68knommu/kernel/vmlinux.lds.S	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/m68knommu/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -191,6 +191,9 @@
 	.text : {
 		_stext = . ;
         	*(.text)
+		__scheduling_functions_start_here = .;
+		*(.sched.text)
+		__scheduling_functions_end_here = .;
         	*(.text.lock)
 
 		. = ALIGN(16);          /* Exception table              */
Index: sched-2.6.5-rc3/arch/mips/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/mips/kernel/process.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/mips/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -283,11 +283,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 /* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
@@ -299,7 +294,8 @@
 	if (!mips_frame_info_initialized)
 		return 0;
 	pc = thread_saved_pc(p);
-	if (pc < first_sched || pc >= last_sched)
+	if (pc < scheduling_functions_start_here ||
+			pc >= scheduling_functions_end_here)
 		goto out;
 
 	if (pc >= (unsigned long) sleep_on_timeout)
@@ -333,7 +329,8 @@
 	 */
 	pc    = ((unsigned long *)frame)[schedule_timeout_frame.pc_offset];
 
-	if (pc >= first_sched && pc < last_sched) {
+	if (pc >= scheduling_functions_start_here &&
+			pc < scheduling_functions_end_here) {
 		/* schedule_timeout called by [interruptible_]sleep_on_timeout */
 		frame = ((unsigned long *)frame)[schedule_timeout_frame.frame_offset];
 		pc    = ((unsigned long *)frame)[sleep_on_timeout_frame.pc_offset];
Index: sched-2.6.5-rc3/arch/mips/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/mips/kernel/semaphore.c	2004-03-29 19:26:31.000000000 -0800
+++ sched-2.6.5-rc3/arch/mips/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/sched.h>
 
 #ifdef CONFIG_CPU_HAS_LLDSCD
@@ -104,7 +105,7 @@
  * Either form may be used in conjunction with "up()".
  */
 
-void __down_failed(struct semaphore * sem)
+__sched void __down_failed(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	wait_queue_t wait;
@@ -227,7 +228,7 @@
 
 #endif /* !CONFIG_CPU_HAS_LLDSCD */
 
-int __down_failed_interruptible(struct semaphore * sem)
+__sched int __down_failed_interruptible(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	wait_queue_t wait;
Index: sched-2.6.5-rc3/arch/mips/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/mips/kernel/vmlinux.lds.S	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/mips/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -28,6 +28,9 @@
   _text = .;			/* Text and read-only data */
   .text : {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.sched.text)
+    __scheduling_functions_end_here = .;
     *(.fixup)
     *(.gnu.warning)
   } =0
Index: sched-2.6.5-rc3/arch/parisc/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/parisc/kernel/semaphore.c	2004-03-29 19:26:56.000000000 -0800
+++ sched-2.6.5-rc3/arch/parisc/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 /*
  * Semaphores are complex as we wish to avoid using two variables.
@@ -58,7 +59,7 @@
 	sem->count += (sem->count < 0) ? 1 : - 1;
 	
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	DOWN_HEAD
 
@@ -74,7 +75,7 @@
 	UPDATE_COUNT
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	DOWN_HEAD
 
Index: sched-2.6.5-rc3/arch/parisc/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/parisc/kernel/vmlinux.lds.S	2004-03-29 19:25:35.000000000 -0800
+++ sched-2.6.5-rc3/arch/parisc/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -50,6 +50,9 @@
   _text = .;			/* Text and read-only data */
   .text ALIGN(16) : {
 	*(.text*)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here =.;
 	*(.PARISC.unwind)
 	*(.fixup)
 	*(.lock.text)		/* out-of-line lock text */
Index: sched-2.6.5-rc3/arch/ppc/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc/kernel/process.c	2004-03-29 19:26:14.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc/kernel/process.c	2004-03-30 23:25:36.000000000 -0800
@@ -659,11 +659,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched    ((unsigned long) scheduling_functions_start_here)
-#define last_sched     ((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
@@ -678,7 +673,8 @@
 			return 0;
 		if (count > 0) {
 			ip = *(unsigned long *)(sp + 4);
-			if (ip < first_sched || ip >= last_sched)
+			if (ip < scheduling_functions_start_here ||
+					ip >= scheduling_functions_end_here)
 				return ip;
 		}
 	} while (count++ < 16);
Index: sched-2.6.5-rc3/arch/ppc/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc/kernel/semaphore.c	2004-03-30 23:25:36.000000000 -0800
@@ -15,6 +15,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/errno.h>
@@ -69,7 +70,7 @@
  * Thus it is only when we decrement count from some value > 0
  * that we have actually got the semaphore.
  */
-void __down(struct semaphore *sem)
+__sched void __down(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -99,7 +100,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/ppc/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc/kernel/vmlinux.lds.S	2004-03-29 19:27:47.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc/kernel/vmlinux.lds.S	2004-03-30 23:25:36.000000000 -0800
@@ -31,6 +31,9 @@
   .text      :
   {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.sched.text)
+    __scheduling_functions_end_here = .;
     *(.fixup)
     *(.got1)
     __got2_start = .;
Index: sched-2.6.5-rc3/arch/ppc64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc64/kernel/process.c	2004-03-29 19:26:29.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc64/kernel/process.c	2004-03-30 23:24:15.000000000 -0800
@@ -475,11 +475,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched    (*(unsigned long *)scheduling_functions_start_here)
-#define last_sched     (*(unsigned long *)scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
@@ -498,7 +493,8 @@
 			return 0;
 		if (count > 0) {
 			ip = *(unsigned long *)(sp + 16);
-			if (ip < first_sched || ip >= last_sched)
+			if (ip < scheduling_functions_start_here ||
+					ip >= scheduling_functions_end_here)
 				return ip;
 		}
 	} while (count++ < 16);
Index: sched-2.6.5-rc3/arch/ppc64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc64/kernel/semaphore.c	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc64/kernel/semaphore.c	2004-03-30 23:25:37.000000000 -0800
@@ -17,6 +17,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/errno.h>
@@ -70,7 +71,7 @@
  * Thus it is only when we decrement count from some value > 0
  * that we have actually got the semaphore.
  */
-void __down(struct semaphore *sem)
+__sched void __down(struct semaphore *sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -99,7 +100,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/ppc64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/ppc64/kernel/vmlinux.lds.S	2004-03-29 19:26:57.000000000 -0800
+++ sched-2.6.5-rc3/arch/ppc64/kernel/vmlinux.lds.S	2004-03-30 23:25:37.000000000 -0800
@@ -13,6 +13,9 @@
   /* Read-only sections, merged into text segment: */
   .text : {
 	*(.text .text.*)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	. = ALIGN(4096);
 	_etext = .;
Index: sched-2.6.5-rc3/arch/s390/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/s390/kernel/process.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/s390/kernel/process.c	2004-03-30 23:25:37.000000000 -0800
@@ -384,11 +384,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long r14, r15, bc;
@@ -411,12 +406,10 @@
 #else
 		r14 = *(unsigned long *) (bc+112);
 #endif
-		if (r14 < first_sched || r14 >= last_sched)
+		if (r14 < scheduling_functions_start_here ||
+				r14 >= scheduling_functions_end_here)
 			return r14;
 		bc = (*(unsigned long *) bc) & PSW_ADDR_INSN;
 	} while (count++ < 16);
 	return 0;
 }
-#undef last_sched
-#undef first_sched
-
Index: sched-2.6.5-rc3/arch/s390/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/s390/kernel/semaphore.c	2004-03-29 19:27:15.000000000 -0800
+++ sched-2.6.5-rc3/arch/s390/kernel/semaphore.c	2004-03-30 23:25:37.000000000 -0800
@@ -11,6 +11,7 @@
  */
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -60,7 +61,7 @@
  *   count > 0: decrement count, wake up queue and exit.
  *   count <= 0: set count to -1, go to sleep.
  */
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -82,7 +83,7 @@
  *   count > 0: wake up queue and exit.
  *   count <= 0: set count to 0, wake up queue and exit.
  */
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/s390/kernel/vmlinux.lds.S	2004-03-29 19:26:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/s390/kernel/vmlinux.lds.S	2004-03-30 23:25:37.000000000 -0800
@@ -23,6 +23,9 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
Index: sched-2.6.5-rc3/arch/sh/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sh/kernel/process.c	2004-03-29 19:26:55.000000000 -0800
+++ sched-2.6.5-rc3/arch/sh/kernel/process.c	2004-03-30 23:25:37.000000000 -0800
@@ -464,11 +464,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long schedule_frame;
Index: sched-2.6.5-rc3/arch/sh/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sh/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/sh/kernel/semaphore.c	2004-03-30 23:25:37.000000000 -0800
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/init.h>
 #include <asm/semaphore.h>
 #include <asm/semaphore-helper.h>
 
@@ -103,7 +104,7 @@
 	tsk->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	DOWN_VAR
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
@@ -113,7 +114,7 @@
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
 	DOWN_VAR
Index: sched-2.6.5-rc3/arch/sh/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sh/kernel/vmlinux.lds.S	2004-03-29 19:26:28.000000000 -0800
+++ sched-2.6.5-rc3/arch/sh/kernel/vmlinux.lds.S	2004-03-30 23:25:37.000000000 -0800
@@ -22,6 +22,9 @@
 	} = 0
   .text : {
 	*(.text)
+	__scheduling_functions_start_here =.;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0009
Index: sched-2.6.5-rc3/arch/sparc/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/kernel/process.c	2004-03-29 19:25:33.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/kernel/process.c	2004-03-30 23:25:37.000000000 -0800
@@ -694,9 +694,6 @@
 	return retval;
 }
 
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
@@ -717,8 +714,8 @@
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-                    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < scheduling_functions_start_here ||
+                    pc >= scheduling_functions_end_here) {
 			ret = pc;
 			goto out;
 		}
Index: sched-2.6.5-rc3/arch/sparc/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/kernel/semaphore.c	2004-03-29 19:27:18.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/kernel/semaphore.c	2004-03-30 23:25:37.000000000 -0800
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -45,7 +46,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -78,7 +79,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/sparc/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/kernel/vmlinux.lds.S	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/kernel/vmlinux.lds.S	2004-03-30 23:25:37.000000000 -0800
@@ -12,6 +12,9 @@
   .text 0xf0004000 :
   {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.sched.text)
+    __scheduling_functions_end_here = .;
     *(.gnu.warning)
   } =0
   _etext = .;
Index: sched-2.6.5-rc3/arch/sparc/lib/rwsem.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc/lib/rwsem.S	2004-03-29 19:26:40.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc/lib/rwsem.S	2004-03-30 23:25:37.000000000 -0800
@@ -8,7 +8,7 @@
 #include <asm/ptrace.h>
 #include <asm/psr.h>
 
-	.text
+	.section .sched.text
 	.align	4
 
 	.globl		___down_read
@@ -113,6 +113,7 @@
 	ba		2b
 	 restore	%l5, %g0, %g5
 
+	.text
 	.globl		___up_read
 ___up_read:
 	rd		%psr, %g3
Index: sched-2.6.5-rc3/arch/sparc64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/kernel/process.c	2004-03-29 19:26:10.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/kernel/process.c	2004-03-30 23:25:37.000000000 -0800
@@ -823,9 +823,6 @@
 	return error;
 }
 
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
@@ -849,8 +846,8 @@
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-		    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < scheduling_functions_start_here ||
+		    pc >= scheduling_functions_end_here) {
 			ret = pc;
 			goto out;
 		}
Index: sched-2.6.5-rc3/arch/sparc64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/kernel/semaphore.c	2004-03-30 23:25:37.000000000 -0800
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 
 /*
  * Atomically update sem->count.
@@ -90,7 +91,7 @@
 	: "g5", "g7", "memory", "cc");
 }
 
-static void __down(struct semaphore * sem)
+static __sched void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -108,7 +109,7 @@
 	wake_up(&sem->wait);
 }
 
-void down(struct semaphore *sem)
+__sched void down(struct semaphore *sem)
 {
 	might_sleep();
 	/* This atomically does:
@@ -192,7 +193,7 @@
 	return ret;
 }
 
-static int __down_interruptible(struct semaphore * sem)
+static __sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -216,7 +217,7 @@
 	return retval;
 }
 
-int down_interruptible(struct semaphore *sem)
+__sched int down_interruptible(struct semaphore *sem)
 {
 	int ret = 0;
 	
Index: sched-2.6.5-rc3/arch/sparc64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/kernel/vmlinux.lds.S	2004-03-29 19:27:06.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/kernel/vmlinux.lds.S	2004-03-30 23:25:37.000000000 -0800
@@ -15,6 +15,9 @@
   .text 0x0000000000404000 :
   {
     *(.text)
+    __scheduling_functions_start_here = .;
+    *(.sched.text)
+    __scheduling_functions_end_here = .;
     *(.gnu.warning)
   } =0
   _etext = .;
Index: sched-2.6.5-rc3/arch/sparc64/lib/rwsem.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/sparc64/lib/rwsem.c	2004-03-29 19:25:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/sparc64/lib/rwsem.c	2004-03-30 23:25:37.000000000 -0800
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/rwsem.h>
+#include <linux/init.h>
 #include <linux/module.h>
 
 extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
@@ -13,7 +14,7 @@
 extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
 extern struct rw_semaphore *FASTCALL(rwsem_downgrade_wake(struct rw_semaphore *));
 
-void __down_read(struct rw_semaphore *sem)
+__sched void __down_read(struct rw_semaphore *sem)
 {
 	__asm__ __volatile__(
 		"! beginning __down_read\n"
@@ -72,7 +73,7 @@
 }
 EXPORT_SYMBOL(__down_read_trylock);
 
-void __down_write(struct rw_semaphore *sem)
+__sched void __down_write(struct rw_semaphore *sem)
 {
 	__asm__ __volatile__(
 		"! beginning __down_write\n\t"
Index: sched-2.6.5-rc3/arch/v850/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/v850/kernel/process.c	2004-03-29 19:25:34.000000000 -0800
+++ sched-2.6.5-rc3/arch/v850/kernel/process.c	2004-03-30 23:25:37.000000000 -0800
@@ -203,11 +203,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here (void);
-extern void scheduling_functions_end_here (void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan (struct task_struct *p)
 {
 #if 0  /* Barf.  Figure out the stack-layout later.  XXX  */
@@ -221,15 +216,16 @@
 
 	/* This quite disgusting function walks up the stack, following
 	   saved return address, until it something that's out of bounds
-	   (as defined by `first_sched' and `last_sched').  It then
-	   returns the last PC that was in-bounds.  */
+	   (as defined by `scheduling_functions_start_here' and
+	   `scheduling_functions_end_here').  It then returns the last
+	   PC that was in-bounds.  */
 	do {
-		if (fp < stack_page + sizeof (struct task_struct) ||
-		    fp >= 8184+stack_page)
+		if (fp < stack_page + sizeof(struct thread_info) ||
+		    fp >= THREAD_SIZE + stack_page - 8)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (pc < first_sched || pc >= last_sched)
+		if (pc < scheduling_functions_start_here ||
+				pc >= scheduling_functions_end_here)
 			return pc;
 		fp = *(unsigned long *) fp;
 	} while (count++ < 16);
Index: sched-2.6.5-rc3/arch/v850/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/v850/kernel/semaphore.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/arch/v850/kernel/semaphore.c	2004-03-30 23:25:37.000000000 -0800
@@ -15,6 +15,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 
 #include <asm/semaphore.h>
 
@@ -56,7 +57,7 @@
 
 static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -89,7 +90,7 @@
 	wake_up(&sem->wait);
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/v850/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/v850/kernel/vmlinux.lds.S	2004-03-29 19:26:30.000000000 -0800
+++ sched-2.6.5-rc3/arch/v850/kernel/vmlinux.lds.S	2004-03-30 23:25:37.000000000 -0800
@@ -64,6 +64,9 @@
 #define TEXT_CONTENTS							      \
 		__stext = . ;						      \
         	*(.text)						      \
+		__scheduling_functions_start_here = .;
+		*(.sched.text)
+		__scheduling_functions_end_here = .;
 			*(.exit.text)	/* 2.5 convention */		      \
 			*(.text.exit)	/* 2.4 convention */		      \
 			*(.text.lock)					      \
Index: sched-2.6.5-rc3/arch/x86_64/kernel/process.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/kernel/process.c	2004-03-29 19:26:28.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/kernel/process.c	2004-03-30 23:25:37.000000000 -0800
@@ -576,11 +576,6 @@
 /*
  * These bracket the sleeping functions..
  */
-extern void scheduling_functions_start_here(void);
-extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long stack;
@@ -597,14 +592,13 @@
 		if (fp < (unsigned long)stack || fp > (unsigned long)stack+THREAD_SIZE)
 			return 0; 
 		rip = *(u64 *)(fp+8); 
-		if (rip < first_sched || rip >= last_sched)
+		if (rip < scheduling_functions_start_here ||
+				rip >= scheduling_functions_end_here)
 			return rip; 
 		fp = *(u64 *)fp; 
 	} while (count++ < 16); 
 	return 0;
 }
-#undef last_sched
-#undef first_sched
 
 long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
 { 
Index: sched-2.6.5-rc3/arch/x86_64/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/kernel/semaphore.c	2004-03-29 19:27:47.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/kernel/semaphore.c	2004-03-30 23:25:37.000000000 -0800
@@ -14,6 +14,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/errno.h>
 
 #include <asm/semaphore.h>
@@ -54,7 +55,7 @@
 	wake_up(&sem->wait);
 }
 
-void __down(struct semaphore * sem)
+__sched void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -91,7 +92,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-int __down_interruptible(struct semaphore * sem)
+__sched int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
Index: sched-2.6.5-rc3/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/kernel/vmlinux.lds.S	2004-03-29 19:25:31.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/kernel/vmlinux.lds.S	2004-03-30 23:25:37.000000000 -0800
@@ -15,6 +15,9 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	__scheduling_functions_start_here = .;
+	*(.sched.text)
+	__scheduling_functions_end_here = .;
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: sched-2.6.5-rc3/arch/x86_64/lib/thunk.S
===================================================================
--- sched-2.6.5-rc3.orig/arch/x86_64/lib/thunk.S	2004-03-29 19:26:11.000000000 -0800
+++ sched-2.6.5-rc3/arch/x86_64/lib/thunk.S	2004-03-30 23:25:37.000000000 -0800
@@ -35,6 +35,7 @@
 	.endm
 	
 
+	.section .sched.text
 #ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 	thunk rwsem_down_read_failed_thunk,rwsem_down_read_failed
 	thunk rwsem_down_write_failed_thunk,rwsem_down_write_failed
@@ -65,7 +66,7 @@
 
 #ifdef CONFIG_SMP
 /* Support for read/write spinlocks. */
-	
+	.text
 /* rax:	pointer to rwlock_t */	
 ENTRY(__write_lock_failed)
 	lock
Index: sched-2.6.5-rc3/include/linux/init.h
===================================================================
--- sched-2.6.5-rc3.orig/include/linux/init.h	2004-03-29 19:25:31.000000000 -0800
+++ sched-2.6.5-rc3/include/linux/init.h	2004-03-30 23:25:37.000000000 -0800
@@ -46,6 +46,8 @@
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
+#define __sched		__attribute__((__section__(".sched.text")))
+
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
Index: sched-2.6.5-rc3/include/linux/sched.h
===================================================================
--- sched-2.6.5-rc3.orig/include/linux/sched.h	2004-03-29 19:25:32.000000000 -0800
+++ sched-2.6.5-rc3/include/linux/sched.h	2004-03-30 23:25:37.000000000 -0800
@@ -170,6 +170,8 @@
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
+extern const unsigned long scheduling_functions_start_here;
+extern const unsigned long scheduling_functions_end_here;
 
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
Index: sched-2.6.5-rc3/kernel/sched.c
===================================================================
--- sched-2.6.5-rc3.orig/kernel/sched.c	2004-03-29 19:27:01.000000000 -0800
+++ sched-2.6.5-rc3/kernel/sched.c	2004-03-30 23:25:37.000000000 -0800
@@ -225,6 +225,13 @@
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+extern unsigned long __scheduling_functions_start_here;
+extern unsigned long __scheduling_functions_end_here;
+const unsigned long scheduling_functions_start_here =
+			(unsigned long)&__scheduling_functions_start_here;
+const unsigned long scheduling_functions_end_here =
+			(unsigned long)&__scheduling_functions_end_here;
+
 /*
  * Default context-switch locking:
  */
@@ -1587,12 +1594,10 @@
 	rebalance_tick(rq, 0);
 }
 
-void scheduling_functions_start_here(void) { }
-
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void schedule(void)
+asmlinkage __sched void schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -1731,7 +1736,7 @@
  * off of preempt_enable.  Kernel preemptions off return from interrupt
  * occur there and call schedule directly.
  */
-asmlinkage void preempt_schedule(void)
+asmlinkage __sched void preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
 
@@ -1869,7 +1874,7 @@
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
-void fastcall wait_for_completion(struct completion *x)
+__sched void fastcall wait_for_completion(struct completion *x)
 {
 	might_sleep();
 	spin_lock_irq(&x->wait.lock);
@@ -1907,7 +1912,7 @@
 	__remove_wait_queue(q, &wait);			\
 	spin_unlock_irqrestore(&q->lock, flags);
 
-void fastcall interruptible_sleep_on(wait_queue_head_t *q)
+__sched void fastcall interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1920,7 +1925,7 @@
 
 EXPORT_SYMBOL(interruptible_sleep_on);
 
-long fastcall interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+__sched long fastcall interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1935,7 +1940,7 @@
 
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 
-void fastcall sleep_on(wait_queue_head_t *q)
+__sched void fastcall sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1948,7 +1953,7 @@
 
 EXPORT_SYMBOL(sleep_on);
 
-long fastcall sleep_on_timeout(wait_queue_head_t *q, long timeout)
+__sched long fastcall sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1963,8 +1968,6 @@
 
 EXPORT_SYMBOL(sleep_on_timeout);
 
-void scheduling_functions_end_here(void) { }
-
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
@@ -2424,7 +2427,7 @@
 	return 0;
 }
 
-void __cond_resched(void)
+__sched void __cond_resched(void)
 {
 	set_current_state(TASK_RUNNING);
 	schedule();
@@ -2438,7 +2441,7 @@
  * this is a shortcut for kernel-space yielding - it marks the
  * thread runnable and calls sys_sched_yield().
  */
-void yield(void)
+__sched void yield(void)
 {
 	set_current_state(TASK_RUNNING);
 	sys_sched_yield();
@@ -2453,7 +2456,7 @@
  * But don't do that if it is a deliberate, throttling IO wait (this task
  * has set its backing_dev_info: the queue against which it should throttle)
  */
-void io_schedule(void)
+__sched void io_schedule(void)
 {
 	struct runqueue *rq = this_rq();
 
@@ -2464,7 +2467,7 @@
 
 EXPORT_SYMBOL(io_schedule);
 
-long io_schedule_timeout(long timeout)
+__sched long io_schedule_timeout(long timeout)
 {
 	struct runqueue *rq = this_rq();
 	long ret;
@@ -3009,7 +3012,7 @@
  *
  * Called inside preempt_disable().
  */
-void __preempt_spin_lock(spinlock_t *lock)
+__sched void __preempt_spin_lock(spinlock_t *lock)
 {
 	if (preempt_count() > 1) {
 		_raw_spin_lock(lock);
@@ -3025,7 +3028,7 @@
 
 EXPORT_SYMBOL(__preempt_spin_lock);
 
-void __preempt_write_lock(rwlock_t *lock)
+__sched void __preempt_write_lock(rwlock_t *lock)
 {
 	if (preempt_count() > 1) {
 		_raw_write_lock(lock);
Index: sched-2.6.5-rc3/kernel/timer.c
===================================================================
--- sched-2.6.5-rc3.orig/kernel/timer.c	2004-03-29 19:27:04.000000000 -0800
+++ sched-2.6.5-rc3/kernel/timer.c	2004-03-30 23:25:37.000000000 -0800
@@ -996,7 +996,7 @@
  *
  * In all cases the return value is guaranteed to be non-negative.
  */
-fastcall signed long schedule_timeout(signed long timeout)
+__sched fastcall signed long schedule_timeout(signed long timeout)
 {
 	struct timer_list timer;
 	unsigned long expire;
@@ -1056,7 +1056,7 @@
 	return current->pid;
 }
 
-static long nanosleep_restart(struct restart_block *restart)
+static __sched long nanosleep_restart(struct restart_block *restart)
 {
 	unsigned long expire = restart->arg0, now = jiffies;
 	struct timespec *rmtp = (struct timespec *) restart->arg1;
Index: sched-2.6.5-rc3/lib/rwsem.c
===================================================================
--- sched-2.6.5-rc3.orig/lib/rwsem.c	2004-03-29 19:25:31.000000000 -0800
+++ sched-2.6.5-rc3/lib/rwsem.c	2004-03-30 23:25:37.000000000 -0800
@@ -5,6 +5,7 @@
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <linux/module.h>
 
 struct rwsem_waiter {
@@ -162,7 +163,7 @@
 /*
  * wait for the read lock to be granted
  */
-struct rw_semaphore fastcall *rwsem_down_read_failed(struct rw_semaphore *sem)
+__sched struct rw_semaphore fastcall *rwsem_down_read_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
@@ -178,7 +179,7 @@
 /*
  * wait for the write lock to be granted
  */
-struct rw_semaphore fastcall *rwsem_down_write_failed(struct rw_semaphore *sem)
+__sched struct rw_semaphore fastcall *rwsem_down_write_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
