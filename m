From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 04/16] fs/compat: optional preadv64/pwrite64 compat system calls
Date: Thu,  6 Mar 2014 16:51:11 +0100
Message-ID: <1394121083-2507-5-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:47466 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbaCFPvd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:33 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:32 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2981E17D804E
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:52:06 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpHKw62718054
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:17 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpRDP017384
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:28 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

The preadv64/pwrite64 have been implemented for the x32 ABI, in order
to allow passing 64 bit arguments from user space without splitting
them into two 32 bit parameters, like it would be necessary for usual
compat tasks.
Howevert these two system calls are only being used for the x32 ABI,
so add __ARCH_WANT_COMPAT defines for these two compat syscalls and
make these two only visible for x86.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/x86/include/asm/unistd.h |  2 ++
 fs/read_write.c               | 36 ++++++++++++++++++++++++++++--------
 include/linux/compat.h        | 13 +++++++++++++
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index f4b5795d7e34..3f556c6a0157 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -24,6 +24,8 @@
 #  include <asm/unistd_64_x32.h>
 #  define __ARCH_WANT_COMPAT_SYS_TIME
 #  define __ARCH_WANT_COMPAT_SYS_GETDENTS64
+#  define __ARCH_WANT_COMPAT_SYS_PREADV64
+#  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 
 # endif
 
diff --git a/fs/read_write.c b/fs/read_write.c
index edc5746a902a..72c09b4a01a4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -982,9 +982,9 @@ COMPAT_SYSCALL_DEFINE3(readv, compat_ulong_t, fd,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE4(preadv64, unsigned long, fd,
-		const struct compat_iovec __user *,vec,
-		unsigned long, vlen, loff_t, pos)
+static long __compat_sys_preadv64(unsigned long fd,
+				  const struct compat_iovec __user *vec,
+				  unsigned long vlen, loff_t pos)
 {
 	struct fd f;
 	ssize_t ret;
@@ -1001,12 +1001,22 @@ COMPAT_SYSCALL_DEFINE4(preadv64, unsigned long, fd,
 	return ret;
 }
 
+#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
+COMPAT_SYSCALL_DEFINE4(preadv64, unsigned long, fd,
+		const struct compat_iovec __user *,vec,
+		unsigned long, vlen, loff_t, pos)
+{
+	return __compat_sys_preadv64(fd, vec, vlen, pos);
+}
+#endif
+
 COMPAT_SYSCALL_DEFINE5(preadv, compat_ulong_t, fd,
 		const struct compat_iovec __user *,vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high)
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
-	return compat_sys_preadv64(fd, vec, vlen, pos);
+
+	return __compat_sys_preadv64(fd, vec, vlen, pos);
 }
 
 static size_t compat_writev(struct file *file,
@@ -1049,9 +1059,9 @@ COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
-		const struct compat_iovec __user *,vec,
-		unsigned long, vlen, loff_t, pos)
+static long __compat_sys_pwritev64(unsigned long fd,
+				   const struct compat_iovec __user *vec,
+				   unsigned long vlen, loff_t pos)
 {
 	struct fd f;
 	ssize_t ret;
@@ -1068,12 +1078,22 @@ COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
 	return ret;
 }
 
+#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
+COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
+		const struct compat_iovec __user *,vec,
+		unsigned long, vlen, loff_t, pos)
+{
+	return __compat_sys_pwritev64(fd, vec, vlen, pos);
+}
+#endif
+
 COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
 		const struct compat_iovec __user *,vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high)
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
-	return compat_sys_pwritev64(fd, vec, vlen, pos);
+
+	return __compat_sys_pwritev64(fd, vec, vlen, pos);
 }
 #endif
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 179b1da9e19f..1c457428ec0a 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -340,6 +340,19 @@ asmlinkage ssize_t compat_sys_preadv(compat_ulong_t fd,
 asmlinkage ssize_t compat_sys_pwritev(compat_ulong_t fd,
 		const struct compat_iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high);
+
+#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
+asmlinkage long compat_sys_preadv64(unsigned long fd,
+		const struct compat_iovec __user *vec,
+		unsigned long vlen, loff_t pos);
+#endif
+
+#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
+asmlinkage long compat_sys_pwritev64(unsigned long fd,
+		const struct compat_iovec __user *vec,
+		unsigned long vlen, loff_t pos);
+#endif
+
 asmlinkage long compat_sys_lseek(unsigned int, compat_off_t, unsigned int);
 
 asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
-- 
1.8.4.5
