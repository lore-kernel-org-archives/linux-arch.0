From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 082/109] fs: add ksys_ftruncate() wrapper; remove in-kernel calls to sys_ftruncate()
Date: Thu, 29 Mar 2018 13:23:59 +0200
Message-ID: <20180329112426.23043-83-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the ksys_ftruncate() wrapper allows us to get rid of in-kernel
calls to the sys_ftruncate() syscall. The ksys_ prefix denotes that this
function is meant as a drop-in replacement for the syscall. In
particular, it uses the same calling convention as sys_ftruncate().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/mips/kernel/linux32.c      | 2 +-
 arch/parisc/kernel/sys_parisc.c | 4 ++--
 arch/powerpc/kernel/sys_ppc32.c | 2 +-
 arch/s390/kernel/compat_linux.c | 2 +-
 arch/sparc/kernel/sys_sparc32.c | 2 +-
 arch/x86/ia32/sys_ia32.c        | 2 +-
 fs/internal.h                   | 1 +
 fs/open.c                       | 2 +-
 include/linux/syscalls.h        | 7 +++++++
 init/initramfs.c                | 2 +-
 10 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index b332f6fc1e72..3c90449742a0 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -88,7 +88,7 @@ SYSCALL_DEFINE4(32_truncate64, const char __user *, path,
 SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
 	unsigned long, a2, unsigned long, a3)
 {
-	return sys_ftruncate(fd, merge_64(a2, a3));
+	return ksys_ftruncate(fd, merge_64(a2, a3));
 }
 
 SYSCALL_DEFINE5(32_llseek, unsigned int, fd, unsigned int, offset_high,
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 378a754ca186..6d2a64859c22 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -298,7 +298,7 @@ asmlinkage long parisc_truncate64(const char __user * path,
 asmlinkage long parisc_ftruncate64(unsigned int fd,
 					unsigned int high, unsigned int low)
 {
-	return sys_ftruncate(fd, (long)high << 32 | low);
+	return ksys_ftruncate(fd, (long)high << 32 | low);
 }
 
 /* stubs for the benefit of the syscall_table since truncate64 and truncate 
@@ -309,7 +309,7 @@ asmlinkage long sys_truncate64(const char __user * path, unsigned long length)
 }
 asmlinkage long sys_ftruncate64(unsigned int fd, unsigned long length)
 {
-	return sys_ftruncate(fd, length);
+	return ksys_ftruncate(fd, length);
 }
 asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 15f216d022e2..e0c9b7f1bf38 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -107,7 +107,7 @@ asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
 asmlinkage int compat_sys_ftruncate64(unsigned int fd, u32 reg4, unsigned long high,
 				 unsigned long low)
 {
-	return sys_ftruncate(fd, (high << 32) | low);
+	return ksys_ftruncate(fd, (high << 32) | low);
 }
 
 long ppc32_fadvise64(int fd, u32 unused, u32 offset_high, u32 offset_low,
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 9a9bb395359c..9c5e975f71a6 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -307,7 +307,7 @@ COMPAT_SYSCALL_DEFINE3(s390_truncate64, const char __user *, path, u32, high, u3
 
 COMPAT_SYSCALL_DEFINE3(s390_ftruncate64, unsigned int, fd, u32, high, u32, low)
 {
-	return sys_ftruncate(fd, (unsigned long)high << 32 | low);
+	return ksys_ftruncate(fd, (unsigned long)high << 32 | low);
 }
 
 COMPAT_SYSCALL_DEFINE5(s390_pread64, unsigned int, fd, char __user *, ubuf,
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 6d964bdefbaa..d64b425fff93 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -65,7 +65,7 @@ asmlinkage long sys32_ftruncate64(unsigned int fd, unsigned long high, unsigned
 	if ((int)high < 0)
 		return -EINVAL;
 	else
-		return sys_ftruncate(fd, (high << 32) | low);
+		return ksys_ftruncate(fd, (high << 32) | low);
 }
 
 static int cp_compat_stat64(struct kstat *stat,
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 23a5260eae67..1979e5b4ad9a 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -61,7 +61,7 @@ COMPAT_SYSCALL_DEFINE3(x86_truncate64, const char __user *, filename,
 COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
 		       unsigned long, offset_low, unsigned long, offset_high)
 {
-       return sys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
+	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
 }
 
 /*
diff --git a/fs/internal.h b/fs/internal.h
index c797480cbd6f..980d005b21b4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -119,6 +119,7 @@ extern struct file *do_filp_open(int dfd, struct filename *pathname,
 extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
 		const char *, const struct open_flags *);
 
+long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 long do_faccessat(int dfd, const char __user *filename, int mode);
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
diff --git a/fs/open.c b/fs/open.c
index 7b2eccb541f2..b3f3b2cd9f19 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -162,7 +162,7 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 }
 #endif
 
-static long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
 	struct inode *inode;
 	struct dentry *dentry;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index df0d1e818a6e..41023177c8ec 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1038,4 +1038,11 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
 			     AT_SYMLINK_NOFOLLOW);
 }
 
+extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
+
+static inline long ksys_ftruncate(unsigned int fd, unsigned long length)
+{
+	return do_sys_ftruncate(fd, length, 1);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 35173bef7c00..0d3b001b0dc5 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -346,7 +346,7 @@ static int __init do_name(void)
 				ksys_fchown(wfd, uid, gid);
 				ksys_fchmod(wfd, mode);
 				if (body_len)
-					sys_ftruncate(wfd, body_len);
+					ksys_ftruncate(wfd, body_len);
 				vcollected = kstrdup(collected, GFP_KERNEL);
 				state = CopyFile;
 			}
-- 
2.16.3
