Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267495AbUIUDm6@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:3225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267494AbUIUDm6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Sep 2004 23:42:58 -0400
Date: Mon, 20 Sep 2004 20:40:55 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: x86-64-waitid-compat-fix
Message-Id: <20040920204055.577976a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


I guess I'll merge this into Linus's tree this evening.  It breaks sparc64
and probably other architectures.  The fix will be simple; probably the
same as x86_64..


From: Roland McGrath <roland@redhat.com>

This patch updates the x86-64's compat code to handle the new argument to
waitid.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/ia32/sys_ia32.c |   11 +++++++++--
 25-akpm/include/linux/syscalls.h    |    3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff -puN arch/x86_64/ia32/sys_ia32.c~x86-64-waitid-compat-fix arch/x86_64/ia32/sys_ia32.c
--- 25/arch/x86_64/ia32/sys_ia32.c~x86-64-waitid-compat-fix	Mon Sep 20 14:58:27 2004
+++ 25-akpm/arch/x86_64/ia32/sys_ia32.c	Mon Sep 20 14:58:27 2004
@@ -1152,19 +1152,26 @@ asmlinkage long sys32_clone(unsigned int
 }
 
 asmlinkage long sys32_waitid(int which, compat_pid_t pid,
-			     siginfo_t32 __user *uinfo, int options)
+			     siginfo_t32 __user *uinfo, int options,
+			     struct compat_rusage __user *uru)
 {
 	siginfo_t info;
+	struct rusage ru;
 	long ret;
 	mm_segment_t old_fs = get_fs();
 
 	info.si_signo = 0;
 	set_fs (KERNEL_DS);
-	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options);
+	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options,
+			 uru ? &ru : NULL);
 	set_fs (old_fs);
 
 	if (ret < 0 || info.si_signo == 0)
 		return ret;
+
+	if (uru && (ret = put_compat_rusage(&ru, uru)))
+		return ret;
+
 	BUG_ON(info.si_code & __SI_MASK);
 	info.si_code |= __SI_CHLD;
 	return ia32_copy_siginfo_to_user(uinfo, &info);
diff -puN include/linux/syscalls.h~x86-64-waitid-compat-fix include/linux/syscalls.h
--- 25/include/linux/syscalls.h~x86-64-waitid-compat-fix	Mon Sep 20 14:58:27 2004
+++ 25-akpm/include/linux/syscalls.h	Mon Sep 20 14:58:27 2004
@@ -163,7 +163,8 @@ asmlinkage void sys_exit_group(int error
 asmlinkage long sys_wait4(pid_t pid, unsigned int __user *stat_addr,
 				int options, struct rusage __user *ru);
 asmlinkage long sys_waitid(int which, pid_t pid,
-			   	struct siginfo __user *infop, int options);
+			   struct siginfo __user *infop,
+			   int options, struct rusage __user *ru);
 asmlinkage long sys_waitpid(pid_t pid, unsigned int __user *stat_addr, int options);
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
_
