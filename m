From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 20/28] lkl tools: host lib: filesystem helpers
Date: Tue,  3 Nov 2015 22:20:51 +0200
Message-ID: <1446582059-17355-21-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Add LKL applications APIs to mount and unmount a filesystem from a
disk added via lkl_disk_add().

Also add open/close/read directory wrappers on top of
lkl_sys_getdents64.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 tools/lkl/include/lkl.h |  66 +++++++++++++++
 tools/lkl/lib/fs.c      | 218 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+)
 create mode 100644 tools/lkl/lib/fs.c

diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index 0c30b23..e6a9c77 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -40,4 +40,70 @@ union lkl_disk_backstore {
  */
 int lkl_disk_add(union lkl_disk_backstore backstore);
 
+/**
+ * lkl_mount_dev - mount a disk
+ *
+ * This functions creates a device file for the given disk, creates a mount
+ * point and mounts the device over the mount point.
+ *
+ * @disk_id - the disk id identifying the disk to be mounted
+ * @fs_type - filesystem type
+ * @flags - mount flags
+ * @data - additional filesystem specific mount data
+ * @mnt_str - a string that will be filled by this function with the path where
+ * the filisystem has been mounted
+ * @mnt_str_len - size of mnt_str
+ * @returns - 0 on success, a negative value on error
+ */
+long lkl_mount_dev(unsigned int disk_id, const char *fs_type, int flags,
+		   void *data, char *mnt_str, int mnt_str_len);
+
+/**
+ * lkl_umount_dev - umount a disk
+ *
+ * This functions umounts the given disks and removes the device file and the
+ * mount point.
+ *
+ * @disk_id - the disk id identifying the disk to be mounted
+ * @flags - umount flags
+ * @timeout_ms - timeout to wait for the kernel to flush closed files so that
+ * umount can succeed
+ * @returns - 0 on success, a negative value on error
+ */
+long lkl_umount_dev(unsigned int disk_id, int flags, long timeout_ms);
+
+/**
+ * lkl_opendir - open a directory
+ *
+ * @path - directory path
+ * @err - pointer to store the error in case of failure
+ * @returns - a handle to be used when calling lkl_readdir
+ */
+struct lkl_dir *lkl_opendir(const char *path, int *err);
+
+/**
+ * lkl_closedir - close the directory
+ *
+ * @dir - the directory handler as returned by lkl_opendir
+ */
+void lkl_closedir(struct lkl_dir *dir);
+
+/**
+ * lkl_readdir - get the next available entry of the directory
+ *
+ * @dir - the directory handler as returned by lkl_opendir
+ * @returns - a lkl_dirent64 entry or NULL if the end of the directory stream is
+ * reached or if an error occurred; check lkl_errdir() to distinguish between
+ * errors or end of the directory stream
+ */
+struct lkl_dirent64 *lkl_readdir(struct lkl_dir *dir);
+
+/**
+ * lkl_errdir - checks if an error occurred during the last lkl_readdir call
+ *
+ * @dir - the directory handler as returned by lkl_opendir
+ * @returns - 0 if no error occurred, or a negative value otherwise
+ */
+int lkl_errdir(struct lkl_dir *dir);
+
 #endif
diff --git a/tools/lkl/lib/fs.c b/tools/lkl/lib/fs.c
new file mode 100644
index 0000000..16f4d44
--- /dev/null
+++ b/tools/lkl/lib/fs.c
@@ -0,0 +1,218 @@
+#include <stdio.h>
+#include <string.h>
+#include <lkl_host.h>
+
+long lkl_mount_sysfs(void)
+{
+	long ret;
+	static int sysfs_mounted;
+
+	if (sysfs_mounted)
+		return 0;
+
+	ret = lkl_sys_mkdir("/sys", 0700);
+	if (ret)
+		return ret;
+
+	ret = lkl_sys_mount("none", "sys", "sysfs", 0, NULL);
+
+	if (ret == 0)
+		sysfs_mounted = 1;
+
+	return ret;
+}
+
+static long get_virtio_blkdev(int disk_id)
+{
+	char sysfs_path[] = "/sys/block/vda/dev";
+	char buf[16] = { 0, };
+	long fd, ret;
+	int major, minor;
+
+	ret = lkl_mount_sysfs();
+	if (ret)
+		return ret;
+
+	sysfs_path[strlen("/sys/block/vd")] += disk_id;
+
+	fd = lkl_sys_open(sysfs_path, LKL_O_RDONLY, 0);
+	if (fd < 0)
+		return fd;
+
+	ret = lkl_sys_read(fd, buf, sizeof(buf));
+	if (ret < 0)
+		goto out_close;
+
+	if (ret == sizeof(buf)) {
+		ret = -LKL_ENOBUFS;
+		goto out_close;
+	}
+
+	ret = sscanf(buf, "%d:%d", &major, &minor);
+	if (ret != 2) {
+		ret = -LKL_EINVAL;
+		goto out_close;
+	}
+
+	ret = LKL_MKDEV(major, minor);
+
+out_close:
+	lkl_sys_close(fd);
+
+	return ret;
+}
+
+long lkl_mount_dev(unsigned int disk_id, const char *fs_type, int flags,
+		   void *data, char *mnt_str, int mnt_str_len)
+{
+	char dev_str[] = { "/dev/xxxxxxxx" };
+	unsigned int dev;
+	int err;
+
+	if (mnt_str_len < sizeof("/mnt/xxxxxxxx"))
+		return -LKL_ENOMEM;
+
+	dev = get_virtio_blkdev(disk_id);
+
+	snprintf(dev_str, sizeof(dev_str), "/dev/%08x", dev);
+	snprintf(mnt_str, mnt_str_len, "/mnt/%08x", dev);
+
+	err = lkl_sys_access("/dev", LKL_S_IRWXO);
+	if (err < 0) {
+		if (err == -LKL_ENOENT)
+			err = lkl_sys_mkdir("/dev", 0700);
+		if (err < 0)
+			return err;
+	}
+
+	err = lkl_sys_mknod(dev_str, LKL_S_IFBLK | 0600, dev);
+	if (err < 0)
+		return err;
+
+	err = lkl_sys_access("/mnt", LKL_S_IRWXO);
+	if (err < 0) {
+		if (err == -LKL_ENOENT)
+			err = lkl_sys_mkdir("/mnt", 0700);
+		if (err < 0)
+			return err;
+	}
+
+	err = lkl_sys_mkdir(mnt_str, 0700);
+	if (err < 0) {
+		lkl_sys_unlink(dev_str);
+		return err;
+	}
+
+	err = lkl_sys_mount(dev_str, mnt_str, fs_type, flags, data);
+	if (err < 0) {
+		lkl_sys_unlink(dev_str);
+		lkl_sys_rmdir(mnt_str);
+		return err;
+	}
+
+	return 0;
+}
+
+long lkl_umount_dev(unsigned int disk_id, int flags, long timeout_ms)
+{
+	char dev_str[] = { "/dev/xxxxxxxx" };
+	char mnt_str[] = { "/mnt/xxxxxxxx" };
+	long incr = 10000000; /* 10 ms */
+	struct lkl_timespec ts = {
+		.tv_sec = 0,
+		.tv_nsec = incr,
+	};
+	unsigned int dev;
+	int err;
+
+	dev = get_virtio_blkdev(disk_id);
+
+	snprintf(dev_str, sizeof(dev_str), "/dev/%08x", dev);
+	snprintf(mnt_str, sizeof(mnt_str), "/mnt/%08x", dev);
+
+	do {
+		err = lkl_sys_umount(mnt_str, flags);
+		if (err == -LKL_EBUSY) {
+			lkl_sys_nanosleep(&ts, NULL);
+			timeout_ms -= incr / 1000000;
+		}
+	} while (err == -LKL_EBUSY && timeout_ms > 0);
+
+	if (err)
+		return err;
+
+	err = lkl_sys_unlink(dev_str);
+	if (err)
+		return err;
+
+	return lkl_sys_rmdir(mnt_str);
+}
+
+struct lkl_dir {
+	int fd;
+	char buf[1024];
+	char *pos;
+	int len;
+};
+
+struct lkl_dir *lkl_opendir(const char *path, int *err)
+{
+	struct lkl_dir *dir = lkl_host_ops.mem_alloc(sizeof(struct lkl_dir));
+
+	if (!dir) {
+		*err = -LKL_ENOMEM;
+		return NULL;
+	}
+
+	dir->fd = lkl_sys_open(path, LKL_O_RDONLY | LKL_O_DIRECTORY, 0);
+	if (dir->fd < 0) {
+		*err = dir->fd;
+		lkl_host_ops.mem_free(dir);
+		return NULL;
+	}
+
+	dir->len = 0;
+	dir->pos = NULL;
+
+	return dir;
+}
+
+void lkl_closedir(struct lkl_dir *dir)
+{
+	lkl_sys_close(dir->fd);
+	lkl_host_ops.mem_free(dir);
+}
+
+struct lkl_dirent64 *lkl_readdir(struct lkl_dir *dir)
+{
+	struct lkl_dirent64 *de;
+
+	if (dir->len < 0)
+		return NULL;
+
+	if (!dir->pos || dir->pos - dir->buf >= dir->len)
+		goto read_buf;
+
+return_de:
+	de = (struct lkl_dirent64 *)dir->pos;
+	dir->pos += de->d_reclen;
+
+	return de;
+
+read_buf:
+	dir->pos = NULL;
+	dir->len = lkl_sys_getdents64(dir->fd, dir->buf, sizeof(dir->buf));
+	if (dir->len <= 0)
+		return NULL;
+
+	dir->pos = dir->buf;
+	goto return_de;
+}
+
+int lkl_errdir(struct lkl_dir *dir)
+{
+	if (dir->len >= 0)
+		return 0;
+
+	return dir->len;
+}
-- 
2.1.0
