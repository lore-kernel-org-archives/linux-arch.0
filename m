From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 077/109] fs: add do_mknodat() helper and ksys_mknod() wrapper; remove in-kernel calls to syscall
Date: Thu, 29 Mar 2018 13:23:54 +0200
Message-ID: <20180329112426.23043-78-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_mknodat() helper allows us to get rid of
fs-internal calls to the sys_mknodat() syscall.

Introducing the ksys_mknod() wrapper allows us to avoid the in-kernel
calls to sys_mknod() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it uses
the same calling convention as sys_mknod().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            |  2 ++
 fs/namei.c               | 12 +++++++++---
 include/linux/syscalls.h |  9 +++++++++
 init/do_mounts.h         |  2 +-
 init/initramfs.c         |  2 +-
 init/noinitramfs.c       |  2 +-
 6 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index a3f04ca2a08b..4f0b67054c54 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,6 +55,8 @@ extern void __init chrdev_init(void);
 extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
+long do_mknodat(int dfd, const char __user *filename, umode_t mode,
+		unsigned int dev);
 long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
diff --git a/fs/namei.c b/fs/namei.c
index e15da92209d5..8459a18cdd18 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3728,8 +3728,8 @@ static int may_mknod(umode_t mode)
 	}
 }
 
-SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
-		unsigned, dev)
+long do_mknodat(int dfd, const char __user *filename, umode_t mode,
+		unsigned int dev)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -3772,9 +3772,15 @@ SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
 	return error;
 }
 
+SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
+		unsigned int, dev)
+{
+	return do_mknodat(dfd, filename, mode, dev);
+}
+
 SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev)
 {
-	return sys_mknodat(AT_FDCWD, filename, mode, dev);
+	return do_mknodat(AT_FDCWD, filename, mode, dev);
 }
 
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 39c5cef86a10..0b4fd684f0f1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -988,4 +988,13 @@ static inline long ksys_symlink(const char __user *oldname,
 	return do_symlinkat(oldname, AT_FDCWD, newname);
 }
 
+extern long do_mknodat(int dfd, const char __user *filename, umode_t mode,
+		       unsigned int dev);
+
+static inline long ksys_mknod(const char __user *filename, umode_t mode,
+			      unsigned int dev)
+{
+	return do_mknodat(AT_FDCWD, filename, mode, dev);
+}
+
 #endif
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 401f90ee1eeb..0bb0806de4ce 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -17,7 +17,7 @@ extern int root_mountflags;
 static inline int create_dev(char *name, dev_t dev)
 {
 	ksys_unlink(name);
-	return sys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
+	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
 static inline u32 bstat(char *name)
diff --git a/init/initramfs.c b/init/initramfs.c
index cd9571a113b6..2972ed0ab399 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -359,7 +359,7 @@ static int __init do_name(void)
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
-			sys_mknod(collected, mode, rdev);
+			ksys_mknod(collected, mode, rdev);
 			sys_chown(collected, uid, gid);
 			sys_chmod(collected, mode);
 			do_utime(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index a08a9d937e60..f4bad8436c93 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -33,7 +33,7 @@ static int __init default_rootfs(void)
 	if (err < 0)
 		goto out;
 
-	err = sys_mknod((const char __user __force *) "/dev/console",
+	err = ksys_mknod((const char __user __force *) "/dev/console",
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			new_encode_dev(MKDEV(5, 1)));
 	if (err < 0)
-- 
2.16.3
