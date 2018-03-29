From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 093/109] fs: add ksys_truncate() wrapper; remove in-kernel calls to sys_truncate()
Date: Thu, 29 Mar 2018 13:24:10 +0200
Message-ID: <20180329112426.23043-94-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the ksys_truncate() wrapper allows us to get rid of in-kernel
calls to the sys_truncate() syscall. The ksys_ prefix denotes that this
function is meant as a drop-in replacement for the syscall. In
particular, it uses the same calling convention as sys_truncate().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/mips/kernel/linux32.c      | 2 +-
 arch/parisc/kernel/sys_parisc.c | 6 +++---
 arch/powerpc/kernel/sys_ppc32.c | 2 +-
 arch/s390/kernel/compat_linux.c | 2 +-
 arch/sparc/kernel/sys_sparc32.c | 2 +-
 arch/x86/ia32/sys_ia32.c        | 3 ++-
 fs/open.c                       | 2 +-
 include/linux/syscalls.h        | 7 +++++++
 8 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 57b3310873f0..58e7dd27f106 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -82,7 +82,7 @@ struct rlimit32 {
 SYSCALL_DEFINE4(32_truncate64, const char __user *, path,
 	unsigned long, __dummy, unsigned long, a2, unsigned long, a3)
 {
-	return sys_truncate(path, merge_64(a2, a3));
+	return ksys_truncate(path, merge_64(a2, a3));
 }
 
 SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index ef995b5d97ef..3377a00163c3 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -292,7 +292,7 @@ asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
 asmlinkage long parisc_truncate64(const char __user * path,
 					unsigned int high, unsigned int low)
 {
-	return sys_truncate(path, (long)high << 32 | low);
+	return ksys_truncate(path, (long)high << 32 | low);
 }
 
 asmlinkage long parisc_ftruncate64(unsigned int fd,
@@ -305,7 +305,7 @@ asmlinkage long parisc_ftruncate64(unsigned int fd,
  * are identical on LP64 */
 asmlinkage long sys_truncate64(const char __user * path, unsigned long length)
 {
-	return sys_truncate(path, length);
+	return ksys_truncate(path, length);
 }
 asmlinkage long sys_ftruncate64(unsigned int fd, unsigned long length)
 {
@@ -320,7 +320,7 @@ asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg
 asmlinkage long parisc_truncate64(const char __user * path,
 					unsigned int high, unsigned int low)
 {
-	return sys_truncate64(path, (loff_t)high << 32 | low);
+	return ksys_truncate(path, (loff_t)high << 32 | low);
 }
 
 asmlinkage long parisc_ftruncate64(unsigned int fd,
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 664e4c5b5855..a0a251d7c9c5 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -94,7 +94,7 @@ compat_ssize_t compat_sys_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 co
 asmlinkage int compat_sys_truncate64(const char __user * path, u32 reg4,
 				unsigned long high, unsigned long low)
 {
-	return sys_truncate(path, (high << 32) | low);
+	return ksys_truncate(path, (high << 32) | low);
 }
 
 asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 605f6f026e44..e4092ec17ea5 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -302,7 +302,7 @@ COMPAT_SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, compat_ulong_t, second,
 
 COMPAT_SYSCALL_DEFINE3(s390_truncate64, const char __user *, path, u32, high, u32, low)
 {
-	return sys_truncate(path, (unsigned long)high << 32 | low);
+	return ksys_truncate(path, (unsigned long)high << 32 | low);
 }
 
 COMPAT_SYSCALL_DEFINE3(s390_ftruncate64, unsigned int, fd, u32, high, u32, low)
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index af18b9ff86be..aab2428b17b5 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -57,7 +57,7 @@ asmlinkage long sys32_truncate64(const char __user * path, unsigned long high, u
 	if ((int)high < 0)
 		return -EINVAL;
 	else
-		return sys_truncate(path, (high << 32) | low);
+		return ksys_truncate(path, (high << 32) | low);
 }
 
 asmlinkage long sys32_ftruncate64(unsigned int fd, unsigned long high, unsigned long low)
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 0c5f8932c136..90e7a2b3dc5b 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -55,7 +55,8 @@
 COMPAT_SYSCALL_DEFINE3(x86_truncate64, const char __user *, filename,
 		       unsigned long, offset_low, unsigned long, offset_high)
 {
-       return sys_truncate(filename, ((loff_t) offset_high << 32) | offset_low);
+	return ksys_truncate(filename,
+			    ((loff_t) offset_high << 32) | offset_low);
 }
 
 COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
diff --git a/fs/open.c b/fs/open.c
index 8a42a2961130..2e816fc7bd56 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -128,7 +128,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
 
-static long do_sys_truncate(const char __user *pathname, loff_t length)
+long do_sys_truncate(const char __user *pathname, loff_t length)
 {
 	unsigned int lookup_flags = LOOKUP_FOLLOW;
 	struct path path;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 331da76f66e2..78b79e3a1279 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1078,4 +1078,11 @@ static inline long ksys_open(const char __user *filename, int flags,
 	return do_sys_open(AT_FDCWD, filename, flags, mode);
 }
 
+extern long do_sys_truncate(const char __user *pathname, loff_t length);
+
+static inline long ksys_truncate(const char __user *pathname, loff_t length)
+{
+	return do_sys_truncate(pathname, length);
+}
+
 #endif
-- 
2.16.3
