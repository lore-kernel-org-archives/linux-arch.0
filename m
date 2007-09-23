Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:54487 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbXIWLi7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 23 Sep 2007 07:38:59 -0400
Date: Sun, 23 Sep 2007 13:38:45 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] m32r: convert to generic sys_ptrace
Message-ID: <20070923113845.GA8299@lst.de>
References: <20070908191107.GA4881@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070908191107.GA4881@lst.de>
Sender: linux-arch-owner@vger.kernel.org
To: takata@linux-m32r.org, akpm@osdl.org
Cc: linux-m32r@ml.linux-m32r.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Convert m32r to the generic sys_ptrace.  The conversion requires an
architecture hook after ptrace_attach which this patch adds.  The hook
will also be needed for a conersion of ia64 to the generic ptrace code.

Thanks to Hirokazu Takata for fixing a bug in the first version of this
code.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/m32r/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/ptrace.c	2007-09-09 11:58:35.000000000 +0200
+++ linux-2.6/arch/m32r/kernel/ptrace.c	2007-09-23 13:35:14.000000000 +0200
@@ -570,7 +570,7 @@ withdraw_debug_trap(struct pt_regs *regs
 	}
 }
 
-static void
+void
 init_debug_traps(struct task_struct *child)
 {
 	struct debug_trap *p = &child->thread.debug_trap;
@@ -593,8 +593,8 @@ void ptrace_disable(struct task_struct *
 	/* nothing to do.. */
 }
 
-static int
-do_ptrace(long request, struct task_struct *child, long addr, long data)
+long
+arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	int ret;
 
@@ -728,42 +728,6 @@ do_ptrace(long request, struct task_stru
 	return ret;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
-{
-	struct task_struct *child;
-	int ret;
-
-	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		ret = ptrace_traceme();
-		goto out;
-	}
-
-	child = ptrace_get_task_struct(pid);
-	if (IS_ERR(child)) {
-		ret = PTR_ERR(child);
-		goto out;
-	}
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		if (ret == 0)
-			init_debug_traps(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret == 0)
-		ret = do_ptrace(request, child, addr, data);
-
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
-
-	return ret;
-}
-
 /* notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
Index: linux-2.6/include/asm-m32r/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-m32r/ptrace.h	2007-09-09 11:58:35.000000000 +0200
+++ linux-2.6/include/asm-m32r/ptrace.h	2007-09-23 13:34:12.000000000 +0200
@@ -120,7 +120,10 @@ struct pt_regs {
 
 #include <asm/m32r.h>		/* M32R_PSW_BSM, M32R_PSW_BPM */
 
-#define __ARCH_SYS_PTRACE	1
+struct task_struct;
+extern void init_debug_traps(struct task_struct *);
+#define arch_ptrace_attach(child) \
+	init_debug_traps(child)
 
 #if defined(CONFIG_ISA_M32R2) || defined(CONFIG_CHIP_VDEC2)
 #define user_mode(regs) ((M32R_PSW_BPM & (regs)->psw) != 0)
Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2007-09-11 16:25:08.000000000 +0200
+++ linux-2.6/kernel/ptrace.c	2007-09-23 13:34:12.000000000 +0200
@@ -450,6 +450,10 @@ struct task_struct *ptrace_get_task_stru
 	return child;
 }
 
+#ifndef arch_ptrace_attach
+#define arch_ptrace_attach(child)	do { } while (0)
+#endif
+
 #ifndef __ARCH_SYS_PTRACE
 asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
@@ -473,6 +477,12 @@ asmlinkage long sys_ptrace(long request,
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
+		/*
+		 * Some architectures need to do book-keeping after
+		 * a ptrace attach.
+		 */
+		if (!ret)
+			arch_ptrace_attach(child);
 		goto out_put_task_struct;
 	}
 
