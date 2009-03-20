From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] Simplify copy_thread()
Date: Sat, 21 Mar 2009 01:00:07 +0300
Message-ID: <20090320220007.GA5719@x200.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55831 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZCTVwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2009 17:52:54 -0400
Received: by bwz17 with SMTP id 17so1054701bwz.37
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2009 14:52:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org

First argument unused since 2.3.11.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/alpha/kernel/process.c         |    2 +-
 arch/arm/kernel/process.c           |    2 +-
 arch/avr32/kernel/process.c         |    2 +-
 arch/blackfin/kernel/process.c      |    2 +-
 arch/cris/arch-v10/kernel/process.c |    2 +-
 arch/cris/arch-v32/kernel/process.c |    2 +-
 arch/frv/kernel/process.c           |    2 +-
 arch/h8300/kernel/process.c         |    2 +-
 arch/ia64/kernel/process.c          |    2 +-
 arch/m32r/kernel/process.c          |    2 +-
 arch/m68k/kernel/process.c          |    2 +-
 arch/m68knommu/kernel/process.c     |    2 +-
 arch/mips/kernel/process.c          |    2 +-
 arch/mn10300/kernel/process.c       |    2 +-
 arch/parisc/kernel/process.c        |    2 +-
 arch/powerpc/kernel/process.c       |    2 +-
 arch/s390/kernel/process.c          |    2 +-
 arch/sh/kernel/process_32.c         |    2 +-
 arch/sh/kernel/process_64.c         |    2 +-
 arch/sparc/kernel/process_32.c      |    2 +-
 arch/sparc/kernel/process_64.c      |    2 +-
 arch/um/kernel/process.c            |    2 +-
 arch/x86/kernel/process_32.c        |    2 +-
 arch/x86/kernel/process_64.c        |    2 +-
 arch/xtensa/kernel/process.c        |    2 +-
 include/linux/sched.h               |    2 +-
 kernel/fork.c                       |    2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)

--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -272,7 +272,7 @@ alpha_vfork(struct pt_regs *regs)
  */
 
 int
-copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+copy_thread(unsigned long clone_flags, unsigned long usp,
 	    unsigned long unused,
 	    struct task_struct * p, struct pt_regs * regs)
 {
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -300,7 +300,7 @@ void release_thread(struct task_struct *dead_task)
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 int
-copy_thread(int nr, unsigned long clone_flags, unsigned long stack_start,
+copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	    unsigned long stk_sz, struct task_struct *p, struct pt_regs *regs)
 {
 	struct thread_info *thread = task_thread_info(p);
--- a/arch/avr32/kernel/process.c
+++ b/arch/avr32/kernel/process.c
@@ -332,7 +332,7 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 
 asmlinkage void ret_from_fork(void);
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/blackfin/kernel/process.c
+++ b/arch/blackfin/kernel/process.c
@@ -193,7 +193,7 @@ asmlinkage int bfin_clone(struct pt_regs *regs)
 }
 
 int
-copy_thread(int nr, unsigned long clone_flags,
+copy_thread(unsigned long clone_flags,
 	    unsigned long usp, unsigned long topstk,
 	    struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/cris/arch-v10/kernel/process.c
+++ b/arch/cris/arch-v10/kernel/process.c
@@ -115,7 +115,7 @@ int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
  */
 asmlinkage void ret_from_fork(void);
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/cris/arch-v32/kernel/process.c
+++ b/arch/cris/arch-v32/kernel/process.c
@@ -131,7 +131,7 @@ kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 extern asmlinkage void ret_from_fork(void);
 
 int
-copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+copy_thread(unsigned long clone_flags, unsigned long usp,
 	unsigned long unused,
 	struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -204,7 +204,7 @@ void prepare_to_copy(struct task_struct *tsk)
 /*
  * set up the kernel stack and exception frames for a new process
  */
-int copy_thread(int nr, unsigned long clone_flags,
+int copy_thread(unsigned long clone_flags,
 		unsigned long usp, unsigned long topstk,
 		struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -191,7 +191,7 @@ asmlinkage int h8300_clone(struct pt_regs *regs)
 
 }
 
-int copy_thread(int nr, unsigned long clone_flags,
+int copy_thread(unsigned long clone_flags,
                 unsigned long usp, unsigned long topstk,
 		 struct task_struct * p, struct pt_regs * regs)
 {
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -413,7 +413,7 @@ ia64_load_extra (struct task_struct *task)
  * so there is nothing to worry about.
  */
 int
-copy_thread (int nr, unsigned long clone_flags,
+copy_thread (unsigned long clone_flags,
 	     unsigned long user_stack_base, unsigned long user_stack_size,
 	     struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/m32r/kernel/process.c
+++ b/arch/m32r/kernel/process.c
@@ -225,7 +225,7 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 	return 0; /* Task didn't use the fpu at all. */
 }
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long spu,
+int copy_thread(unsigned long clone_flags, unsigned long spu,
 	unsigned long unused, struct task_struct *tsk, struct pt_regs *regs)
 {
 	struct pt_regs *childregs = task_pt_regs(tsk);
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -233,7 +233,7 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
 		       parent_tidptr, child_tidptr);
 }
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 		 unsigned long unused,
 		 struct task_struct * p, struct pt_regs * regs)
 {
--- a/arch/m68knommu/kernel/process.c
+++ b/arch/m68knommu/kernel/process.c
@@ -199,7 +199,7 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
         return do_fork(clone_flags, newsp, regs, 0, NULL, NULL);
 }
 
-int copy_thread(int nr, unsigned long clone_flags,
+int copy_thread(unsigned long clone_flags,
 		unsigned long usp, unsigned long topstk,
 		struct task_struct * p, struct pt_regs * regs)
 {
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -99,7 +99,7 @@ void flush_thread(void)
 {
 }
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 	unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
 	struct thread_info *ti = task_thread_info(p);
--- a/arch/mn10300/kernel/process.c
+++ b/arch/mn10300/kernel/process.c
@@ -193,7 +193,7 @@ void prepare_to_copy(struct task_struct *tsk)
  * set up the kernel stack for a new thread and copy arch-specific thread
  * control information
  */
-int copy_thread(int nr, unsigned long clone_flags,
+int copy_thread(unsigned long clone_flags,
 		unsigned long c_usp, unsigned long ustk_size,
 		struct task_struct *p, struct pt_regs *kregs)
 {
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -263,7 +263,7 @@ sys_vfork(struct pt_regs *regs)
 }
 
 int
-copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+copy_thread(unsigned long clone_flags, unsigned long usp,
 	    unsigned long unused,	/* in ia64 this is "user_stack_size" */
 	    struct task_struct * p, struct pt_regs * pregs)
 {
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -595,7 +595,7 @@ void prepare_to_copy(struct task_struct *tsk)
 /*
  * Copy a thread..
  */
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused, struct task_struct *p,
 		struct pt_regs *regs)
 {
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -167,7 +167,7 @@ void release_thread(struct task_struct *dead_task)
 {
 }
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long new_stackp,
+int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	unsigned long unused,
         struct task_struct * p, struct pt_regs * regs)
 {
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -170,7 +170,7 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 
 asmlinkage void ret_from_fork(void);
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -425,7 +425,7 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 
 asmlinkage void ret_from_fork(void);
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -455,7 +455,7 @@ asmlinkage int sparc_do_fork(unsigned long clone_flags,
  */
 extern void ret_from_fork(void);
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
+int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -561,7 +561,7 @@ asmlinkage long sparc_do_fork(unsigned long clone_flags,
  * Parent -->  %o0 == childs  pid, %o1 == 0
  * Child  -->  %o0 == parents pid, %o1 == 1
  */
-int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
+int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -179,7 +179,7 @@ void fork_handler(void)
 	userspace(&current->thread.regs.regs);
 }
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
+int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long stack_top, struct task_struct * p,
 		struct pt_regs *regs)
 {
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -287,7 +287,7 @@ void prepare_to_copy(struct task_struct *tsk)
 	unlazy_fpu(tsk);
 }
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
+int copy_thread(unsigned long clone_flags, unsigned long sp,
 	unsigned long unused,
 	struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -317,7 +317,7 @@ void prepare_to_copy(struct task_struct *tsk)
 	unlazy_fpu(tsk);
 }
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
+int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long unused,
 	struct task_struct *p, struct pt_regs *regs)
 {
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -172,7 +172,7 @@ void prepare_to_copy(struct task_struct *tsk)
  *       childregs.
  */
 
-int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
+int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused,
                 struct task_struct * p, struct pt_regs * regs)
 {
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1949,7 +1949,7 @@ extern void mm_release(struct task_struct *, struct mm_struct *);
 /* Allocate a new mm structure and copy contents from tsk->mm */
 extern struct mm_struct *dup_mm(struct task_struct *tsk);
 
-extern int  copy_thread(int, unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
+extern int  copy_thread(unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
 extern void flush_thread(void);
 extern void exit_thread(void);
 
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1120,7 +1120,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 		goto bad_fork_cleanup_mm;
 	if ((retval = copy_io(clone_flags, p)))
 		goto bad_fork_cleanup_namespaces;
-	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
+	retval = copy_thread(clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_io;
 
