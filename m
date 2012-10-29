From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 2/4] xtensa: switch to generic kernel_thread()
Date: Mon, 29 Oct 2012 18:56:19 +0400
Message-ID: <1351522581-30516-3-git-send-email-jcmvbkbc@gmail.com>
References: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32848 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab2J2O4o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 10:56:44 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3826574lag.19
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2012 07:56:43 -0700 (PDT)
In-Reply-To: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig                 |    1 +
 arch/xtensa/include/asm/processor.h |    4 +-
 arch/xtensa/kernel/entry.S          |   41 ++++++-------------
 arch/xtensa/kernel/process.c        |   77 +++++++++++++++++++++--------------
 arch/xtensa/kernel/xtensa_ksyms.c   |    1 -
 5 files changed, 61 insertions(+), 63 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 75bb9a5..1033a1a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -13,6 +13,7 @@ config XTENSA
 	select GENERIC_CPU_DEVICES
 	select MODULES_USE_ELF_RELA
 	select GENERIC_PCI_IOMAP
+	select GENERIC_KERNEL_THREAD
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 5d6c536..c1fc2d4 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -152,6 +152,7 @@ struct thread_struct {
 
 /* Clearing a0 terminates the backtrace. */
 #define start_thread(regs, new_pc, new_sp) \
+	memset(regs, 0, sizeof(*regs)); \
 	regs->pc = new_pc; \
 	regs->ps = USER_PS_VALUE; \
 	regs->areg[1] = new_sp; \
@@ -168,9 +169,6 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
 
-/* Create a kernel thread without removing it from tasklists */
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
-
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(p, mm)	do { } while(0)
 #define release_segments(mm)	do { } while(0)
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 0dead62..0fc994f 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1833,34 +1833,6 @@ ENTRY(system_call)
 
 
 /*
- * Create a kernel thread
- *
- * int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
- * a2                    a2                 a3             a4
- */
-
-ENTRY(kernel_thread)
-	entry	a1, 16
-
-	mov	a5, a2			# preserve fn over syscall
-	mov	a7, a3			# preserve args over syscall
-
-	movi	a3, _CLONE_VM | _CLONE_UNTRACED
-	movi	a2, __NR_clone
-	or	a6, a4, a3		# arg0: flags
-	mov	a3, a1			# arg1: sp
-	syscall
-
-	beq	a3, a1, 1f		# branch if parent
-	mov	a6, a7			# args
-	callx4	a5			# fn(args)
-
-	movi	a2, __NR_exit
-	syscall				# return value of fn(args) still in a6
-
-1:	retw
-
-/*
  * Do a system call from kernel instead of calling sys_execve, so we end up
  * with proper pt_regs.
  *
@@ -1958,3 +1930,16 @@ ENTRY(ret_from_fork)
 
 	j	common_exception_return
 
+/*
+ * Kernel thread creation helper
+ * On entry, set up by copy_thread: a2 = thread_fn, a3 = thread_fn arg
+ *           left from _switch_to: a6 = prev
+ */
+ENTRY(ret_from_kernel_thread)
+
+	call4	schedule_tail
+	mov	a6, a3
+	callx4	a2
+	call4	do_exit
+
+ENDPROC(ret_from_kernel_thread)
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 341c151..be52fe4 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -45,6 +45,7 @@
 #include <asm/regs.h>
 
 extern void ret_from_fork(void);
+extern void ret_from_kernel_thread(void);
 
 struct task_struct *current_set[NR_CPUS] = {&init_task, };
 
@@ -158,18 +159,30 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 /*
  * Copy thread.
  *
+ * There are two modes in which this function is called:
+ * 1) Userspace thread creation,
+ *    regs != NULL, usp_thread_fn is userspace stack pointer.
+ *    It is expected to copy parent regs (in case CLONE_VM is not set
+ *    in the clone_flags) and set up passed usp in the childregs.
+ * 2) Kernel thread creation,
+ *    regs == NULL, usp_thread_fn is the function to run in the new thread
+ *    and thread_fn_arg is its parameter.
+ *    childregs are not used for the kernel threads.
+ *
  * The stack layout for the new thread looks like this:
  *
- *	+------------------------+ <- sp in childregs (= tos)
+ *	+------------------------+
  *	|       childregs        |
  *	+------------------------+ <- thread.sp = sp in dummy-frame
  *	|      dummy-frame       |    (saved in dummy-frame spill-area)
  *	+------------------------+
  *
- * We create a dummy frame to return to ret_from_fork:
- *   a0 points to ret_from_fork (simulating a call4)
+ * We create a dummy frame to return to either ret_from_fork or
+ *   ret_from_kernel_thread:
+ *   a0 points to ret_from_fork/ret_from_kernel_thread (simulating a call4)
  *   sp points to itself (thread.sp)
- *   a2, a3 are unused.
+ *   a2, a3 are unused for userspace threads,
+ *   a2 points to thread_fn, a3 holds thread_fn arg for kernel threads.
  *
  * Note: This is a pristine frame, so we don't need any spill region on top of
  *       childregs.
@@ -185,41 +198,37 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
  * involved.  Much simpler to just not copy those live frames across.
  */
 
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long unused,
-                struct task_struct * p, struct pt_regs * regs)
+int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
+		unsigned long thread_fn_arg,
+		struct task_struct *p, struct pt_regs *unused)
 {
-	struct pt_regs *childregs;
-	unsigned long tos;
-	int user_mode = user_mode(regs);
+	struct pt_regs *childregs = task_pt_regs(p);
 
 #if (XTENSA_HAVE_COPROCESSORS || XTENSA_HAVE_IO_PORTS)
 	struct thread_info *ti;
 #endif
 
-	/* Set up new TSS. */
-	tos = (unsigned long)task_stack_page(p) + THREAD_SIZE;
-	if (user_mode)
-		childregs = (struct pt_regs*)(tos - PT_USER_SIZE);
-	else
-		childregs = (struct pt_regs*)tos - 1;
-
-	/* This does not copy all the regs.  In a bout of brilliance or madness,
-	   ARs beyond a0-a15 exist past the end of the struct. */
-	*childregs = *regs;
-
 	/* Create a call4 dummy-frame: a0 = 0, a1 = childregs. */
 	*((int*)childregs - 3) = (unsigned long)childregs;
 	*((int*)childregs - 4) = 0;
 
-	childregs->areg[2] = 0;
-	p->set_child_tid = p->clear_child_tid = NULL;
-	p->thread.ra = MAKE_RA_FOR_CALL((unsigned long)ret_from_fork, 0x1);
 	p->thread.sp = (unsigned long)childregs;
 
-	if (user_mode(regs)) {
+	if (!(p->flags & PF_KTHREAD)) {
+		struct pt_regs *regs = current_pt_regs();
+		unsigned long usp = usp_thread_fn ?
+			usp_thread_fn : regs->areg[1];
+
+		p->thread.ra = MAKE_RA_FOR_CALL(
+				(unsigned long)ret_from_fork, 0x1);
 
+		/* This does not copy all the regs.
+		 * In a bout of brilliance or madness,
+		 * ARs beyond a0-a15 exist past the end of the struct.
+		 */
+		*childregs = *regs;
 		childregs->areg[1] = usp;
+		childregs->areg[2] = 0;
 
 		/* When sharing memory with the parent thread, the child
 		   usually starts on a pristine stack, so we have to reset
@@ -254,11 +263,19 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 // FIXME: we need to set THREADPTR in thread_info...
 		if (clone_flags & CLONE_SETTLS)
 			childregs->areg[2] = childregs->areg[6];
-
 	} else {
-		/* In kernel space, we start a new thread with a new stack. */
-		childregs->wmask = 1;
-		childregs->areg[1] = tos;
+		p->thread.ra = MAKE_RA_FOR_CALL(
+				(unsigned long)ret_from_kernel_thread, 1);
+
+		/* pass parameters to ret_from_kernel_thread:
+		 * a2 = thread_fn, a3 = thread_fn arg
+		 */
+		*((int *)childregs - 1) = thread_fn_arg;
+		*((int *)childregs - 2) = usp_thread_fn;
+
+		/* Childregs are only used when we're going to userspace
+		 * in which case start_thread will set them up.
+		 */
 	}
 
 #if (XTENSA_HAVE_COPROCESSORS || XTENSA_HAVE_IO_PORTS)
@@ -354,8 +371,6 @@ long xtensa_clone(unsigned long clone_flags, unsigned long newsp,
                   void __user *child_tid, long a5,
                   struct pt_regs *regs)
 {
-        if (!newsp)
-                newsp = regs->areg[1];
         return do_fork(clone_flags, newsp, regs, 0, parent_tid, child_tid);
 }
 
diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index a8b9f1f..afe058b 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -43,7 +43,6 @@ EXPORT_SYMBOL(__strncpy_user);
 EXPORT_SYMBOL(clear_page);
 EXPORT_SYMBOL(copy_page);
 
-EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(empty_zero_page);
 
 /*
-- 
1.7.7.6
