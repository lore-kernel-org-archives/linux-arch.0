From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 09/16] fs/compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu,  6 Mar 2014 16:51:16 +0100
Message-ID: <1394121083-2507-10-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:33379 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbaCFPvf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:35 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:34 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8C12D1B08051
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:16 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpKJx60424316
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:20 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpTww017530
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:31 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Convert all compat system call functions where all parameter types
have a size of four or less than four bytes, or are pointer types
to COMPAT_SYSCALL_DEFINE.
The implicit casts within COMPAT_SYSCALL_DEFINE will perform proper
zero and sign extension to 64 bit of all parameters if needed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 fs/compat.c | 73 ++++++++++++++++++++++++++++++-------------------------------
 fs/exec.c   |  6 ++---
 2 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 0095a6978eef..6d8312b7a51d 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -72,8 +72,8 @@ int compat_printk(const char *fmt, ...)
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
  */
-asmlinkage long compat_sys_utime(const char __user *filename,
-				 struct compat_utimbuf __user *t)
+COMPAT_SYSCALL_DEFINE2(utime, const char __user *, filename,
+		       struct compat_utimbuf __user *, t)
 {
 	struct timespec tv[2];
 
@@ -87,7 +87,7 @@ asmlinkage long compat_sys_utime(const char __user *filename,
 	return do_utimes(AT_FDCWD, filename, t ? tv : NULL, 0);
 }
 
-asmlinkage long compat_sys_utimensat(unsigned int dfd, const char __user *filename, struct compat_timespec __user *t, int flags)
+COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filename, struct compat_timespec __user *, t, int, flags)
 {
 	struct timespec tv[2];
 
@@ -102,7 +102,7 @@ asmlinkage long compat_sys_utimensat(unsigned int dfd, const char __user *filena
 	return do_utimes(dfd, filename, t ? tv : NULL, flags);
 }
 
-asmlinkage long compat_sys_futimesat(unsigned int dfd, const char __user *filename, struct compat_timeval __user *t)
+COMPAT_SYSCALL_DEFINE3(futimesat, unsigned int, dfd, const char __user *, filename, struct compat_timeval __user *, t)
 {
 	struct timespec tv[2];
 
@@ -121,7 +121,7 @@ asmlinkage long compat_sys_futimesat(unsigned int dfd, const char __user *filena
 	return do_utimes(dfd, filename, t ? tv : NULL, 0);
 }
 
-asmlinkage long compat_sys_utimes(const char __user *filename, struct compat_timeval __user *t)
+COMPAT_SYSCALL_DEFINE2(utimes, const char __user *, filename, struct compat_timeval __user *, t)
 {
 	return compat_sys_futimesat(AT_FDCWD, filename, t);
 }
@@ -159,8 +159,8 @@ static int cp_compat_stat(struct kstat *stat, struct compat_stat __user *ubuf)
 	return copy_to_user(ubuf, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
 
-asmlinkage long compat_sys_newstat(const char __user * filename,
-		struct compat_stat __user *statbuf)
+COMPAT_SYSCALL_DEFINE2(newstat, const char __user *, filename,
+		       struct compat_stat __user *, statbuf)
 {
 	struct kstat stat;
 	int error;
@@ -171,8 +171,8 @@ asmlinkage long compat_sys_newstat(const char __user * filename,
 	return cp_compat_stat(&stat, statbuf);
 }
 
-asmlinkage long compat_sys_newlstat(const char __user * filename,
-		struct compat_stat __user *statbuf)
+COMPAT_SYSCALL_DEFINE2(newlstat, const char __user *, filename,
+		       struct compat_stat __user *, statbuf)
 {
 	struct kstat stat;
 	int error;
@@ -184,9 +184,9 @@ asmlinkage long compat_sys_newlstat(const char __user * filename,
 }
 
 #ifndef __ARCH_WANT_STAT64
-asmlinkage long compat_sys_newfstatat(unsigned int dfd,
-		const char __user *filename,
-		struct compat_stat __user *statbuf, int flag)
+COMPAT_SYSCALL_DEFINE4(newfstatat, unsigned int, dfd,
+		       const char __user *, filename,
+		       struct compat_stat __user *, statbuf, int, flag)
 {
 	struct kstat stat;
 	int error;
@@ -198,8 +198,8 @@ asmlinkage long compat_sys_newfstatat(unsigned int dfd,
 }
 #endif
 
-asmlinkage long compat_sys_newfstat(unsigned int fd,
-		struct compat_stat __user * statbuf)
+COMPAT_SYSCALL_DEFINE2(newfstat, unsigned int, fd,
+		       struct compat_stat __user *, statbuf)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
@@ -247,7 +247,7 @@ static int put_compat_statfs(struct compat_statfs __user *ubuf, struct kstatfs *
  * The following statfs calls are copies of code from fs/statfs.c and
  * should be checked against those from time to time
  */
-asmlinkage long compat_sys_statfs(const char __user *pathname, struct compat_statfs __user *buf)
+COMPAT_SYSCALL_DEFINE2(statfs, const char __user *, pathname, struct compat_statfs __user *, buf)
 {
 	struct kstatfs tmp;
 	int error = user_statfs(pathname, &tmp);
@@ -256,7 +256,7 @@ asmlinkage long compat_sys_statfs(const char __user *pathname, struct compat_sta
 	return error;
 }
 
-asmlinkage long compat_sys_fstatfs(unsigned int fd, struct compat_statfs __user *buf)
+COMPAT_SYSCALL_DEFINE2(fstatfs, unsigned int, fd, struct compat_statfs __user *, buf)
 {
 	struct kstatfs tmp;
 	int error = fd_statfs(fd, &tmp);
@@ -298,7 +298,7 @@ static int put_compat_statfs64(struct compat_statfs64 __user *ubuf, struct kstat
 	return 0;
 }
 
-asmlinkage long compat_sys_statfs64(const char __user *pathname, compat_size_t sz, struct compat_statfs64 __user *buf)
+COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -312,7 +312,7 @@ asmlinkage long compat_sys_statfs64(const char __user *pathname, compat_size_t s
 	return error;
 }
 
-asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user *buf)
+COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -331,7 +331,7 @@ asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz, struct c
  * Given how simple this syscall is that apporach is more maintainable
  * than the various conversion hacks.
  */
-asmlinkage long compat_sys_ustat(unsigned dev, struct compat_ustat __user *u)
+COMPAT_SYSCALL_DEFINE2(ustat, unsigned, dev, struct compat_ustat __user *, u)
 {
 	struct compat_ustat tmp;
 	struct kstatfs sbuf;
@@ -476,8 +476,7 @@ asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
 	return compat_sys_fcntl64(fd, cmd, arg);
 }
 
-asmlinkage long
-compat_sys_io_setup(unsigned nr_reqs, u32 __user *ctx32p)
+COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_reqs, u32 __user *, ctx32p)
 {
 	long ret;
 	aio_context_t ctx64;
@@ -869,8 +868,8 @@ efault:
 	return -EFAULT;
 }
 
-asmlinkage long compat_sys_old_readdir(unsigned int fd,
-	struct compat_old_linux_dirent __user *dirent, unsigned int count)
+COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
+		struct compat_old_linux_dirent __user *, dirent, unsigned int, count)
 {
 	int error;
 	struct fd f = fdget(fd);
@@ -948,8 +947,8 @@ efault:
 	return -EFAULT;
 }
 
-asmlinkage long compat_sys_getdents(unsigned int fd,
-		struct compat_linux_dirent __user *dirent, unsigned int count)
+COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
+		struct compat_linux_dirent __user *, dirent, unsigned int, count)
 {
 	struct fd f;
 	struct compat_linux_dirent __user * lastdirent;
@@ -1033,8 +1032,8 @@ efault:
 	return -EFAULT;
 }
 
-asmlinkage long compat_sys_getdents64(unsigned int fd,
-		struct linux_dirent64 __user * dirent, unsigned int count)
+COMPAT_SYSCALL_DEFINE3(getdents64, unsigned int, fd,
+		struct linux_dirent64 __user *, dirent, unsigned int, count)
 {
 	struct fd f;
 	struct linux_dirent64 __user * lastdirent;
@@ -1287,9 +1286,9 @@ out_nofds:
 	return ret;
 }
 
-asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
-	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	struct compat_timeval __user *tvp)
+COMPAT_SYSCALL_DEFINE5(select, int, n, compat_ulong_t __user *, inp,
+	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
+	struct compat_timeval __user *, tvp)
 {
 	struct timespec end_time, *to = NULL;
 	struct compat_timeval tv;
@@ -1320,7 +1319,7 @@ struct compat_sel_arg_struct {
 	compat_uptr_t tvp;
 };
 
-asmlinkage long compat_sys_old_select(struct compat_sel_arg_struct __user *arg)
+COMPAT_SYSCALL_DEFINE1(old_select, struct compat_sel_arg_struct __user *, arg)
 {
 	struct compat_sel_arg_struct a;
 
@@ -1381,9 +1380,9 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	return ret;
 }
 
-asmlinkage long compat_sys_pselect6(int n, compat_ulong_t __user *inp,
-	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	struct compat_timespec __user *tsp, void __user *sig)
+COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
+	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
+	struct compat_timespec __user *, tsp, void __user *, sig)
 {
 	compat_size_t sigsetsize = 0;
 	compat_uptr_t up = 0;
@@ -1400,9 +1399,9 @@ asmlinkage long compat_sys_pselect6(int n, compat_ulong_t __user *inp,
 				 sigsetsize);
 }
 
-asmlinkage long compat_sys_ppoll(struct pollfd __user *ufds,
-	unsigned int nfds, struct compat_timespec __user *tsp,
-	const compat_sigset_t __user *sigmask, compat_size_t sigsetsize)
+COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
+	unsigned int,  nfds, struct compat_timespec __user *, tsp,
+	const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
 {
 	compat_sigset_t ss32;
 	sigset_t ksigmask, sigsaved;
diff --git a/fs/exec.c b/fs/exec.c
index 3d78fccdd723..4f59402fdda5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1619,9 +1619,9 @@ SYSCALL_DEFINE3(execve,
 	return do_execve(getname(filename), argv, envp);
 }
 #ifdef CONFIG_COMPAT
-asmlinkage long compat_sys_execve(const char __user * filename,
-	const compat_uptr_t __user * argv,
-	const compat_uptr_t __user * envp)
+COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
+	const compat_uptr_t __user *, argv,
+	const compat_uptr_t __user *, envp)
 {
 	return compat_do_execve(getname(filename), argv, envp);
 }
-- 
1.8.4.5
