From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 071/109] fs: add ksys_chdir() helper; remove in-kernel calls to sys_chdir()
Date: Thu, 29 Mar 2018 13:23:48 +0200
Message-ID: <20180329112426.23043-72-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the sys_chdir()
syscall. The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_chdir().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c  | 2 +-
 fs/open.c                | 7 ++++++-
 include/linux/syscalls.h | 1 +
 init/do_mounts.c         | 2 +-
 init/do_mounts_initrd.c  | 8 ++++----
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 5743f04014ca..3f7ee954fd2c 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -386,7 +386,7 @@ static int devtmpfsd(void *p)
 	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
 	if (*err)
 		goto out;
-	sys_chdir("/.."); /* will traverse into overmounted root */
+	ksys_chdir("/.."); /* will traverse into overmounted root */
 	ksys_chroot(".");
 	complete(&setup_done);
 	while (1) {
diff --git a/fs/open.c b/fs/open.c
index 7a475e8a2e41..a19b8277c439 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -431,7 +431,7 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 	return sys_faccessat(AT_FDCWD, filename, mode);
 }
 
-SYSCALL_DEFINE1(chdir, const char __user *, filename)
+int ksys_chdir(const char __user *filename)
 {
 	struct path path;
 	int error;
@@ -457,6 +457,11 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 	return error;
 }
 
+SYSCALL_DEFINE1(chdir, const char __user *, filename)
+{
+	return ksys_chdir(filename);
+}
+
 SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 {
 	struct fd f = fdget_raw(fd);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 80524faa9664..090645b48447 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -952,5 +952,6 @@ int ksys_umount(char __user *name, int flags);
 int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
+int ksys_chdir(const char __user *filename);
 
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2f06f7827b0c..89f18985fa90 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -367,7 +367,7 @@ static int __init do_mount_root(char *name, char *fs, int flags, void *data)
 	if (err)
 		return err;
 
-	sys_chdir("/root");
+	ksys_chdir("/root");
 	s = current->fs->pwd.dentry->d_sb;
 	ROOT_DEV = s->s_dev;
 	printk(KERN_INFO
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 71293265ac4b..83f396d30b9a 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -42,7 +42,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	ksys_dup(0);
 	ksys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
-	sys_chdir("/root");
+	ksys_chdir("/root");
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 	sys_setsid();
@@ -61,7 +61,7 @@ static void __init handle_initrd(void)
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	sys_mkdir("/old", 0700);
-	sys_chdir("/old");
+	ksys_chdir("/old");
 
 	/* try loading default modules from initrd */
 	load_default_modules();
@@ -86,11 +86,11 @@ static void __init handle_initrd(void)
 	ksys_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
-		sys_chdir("/old");
+		ksys_chdir("/old");
 		return;
 	}
 
-	sys_chdir("/");
+	ksys_chdir("/");
 	ROOT_DEV = new_decode_dev(real_root_dev);
 	mount_root();
 
-- 
2.16.3
