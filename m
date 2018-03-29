From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 066/109] fs: add ksys_mount() helper; remove in-kernel calls to sys_mount()
Date: Thu, 29 Mar 2018 13:23:43 +0200
Message-ID: <20180329112426.23043-67-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the sys_mount()
syscall. The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_mount().

In the near future, all callers of ksys_mount() should be converted to call
do_mount() directly.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c  |  5 +++--
 fs/namespace.c           | 10 ++++++++--
 include/linux/syscalls.h |  3 +++
 init/do_mounts.c         |  4 ++--
 init/do_mounts_initrd.c  |  6 +++---
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 50025d7959cb..4afb04686c8e 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -356,7 +356,8 @@ int devtmpfs_mount(const char *mntdir)
 	if (!thread)
 		return 0;
 
-	err = sys_mount("devtmpfs", (char *)mntdir, "devtmpfs", MS_SILENT, NULL);
+	err = ksys_mount("devtmpfs", (char *)mntdir, "devtmpfs", MS_SILENT,
+			 NULL);
 	if (err)
 		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
 	else
@@ -382,7 +383,7 @@ static int devtmpfsd(void *p)
 	*err = sys_unshare(CLONE_NEWNS);
 	if (*err)
 		goto out;
-	*err = sys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
+	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
 	if (*err)
 		goto out;
 	sys_chdir("/.."); /* will traverse into overmounted root */
diff --git a/fs/namespace.c b/fs/namespace.c
index 9d1374ab6e06..642b8b229944 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3032,8 +3032,8 @@ struct dentry *mount_subtree(struct vfsmount *mnt, const char *name)
 }
 EXPORT_SYMBOL(mount_subtree);
 
-SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
-		char __user *, type, unsigned long, flags, void __user *, data)
+int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
+	       unsigned long flags, void __user *data)
 {
 	int ret;
 	char *kernel_type;
@@ -3066,6 +3066,12 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ret;
 }
 
+SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
+		char __user *, type, unsigned long, flags, void __user *, data)
+{
+	return ksys_mount(dev_name, dir_name, type, flags, data);
+}
+
 /*
  * Return true if path is reachable from root
  *
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 6ab7ed71a8b6..3a9f9c534624 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -946,4 +946,7 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
  * the ksys_xyzyyz() functions prototyped below.
  */
 
+int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
+	       unsigned long flags, void __user *data);
+
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7cf4f6dafd5f..eb768de43d84 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -363,7 +363,7 @@ static void __init get_fs_names(char *page)
 static int __init do_mount_root(char *name, char *fs, int flags, void *data)
 {
 	struct super_block *s;
-	int err = sys_mount(name, "/root", fs, flags, data);
+	int err = ksys_mount(name, "/root", fs, flags, data);
 	if (err)
 		return err;
 
@@ -599,7 +599,7 @@ void __init prepare_namespace(void)
 	mount_root();
 out:
 	devtmpfs_mount("dev");
-	sys_mount(".", "/", NULL, MS_MOVE, NULL);
+	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 53d4f0f326e7..7868a6039fb4 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -43,7 +43,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	sys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
 	sys_chdir("/root");
-	sys_mount(".", "/", NULL, MS_MOVE, NULL);
+	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
 	sys_setsid();
 	return 0;
@@ -81,7 +81,7 @@ static void __init handle_initrd(void)
 	current->flags &= ~PF_FREEZER_SKIP;
 
 	/* move initrd to rootfs' /old */
-	sys_mount("..", ".", NULL, MS_MOVE, NULL);
+	ksys_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
 	sys_chroot("..");
 
@@ -95,7 +95,7 @@ static void __init handle_initrd(void)
 	mount_root();
 
 	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = sys_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
+	error = ksys_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
 	if (!error)
 		printk("okay\n");
 	else {
-- 
2.16.3
