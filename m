From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 03/45] fs: add ksys_lseek() helper; remove in-kernel calls to sys_lseek()
Date: Thu, 22 Mar 2018 10:00:17 +0100
Message-ID: <20180322090059.19361-4-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_lseek() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_lseek().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/read_write.c          | 9 +++++++--
 include/linux/syscalls.h | 1 +
 init/do_mounts_rd.c      | 8 ++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 8e8f0b4f52e2..b38b008a078e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -301,7 +301,7 @@ loff_t vfs_llseek(struct file *file, loff_t offset, int whence)
 }
 EXPORT_SYMBOL(vfs_llseek);
 
-SYSCALL_DEFINE3(lseek, unsigned int, fd, off_t, offset, unsigned int, whence)
+off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
 {
 	off_t retval;
 	struct fd f = fdget_pos(fd);
@@ -319,10 +319,15 @@ SYSCALL_DEFINE3(lseek, unsigned int, fd, off_t, offset, unsigned int, whence)
 	return retval;
 }
 
+SYSCALL_DEFINE3(lseek, unsigned int, fd, off_t, offset, unsigned int, whence)
+{
+	return ksys_lseek(fd, offset, whence);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned int, whence)
 {
-	return sys_lseek(fd, offset, whence);
+	return ksys_lseek(fd, offset, whence);
 }
 #endif
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f1d341d0972f..d11d06ab546e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -975,6 +975,7 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 		    unsigned int count);
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 4dafaed5736f..13e54148c0e0 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -90,7 +90,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	/*
 	 * Read block 0 to test for compressed kernel
 	 */
-	sys_lseek(fd, start_block * BLOCK_SIZE, 0);
+	ksys_lseek(fd, start_block * BLOCK_SIZE, 0);
 	sys_read(fd, buf, size);
 
 	*decompressor = decompress_method(buf, size, &compress_name);
@@ -136,7 +136,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	/*
 	 * Read 512 bytes further to check if cramfs is padded
 	 */
-	sys_lseek(fd, start_block * BLOCK_SIZE + 0x200, 0);
+	ksys_lseek(fd, start_block * BLOCK_SIZE + 0x200, 0);
 	sys_read(fd, buf, size);
 
 	if (cramfsb->magic == CRAMFS_MAGIC) {
@@ -150,7 +150,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	/*
 	 * Read block 1 to test for minix and ext2 superblock
 	 */
-	sys_lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
+	ksys_lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
 	sys_read(fd, buf, size);
 
 	/* Try minix */
@@ -178,7 +178,7 @@ identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
 	       start_block);
 
 done:
-	sys_lseek(fd, start_block * BLOCK_SIZE, 0);
+	ksys_lseek(fd, start_block * BLOCK_SIZE, 0);
 	kfree(buf);
 	return nblocks;
 }
-- 
2.16.2
