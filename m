From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 04/11] sysctl: ia64 Use the compat_sys_sysctl
Date: Thu,  5 Nov 2009 16:41:47 -0800
Message-ID: <1257468114-6823-4-git-send-email-ebiederm@xmission.com>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:39325 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759248AbZKFAmI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2009 19:42:08 -0500
In-Reply-To: <m1tyx8trik.fsf@fess.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>

From: Eric W. Biederman <ebiederm@xmission.com>

Now that we have a generic 32bit compatibility implementation
there is no need for ia64 to implement it's own.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/ia32/ia32_entry.S |    2 +-
 arch/ia64/ia32/sys_ia32.c   |   55 -------------------------------------------
 2 files changed, 1 insertions(+), 56 deletions(-)

diff --git a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
index af9405c..10c3751 100644
--- a/arch/ia64/ia32/ia32_entry.S
+++ b/arch/ia64/ia32/ia32_entry.S
@@ -327,7 +327,7 @@ ia32_syscall_table:
 	data8 compat_sys_writev
 	data8 sys_getsid
 	data8 sys_fdatasync
-	data8 sys32_sysctl
+	data8 compat_sys_sysctl
 	data8 sys_mlock		  /* 150 */
 	data8 sys_munlock
 	data8 sys_mlockall
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index 625ed8f..429ec96 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -1628,61 +1628,6 @@ sys32_msync (unsigned int start, unsigned int len, int flags)
 	return sys_msync(addr, len + (start - addr), flags);
 }
 
-struct sysctl32 {
-	unsigned int	name;
-	int		nlen;
-	unsigned int	oldval;
-	unsigned int	oldlenp;
-	unsigned int	newval;
-	unsigned int	newlen;
-	unsigned int	__unused[4];
-};
-
-#ifdef CONFIG_SYSCTL_SYSCALL
-asmlinkage long
-sys32_sysctl (struct sysctl32 __user *args)
-{
-	struct sysctl32 a32;
-	mm_segment_t old_fs = get_fs ();
-	void __user *oldvalp, *newvalp;
-	size_t oldlen;
-	int __user *namep;
-	long ret;
-
-	if (copy_from_user(&a32, args, sizeof(a32)))
-		return -EFAULT;
-
-	/*
-	 * We need to pre-validate these because we have to disable address checking
-	 * before calling do_sysctl() because of OLDLEN but we can't run the risk of the
-	 * user specifying bad addresses here.  Well, since we're dealing with 32 bit
-	 * addresses, we KNOW that access_ok() will always succeed, so this is an
-	 * expensive NOP, but so what...
-	 */
-	namep = (int __user *) compat_ptr(a32.name);
-	oldvalp = compat_ptr(a32.oldval);
-	newvalp = compat_ptr(a32.newval);
-
-	if ((oldvalp && get_user(oldlen, (int __user *) compat_ptr(a32.oldlenp)))
-	    || !access_ok(VERIFY_WRITE, namep, 0)
-	    || !access_ok(VERIFY_WRITE, oldvalp, 0)
-	    || !access_ok(VERIFY_WRITE, newvalp, 0))
-		return -EFAULT;
-
-	set_fs(KERNEL_DS);
-	lock_kernel();
-	ret = do_sysctl(namep, a32.nlen, oldvalp, (size_t __user *) &oldlen,
-			newvalp, (size_t) a32.newlen);
-	unlock_kernel();
-	set_fs(old_fs);
-
-	if (oldvalp && put_user (oldlen, (int __user *) compat_ptr(a32.oldlenp)))
-		return -EFAULT;
-
-	return ret;
-}
-#endif
-
 asmlinkage long
 sys32_newuname (struct new_utsname __user *name)
 {
-- 
1.6.5.2.143.g8cc62
