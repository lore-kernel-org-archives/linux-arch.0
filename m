From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 04/45] fs: add ksys_read() helper; remove in-kernel calls to sys_read()
Date: Thu, 22 Mar 2018 10:00:18 +0100
Message-ID: <20180322090059.19361-5-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_read() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_read().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/s390/kernel/compat_linux.c |  2 +-
 fs/read_write.c                 |  7 ++++++-
 include/linux/syscalls.h        |  1 +
 init/do_mounts.c                |  2 +-
 init/do_mounts_rd.c             | 10 +++++-----
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index a1fa8051fe63..fb902b591bb4 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -460,7 +460,7 @@ COMPAT_SYSCALL_DEFINE3(s390_read, unsigned int, fd, char __user *, buf, compat_s
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
 
-	return sys_read(fd, buf, count);
+	return ksys_read(fd, buf, count);
 }
 
 COMPAT_SYSCALL_DEFINE3(s390_write, unsigned int, fd, const char __user *, buf, compat_size_t, count)
diff --git a/fs/read_write.c b/fs/read_write.c
index b38b008a078e..fc441e1ac683 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -568,7 +568,7 @@ static inline void file_pos_write(struct file *file, loff_t pos)
 	file->f_pos = pos;
 }
 
-SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
+ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 {
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
@@ -583,6 +583,11 @@ SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 	return ret;
 }
 
+SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
+{
+	return ksys_read(fd, buf, count);
+}
+
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 {
 	struct fd f = fdget_pos(fd);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d11d06ab546e..e3a52c0bbf52 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -976,6 +976,7 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 		    unsigned int count);
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence);
+ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/init/do_mounts.c b/init/do_mounts.c
index b17e0095eb4e..2c71dabe5626 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -500,7 +500,7 @@ void __init change_floppy(char *fmt, ...)
 		ksys_ioctl(fd, TCGETS, (long)&termios);
 		termios.c_lflag &= ~ICANON;
 		ksys_ioctl(fd, TCSETSF, (long)&termios);
-		sys_read(fd, &c, 1);
+		ksys_read(fd, &c, 1);
 		termios.c_lflag |= ICANON;
 		ksys_ioctl(fd, TCSETSF, (long)&termios);
 		ksys_close(fd);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 13e54148c0e0..12c159824c7b 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -91,7 +91,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	 * Read block 0 to test for compressed kernel
 	 */
 	ksys_lseek(fd, start_block * BLOCK_SIZE, 0);
-	sys_read(fd, buf, size);
+	ksys_read(fd, buf, size);
 
 	*decompressor = decompress_method(buf, size, &compress_name);
 	if (compress_name) {
@@ -137,7 +137,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	 * Read 512 bytes further to check if cramfs is padded
 	 */
 	ksys_lseek(fd, start_block * BLOCK_SIZE + 0x200, 0);
-	sys_read(fd, buf, size);
+	ksys_read(fd, buf, size);
 
 	if (cramfsb->magic == CRAMFS_MAGIC) {
 		printk(KERN_NOTICE
@@ -151,7 +151,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	 * Read block 1 to test for minix and ext2 superblock
 	 */
 	ksys_lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
-	sys_read(fd, buf, size);
+	ksys_read(fd, buf, size);
 
 	/* Try minix */
 	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
@@ -269,7 +269,7 @@ int __init rd_load_image(char *from)
 			}
 			printk("Loading disk #%d... ", disk);
 		}
-		sys_read(in_fd, buf, BLOCK_SIZE);
+		ksys_read(in_fd, buf, BLOCK_SIZE);
 		ksys_write(out_fd, buf, BLOCK_SIZE);
 #if !defined(CONFIG_S390)
 		if (!(i % 16)) {
@@ -307,7 +307,7 @@ static int crd_infd, crd_outfd;
 
 static long __init compr_fill(void *buf, unsigned long len)
 {
-	long r = sys_read(crd_infd, buf, len);
+	long r = ksys_read(crd_infd, buf, len);
 	if (r < 0)
 		printk(KERN_ERR "RAMDISK: error while reading compressed data");
 	else if (r == 0)
-- 
2.16.2
