From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 084/109] fs: add ksys_open() wrapper; remove in-kernel calls to sys_open()
Date: Thu, 29 Mar 2018 13:24:01 +0200
Message-ID: <20180329112426.23043-85-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using this wrapper allows us to avoid the in-kernel calls to the
sys_open() syscall. The ksys_ prefix denotes that this function is meant
as a drop-in replacement for the syscall. In particular, it uses the
same calling convention as sys_open().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/open.c                |  2 +-
 include/linux/syscalls.h | 11 +++++++++++
 init/do_mounts.c         |  4 ++--
 init/do_mounts_initrd.c  |  4 ++--
 init/do_mounts_md.c      |  6 +++---
 init/do_mounts_rd.c      |  6 +++---
 init/initramfs.c         |  6 +++---
 init/main.c              |  2 +-
 8 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 710102fc262b..8a42a2961130 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1151,7 +1151,7 @@ COMPAT_SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, fla
  */
 SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
 {
-	return sys_open(pathname, O_CREAT | O_WRONLY | O_TRUNC, mode);
+	return ksys_open(pathname, O_CREAT | O_WRONLY | O_TRUNC, mode);
 }
 
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 38805f3447ea..f9df17dcec1c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1057,4 +1057,15 @@ static inline int ksys_close(unsigned int fd)
 	return __close_fd(current->files, fd);
 }
 
+extern long do_sys_open(int dfd, const char __user *filename, int flags,
+			umode_t mode);
+
+static inline long ksys_open(const char __user *filename, int flags,
+			     umode_t mode)
+{
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+	return do_sys_open(AT_FDCWD, filename, flags, mode);
+}
+
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index a28dd42d1f84..cc1103477071 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -489,13 +489,13 @@ void __init change_floppy(char *fmt, ...)
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
 	va_end(args);
-	fd = sys_open("/dev/root", O_RDWR | O_NDELAY, 0);
+	fd = ksys_open("/dev/root", O_RDWR | O_NDELAY, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, FDEJECT, 0);
 		ksys_close(fd);
 	}
 	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
-	fd = sys_open("/dev/console", O_RDWR, 0);
+	fd = ksys_open("/dev/console", O_RDWR, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, TCGETS, (long)&termios);
 		termios.c_lflag &= ~ICANON;
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 6907c6dbc443..cedca8fd2590 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -38,7 +38,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	sys_unshare(CLONE_FS | CLONE_FILES);
 	/* stdin/stdout/stderr for /linuxrc */
-	sys_open("/dev/console", O_RDWR, 0);
+	ksys_open("/dev/console", O_RDWR, 0);
 	ksys_dup(0);
 	ksys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
@@ -99,7 +99,7 @@ static void __init handle_initrd(void)
 	if (!error)
 		printk("okay\n");
 	else {
-		int fd = sys_open("/dev/root.old", O_RDWR, 0);
+		int fd = ksys_open("/dev/root.old", O_RDWR, 0);
 		if (error == -ENOENT)
 			printk("/initrd does not exist. Ignored.\n");
 		else
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index ebd4013d589e..76dcfaada3ed 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -181,7 +181,7 @@ static void __init md_setup_drive(void)
 			partitioned ? "_d" : "", minor,
 			md_setup_args[ent].device_names);
 
-		fd = sys_open(name, 0, 0);
+		fd = ksys_open(name, 0, 0);
 		if (fd < 0) {
 			printk(KERN_ERR "md: open failed - cannot start "
 					"array %s\n", name);
@@ -244,7 +244,7 @@ static void __init md_setup_drive(void)
 			 * array without it
 			 */
 			ksys_close(fd);
-			fd = sys_open(name, 0, 0);
+			fd = ksys_open(name, 0, 0);
 			sys_ioctl(fd, BLKRRPART, 0);
 		}
 		ksys_close(fd);
@@ -294,7 +294,7 @@ static void __init autodetect_raid(void)
 
 	wait_for_device_probe();
 
-	fd = sys_open("/dev/md0", 0, 0);
+	fd = ksys_open("/dev/md0", 0, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, RAID_AUTORUN, raid_autopart);
 		ksys_close(fd);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index f1aa341862d3..a6706314baa7 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -196,11 +196,11 @@ int __init rd_load_image(char *from)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
-	out_fd = sys_open("/dev/ram", O_RDWR, 0);
+	out_fd = ksys_open("/dev/ram", O_RDWR, 0);
 	if (out_fd < 0)
 		goto out;
 
-	in_fd = sys_open(from, O_RDONLY, 0);
+	in_fd = ksys_open(from, O_RDONLY, 0);
 	if (in_fd < 0)
 		goto noclose_input;
 
@@ -262,7 +262,7 @@ int __init rd_load_image(char *from)
 				goto noclose_input;
 			}
 			change_floppy("disk #%d", disk);
-			in_fd = sys_open(from, O_RDONLY, 0);
+			in_fd = ksys_open(from, O_RDONLY, 0);
 			if (in_fd < 0)  {
 				printk("Error opening disk.\n");
 				goto noclose_input;
diff --git a/init/initramfs.c b/init/initramfs.c
index ce2bcad97cdf..5f2ff1d2370e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -340,7 +340,7 @@ static int __init do_name(void)
 			int openflags = O_WRONLY|O_CREAT;
 			if (ml != 1)
 				openflags |= O_TRUNC;
-			wfd = sys_open(collected, openflags, mode);
+			wfd = ksys_open(collected, openflags, mode);
 
 			if (wfd >= 0) {
 				ksys_fchown(wfd, uid, gid);
@@ -567,7 +567,7 @@ static void __init clean_rootfs(void)
 	struct linux_dirent64 *dirp;
 	int num;
 
-	fd = sys_open("/", O_RDONLY, 0);
+	fd = ksys_open("/", O_RDONLY, 0);
 	WARN_ON(fd < 0);
 	if (fd < 0)
 		return;
@@ -629,7 +629,7 @@ static int __init populate_rootfs(void)
 		}
 		printk(KERN_INFO "rootfs image is not initramfs (%s)"
 				"; looks like an initrd\n", err);
-		fd = sys_open("/initrd.image",
+		fd = ksys_open("/initrd.image",
 			      O_WRONLY|O_CREAT, 0700);
 		if (fd >= 0) {
 			ssize_t written = xwrite(fd, (char *)initrd_start,
diff --git a/init/main.c b/init/main.c
index d0ded4322c6b..e77951ae2c19 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1074,7 +1074,7 @@ static noinline void __init kernel_init_freeable(void)
 	do_basic_setup();
 
 	/* Open the /dev/console on the rootfs, this should never fail */
-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		pr_err("Warning: unable to open an initial console.\n");
 
 	(void) ksys_dup(0);
-- 
2.16.3
