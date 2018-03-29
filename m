From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 079/109] fs: add ksys_fchmod() and do_fchmodat() helpers and ksys_chmod() wrapper; remove in-kernel calls to syscall
Date: Thu, 29 Mar 2018 13:23:56 +0200
Message-ID: <20180329112426.23043-80-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_fchmodat() helper allows us to get rid of
fs-internal calls to the sys_fchmodat() syscall.

Introducing the ksys_fchmod() helper and the ksys_chmod() wrapper allows
us to avoid the in-kernel calls to the sys_fchmod() and sys_chmod()
syscalls. The ksys_ prefix denotes that these functions are meant as a
drop-in replacement for the syscalls. In particular, they use the same
calling convention as sys_fchmod() and sys_chmod().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            |  2 ++
 fs/open.c                | 17 ++++++++++++++---
 include/linux/syscalls.h |  8 ++++++++
 init/initramfs.c         |  6 +++---
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 91e6fc93fcb5..2474bf460f96 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -119,6 +119,8 @@ extern struct file *do_filp_open(int dfd, struct filename *pathname,
 extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
 		const char *, const struct open_flags *);
 
+int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
+
 extern int open_check_o_direct(struct file *f);
 extern int vfs_open(const struct path *, struct file *, const struct cred *);
 extern struct file *filp_clone_open(struct file *);
diff --git a/fs/open.c b/fs/open.c
index a19b8277c439..6037f2bf418c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -551,7 +551,7 @@ static int chmod_common(const struct path *path, umode_t mode)
 	return error;
 }
 
-SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
+int ksys_fchmod(unsigned int fd, umode_t mode)
 {
 	struct fd f = fdget(fd);
 	int err = -EBADF;
@@ -564,7 +564,12 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return err;
 }
 
-SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode)
+SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
+{
+	return ksys_fchmod(fd, mode);
+}
+
+int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 {
 	struct path path;
 	int error;
@@ -582,9 +587,15 @@ SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode
 	return error;
 }
 
+SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
+		umode_t, mode)
+{
+	return do_fchmodat(dfd, filename, mode);
+}
+
 SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 {
-	return sys_fchmodat(AT_FDCWD, filename, mode);
+	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
 static int chown_common(const struct path *path, uid_t user, gid_t group)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 827ed917630c..dd6c306f4f00 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -953,6 +953,7 @@ int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
+int ksys_fchmod(unsigned int fd, umode_t mode);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
@@ -1006,4 +1007,11 @@ static inline long ksys_link(const char __user *oldname,
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
+extern int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
+
+static inline int ksys_chmod(const char __user *filename, umode_t mode)
+{
+	return do_fchmodat(AT_FDCWD, filename, mode);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 5855ab632b4e..16c3c23076e2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -344,7 +344,7 @@ static int __init do_name(void)
 
 			if (wfd >= 0) {
 				sys_fchown(wfd, uid, gid);
-				sys_fchmod(wfd, mode);
+				ksys_fchmod(wfd, mode);
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
 				vcollected = kstrdup(collected, GFP_KERNEL);
@@ -354,14 +354,14 @@ static int __init do_name(void)
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
 		sys_chown(collected, uid, gid);
-		sys_chmod(collected, mode);
+		ksys_chmod(collected, mode);
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			ksys_mknod(collected, mode, rdev);
 			sys_chown(collected, uid, gid);
-			sys_chmod(collected, mode);
+			ksys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
 	}
-- 
2.16.3
