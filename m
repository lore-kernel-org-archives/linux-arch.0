Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:2447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030599AbWBHX0k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2006 18:26:40 -0500
Message-Id: <200602082326.k18NQFQs017837@shell0.pdx.osdl.net>
Subject: [patch 1/1] fstatat64 support
From: akpm@osdl.org
Date: Wed, 08 Feb 2006 15:25:51 -0800
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org, drepper@redhat.com, ak@muc.de, hch@lst.de
List-ID: <linux-arch.vger.kernel.org>


From: Ulrich Drepper <drepper@redhat.com>

The *at patches introduced fstatat and, due to inusfficient research, I
used the newfstat functions generally as the guideline.  The result is that
on 32-bit platforms we don't have all the information needed to implement
fstatat64.

This patch modifies the code to pass up 64-bit information if
__ARCH_WANT_STAT64 is defined.  I renamed the syscall entry point to make
this clear.  Other archs will continue to use the existing code.  On x86-64
the compat code is implemented using a new sys32_ function.  this is what
is done for the other stat syscalls as well.

This patch might break some other archs (those which define
__ARCH_WANT_STAT64 and which already wired up the syscall).  Yet others
might need changes to accomodate the compatibility mode.  I really don't
want to do that work because all this stat handling is a mess (more so in
glibc, but the kernel is also affected).  It should be done by the arch
maintainers.  I'll provide some stand-alone test shortly.  Those who are
eager could compile glibc and run 'make check' (no installation needed).

The patch below has been tested on x86 and x86-64.

Signed-off-by: Ulrich Drepper <drepper@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/syscall_table.S |    2 +-
 arch/x86_64/ia32/ia32entry.S     |    2 +-
 arch/x86_64/ia32/sys_ia32.c      |   22 ++++++++++++++++++++++
 fs/stat.c                        |   22 ++++++++++++++++++++++
 include/asm-i386/unistd.h        |    2 +-
 include/asm-x86_64/ia32_unistd.h |    2 +-
 include/linux/syscalls.h         |    2 ++
 7 files changed, 50 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/syscall_table.S~fstatat64-support arch/i386/kernel/syscall_table.S
--- devel/arch/i386/kernel/syscall_table.S~fstatat64-support	2006-02-08 15:23:45.000000000 -0800
+++ devel-akpm/arch/i386/kernel/syscall_table.S	2006-02-08 15:23:45.000000000 -0800
@@ -299,7 +299,7 @@ ENTRY(sys_call_table)
 	.long sys_mknodat
 	.long sys_fchownat
 	.long sys_futimesat
-	.long sys_newfstatat		/* 300 */
+	.long sys_newfstatat64		/* 300 */
 	.long sys_unlinkat
 	.long sys_renameat
 	.long sys_linkat
diff -puN arch/x86_64/ia32/ia32entry.S~fstatat64-support arch/x86_64/ia32/ia32entry.S
--- devel/arch/x86_64/ia32/ia32entry.S~fstatat64-support	2006-02-08 15:23:45.000000000 -0800
+++ devel-akpm/arch/x86_64/ia32/ia32entry.S	2006-02-08 15:23:45.000000000 -0800
@@ -677,7 +677,7 @@ ia32_sys_call_table:
 	.quad sys_mknodat
 	.quad sys_fchownat
 	.quad compat_sys_futimesat
-	.quad compat_sys_newfstatat	/* 300 */
+	.quad sys32_fstatat		/* 300 */
 	.quad sys_unlinkat
 	.quad sys_renameat
 	.quad sys_linkat
diff -puN arch/x86_64/ia32/sys_ia32.c~fstatat64-support arch/x86_64/ia32/sys_ia32.c
--- devel/arch/x86_64/ia32/sys_ia32.c~fstatat64-support	2006-02-08 15:23:45.000000000 -0800
+++ devel-akpm/arch/x86_64/ia32/sys_ia32.c	2006-02-08 15:23:45.000000000 -0800
@@ -180,6 +180,28 @@ sys32_fstat64(unsigned int fd, struct st
 	return ret;
 }
 
+asmlinkage long
+sys32_fstatat(unsigned int dfd, char __user *filename,
+	      struct stat64 __user* statbuf, int flag)
+{
+	struct kstat stat;
+	int error = -EINVAL;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	if (flag & AT_SYMLINK_NOFOLLOW)
+		error = vfs_lstat_fd(dfd, filename, &stat);
+	else
+		error = vfs_stat_fd(dfd, filename, &stat);
+
+	if (!error)
+		error = cp_stat64(statbuf, &stat);
+
+out:
+	return error;
+}
+
 /*
  * Linux/i386 didn't use to be able to handle more than
  * 4 system call parameters, so these system calls used a memory
diff -puN fs/stat.c~fstatat64-support fs/stat.c
--- devel/fs/stat.c~fstatat64-support	2006-02-08 15:23:45.000000000 -0800
+++ devel-akpm/fs/stat.c	2006-02-08 15:23:45.000000000 -0800
@@ -261,6 +261,7 @@ asmlinkage long sys_newlstat(char __user
 	return error;
 }
 
+#ifndef __ARCH_WANT_STAT64
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
 				struct stat __user *statbuf, int flag)
 {
@@ -281,6 +282,7 @@ asmlinkage long sys_newfstatat(int dfd, 
 out:
 	return error;
 }
+#endif
 
 asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf)
 {
@@ -395,6 +397,26 @@ asmlinkage long sys_fstat64(unsigned lon
 	return error;
 }
 
+asmlinkage long sys_newfstatat64(int dfd, char __user *filename,
+				 struct stat64 __user *statbuf, int flag)
+{
+	struct kstat stat;
+	int error = -EINVAL;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	if (flag & AT_SYMLINK_NOFOLLOW)
+		error = vfs_lstat_fd(dfd, filename, &stat);
+	else
+		error = vfs_stat_fd(dfd, filename, &stat);
+
+	if (!error)
+		error = cp_new_stat64(&stat, statbuf);
+
+out:
+	return error;
+}
 #endif /* __ARCH_WANT_STAT64 */
 
 void inode_add_bytes(struct inode *inode, loff_t bytes)
diff -puN include/asm-i386/unistd.h~fstatat64-support include/asm-i386/unistd.h
--- devel/include/asm-i386/unistd.h~fstatat64-support	2006-02-08 15:23:45.000000000 -0800
+++ devel-akpm/include/asm-i386/unistd.h	2006-02-08 15:23:45.000000000 -0800
@@ -305,7 +305,7 @@
 #define __NR_mknodat		297
 #define __NR_fchownat		298
 #define __NR_futimesat		299
-#define __NR_newfstatat		300
+#define __NR_newfstatat64	300
 #define __NR_unlinkat		301
 #define __NR_renameat		302
 #define __NR_linkat		303
diff -puN include/asm-x86_64/ia32_unistd.h~fstatat64-support include/asm-x86_64/ia32_unistd.h
--- devel/include/asm-x86_64/ia32_unistd.h~fstatat64-support	2006-02-08 15:23:45.000000000 -0800
+++ devel-akpm/include/asm-x86_64/ia32_unistd.h	2006-02-08 15:23:45.000000000 -0800
@@ -305,7 +305,7 @@
 #define __NR_ia32_mknodat		297
 #define __NR_ia32_fchownat		298
 #define __NR_ia32_futimesat		299
-#define __NR_ia32_newfstatat		300
+#define __NR_ia32_newfstatat64		300
 #define __NR_ia32_unlinkat		301
 #define __NR_ia32_renameat		302
 #define __NR_ia32_linkat		303
diff -puN include/linux/syscalls.h~fstatat64-support include/linux/syscalls.h
--- devel/include/linux/syscalls.h~fstatat64-support	2006-02-08 15:23:45.000000000 -0800
+++ devel-akpm/include/linux/syscalls.h	2006-02-08 15:23:45.000000000 -0800
@@ -557,6 +557,8 @@ asmlinkage long sys_openat(int dfd, cons
 			   int mode);
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
 			       struct stat __user *statbuf, int flag);
+asmlinkage long sys_newfstatat64(int dfd, char __user *filename,
+				 struct stat64 __user *statbuf, int flag);
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
 asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename,
_
