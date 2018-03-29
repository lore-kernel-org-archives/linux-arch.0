From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 068/109] fs: add ksys_dup{,3}() helper; remove in-kernel calls to sys_dup{,3}()
Date: Thu, 29 Mar 2018 13:23:45 +0200
Message-ID: <20180329112426.23043-69-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using ksys_dup() and ksys_dup3() as helper functions allows us to
avoid the in-kernel calls to the sys_dup() and sys_dup3() syscalls.
The ksys_ prefix denotes that these functions are meant as a drop-in
replacement for the syscalls. In particular, they use the same
calling convention as sys_dup{,3}().

In the near future, the fs-external callers of ksys_dup{,3}() should be
converted to call do_dup2() directly. Then, ksys_dup{,3}() can be moved
within sys_dup{,3}() again.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/file.c                | 16 +++++++++++++---
 include/linux/syscalls.h |  1 +
 init/do_mounts_initrd.c  |  4 ++--
 init/main.c              |  4 ++--
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 42f0db4bd0fb..d304004f0b65 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -870,7 +870,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	return err;
 }
 
-SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
+static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
 	struct file *file;
@@ -904,6 +904,11 @@ SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
 	return err;
 }
 
+SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
+{
+	return ksys_dup3(oldfd, newfd, flags);
+}
+
 SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 {
 	if (unlikely(newfd == oldfd)) { /* corner case */
@@ -916,10 +921,10 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 		rcu_read_unlock();
 		return retval;
 	}
-	return sys_dup3(oldfd, newfd, 0);
+	return ksys_dup3(oldfd, newfd, 0);
 }
 
-SYSCALL_DEFINE1(dup, unsigned int, fildes)
+int ksys_dup(unsigned int fildes)
 {
 	int ret = -EBADF;
 	struct file *file = fget_raw(fildes);
@@ -934,6 +939,11 @@ SYSCALL_DEFINE1(dup, unsigned int, fildes)
 	return ret;
 }
 
+SYSCALL_DEFINE1(dup, unsigned int, fildes)
+{
+	return ksys_dup(fildes);
+}
+
 int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 {
 	int err;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 48964c408c7b..50876ae1d17b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -949,5 +949,6 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 	       unsigned long flags, void __user *data);
 int ksys_umount(char __user *name, int flags);
+int ksys_dup(unsigned int fildes);
 
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 1c4da8353332..e8573e1776f6 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -39,8 +39,8 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	sys_unshare(CLONE_FS | CLONE_FILES);
 	/* stdin/stdout/stderr for /linuxrc */
 	sys_open("/dev/console", O_RDWR, 0);
-	sys_dup(0);
-	sys_dup(0);
+	ksys_dup(0);
+	ksys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
 	sys_chdir("/root");
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..b8649d1466e1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1077,8 +1077,8 @@ static noinline void __init kernel_init_freeable(void)
 	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		pr_err("Warning: unable to open an initial console.\n");
 
-	(void) sys_dup(0);
-	(void) sys_dup(0);
+	(void) ksys_dup(0);
+	(void) ksys_dup(0);
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
-- 
2.16.3
