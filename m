From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 086/109] fs: add ksys_ioctl() helper; remove in-kernel calls to sys_ioctl()
Date: Thu, 29 Mar 2018 13:24:03 +0200
Message-ID: <20180329112426.23043-87-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_ioctl() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_ioctl().

After careful review, at least some of these calls could be converted
to do_vfs_ioctl() in future.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/ioctl.c               |  7 ++++++-
 include/linux/syscalls.h |  1 +
 init/do_mounts.c         |  8 ++++----
 init/do_mounts_initrd.c  |  2 +-
 init/do_mounts_md.c      | 15 ++++++++-------
 init/do_mounts_rd.c      |  4 ++--
 6 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5ace7efb0d04..4823431d1c9d 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -689,7 +689,7 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 	return error;
 }
 
-SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
+int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	int error;
 	struct fd f = fdget(fd);
@@ -702,3 +702,8 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 	fdput(f);
 	return error;
 }
+
+SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
+{
+	return ksys_ioctl(fd, cmd, arg);
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c056aff6d7ad..5a959efd8fb7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -957,6 +957,7 @@ int ksys_fchmod(unsigned int fd, umode_t mode);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 		    unsigned int count);
+int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/init/do_mounts.c b/init/do_mounts.c
index cc1103477071..b17e0095eb4e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -491,18 +491,18 @@ void __init change_floppy(char *fmt, ...)
 	va_end(args);
 	fd = ksys_open("/dev/root", O_RDWR | O_NDELAY, 0);
 	if (fd >= 0) {
-		sys_ioctl(fd, FDEJECT, 0);
+		ksys_ioctl(fd, FDEJECT, 0);
 		ksys_close(fd);
 	}
 	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
 	fd = ksys_open("/dev/console", O_RDWR, 0);
 	if (fd >= 0) {
-		sys_ioctl(fd, TCGETS, (long)&termios);
+		ksys_ioctl(fd, TCGETS, (long)&termios);
 		termios.c_lflag &= ~ICANON;
-		sys_ioctl(fd, TCSETSF, (long)&termios);
+		ksys_ioctl(fd, TCSETSF, (long)&termios);
 		sys_read(fd, &c, 1);
 		termios.c_lflag |= ICANON;
-		sys_ioctl(fd, TCSETSF, (long)&termios);
+		ksys_ioctl(fd, TCSETSF, (long)&termios);
 		ksys_close(fd);
 	}
 }
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index cedca8fd2590..03ec0c1b7553 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -110,7 +110,7 @@ static void __init handle_initrd(void)
 		if (fd < 0) {
 			error = fd;
 		} else {
-			error = sys_ioctl(fd, BLKFLSBUF, 0);
+			error = ksys_ioctl(fd, BLKFLSBUF, 0);
 			ksys_close(fd);
 		}
 		printk(!error ? "okay\n" : "failed\n");
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index 76dcfaada3ed..7d85d172bc7e 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -187,7 +187,7 @@ static void __init md_setup_drive(void)
 					"array %s\n", name);
 			continue;
 		}
-		if (sys_ioctl(fd, SET_ARRAY_INFO, 0) == -EBUSY) {
+		if (ksys_ioctl(fd, SET_ARRAY_INFO, 0) == -EBUSY) {
 			printk(KERN_WARNING
 			       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
 			       minor);
@@ -210,7 +210,7 @@ static void __init md_setup_drive(void)
 			ainfo.state = (1 << MD_SB_CLEAN);
 			ainfo.layout = 0;
 			ainfo.chunk_size = md_setup_args[ent].chunk;
-			err = sys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
+			err = ksys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
 			for (i = 0; !err && i <= MD_SB_DISKS; i++) {
 				dev = devices[i];
 				if (!dev)
@@ -220,7 +220,8 @@ static void __init md_setup_drive(void)
 				dinfo.state = (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
 				dinfo.major = MAJOR(dev);
 				dinfo.minor = MINOR(dev);
-				err = sys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
+				err = ksys_ioctl(fd, ADD_NEW_DISK,
+						 (long)&dinfo);
 			}
 		} else {
 			/* persistent */
@@ -230,11 +231,11 @@ static void __init md_setup_drive(void)
 					break;
 				dinfo.major = MAJOR(dev);
 				dinfo.minor = MINOR(dev);
-				sys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
+				ksys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
 			}
 		}
 		if (!err)
-			err = sys_ioctl(fd, RUN_ARRAY, 0);
+			err = ksys_ioctl(fd, RUN_ARRAY, 0);
 		if (err)
 			printk(KERN_WARNING "md: starting md%d failed\n", minor);
 		else {
@@ -245,7 +246,7 @@ static void __init md_setup_drive(void)
 			 */
 			ksys_close(fd);
 			fd = ksys_open(name, 0, 0);
-			sys_ioctl(fd, BLKRRPART, 0);
+			ksys_ioctl(fd, BLKRRPART, 0);
 		}
 		ksys_close(fd);
 	}
@@ -296,7 +297,7 @@ static void __init autodetect_raid(void)
 
 	fd = ksys_open("/dev/md0", 0, 0);
 	if (fd >= 0) {
-		sys_ioctl(fd, RAID_AUTORUN, raid_autopart);
+		ksys_ioctl(fd, RAID_AUTORUN, raid_autopart);
 		ksys_close(fd);
 	}
 }
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index a6706314baa7..4dafaed5736f 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -218,7 +218,7 @@ int __init rd_load_image(char *from)
 	 * NOTE NOTE: nblocks is not actually blocks but
 	 * the number of kibibytes of data to load into a ramdisk.
 	 */
-	if (sys_ioctl(out_fd, BLKGETSIZE, (unsigned long)&rd_blocks) < 0)
+	if (ksys_ioctl(out_fd, BLKGETSIZE, (unsigned long)&rd_blocks) < 0)
 		rd_blocks = 0;
 	else
 		rd_blocks >>= 1;
@@ -232,7 +232,7 @@ int __init rd_load_image(char *from)
 	/*
 	 * OK, time to copy in the data
 	 */
-	if (sys_ioctl(in_fd, BLKGETSIZE, (unsigned long)&devblocks) < 0)
+	if (ksys_ioctl(in_fd, BLKGETSIZE, (unsigned long)&devblocks) < 0)
 		devblocks = 0;
 	else
 		devblocks >>= 1;
-- 
2.16.3
