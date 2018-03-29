From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 085/109] fs: add ksys_getdents64() helper; remove in-kernel calls to sys_getdents64()
Date: Thu, 29 Mar 2018 13:24:02 +0200
Message-ID: <20180329112426.23043-86-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_getdents64() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_getdents64().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/readdir.c             | 11 +++++++++--
 include/linux/syscalls.h |  2 ++
 init/initramfs.c         |  4 ++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 1b83b0ad183b..d97f548e6323 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -292,8 +292,8 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	return -EFAULT;
 }
 
-SYSCALL_DEFINE3(getdents64, unsigned int, fd,
-		struct linux_dirent64 __user *, dirent, unsigned int, count)
+int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
+		    unsigned int count)
 {
 	struct fd f;
 	struct linux_dirent64 __user * lastdirent;
@@ -326,6 +326,13 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	return error;
 }
 
+
+SYSCALL_DEFINE3(getdents64, unsigned int, fd,
+		struct linux_dirent64 __user *, dirent, unsigned int, count)
+{
+	return ksys_getdents64(fd, dirent, count);
+}
+
 #ifdef CONFIG_COMPAT
 struct compat_old_linux_dirent {
 	compat_ulong_t	d_ino;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f9df17dcec1c..c056aff6d7ad 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -955,6 +955,8 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
 int ksys_fchmod(unsigned int fd, umode_t mode);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
+int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
+		    unsigned int count);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/init/initramfs.c b/init/initramfs.c
index 5f2ff1d2370e..13643c46ebab 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -579,7 +579,7 @@ static void __init clean_rootfs(void)
 	}
 
 	dirp = buf;
-	num = sys_getdents64(fd, dirp, BUF_SIZE);
+	num = ksys_getdents64(fd, dirp, BUF_SIZE);
 	while (num > 0) {
 		while (num > 0) {
 			struct kstat st;
@@ -599,7 +599,7 @@ static void __init clean_rootfs(void)
 		}
 		dirp = buf;
 		memset(buf, 0, BUF_SIZE);
-		num = sys_getdents64(fd, dirp, BUF_SIZE);
+		num = ksys_getdents64(fd, dirp, BUF_SIZE);
 	}
 
 	ksys_close(fd);
-- 
2.16.3
