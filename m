Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 30 Jun 2005 17:57:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: RFC: is_compat_task
Message-Id: <20050630175741.0fba8049.sfr@canb.auug.org.au>
In-Reply-To: <20050629121228.GH21575@bragg.suse.de>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
	<20050628.134736.45885284.davem@davemloft.net>
	<20050629164127.58e97376.sfr@canb.auug.org.au>
	<20050629121228.GH21575@bragg.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__30_Jun_2005_17_57_41_+1000_YrqwMLNP5Sag=PQx"
To: Andi Kleen <ak@suse.de>
Cc: davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Thu__30_Jun_2005_17_57_41_+1000_YrqwMLNP5Sag=PQx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jun 2005 14:12:28 +0200 Andi Kleen <ak@suse.de> wrote:
>
> I think for the particular input case it would be still better
> to just define ->compat_write at the VFS level.
>=20
> This would require a new compat_sys_write() wrapper, but that would
> be straight forward.

You mean something like this?

diff -ruN linus/fs/compat.c linus-compat_write.1/fs/compat.c
--- linus/fs/compat.c	2005-06-27 16:08:02.000000000 +1000
+++ linus-compat_write.1/fs/compat.c	2005-06-30 17:48:35.000000000 +1000
@@ -51,6 +51,12 @@
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
=20
+asmlinkage ssize_t compat_sys_write(unsigned int fd, const char __user * b=
uf,
+		compat_size_t count)
+{
+	return do_sys_write(fd, buf, count, 1);
+}
+
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
diff -ruN linus/fs/read_write.c linus-compat_write.1/fs/read_write.c
--- linus/fs/read_write.c	2005-06-27 16:08:05.000000000 +1000
+++ linus-compat_write.1/fs/read_write.c	2005-06-30 17:44:46.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
=20
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -283,13 +284,15 @@
=20
 EXPORT_SYMBOL(do_sync_write);
=20
-ssize_t vfs_write(struct file *file, const char __user *buf, size_t count,=
 loff_t *pos)
+static ssize_t do_vfs_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *pos, int compat)
 {
 	ssize_t ret;
=20
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->write && !file->f_op->aio_write))
+	if (!file->f_op || (!file->f_op->write && !file->f_op->aio_write &&
+			!is_compat_write(compat, file->f_op->compat_write)))
 		return -EINVAL;
 	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
 		return -EFAULT;
@@ -298,7 +301,10 @@
 	if (!ret) {
 		ret =3D security_file_permission (file, MAY_WRITE);
 		if (!ret) {
-			if (file->f_op->write)
+			if (is_compat_write(compat, file->f_op->compat_write))
+				ret =3D file->f_op->compat_write(file, buf,
+						count, pos);
+			else if (file->f_op->write)
 				ret =3D file->f_op->write(file, buf, count, pos);
 			else
 				ret =3D do_sync_write(file, buf, count, pos);
@@ -313,6 +319,12 @@
 	return ret;
 }
=20
+ssize_t vfs_write(struct file *file, const char __user *buf, size_t count,
+		loff_t *pos)
+{
+	return do_vfs_write(file, buf, count, pos, 0);
+}
+
 EXPORT_SYMBOL(vfs_write);
=20
 static inline loff_t file_pos_read(struct file *file)
@@ -343,7 +355,8 @@
 }
 EXPORT_SYMBOL_GPL(sys_read);
=20
-asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf, siz=
e_t count)
+ssize_t do_sys_write(unsigned int fd, const char __user * buf, size_t coun=
t,
+		int compat)
 {
 	struct file *file;
 	ssize_t ret =3D -EBADF;
@@ -352,7 +365,7 @@
 	file =3D fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos =3D file_pos_read(file);
-		ret =3D vfs_write(file, buf, count, &pos);
+		ret =3D do_vfs_write(file, buf, count, &pos, compat);
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
 	}
@@ -360,6 +373,12 @@
 	return ret;
 }
=20
+asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf,
+		size_t count)
+{
+	return do_sys_write(fd, buf, count, 0);
+}
+
 asmlinkage ssize_t sys_pread64(unsigned int fd, char __user *buf,
 			     size_t count, loff_t pos)
 {
diff -ruN linus/include/linux/compat.h linus-compat_write.1/include/linux/c=
ompat.h
--- linus/include/linux/compat.h	2005-06-27 16:08:11.000000000 +1000
+++ linus-compat_write.1/include/linux/compat.h	2005-06-30 17:52:59.0000000=
00 +1000
@@ -158,5 +158,11 @@
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
=20
+#define is_compat_write(flag, func)	((flag) && (NULL !=3D func))
+
+#else /* CONFIG_COMPAT */
+
+#define is_compat_write(flag, func)	0
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -ruN linus/include/linux/fs.h linus-compat_write.1/include/linux/fs.h
--- linus/include/linux/fs.h	2005-06-28 10:05:27.000000000 +1000
+++ linus-compat_write.1/include/linux/fs.h	2005-06-30 17:50:59.000000000 +=
1000
@@ -951,6 +951,7 @@
 	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, loff_t=
);
+	ssize_t (*compat_write) (struct file *, const char __user *, size_t, loff=
_t *);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1498,6 +1499,8 @@
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t le=
n, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, si=
ze_t len, loff_t *ppos);
+extern ssize_t do_sys_write(unsigned int fd, const char __user * buf,
+		size_t count, int compat);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *i=
ov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read=
_actor_t, void *);

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__30_Jun_2005_17_57_41_+1000_YrqwMLNP5Sag=PQx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCw6X1FdBgD/zoJvwRAoNyAJwKZsOpJiTs3eUWCT2qfnwFvN26IgCgis6i
7e5SeAbyBgQOiMTq7Gp09Mc=
=EpYS
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Jun_2005_17_57_41_+1000_YrqwMLNP5Sag=PQx--
