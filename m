Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268828AbUIHAob@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:53142 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268834AbUIHAob (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 20:44:31 -0400
Date: Wed, 8 Sep 2004 10:40:40 +1000
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] [ppc64] Fix compat cpu affinity on big endian 64bit
Message-ID: <20040908004040.GD25278@krispykreme>
References: <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org> <20040908002408.GA25278@krispykreme> <20040908003359.GC25278@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908003359.GC25278@krispykreme>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


Add compat sched affinity code. We can argue about how 
USE_COMPAT_ULONG_CPUMASK works now that the non compat interface has changed.

The old non compat behaviour was to require a bitmap long enough in both
setaffinity and getaffinity, now its only required in getaffinity. I
could do the same for the 32bit interfaces.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN kernel/compat.c~compat_sys_sched_affinity kernel/compat.c
--- gr_work/kernel/compat.c~compat_sys_sched_affinity	2004-09-06 04:19:06.327399153 -0500
+++ gr_work-anton/kernel/compat.c	2004-09-07 19:36:09.127584076 -0500
@@ -412,16 +412,43 @@ compat_sys_wait4(compat_pid_t pid, compa
 	}
 }
 
+/*
+ * for maximum compatability, we allow programs to use a single (compat)
+ * unsigned long bitmask if all cpus will fit. If not, you have to have
+ * at least the kernel size available.
+ */
+#define USE_COMPAT_ULONG_CPUMASK (NR_CPUS <= BITS_PER_COMPAT_LONG)
+
 asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid, 
 					     unsigned int len,
 					     compat_ulong_t __user *user_mask_ptr)
 {
-	unsigned long kern_mask;
+	cpumask_t kern_mask;
 	mm_segment_t old_fs;
 	int ret;
 
-	if (get_user(kern_mask, user_mask_ptr))
-		return -EFAULT;
+	if (USE_COMPAT_ULONG_CPUMASK) {
+		compat_ulong_t user_mask;
+
+		if (len < sizeof(user_mask))
+			return -EINVAL;
+
+		if (get_user(user_mask, user_mask_ptr))
+			return -EFAULT;
+
+		cpus_addr(kern_mask)[0] = user_mask;
+	} else {
+		unsigned long *k;
+
+		if (len < sizeof(kern_mask))
+			return -EINVAL;
+
+		k = cpus_addr(kern_mask);
+		ret = compat_get_bitmap(k, user_mask_ptr,
+					sizeof(kern_mask) * BITS_PER_LONG);
+		if (ret)
+			return ret;
+	}
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -436,10 +463,14 @@ asmlinkage long compat_sys_sched_setaffi
 asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid, unsigned int len,
 					     compat_ulong_t __user *user_mask_ptr)
 {
-	unsigned long kern_mask;
+	cpumask_t kern_mask;
 	mm_segment_t old_fs;
 	int ret;
 
+	if (len < (USE_COMPAT_ULONG_CPUMASK ? sizeof(compat_ulong_t)
+				: sizeof(kern_mask)))
+		return -EINVAL;
+
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_sched_getaffinity(pid,
@@ -447,10 +478,23 @@ asmlinkage long compat_sys_sched_getaffi
 				    (unsigned long __user *) &kern_mask);
 	set_fs(old_fs);
 
-	if (ret > 0) {
-		ret = sizeof(compat_ulong_t);
-		if (put_user(kern_mask, user_mask_ptr))
+	if (ret < 0)
+		return ret;
+
+	if (USE_COMPAT_ULONG_CPUMASK) {
+		if (put_user(&cpus_addr(kern_mask)[0], user_mask_ptr))
 			return -EFAULT;
+		ret = sizeof(compat_ulong_t);
+	} else {
+		unsigned long *k;
+
+		k = cpus_addr(kern_mask);
+		ret = compat_put_bitmap(user_mask_ptr, k,
+					sizeof(kern_mask) * BITS_PER_LONG);
+		if (ret)
+			return ret;
+
+		ret = sizeof(kern_mask);
 	}
 
 	return ret;
_
