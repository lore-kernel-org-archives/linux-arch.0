From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 095/109] fs: add ksys_fallocate() wrapper; remove in-kernel calls to sys_fallocate()
Date: Thu, 29 Mar 2018 13:24:12 +0200
Message-ID: <20180329112426.23043-96-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the ksys_fallocate() wrapper allows us to get rid of in-kernel
calls to the sys_fallocate() syscall. The ksys_ prefix denotes that this
function is meant as a drop-in replacement for the syscall. In
particular, it uses the same calling convention as sys_fallocate().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/mips/kernel/linux32.c      | 4 ++--
 arch/parisc/kernel/sys_parisc.c | 4 ++--
 arch/powerpc/kernel/sys_ppc32.c | 2 +-
 arch/s390/kernel/compat_linux.c | 4 ++--
 arch/sparc/kernel/sys_sparc32.c | 4 ++--
 arch/x86/ia32/sys_ia32.c        | 4 ++--
 fs/open.c                       | 7 ++++++-
 include/linux/syscalls.h        | 1 +
 8 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 91e85e2f8aa5..0779d474c8ad 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -157,6 +157,6 @@ asmlinkage long sys32_fadvise64_64(int fd, int __pad,
 asmlinkage long sys32_fallocate(int fd, int mode, unsigned offset_a2,
 	unsigned offset_a3, unsigned len_a4, unsigned len_a5)
 {
-	return sys_fallocate(fd, mode, merge_64(offset_a2, offset_a3),
-			     merge_64(len_a4, len_a5));
+	return ksys_fallocate(fd, mode, merge_64(offset_a2, offset_a3),
+			      merge_64(len_a4, len_a5));
 }
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 4f47e8379854..588fab336ddd 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -367,8 +367,8 @@ asmlinkage long parisc_sync_file_range(int fd,
 asmlinkage long parisc_fallocate(int fd, int mode, u32 offhi, u32 offlo,
 				u32 lenhi, u32 lenlo)
 {
-        return sys_fallocate(fd, mode, ((u64)offhi << 32) | offlo,
-                             ((u64)lenhi << 32) | lenlo);
+	return ksys_fallocate(fd, mode, ((u64)offhi << 32) | offlo,
+			      ((u64)lenhi << 32) | lenlo);
 }
 
 long parisc_personality(unsigned long personality)
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 36a651e6e033..68f11e1065f8 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -100,7 +100,7 @@ asmlinkage int compat_sys_truncate64(const char __user * path, u32 reg4,
 asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
 				     u32 lenhi, u32 lenlo)
 {
-	return sys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
+	return ksys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
 			     ((loff_t)lenhi << 32) | lenlo);
 }
 
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 71e2c5bc4926..039858f9f128 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -516,6 +516,6 @@ COMPAT_SYSCALL_DEFINE6(s390_sync_file_range, int, fd, u32, offhigh, u32, offlow,
 COMPAT_SYSCALL_DEFINE6(s390_fallocate, int, fd, int, mode, u32, offhigh, u32, offlow,
 		       u32, lenhigh, u32, lenlow)
 {
-	return sys_fallocate(fd, mode, ((loff_t)offhigh << 32) + offlow,
-			     ((u64)lenhigh << 32) + lenlow);
+	return ksys_fallocate(fd, mode, ((loff_t)offhigh << 32) + offlow,
+			      ((u64)lenhigh << 32) + lenlow);
 }
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 40c0d2e1db1d..4ba62d676632 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -250,6 +250,6 @@ long sys32_sync_file_range(unsigned int fd, unsigned long off_high, unsigned lon
 asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
 				     u32 lenhi, u32 lenlo)
 {
-	return sys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
-			     ((loff_t)lenhi << 32) | lenlo);
+	return ksys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
+			      ((loff_t)lenhi << 32) | lenlo);
 }
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index c08c25f73d79..df2acb13623f 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -226,8 +226,8 @@ COMPAT_SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
 		       unsigned int, offset_lo, unsigned int, offset_hi,
 		       unsigned int, len_lo, unsigned int, len_hi)
 {
-	return sys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
-			     ((u64)len_hi << 32) | len_lo);
+	return ksys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
+			      ((u64)len_hi << 32) | len_lo);
 }
 
 /*
diff --git a/fs/open.c b/fs/open.c
index 2e816fc7bd56..d0e955b558ad 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -333,7 +333,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 }
 EXPORT_SYMBOL_GPL(vfs_fallocate);
 
-SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
+int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
@@ -345,6 +345,11 @@ SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
 	return error;
 }
 
+SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
+{
+	return ksys_fallocate(fd, mode, offset, len);
+}
+
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a30e4c2d0c27..613b8127834d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -969,6 +969,7 @@ ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 		     loff_t pos);
 ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 		      size_t count, loff_t pos);
+int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
-- 
2.16.3
