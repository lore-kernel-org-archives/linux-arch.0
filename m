From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 092/109] fs: add ksys_sync_file_range helper(); remove in-kernel calls to syscall
Date: Thu, 29 Mar 2018 13:24:09 +0200
Message-ID: <20180329112426.23043-93-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_sync_file_range() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it uses
the same calling convention as sys_sync_file_range().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/mips/kernel/linux32.c      |  2 +-
 arch/parisc/kernel/sys_parisc.c |  2 +-
 arch/powerpc/kernel/sys_ppc32.c |  2 +-
 arch/s390/kernel/compat_linux.c |  2 +-
 arch/sparc/kernel/sys_sparc32.c |  2 +-
 arch/x86/ia32/sys_ia32.c        |  6 +++---
 fs/sync.c                       | 12 +++++++++---
 include/linux/syscalls.h        |  2 ++
 8 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 3c90449742a0..57b3310873f0 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -139,7 +139,7 @@ asmlinkage long sys32_sync_file_range(int fd, int __pad,
 	unsigned long a4, unsigned long a5,
 	int flags)
 {
-	return sys_sync_file_range(fd,
+	return ksys_sync_file_range(fd,
 			merge_64(a2, a3), merge_64(a4, a5),
 			flags);
 }
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 6d2a64859c22..ef995b5d97ef 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -360,7 +360,7 @@ asmlinkage long parisc_sync_file_range(int fd,
 			u32 hi_off, u32 lo_off, u32 hi_nbytes, u32 lo_nbytes,
 			unsigned int flags)
 {
-	return sys_sync_file_range(fd, (loff_t)hi_off << 32 | lo_off,
+	return ksys_sync_file_range(fd, (loff_t)hi_off << 32 | lo_off,
 			(loff_t)hi_nbytes << 32 | lo_nbytes, flags);
 }
 
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index e0c9b7f1bf38..664e4c5b5855 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -124,5 +124,5 @@ asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
 	loff_t offset = ((loff_t)offset_hi << 32) | offset_lo;
 	loff_t nbytes = ((loff_t)nbytes_hi << 32) | nbytes_lo;
 
-	return sys_sync_file_range(fd, offset, nbytes, flags);
+	return ksys_sync_file_range(fd, offset, nbytes, flags);
 }
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index af0469f204fd..605f6f026e44 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -509,7 +509,7 @@ COMPAT_SYSCALL_DEFINE1(s390_fadvise64_64, struct fadvise64_64_args __user *, arg
 COMPAT_SYSCALL_DEFINE6(s390_sync_file_range, int, fd, u32, offhigh, u32, offlow,
 		       u32, nhigh, u32, nlow, unsigned int, flags)
 {
-	return sys_sync_file_range(fd, ((loff_t)offhigh << 32) + offlow,
+	return ksys_sync_file_range(fd, ((loff_t)offhigh << 32) + offlow,
 				   ((u64)nhigh << 32) + nlow, flags);
 }
 
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index d64b425fff93..af18b9ff86be 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -241,7 +241,7 @@ long compat_sys_fadvise64_64(int fd,
 
 long sys32_sync_file_range(unsigned int fd, unsigned long off_high, unsigned long off_low, unsigned long nb_high, unsigned long nb_low, unsigned int flags)
 {
-	return sys_sync_file_range(fd,
+	return ksys_sync_file_range(fd,
 				   (off_high << 32) | off_low,
 				   (nb_high << 32) | nb_low,
 				   flags);
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 1979e5b4ad9a..0c5f8932c136 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -209,9 +209,9 @@ COMPAT_SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
 		       unsigned int, off_hi, unsigned int, n_low,
 		       unsigned int, n_hi, int, flags)
 {
-	return sys_sync_file_range(fd,
-				   ((u64)off_hi << 32) | off_low,
-				   ((u64)n_hi << 32) | n_low, flags);
+	return ksys_sync_file_range(fd,
+				    ((u64)off_hi << 32) | off_low,
+				    ((u64)n_hi << 32) | n_low, flags);
 }
 
 COMPAT_SYSCALL_DEFINE5(x86_fadvise64, int, fd, unsigned int, offset_lo,
diff --git a/fs/sync.c b/fs/sync.c
index 602ae94bb67e..9908a114d506 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -285,8 +285,8 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
  * already-instantiated disk blocks, there are no guarantees here that the data
  * will be available after a crash.
  */
-SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
-				unsigned int, flags)
+int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
+			 unsigned int flags)
 {
 	int ret;
 	struct fd f;
@@ -364,10 +364,16 @@ SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
 	return ret;
 }
 
+SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
+				unsigned int, flags)
+{
+	return ksys_sync_file_range(fd, offset, nbytes, flags);
+}
+
 /* It would be nice if people remember that not all the world's an i386
    when they introduce new system calls */
 SYSCALL_DEFINE4(sync_file_range2, int, fd, unsigned int, flags,
 				 loff_t, offset, loff_t, nbytes)
 {
-	return sys_sync_file_range(fd, offset, nbytes, flags);
+	return ksys_sync_file_range(fd, offset, nbytes, flags);
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 4dd685ee425d..331da76f66e2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -963,6 +963,8 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
 int ksys_setsid(void);
+int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
+			 unsigned int flags);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
-- 
2.16.3
