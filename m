Return-Path: <anton@samba.org>
Received: from dp.samba.org ([66.70.73.150]:27627 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262493AbUCRJvB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 04:51:01 -0500
Date: Thu, 18 Mar 2004 20:46:24 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: compat_sys_sched_setaffinity()
Message-ID: <20040318094624.GJ28212@krispykreme>
References: <20040318010531.1af5b0a9.akpm@osdl.org> <20040318011743.475153bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318011743.475153bf.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

 
> It also seems to be broken with NR_CPUS > 32.  The syscall API says
> (implies?) that CPU 0 is the LSB of *user_mask_ptr.  On a big-endian 32-bit
> app, an attempt to bind to CPU #0 will end up binding to CPU #33, methinks.
> 
> 
> And it's potentially trying to copy more than `len' bytes from userspace so
> it might incorrectly return -EFAULT.
> 
> 
> And it's failing to check that len >= sizeof(cpumask_t).  If the user
> passes in len==1, he gets bound to garbage CPUs.

Remember this patch? :) Dave and you had some concerns that it would
do bad things on little endian but I cant see why.

Anton

--

From anton@samba.org Thu Jan 22 02:27:40 2004
Date: Thu, 22 Jan 2004 02:27:40 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-arch@vger.kernel.org
Subject: compat sched_affinity

Hi,

Ive got a patch in my local tree from Milton Miller that fixes the sched
affinity calls when NR_CPUS > 32.

Thoughts?
Anton

--

Patch from Milton Miller that adds the sched_affinity syscalls into the
compat layer.

 gr16b-anton/kernel/compat.c |   88 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 79 insertions(+), 9 deletions(-)

diff -puN kernel/compat.c~compat_sys_sched_affinity kernel/compat.c
--- gr16b/kernel/compat.c~compat_sys_sched_affinity	2004-01-21 23:48:39.853282726 +1100
+++ gr16b-anton/kernel/compat.c	2004-01-21 23:48:39.861282640 +1100
@@ -381,6 +381,12 @@ compat_sys_wait4(compat_pid_t pid, compa
 	}
 }
 
+/* for maximum compatability, we allow programs to use a single (compat)
+ * unsigned long bitmask if all cpus will fit.  If not, you have to have
+ * at least the kernel size available.
+ */
+#define USE_COMPAT_ULONG_CPUMASK (NR_CPUS <= 8*sizeof(compat_ulong_t))
+
 extern asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
@@ -388,18 +394,54 @@ asmlinkage long compat_sys_sched_setaffi
 					     unsigned int len,
 					     compat_ulong_t *user_mask_ptr)
 {
-	unsigned long kernel_mask;
+	cpumask_t kernel_mask;
 	mm_segment_t old_fs;
 	int ret;
 
-	if (get_user(kernel_mask, user_mask_ptr))
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
+		kernel_mask = cpus_promote(user_mask);
+	} else {
+		if (len < sizeof(kernel_mask))
+			return -EINVAL;
+
+		if (!access_ok(VERIFY_READ, user_mask_ptr, sizeof(kernel_mask)))
+			return -EFAULT;
+		else {
+			int i, j;
+			unsigned long *k, m;
+			compat_ulong_t um;
+
+			k = &cpus_coerce(kernel_mask);
+
+			for (i=0; i < sizeof(kernel_mask)/sizeof(m); i++) {
+				m = 0;
+
+				for (j = 0; j < sizeof(m)/sizeof(um); j++ ) {
+					if (__get_user(um, user_mask_ptr))
+						return -EFAULT;
+					user_mask_ptr++;
+					m <<= 4*sizeof(um);
+					m <<= 4*sizeof(um);
+					m |= um;
+				}
+				*k++ = m;
+			}
+		}
+	}
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_sched_setaffinity(pid,
 				    sizeof(kernel_mask),
-				    &kernel_mask);
+				    (unsigned long *)&kernel_mask);
 	set_fs(old_fs);
 
 	return ret;
@@ -411,21 +453,49 @@ extern asmlinkage long sys_sched_getaffi
 asmlinkage int compat_sys_sched_getaffinity(compat_pid_t pid, unsigned int len,
 					    compat_ulong_t *user_mask_ptr)
 {
-	unsigned long kernel_mask;
+	cpumask_t kernel_mask;
 	mm_segment_t old_fs;
 	int ret;
 
+	if (len < (USE_COMPAT_ULONG_CPUMASK ? sizeof(compat_ulong_t)
+				: sizeof(kernel_mask)))
+		return -EINVAL;
+
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_sched_getaffinity(pid,
 				    sizeof(kernel_mask),
-				    &kernel_mask);
+				    (unsigned long *)&kernel_mask);
 	set_fs(old_fs);
 
 	if (ret > 0) {
-		ret = sizeof(compat_ulong_t);
-		if (put_user(kernel_mask, user_mask_ptr))
-			return -EFAULT;
+		if (USE_COMPAT_ULONG_CPUMASK) {
+			ret = sizeof(compat_ulong_t);
+			if (put_user(cpus_coerce(kernel_mask), user_mask_ptr))
+				return -EFAULT;
+		} else {
+			int i, j, err;
+			unsigned long *k, m;
+			compat_ulong_t um;
+
+			err = access_ok(VERIFY_WRITE, user_mask_ptr, ret);
+
+			k = &cpus_coerce(kernel_mask);
+
+			for (i=0; i < sizeof(kernel_mask)/sizeof(m) && !err; i++) {
+				m = *k++;
+
+				for (j = 0; j < sizeof(m)/sizeof(compat_ulong_t) && !err; j++ ) {
+					um = m;
+					err |= __put_user(um, user_mask_ptr);
+					user_mask_ptr++;
+					m >>= 4*sizeof(compat_ulong_t);
+					m >>= 4*sizeof(compat_ulong_t);
+				}
+			}
+			if (err)
+				ret = -EFAULT;
+		}
 	}
 
 	return ret;
