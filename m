Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 1 Jul 2005 14:56:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH, for review 1/3] compat_sys_{read,write}
Message-Id: <20050701145642.6a3d6542.sfr@canb.auug.org.au>
In-Reply-To: <20050630154904.GQ13890@bragg.suse.de>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
	<20050628.134736.45885284.davem@davemloft.net>
	<20050629164127.58e97376.sfr@canb.auug.org.au>
	<20050629121228.GH21575@bragg.suse.de>
	<20050630175741.0fba8049.sfr@canb.auug.org.au>
	<20050630084255.GC13890@bragg.suse.de>
	<20050701003806.1de72653.sfr@canb.auug.org.au>
	<20050701012857.6b6de8f9.sfr@canb.auug.org.au>
	<20050630154904.GQ13890@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This patch introduces compatibility syscalls for read and write and the
equivalent hooks in struct file_operations.  These are neede to support
the badly designed (i.e. broken) input layer evdev read and write
interfaces.

I have built this on ppc64 and booted it on an iSeries machine.

Comments?  Testing?

 fs/compat.c        |   12 ++++++++
 fs/read_write.c    |   77 +++++++++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h |    6 ++++
 3 files changed, 79 insertions(+), 16 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/fs/compat.c linus-compat_write.3/fs/compat.c
--- linus/fs/compat.c	2005-06-27 16:08:02.000000000 +1000
+++ linus-compat_write.3/fs/compat.c	2005-07-01 13:48:57.000000000 +1000
@@ -51,6 +51,18 @@
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
 
+asmlinkage ssize_t compat_sys_read(unsigned int fd, char __user * buf,
+		compat_size_t count)
+{
+	return do_sys_read(fd, buf, count, 1);
+}
+
+asmlinkage ssize_t compat_sys_write(unsigned int fd, const char __user * buf,
+		compat_size_t count)
+{
+	return do_sys_write(fd, buf, count, 1);
+}
+
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
diff -ruN linus/fs/read_write.c linus-compat_write.3/fs/read_write.c
--- linus/fs/read_write.c	2005-06-27 16:08:05.000000000 +1000
+++ linus-compat_write.3/fs/read_write.c	2005-07-01 14:39:04.000000000 +1000
@@ -18,6 +18,26 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
+#ifdef CONFIG_COMPAT
+#define vfs_select_rw(file, func, compat)				\
+		(((file)->f_op == NULL) ? NULL				\
+		 : (((compat) && ((file)->f_op->compat_ ## func != NULL)) \
+			? (file)->f_op->compat_ ## func			\
+			: (((file)->f_op->func != NULL)			\
+				? (file)->f_op->func			\
+				: (((file)->f_op->aio_ ## func != NULL)	\
+					? do_sync_ ## func		\
+					: NULL))))
+#else
+#define vfs_select_rw(file, func, compat)				\
+		(((file)->f_op == NULL) ? NULL				\
+			: (((file)->f_op->func != NULL)			\
+				? (file)->f_op->func			\
+				: (((file)->f_op->aio_ ## func != NULL)	\
+					? do_sync_ ## func		\
+					: NULL)))
+#endif	/* CONFIG_COMPAT */
+
 struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
@@ -232,13 +252,15 @@
 
 EXPORT_SYMBOL(do_sync_read);
 
-ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
+static ssize_t do_vfs_read(struct file *file, char __user *buf, size_t count,
+		loff_t *pos, ssize_t (*read_func)(struct file *, char __user *,
+			size_t, loff_t *))
 {
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->read && !file->f_op->aio_read))
+	if (!read_func)
 		return -EINVAL;
 	if (unlikely(!access_ok(VERIFY_WRITE, buf, count)))
 		return -EFAULT;
@@ -247,10 +269,7 @@
 	if (!ret) {
 		ret = security_file_permission (file, MAY_READ);
 		if (!ret) {
-			if (file->f_op->read)
-				ret = file->f_op->read(file, buf, count, pos);
-			else
-				ret = do_sync_read(file, buf, count, pos);
+			ret = read_func(file, buf, count, pos);
 			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_ACCESS);
 				current->rchar += ret;
@@ -262,6 +281,10 @@
 	return ret;
 }
 
+ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
+{
+	return do_vfs_read(file, buf, count, pos, vfs_select_rw(file, read, 0));
+}
 EXPORT_SYMBOL(vfs_read);
 
 ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
@@ -283,13 +306,16 @@
 
 EXPORT_SYMBOL(do_sync_write);
 
-ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
+static ssize_t do_vfs_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *pos,
+		ssize_t (*write_func)(struct file *, const char __user *,
+			size_t, loff_t *))
 {
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->write && !file->f_op->aio_write))
+	if (!write_func)
 		return -EINVAL;
 	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
 		return -EFAULT;
@@ -298,10 +324,7 @@
 	if (!ret) {
 		ret = security_file_permission (file, MAY_WRITE);
 		if (!ret) {
-			if (file->f_op->write)
-				ret = file->f_op->write(file, buf, count, pos);
-			else
-				ret = do_sync_write(file, buf, count, pos);
+			ret = write_func(file, buf, count, pos);
 			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_MODIFY);
 				current->wchar += ret;
@@ -313,6 +336,13 @@
 	return ret;
 }
 
+ssize_t vfs_write(struct file *file, const char __user *buf, size_t count,
+		loff_t *pos)
+{
+	return do_vfs_write(file, buf, count, pos,
+			vfs_select_rw(file, write, 0));
+}
+
 EXPORT_SYMBOL(vfs_write);
 
 static inline loff_t file_pos_read(struct file *file)
@@ -325,7 +355,8 @@
 	file->f_pos = pos;
 }
 
-asmlinkage ssize_t sys_read(unsigned int fd, char __user * buf, size_t count)
+ssize_t do_sys_read(unsigned int fd, char __user * buf,
+		size_t count, int compat)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -334,16 +365,23 @@
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
-		ret = vfs_read(file, buf, count, &pos);
+		ret = do_vfs_read(file, buf, count, &pos,
+				vfs_select_rw(file, read, compat));
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
 	}
 
 	return ret;
 }
+
+asmlinkage ssize_t sys_read(unsigned int fd, char __user * buf, size_t count)
+{
+	return do_sys_read(fd, buf, count, 0);
+}
 EXPORT_SYMBOL_GPL(sys_read);
 
-asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf, size_t count)
+ssize_t do_sys_write(unsigned int fd, const char __user * buf, size_t count,
+		int compat)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -352,7 +390,8 @@
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
-		ret = vfs_write(file, buf, count, &pos);
+		ret = do_vfs_write(file, buf, count, &pos,
+				vfs_select_rw(file, write, compat));
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
 	}
@@ -360,6 +399,12 @@
 	return ret;
 }
 
+asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf,
+		size_t count)
+{
+	return do_sys_write(fd, buf, count, 0);
+}
+
 asmlinkage ssize_t sys_pread64(unsigned int fd, char __user *buf,
 			     size_t count, loff_t pos)
 {
diff -ruN linus/include/linux/fs.h linus-compat_write.3/include/linux/fs.h
--- linus/include/linux/fs.h	2005-06-28 10:05:27.000000000 +1000
+++ linus-compat_write.3/include/linux/fs.h	2005-07-01 13:46:07.000000000 +1000
@@ -949,8 +949,10 @@
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
+	ssize_t (*compat_read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, loff_t);
+	ssize_t (*compat_write) (struct file *, const char __user *, size_t, loff_t *);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1498,6 +1500,10 @@
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
+extern ssize_t do_sys_read(unsigned int fd, char __user * buf,
+		size_t count, int compat);
+extern ssize_t do_sys_write(unsigned int fd, const char __user * buf,
+		size_t count, int compat);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
