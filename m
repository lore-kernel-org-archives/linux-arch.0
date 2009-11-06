From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 09/11] sysctl: x86 Use the compat_sys_sysctl
Date: Thu,  5 Nov 2009 16:41:52 -0800
Message-ID: <1257468114-6823-9-git-send-email-ebiederm@xmission.com>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932195AbZKFAmw@vger.kernel.org>
In-Reply-To: <m1tyx8trik.fsf@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

Now that we have a generic 32bit compatibility implementation
there is no need for x86 to implement it's own.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86/ia32/ia32entry.S       |    2 +-
 arch/x86/ia32/sys_ia32.c        |   56 ---------------------------------------
 arch/x86/include/asm/sys_ia32.h |    5 ---
 3 files changed, 1 insertions(+), 62 deletions(-)

diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index 581b056..5d25848 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -653,7 +653,7 @@ ia32_sys_call_table:
 	.quad compat_sys_writev
 	.quad sys_getsid
 	.quad sys_fdatasync
-	.quad sys32_sysctl	/* sysctl */
+	.quad compat_sys_sysctl	/* sysctl */
 	.quad sys_mlock		/* 150 */
 	.quad sys_munlock
 	.quad sys_mlockall
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 9f55271..df82c0e 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -434,62 +434,6 @@ asmlinkage long sys32_rt_sigqueueinfo(int pid, int sig,
 	return ret;
 }
 
-#ifdef CONFIG_SYSCTL_SYSCALL
-struct sysctl_ia32 {
-	unsigned int	name;
-	int		nlen;
-	unsigned int	oldval;
-	unsigned int	oldlenp;
-	unsigned int	newval;
-	unsigned int	newlen;
-	unsigned int	__unused[4];
-};
-
-
-asmlinkage long sys32_sysctl(struct sysctl_ia32 __user *args32)
-{
-	struct sysctl_ia32 a32;
-	mm_segment_t old_fs = get_fs();
-	void __user *oldvalp, *newvalp;
-	size_t oldlen;
-	int __user *namep;
-	long ret;
-
-	if (copy_from_user(&a32, args32, sizeof(a32)))
-		return -EFAULT;
-
-	/*
-	 * We need to pre-validate these because we have to disable
-	 * address checking before calling do_sysctl() because of
-	 * OLDLEN but we can't run the risk of the user specifying bad
-	 * addresses here.  Well, since we're dealing with 32 bit
-	 * addresses, we KNOW that access_ok() will always succeed, so
-	 * this is an expensive NOP, but so what...
-	 */
-	namep = compat_ptr(a32.name);
-	oldvalp = compat_ptr(a32.oldval);
-	newvalp =  compat_ptr(a32.newval);
-
-	if ((oldvalp && get_user(oldlen, (int __user *)compat_ptr(a32.oldlenp)))
-	    || !access_ok(VERIFY_WRITE, namep, 0)
-	    || !access_ok(VERIFY_WRITE, oldvalp, 0)
-	    || !access_ok(VERIFY_WRITE, newvalp, 0))
-		return -EFAULT;
-
-	set_fs(KERNEL_DS);
-	lock_kernel();
-	ret = do_sysctl(namep, a32.nlen, oldvalp, (size_t __user *)&oldlen,
-			newvalp, (size_t) a32.newlen);
-	unlock_kernel();
-	set_fs(old_fs);
-
-	if (oldvalp && put_user(oldlen, (int __user *)compat_ptr(a32.oldlenp)))
-		return -EFAULT;
-
-	return ret;
-}
-#endif
-
 /* warning: next two assume little endian */
 asmlinkage long sys32_pread(unsigned int fd, char __user *ubuf, u32 count,
 			    u32 poslo, u32 poshi)
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index 72a6dcd..9af9dec 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -51,11 +51,6 @@ asmlinkage long sys32_sched_rr_get_interval(compat_pid_t,
 asmlinkage long sys32_rt_sigpending(compat_sigset_t __user *, compat_size_t);
 asmlinkage long sys32_rt_sigqueueinfo(int, int, compat_siginfo_t __user *);
 
-#ifdef CONFIG_SYSCTL_SYSCALL
-struct sysctl_ia32;
-asmlinkage long sys32_sysctl(struct sysctl_ia32 __user *);
-#endif
-
 asmlinkage long sys32_pread(unsigned int, char __user *, u32, u32, u32);
 asmlinkage long sys32_pwrite(unsigned int, char __user *, u32, u32, u32);
 
-- 
1.6.5.2.143.g8cc62
