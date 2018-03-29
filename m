From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 075/109] fs: add do_mkdirat() helper and ksys_mkdir() wrapper; remove in-kernel calls to syscall
Date: Thu, 29 Mar 2018 13:23:52 +0200
Message-ID: <20180329112426.23043-76-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_mkdirat() helper allows us to get rid of
fs-internal calls to the sys_mkdirat() syscall.

Introducing the ksys_mkdir() wrapper allows us to avoid the in-kernel calls
to the sys_mkdir() syscall. The ksys_ prefix denotes that this function is
meant as a drop-in replacement for the syscall. In particular, it uses the
same calling convention as sys_mkdir().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            | 1 +
 fs/namei.c               | 9 +++++++--
 include/linux/syscalls.h | 7 +++++++
 init/do_mounts_initrd.c  | 2 +-
 init/initramfs.c         | 2 +-
 init/noinitramfs.c       | 4 ++--
 6 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 0eda35fa1743..53846bd4d9d7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,6 +55,7 @@ extern void __init chrdev_init(void);
 extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
+long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
 
diff --git a/fs/namei.c b/fs/namei.c
index 8545151f74e9..dcf506227509 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3803,7 +3803,7 @@ int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
+long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -3828,9 +3828,14 @@ SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
 	return error;
 }
 
+SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
+{
+	return do_mkdirat(dfd, pathname, mode);
+}
+
 SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 {
-	return sys_mkdirat(AT_FDCWD, pathname, mode);
+	return do_mkdirat(AT_FDCWD, pathname, mode);
 }
 
 int vfs_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 746043a05884..c982cb5f4e50 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -972,4 +972,11 @@ static inline long ksys_rmdir(const char __user *pathname)
 	return do_rmdir(AT_FDCWD, pathname);
 }
 
+extern long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
+
+static inline long ksys_mkdir(const char __user *pathname, umode_t mode)
+{
+	return do_mkdirat(AT_FDCWD, pathname, mode);
+}
+
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index e9e9e1c67d31..99922d1ebfe6 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -60,7 +60,7 @@ static void __init handle_initrd(void)
 	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
-	sys_mkdir("/old", 0700);
+	ksys_mkdir("/old", 0700);
 	ksys_chdir("/old");
 
 	/* try loading default modules from initrd */
diff --git a/init/initramfs.c b/init/initramfs.c
index 73bbb227f868..ca538a5f9fa9 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -352,7 +352,7 @@ static int __init do_name(void)
 			}
 		}
 	} else if (S_ISDIR(mode)) {
-		sys_mkdir(collected, mode);
+		ksys_mkdir(collected, mode);
 		sys_chown(collected, uid, gid);
 		sys_chmod(collected, mode);
 		dir_add(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index 267739d85179..a08a9d937e60 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -29,7 +29,7 @@ static int __init default_rootfs(void)
 {
 	int err;
 
-	err = sys_mkdir((const char __user __force *) "/dev", 0755);
+	err = ksys_mkdir((const char __user __force *) "/dev", 0755);
 	if (err < 0)
 		goto out;
 
@@ -39,7 +39,7 @@ static int __init default_rootfs(void)
 	if (err < 0)
 		goto out;
 
-	err = sys_mkdir((const char __user __force *) "/root", 0700);
+	err = ksys_mkdir((const char __user __force *) "/root", 0700);
 	if (err < 0)
 		goto out;
 
-- 
2.16.3
