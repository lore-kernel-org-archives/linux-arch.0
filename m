Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38310 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751526AbWAIHII (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2006 02:08:08 -0500
Date: Mon, 9 Jan 2006 17:59:14 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Adding compat_ptrace_request
Message-ID: <20060109065914.GS26499@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: sfr@canb.auug.org.au
List-ID: <linux-arch.vger.kernel.org>


Hi,

We noticed 32/64bit compat issues with GETSIGINFO and SETSIGINFO. It
looks like s390 are already fixing this up in architecture specific
code, but here is a patch from Stephen Rothwell to add some generic
compat ptrace helpers.

Look OK? 

Anton

--

Subject: [PATCH] compat: add compat_ptrace_request
From: Stephen Rothwell <sfr@canb.auug.org.au>

This is needed so that we can cope with PTRACE_[GS]ETSIGINFO
from 32 bit processes.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/ptrace32.c
===================================================================
--- build.orig/arch/powerpc/kernel/ptrace32.c	2006-01-09 17:44:32.000000000 +1100
+++ build/arch/powerpc/kernel/ptrace32.c	2006-01-09 17:45:32.000000000 +1100
@@ -18,6 +18,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -426,7 +427,7 @@
 #endif
 
 	default:
-		ret = ptrace_request(child, request, addr, data);
+		ret = compat_ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
Index: build/arch/powerpc/kernel/signal_32.c
===================================================================
--- build.orig/arch/powerpc/kernel/signal_32.c	2006-01-09 17:44:32.000000000 +1100
+++ build/arch/powerpc/kernel/signal_32.c	2006-01-09 17:45:32.000000000 +1100
@@ -621,6 +621,14 @@
 	return ret;
 }
 
+int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from)
+{
+	if (copy_from_user(to, from, 3 * sizeof(int)) ||
+	    copy_from_user (to->_sifields._pad, from->_sifields._pad,
+		    SI_PAD_SIZE32))
+		return -EFAULT;
+	return 0;
+}
 
 int copy_siginfo_to_user32(struct compat_siginfo __user *d, siginfo_t *s)
 {
@@ -692,9 +700,9 @@
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
-	if (copy_from_user (&info, uinfo, 3*sizeof(int)) ||
-	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE32))
-		return -EFAULT;
+	ret = copy_siginfo_from_user32(&info, uinfo);
+	if (ret)
+		return ret;
 	set_fs (KERNEL_DS);
 	/* The __user pointer cast is valid becasuse of the set_fs() */
 	ret = sys_rt_sigqueueinfo((int)pid, (int)sig, (siginfo_t __user *) &info);
Index: build/include/linux/compat.h
===================================================================
--- build.orig/include/linux/compat.h	2006-01-09 17:44:26.000000000 +1100
+++ build/include/linux/compat.h	2006-01-09 17:45:32.000000000 +1100
@@ -161,5 +161,10 @@
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
 
+struct task_struct;
+
+long compat_ptrace_request(struct task_struct *child, long request,
+		long addr, long data);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
Index: build/kernel/Makefile
===================================================================
--- build.orig/kernel/Makefile	2006-01-09 17:44:26.000000000 +1100
+++ build/kernel/Makefile	2006-01-09 17:45:32.000000000 +1100
@@ -19,7 +19,7 @@
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
-obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_COMPAT) += compat.o compat_ptrace.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
Index: build/kernel/compat_ptrace.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ build/kernel/compat_ptrace.c	2006-01-09 17:45:32.000000000 +1100
@@ -0,0 +1,91 @@
+/*
+ * (C) Copyright 2005 Stephen Rothwell, IBM Inc.
+ *
+ * Based on ptrace.c
+ *
+ * Common compatibility interfaces for "ptrace()" which we do not want
+ * to continually duplicate across every architecture.
+ */
+#include <linux/compat.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/spinlock.h>
+#include <linux/stddef.h>
+
+typedef struct compat_siginfo compat_siginfo_t;
+
+static long compat_ptrace_getsiginfo(struct task_struct *child,
+		compat_siginfo_t __user *data)
+{
+	siginfo_t lastinfo;
+	int error = -ESRCH;
+
+	read_lock(&tasklist_lock);
+	if (likely(child->sighand != NULL)) {
+		error = -EINVAL;
+		spin_lock_irq(&child->sighand->siglock);
+		if (likely(child->last_siginfo != NULL)) {
+			lastinfo = *child->last_siginfo;
+			error = 0;
+		}
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);
+	if (!error)
+		return copy_siginfo_to_user32(data, &lastinfo);
+	return error;
+}
+
+static long compat_ptrace_setsiginfo(struct task_struct *child,
+		compat_siginfo_t __user *data)
+{
+	siginfo_t newinfo;
+	int error = -ESRCH;
+
+	if (copy_siginfo_from_user32(&newinfo, data))
+		return -EFAULT;
+
+	read_lock(&tasklist_lock);
+	if (likely(child->sighand != NULL)) {
+		error = -EINVAL;
+		spin_lock_irq(&child->sighand->siglock);
+		if (likely(child->last_siginfo != NULL)) {
+			*child->last_siginfo = newinfo;
+			error = 0;
+		}
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);
+	return error;
+}
+
+long compat_ptrace_request(struct task_struct *child, long request,
+		   long addr, long data)
+{
+	long ret = -EIO;
+
+	switch (request) {
+#ifdef PTRACE_OLDSETOPTIONS
+	case PTRACE_OLDSETOPTIONS:
+#endif
+	case PTRACE_SETOPTIONS:
+	case PTRACE_GETEVENTMSG:
+		ret = ptrace_request(child, request, addr, data);
+		break;
+	case PTRACE_GETSIGINFO:
+		ret = compat_ptrace_getsiginfo(child,
+				(compat_siginfo_t __user *)data);
+		break;
+	case PTRACE_SETSIGINFO:
+		ret = compat_ptrace_setsiginfo(child,
+				(compat_siginfo_t __user *)data);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
