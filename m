Return-Path: <arun.sharma@intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:1181 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S265063AbUFGVNM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2004 17:13:12 -0400
Message-ID: <40C4DA5E.8090700@intel.com>
Date: Mon, 07 Jun 2004 14:13:02 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: sys getdents64 needs compat wrapper ?
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de>	<40C110C9.2060900@intel.com> <20040604172816.259f38e8.davem@redhat.com>
In-Reply-To: <20040604172816.259f38e8.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060505010501000501040504"
To: "David S. Miller" <davem@redhat.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060505010501000501040504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2004 5:28 PM, David S. Miller wrote:

> Some bug fixes needed:
> 
> +#define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
> 
> Cast must be "(char __user *)" to avoid sparse warnings.

This updated patch takes care of the __user problems that Dave pointed out. Regarding __put_user vs __copy_to_user, __put_user is more optimal on ia64 like Andrew already noted. I realize it's not optimal on all platforms. So I suggest that we apply the patch for now and try to build something that's optimal for all platforms in the future.

	-Arun


--------------060505010501000501040504
Content-Type: text/plain;
 name="readdir_ive.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="readdir_ive.3.patch"

Running /emul/ia32-linux/bin/ls on 2.6.6 produces kernel mode unaligned
faults.  Analysis shows it's caused by getdents64 system call.

Signed-off-by: Arun Sharma <arun.sharma@intel.com>
Signed-off-by: Gordon Jin <gordon.jin@intel.com>
Original patch by: Arnd Bergmann <arnd@arndb.de>

diff -Nurap a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
--- a/arch/ia64/ia32/ia32_entry.S	2004-05-10 10:32:38.000000000 +0800
+++ b/arch/ia64/ia32/ia32_entry.S	2004-06-07 17:42:56.151928752 +0800
@@ -349,7 +349,7 @@ ia32_syscall_table:
 	data8 sys_setfsuid	/* 16-bit version */
 	data8 sys_setfsgid	/* 16-bit version */
 	data8 sys_llseek	  /* 140 */
-	data8 sys32_getdents
+	data8 compat_sys_getdents
 	data8 sys32_select
 	data8 sys_flock
 	data8 sys32_msync
@@ -428,7 +428,7 @@ ia32_syscall_table:
 	data8 sys_pivot_root
 	data8 sys_mincore
 	data8 sys_madvise
-	data8 sys_getdents64	  /* 220 */
+	data8 compat_sys_getdents64	  /* 220 */
 	data8 compat_sys_fcntl64
 	data8 sys_ni_syscall		/* reserved for TUX */
 	data8 sys_ni_syscall		/* reserved for Security */
diff -Nurap a/fs/compat.c b/fs/compat.c
--- a/fs/compat.c	2004-05-10 10:32:29.000000000 +0800
+++ b/fs/compat.c	2004-06-07 17:43:23.478100292 +0800
@@ -34,6 +34,7 @@
 #include <linux/syscalls.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/dirent.h>
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
 #include <asm/uaccess.h>
@@ -794,3 +795,252 @@ asmlinkage int compat_sys_mount(char __u
 	return retval;
 }
 
+#define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
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
+	if (__put_user(d_type, (char  __user *) dirent + reclen - 1))
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
+	int jj = NAME_OFFSET(dirent);
+	int reclen = COMPAT_ROUND_UP64(jj + namlen + 1);
+	u64 off;
+
+	buf->error = -EINVAL;	/* only used if we fail.. */
+	if (reclen > buf->count)
+		return -EINVAL;
+	dirent = buf->previous;
+
+	if (dirent) {
+		if ((__put_user(offset, (u32 __user *)&dirent->d_off))
+		 || (__put_user(offset >> 32, ((u32 __user *)&dirent->d_off) + 1)))
+			goto efault;
+	}
+	dirent = buf->current_dir;
+	if ((__put_user(ino, (u32 __user *)&dirent->d_ino))
+	 || (__put_user(ino >> 32, ((u32 __user *)&dirent->d_ino) + 1)))
+		goto efault;
+	off = 0;
+	if ((__put_user(off, (u32 __user *)&dirent->d_off))
+	 || (__put_user(off >> 32, ((u32 __user *)&dirent->d_off) + 1)))
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
+		__put_user(d_off, (u32 __user *)&lastdirent->d_off);
+		__put_user(d_off >> 32, ((u32 __user *)&lastdirent->d_off) + 1);
+		error = count - buf.count;
+	}
+
+out_putf:
+	fput(file);
+out:
+	return error;
+}
+#endif /* ! __ARCH_OMIT_COMPAT_SYS_GETDENTS64 */
+

--------------060505010501000501040504--
