Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de ([212.227.126.189]:7418 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265219AbUETVIO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 May 2004 17:08:14 -0400
Subject: =?iso-8859-1?Q?Re:_sys_getdents64_needs_compat_wrapper_??=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Message-Id: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de>
Content-Type: multipart/mixed; boundary="----_=_NextPart_108508699040ad1d0eba5381.88033699";
	charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Thu, 20 May 2004 23:06:01 +0200
To: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: =?iso-8859-1?Q?Arun_Sharma?= <arun.sharma@intel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


This is a multi-part message in MIME format.

------_=_NextPart_108508699040ad1d0eba5381.88033699
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline

Arnd Bergmann <arnd@arndb.de> schrieb am 20.05.2004, 22:54:01:
> 
> The attachment has an older (but so far untested) patch of mine
> to consolidate the syscalls from fs/readdir.c. 

Ok, so here goes the attachment (I hope). Stupid webmail...

------_=_NextPart_108508699040ad1d0eba5381.88033699
Content-Type: text/plain; name=compat_readdir.diff
Content-Disposition: attachment; filename="compat_readdir.diff"

===== fs/compat.c 1.24 vs edited =====
--- 1.24/fs/compat.c	Wed May 19 09:12:47 2004
+++ edited/fs/compat.c	Thu May 20 22:39:43 2004
@@ -1632,3 +1632,246 @@
 	return sys_ni_syscall();
 }
 #endif
+
+#define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
+#define COMPAT_ROUND_UP(x) (((x)+sizeof(compat_long_t)-1) & ~(sizeof(compat_long_t)-1))
+
+struct compat_old_linux_dirent {
+	compat_ulong_t	d_ino;
+	compat_ulong_t	d_offset;
+	unsigned short	d_namlen;
+	char		d_name[1];
+};
+
+struct compat_readdir_callback {
+	struct compat_old_linux_dirent __user * dirent;
+	int result;
+};
+
+static int compat_fillonedir(void * __buf, const char * name, int namlen, loff_t offset,
+		      ino_t ino, unsigned int d_type)
+{
+	struct compat_readdir_callback * buf = __buf;
+	struct compat_old_linux_dirent __user * dirent;
+
+	if (buf->result)
+		return -EINVAL;
+	buf->result++;
+	dirent = buf->dirent;
+	if (!access_ok(VERIFY_WRITE, (unsigned long)dirent,
+			(unsigned long)(dirent->d_name + namlen + 1) -
+				(unsigned long)dirent))
+		goto efault;
+	if (	__put_user(ino, &dirent->d_ino) ||
+		__put_user(offset, &dirent->d_offset) ||
+		__put_user(namlen, &dirent->d_namlen) ||
+		__copy_to_user(dirent->d_name, name, namlen) ||
+		__put_user(0, dirent->d_name + namlen))
+		goto efault;
+	return 0;
+efault:
+	buf->result = -EFAULT;
+	return -EFAULT;
+}
+
+asmlinkage long compat_old_readdir(unsigned int fd,
+	struct compat_old_linux_dirent __user * dirent, unsigned int count)
+{
+	int error;
+	struct file * file;
+	struct compat_readdir_callback buf;
+
+	error = -EBADF;
+	file = fget(fd);
+	if (!file)
+		goto out;
+
+	buf.result = 0;
+	buf.dirent = dirent;
+
+	error = vfs_readdir(file, compat_fillonedir, &buf);
+	if (error >= 0)
+		error = buf.result;
+
+	fput(file);
+out:
+	return error;
+}
+
+struct compat_linux_dirent {
+	compat_ulong_t	d_ino;
+	compat_ulong_t	d_off;
+	unsigned short	d_reclen;
+	char		d_name[1];
+};
+
+struct compat_getdents_callback {
+	struct compat_linux_dirent __user * current_dir;
+	struct compat_linux_dirent __user * previous;
+	int count;
+	int error;
+};
+
+static int compat_filldir(void * __buf, const char * name, int namlen, loff_t offset,
+		   ino_t ino, unsigned int d_type)
+{
+	struct compat_linux_dirent __user * dirent;
+	struct compat_getdents_callback * buf = (struct compat_getdents_callback *) __buf;
+	int reclen = COMPAT_ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
+
+	buf->error = -EINVAL;	/* only used if we fail.. */
+	if (reclen > buf->count)
+		return -EINVAL;
+	dirent = buf->previous;
+	if (dirent) {
+		if (__put_user(offset, &dirent->d_off))
+			goto efault;
+	}
+	dirent = buf->current_dir;
+	if (__put_user(ino, &dirent->d_ino))
+		goto efault;
+	if (__put_user(reclen, &dirent->d_reclen))
+		goto efault;
+	if (copy_to_user(dirent->d_name, name, namlen))
+		goto efault;
+	if (__put_user(0, dirent->d_name + namlen))
+		goto efault;
+	if (__put_user(d_type, (char *) dirent + reclen - 1))
+		goto efault;
+	buf->previous = dirent;
+	dirent = (void __user *)dirent + reclen;
+	buf->current_dir = dirent;
+	buf->count -= reclen;
+	return 0;
+efault:
+	buf->error = -EFAULT;
+	return -EFAULT;
+}
+
+asmlinkage long compat_sys_getdents(unsigned int fd, struct compat_linux_dirent __user * dirent, unsigned int count)
+{
+	struct file * file;
+	struct compat_linux_dirent __user * lastdirent;
+	struct compat_getdents_callback buf;
+	int error;
+
+	error = -EFAULT;
+	if (!access_ok(VERIFY_WRITE, dirent, count))
+		goto out;
+
+	error = -EBADF;
+	file = fget(fd);
+	if (!file)
+		goto out;
+
+	buf.current_dir = dirent;
+	buf.previous = NULL;
+	buf.count = count;
+	buf.error = 0;
+
+	error = vfs_readdir(file, compat_filldir, &buf);
+	if (error < 0)
+		goto out_putf;
+	error = buf.error;
+	lastdirent = buf.previous;
+	if (lastdirent) {
+		if (put_user(file->f_pos, &lastdirent->d_off))
+			error = -EFAULT;
+		else
+			error = count - buf.count;
+	}
+
+out_putf:
+	fput(file);
+out:
+	return error;
+}
+
+#ifndef __ARCH_OMIT_COMPAT_SYS_GETDENTS64
+#define COMPAT_ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
+
+struct compat_getdents_callback64 {
+	struct linux_dirent64 __user * current_dir;
+	struct linux_dirent64 __user * previous;
+	int count;
+	int error;
+};
+
+static int compat_filldir64(void * __buf, const char * name, int namlen, loff_t offset,
+		     ino_t ino, unsigned int d_type)
+{
+	struct linux_dirent64 __user *dirent;
+	struct compat_getdents_callback64 * buf = (struct compat_getdents_callback64 *) __buf;
+	int reclen = COMPAT_ROUND_UP64(NAME_OFFSET(dirent) + namlen + 1);
+	u64 off;
+
+	buf->error = -EINVAL;	/* only used if we fail.. */
+	if (reclen > buf->count)
+		return -EINVAL;
+	dirent = buf->previous;
+	if (dirent) {
+		if (__put_user(offset, &dirent->d_off))
+			goto efault;
+	}
+	dirent = buf->current_dir;
+	if (__copy_to_user(&dirent->d_ino, &ino, sizeof(ino)))
+		goto efault;
+	off = 0;
+	if (__copy_to_user(&dirent->d_off, &off, sizeof(off)))
+		goto efault;
+	if (__put_user(reclen, &dirent->d_reclen))
+		goto efault;
+	if (__put_user(d_type, &dirent->d_type))
+		goto efault;
+	if (copy_to_user(dirent->d_name, name, namlen))
+		goto efault;
+	if (__put_user(0, dirent->d_name + namlen))
+		goto efault;
+	buf->previous = dirent;
+	dirent = (void __user *)dirent + reclen;
+	buf->current_dir = dirent;
+	buf->count -= reclen;
+	return 0;
+efault:
+	buf->error = -EFAULT;
+	return -EFAULT;
+}
+
+asmlinkage long compat_sys_getdents64(unsigned int fd, struct linux_dirent64 __user * dirent, unsigned int count)
+{
+	struct file * file;
+	struct linux_dirent64 __user * lastdirent;
+	struct compat_getdents_callback64 buf;
+	int error;
+
+	error = -EFAULT;
+	if (!access_ok(VERIFY_WRITE, dirent, count))
+		goto out;
+
+	error = -EBADF;
+	file = fget(fd);
+	if (!file)
+		goto out;
+
+	buf.current_dir = dirent;
+	buf.previous = NULL;
+	buf.count = count;
+	buf.error = 0;
+
+	error = vfs_readdir(file, compat_filldir64, &buf);
+	if (error < 0)
+		goto out_putf;
+	error = buf.error;
+	lastdirent = buf.previous;
+	if (lastdirent) {
+		typeof(lastdirent->d_off) d_off = file->f_pos;
+		__put_user(d_off, &lastdirent->d_off);
+		error = count - buf.count;
+	}
+
+out_putf:
+	fput(file);
+out:
+	return error;
+}
+#endif /* ! __ARCH_OMIT_COMPAT_SYS_GETDENTS64 */


------_=_NextPart_108508699040ad1d0eba5381.88033699--
