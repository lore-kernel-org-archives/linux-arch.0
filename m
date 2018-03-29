From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 094/109] fs: add ksys_p{read,write}64() helpers; remove in-kernel calls to syscalls
Date: Thu, 29 Mar 2018 13:24:11 +0200
Message-ID: <20180329112426.23043-95-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the ksys_p{read,write}64() wrappers allows us to get rid of
in-kernel calls to the sys_pread64() and sys_pwrite64() syscalls.
The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_p{read,write}64().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/mips/kernel/linux32.c      |  4 ++--
 arch/parisc/kernel/sys_parisc.c |  4 ++--
 arch/powerpc/kernel/sys_ppc32.c |  4 ++--
 arch/s390/kernel/compat_linux.c |  4 ++--
 arch/sh/kernel/sys_sh32.c       |  4 ++--
 arch/sparc/kernel/sys_sparc32.c |  4 ++--
 arch/x86/ia32/sys_ia32.c        |  8 ++++----
 fs/read_write.c                 | 20 ++++++++++++++++----
 include/linux/syscalls.h        |  4 ++++
 9 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 58e7dd27f106..91e85e2f8aa5 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -105,13 +105,13 @@ SYSCALL_DEFINE5(32_llseek, unsigned int, fd, unsigned int, offset_high,
 SYSCALL_DEFINE6(32_pread, unsigned long, fd, char __user *, buf, size_t, count,
 	unsigned long, unused, unsigned long, a4, unsigned long, a5)
 {
-	return sys_pread64(fd, buf, count, merge_64(a4, a5));
+	return ksys_pread64(fd, buf, count, merge_64(a4, a5));
 }
 
 SYSCALL_DEFINE6(32_pwrite, unsigned int, fd, const char __user *, buf,
 	size_t, count, u32, unused, u64, a4, u64, a5)
 {
-	return sys_pwrite64(fd, buf, count, merge_64(a4, a5));
+	return ksys_pwrite64(fd, buf, count, merge_64(a4, a5));
 }
 
 SYSCALL_DEFINE1(32_personality, unsigned long, personality)
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 3377a00163c3..4f47e8379854 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -333,13 +333,13 @@ asmlinkage long parisc_ftruncate64(unsigned int fd,
 asmlinkage ssize_t parisc_pread64(unsigned int fd, char __user *buf, size_t count,
 					unsigned int high, unsigned int low)
 {
-	return sys_pread64(fd, buf, count, (loff_t)high << 32 | low);
+	return ksys_pread64(fd, buf, count, (loff_t)high << 32 | low);
 }
 
 asmlinkage ssize_t parisc_pwrite64(unsigned int fd, const char __user *buf,
 			size_t count, unsigned int high, unsigned int low)
 {
-	return sys_pwrite64(fd, buf, count, (loff_t)high << 32 | low);
+	return ksys_pwrite64(fd, buf, count, (loff_t)high << 32 | low);
 }
 
 asmlinkage ssize_t parisc_readahead(int fd, unsigned int high, unsigned int low,
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index a0a251d7c9c5..36a651e6e033 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -77,13 +77,13 @@ unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
 compat_ssize_t compat_sys_pread64(unsigned int fd, char __user *ubuf, compat_size_t count,
 			     u32 reg6, u32 poshi, u32 poslo)
 {
-	return sys_pread64(fd, ubuf, count, ((loff_t)poshi << 32) | poslo);
+	return ksys_pread64(fd, ubuf, count, ((loff_t)poshi << 32) | poslo);
 }
 
 compat_ssize_t compat_sys_pwrite64(unsigned int fd, const char __user *ubuf, compat_size_t count,
 			      u32 reg6, u32 poshi, u32 poslo)
 {
-	return sys_pwrite64(fd, ubuf, count, ((loff_t)poshi << 32) | poslo);
+	return ksys_pwrite64(fd, ubuf, count, ((loff_t)poshi << 32) | poslo);
 }
 
 compat_ssize_t compat_sys_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 count)
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index e4092ec17ea5..71e2c5bc4926 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -315,7 +315,7 @@ COMPAT_SYSCALL_DEFINE5(s390_pread64, unsigned int, fd, char __user *, ubuf,
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL;
-	return sys_pread64(fd, ubuf, count, (unsigned long)high << 32 | low);
+	return ksys_pread64(fd, ubuf, count, (unsigned long)high << 32 | low);
 }
 
 COMPAT_SYSCALL_DEFINE5(s390_pwrite64, unsigned int, fd, const char __user *, ubuf,
@@ -323,7 +323,7 @@ COMPAT_SYSCALL_DEFINE5(s390_pwrite64, unsigned int, fd, const char __user *, ubu
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL;
-	return sys_pwrite64(fd, ubuf, count, (unsigned long)high << 32 | low);
+	return ksys_pwrite64(fd, ubuf, count, (unsigned long)high << 32 | low);
 }
 
 COMPAT_SYSCALL_DEFINE4(s390_readahead, int, fd, u32, high, u32, low, s32, count)
diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
index f8dc8bfd4606..c37ee3d0c803 100644
--- a/arch/sh/kernel/sys_sh32.c
+++ b/arch/sh/kernel/sys_sh32.c
@@ -39,13 +39,13 @@ asmlinkage int sys_sh_pipe(void)
 asmlinkage ssize_t sys_pread_wrapper(unsigned int fd, char __user *buf,
 			     size_t count, long dummy, loff_t pos)
 {
-	return sys_pread64(fd, buf, count, pos);
+	return ksys_pread64(fd, buf, count, pos);
 }
 
 asmlinkage ssize_t sys_pwrite_wrapper(unsigned int fd, const char __user *buf,
 			      size_t count, long dummy, loff_t pos)
 {
-	return sys_pwrite64(fd, buf, count, pos);
+	return ksys_pwrite64(fd, buf, count, pos);
 }
 
 asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 offset0, u32 offset1,
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index aab2428b17b5..40c0d2e1db1d 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -200,7 +200,7 @@ asmlinkage compat_ssize_t sys32_pread64(unsigned int fd,
 					unsigned long poshi,
 					unsigned long poslo)
 {
-	return sys_pread64(fd, ubuf, count, (poshi << 32) | poslo);
+	return ksys_pread64(fd, ubuf, count, (poshi << 32) | poslo);
 }
 
 asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd,
@@ -209,7 +209,7 @@ asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd,
 					 unsigned long poshi,
 					 unsigned long poslo)
 {
-	return sys_pwrite64(fd, ubuf, count, (poshi << 32) | poslo);
+	return ksys_pwrite64(fd, ubuf, count, (poshi << 32) | poslo);
 }
 
 asmlinkage long compat_sys_readahead(int fd,
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 90e7a2b3dc5b..c08c25f73d79 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -174,15 +174,15 @@ COMPAT_SYSCALL_DEFINE1(x86_mmap, struct mmap_arg_struct32 __user *, arg)
 COMPAT_SYSCALL_DEFINE5(x86_pread, unsigned int, fd, char __user *, ubuf,
 		       u32, count, u32, poslo, u32, poshi)
 {
-	return sys_pread64(fd, ubuf, count,
-			 ((loff_t)AA(poshi) << 32) | AA(poslo));
+	return ksys_pread64(fd, ubuf, count,
+			    ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
 COMPAT_SYSCALL_DEFINE5(x86_pwrite, unsigned int, fd, const char __user *, ubuf,
 		       u32, count, u32, poslo, u32, poshi)
 {
-	return sys_pwrite64(fd, ubuf, count,
-			  ((loff_t)AA(poshi) << 32) | AA(poslo));
+	return ksys_pwrite64(fd, ubuf, count,
+			     ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
 
diff --git a/fs/read_write.c b/fs/read_write.c
index fc441e1ac683..c4eabbfc90df 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -610,8 +610,8 @@ SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
 	return ksys_write(fd, buf, count);
 }
 
-SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
-			size_t, count, loff_t, pos)
+ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
+		     loff_t pos)
 {
 	struct fd f;
 	ssize_t ret = -EBADF;
@@ -630,8 +630,14 @@ SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
 	return ret;
 }
 
-SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
-			 size_t, count, loff_t, pos)
+SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
+			size_t, count, loff_t, pos)
+{
+	return ksys_pread64(fd, buf, count, pos);
+}
+
+ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
+		      size_t count, loff_t pos)
 {
 	struct fd f;
 	ssize_t ret = -EBADF;
@@ -650,6 +656,12 @@ SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
 	return ret;
 }
 
+SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
+			 size_t, count, loff_t, pos)
+{
+	return ksys_pwrite64(fd, buf, count, pos);
+}
+
 static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 		loff_t *ppos, int type, rwf_t flags)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 78b79e3a1279..a30e4c2d0c27 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -965,6 +965,10 @@ int ksys_unshare(unsigned long unshare_flags);
 int ksys_setsid(void);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
+ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
+		     loff_t pos);
+ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
+		      size_t count, loff_t pos);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
-- 
2.16.3
