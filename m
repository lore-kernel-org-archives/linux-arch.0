From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 11/16] fs/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
Date: Thu,  6 Mar 2014 16:51:18 +0100
Message-ID: <1394121083-2507-12-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:33386 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbaCFPvh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:37 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:35 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 42B251B08040
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:18 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpL026029386
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:21 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpV0E017606
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:33 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Some fs compat system calls have unsigned long parameters instead of
compat_ulong_t.
In order to allow the COMPAT_SYSCALL_DEFINE macro generate code that
performs proper zero and sign extension convert all 64 bit parameters
their corresponding 32 bit counterparts.

compat_sys_io_getevents() is a bit different: the non-compat version
has signed parameters for the "min_nr" and "nr" parameters while the
compat version has unsigned parameters.
So change this as well. For all practical purposes this shouldn't make
any difference (doesn't fix a real bug).
Also introduce a generic compat_aio_context_t type which can be used
everywhere.
The access_ok() check within compat_sys_io_getevents() got also removed
since the non-compat sys_io_getevents() should be able to handle
everything anyway.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 fs/compat.c            | 44 ++++++++++++++++++--------------------------
 fs/compat_ioctl.c      |  5 +++--
 include/linux/compat.h | 18 ++++++++++--------
 3 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 6d8312b7a51d..19252b97f0cc 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -399,8 +399,8 @@ static int put_compat_flock64(struct flock *kfl, struct compat_flock64 __user *u
 }
 #endif
 
-asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
-		unsigned long arg)
+COMPAT_SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
+		       compat_ulong_t, arg)
 {
 	mm_segment_t old_fs;
 	struct flock f;
@@ -468,8 +468,8 @@ asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
 	return ret;
 }
 
-asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
-		unsigned long arg)
+COMPAT_SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd,
+		       compat_ulong_t, arg)
 {
 	if ((cmd == F_GETLK64) || (cmd == F_SETLK64) || (cmd == F_SETLKW64))
 		return -EINVAL;
@@ -495,32 +495,24 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_reqs, u32 __user *, ctx32p)
 	return ret;
 }
 
-asmlinkage long
-compat_sys_io_getevents(aio_context_t ctx_id,
-				 unsigned long min_nr,
-				 unsigned long nr,
-				 struct io_event __user *events,
-				 struct compat_timespec __user *timeout)
+COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
+		       compat_long_t, min_nr,
+		       compat_long_t, nr,
+		       struct io_event __user *, events,
+		       struct compat_timespec __user *, timeout)
 {
-	long ret;
 	struct timespec t;
 	struct timespec __user *ut = NULL;
 
-	ret = -EFAULT;
-	if (unlikely(!access_ok(VERIFY_WRITE, events, 
-				nr * sizeof(struct io_event))))
-		goto out;
 	if (timeout) {
 		if (get_compat_timespec(&t, timeout))
-			goto out;
+			return -EFAULT;
 
 		ut = compat_alloc_user_space(sizeof(*ut));
 		if (copy_to_user(ut, &t, sizeof(t)) )
-			goto out;
+			return -EFAULT;
 	} 
-	ret = sys_io_getevents(ctx_id, min_nr, nr, events, ut);
-out:
-	return ret;
+	return sys_io_getevents(ctx_id, min_nr, nr, events, ut);
 }
 
 /* A write operation does a read from user space and vice versa */
@@ -616,8 +608,8 @@ copy_iocb(long nr, u32 __user *ptr32, struct iocb __user * __user *ptr64)
 
 #define MAX_AIO_SUBMITS 	(PAGE_SIZE/sizeof(struct iocb *))
 
-asmlinkage long
-compat_sys_io_submit(aio_context_t ctx_id, int nr, u32 __user *iocb)
+COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
+		       int, nr, u32 __user *, iocb)
 {
 	struct iocb __user * __user *iocb64; 
 	long ret;
@@ -769,10 +761,10 @@ static int do_nfs4_super_data_conv(void *raw_data)
 #define NCPFS_NAME      "ncpfs"
 #define NFS4_NAME	"nfs4"
 
-asmlinkage long compat_sys_mount(const char __user * dev_name,
-				 const char __user * dir_name,
-				 const char __user * type, unsigned long flags,
-				 const void __user * data)
+COMPAT_SYSCALL_DEFINE5(mount, const char __user *, dev_name,
+		       const char __user *, dir_name,
+		       const char __user *, type, compat_ulong_t, flags,
+		       const void __user *, data)
 {
 	char *kernel_type;
 	unsigned long data_page;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 3881610b6438..e82289047272 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1538,9 +1538,10 @@ static int compat_ioctl_check_table(unsigned int xcmd)
 	return ioctl_pointer[i] == xcmd;
 }
 
-asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
-				unsigned long arg)
+COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
+		       compat_ulong_t, arg32)
 {
+	unsigned long arg = arg32;
 	struct fd f = fdget(fd);
 	int error = -EBADF;
 	if (!f.file)
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1c457428ec0a..fea8ee9afe22 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -71,6 +71,8 @@ typedef struct compat_sigaltstack {
 typedef __compat_uid32_t	compat_uid_t;
 typedef __compat_gid32_t	compat_gid_t;
 
+typedef	compat_ulong_t		compat_aio_context_t;
+
 struct compat_sel_arg_struct;
 struct rusage;
 
@@ -497,20 +499,20 @@ asmlinkage long compat_sys_statfs64(const char __user *pathname,
 asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
 				     struct compat_statfs64 __user *buf);
 asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
-				   unsigned long arg);
+				   compat_ulong_t arg);
 asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
-				 unsigned long arg);
+				 compat_ulong_t arg);
 asmlinkage long compat_sys_io_setup(unsigned nr_reqs, u32 __user *ctx32p);
-asmlinkage long compat_sys_io_getevents(aio_context_t ctx_id,
-					unsigned long min_nr,
-					unsigned long nr,
+asmlinkage long compat_sys_io_getevents(compat_aio_context_t ctx_id,
+					compat_long_t min_nr,
+					compat_long_t nr,
 					struct io_event __user *events,
 					struct compat_timespec __user *timeout);
-asmlinkage long compat_sys_io_submit(aio_context_t ctx_id, int nr,
+asmlinkage long compat_sys_io_submit(compat_aio_context_t ctx_id, int nr,
 				     u32 __user *iocb);
 asmlinkage long compat_sys_mount(const char __user *dev_name,
 				 const char __user *dir_name,
-				 const char __user *type, unsigned long flags,
+				 const char __user *type, compat_ulong_t flags,
 				 const void __user *data);
 asmlinkage long compat_sys_old_readdir(unsigned int fd,
 				       struct compat_old_linux_dirent __user *,
@@ -633,7 +635,7 @@ asmlinkage long compat_sys_rt_sigqueueinfo(compat_pid_t pid, int sig,
 				struct compat_siginfo __user *uinfo);
 asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
 asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
-				 unsigned long arg);
+				 compat_ulong_t arg);
 asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
 		struct compat_timespec __user *utime, u32 __user *uaddr2,
 		u32 val3);
-- 
1.8.4.5
