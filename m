From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 067/109] fs: add ksys_umount() helper; remove in-kernel call to sys_umount()
Date: Thu, 29 Mar 2018 13:23:44 +0200
Message-ID: <20180329112426.23043-68-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel call to the sys_umount()
syscall. The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as ksys_umount().

In the near future, the only fs-external caller of ksys_umount() should be
converted to call do_umount() directly. Then, ksys_umount() can be moved
within sys_umount() again.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/namespace.c           | 9 +++++++--
 include/linux/syscalls.h | 1 +
 init/do_mounts_initrd.c  | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 642b8b229944..e398f32d7541 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1680,7 +1680,7 @@ static inline bool may_mandlock(void)
  * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
  */
 
-SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
+int ksys_umount(char __user *name, int flags)
 {
 	struct path path;
 	struct mount *mnt;
@@ -1720,6 +1720,11 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 	return retval;
 }
 
+SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
+{
+	return ksys_umount(name, flags);
+}
+
 #ifdef __ARCH_WANT_SYS_OLDUMOUNT
 
 /*
@@ -1727,7 +1732,7 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
  */
 SYSCALL_DEFINE1(oldumount, char __user *, name)
 {
-	return sys_umount(name, 0);
+	return ksys_umount(name, 0);
 }
 
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3a9f9c534624..48964c408c7b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -948,5 +948,6 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 
 int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 	       unsigned long flags, void __user *data);
+int ksys_umount(char __user *name, int flags);
 
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 7868a6039fb4..1c4da8353332 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -105,7 +105,7 @@ static void __init handle_initrd(void)
 		else
 			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
-		sys_umount("/old", MNT_DETACH);
+		ksys_umount("/old", MNT_DETACH);
 		printk(KERN_NOTICE "Trying to free ramdisk memory ... ");
 		if (fd < 0) {
 			error = fd;
-- 
2.16.3
