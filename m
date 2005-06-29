Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 29 Jun 2005 16:41:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: RFC: is_compat_task
Message-Id: <20050629164127.58e97376.sfr@canb.auug.org.au>
In-Reply-To: <20050628.134736.45885284.davem@davemloft.net>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
	<20050628.134736.45885284.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__29_Jun_2005_16_41_27_+1000_FqDzN.cblS6YPegk"
To: "David S. Miller" <davem@davemloft.net>
Cc: matthew@wil.cx, ak@suse.de, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__29_Jun_2005_16_41_27_+1000_FqDzN.cblS6YPegk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jun 2005 13:47:36 -0700 (PDT) "David S. Miller" <davem@davemloft=
.net> wrote:
>
> Why don't we do the following to resolve this issue?
> Create a "is_compat_syscall()" macro, in compat syscall
> trap entry, the bit is set, and it is cleared otherwise.
>=20
> It nops out to always evaluate to "0" on non-compat platforms.

How about the patch below which defines is_compat_syscall() for ppc64 (and
all the non-compat-requiring archs)?  (Yes, the ppc64 syscall entry really
checks the thread flag.) The patch alos includes the fixes for the input
layer mess.

If this is acceptable, I will try to figure out what the macro should be
for the other 64 bit architectures.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/drivers/input/evdev.c linus-compat_syscall.2/drivers/input/=
evdev.c
--- linus/drivers/input/evdev.c	2005-06-28 10:05:26.000000000 +1000
+++ linus-compat_syscall.2/drivers/input/evdev.c	2005-06-29 16:00:58.000000=
000 +1000
@@ -154,16 +154,6 @@
 	__s32 value;
 };
=20
-#ifdef CONFIG_X86_64
-#  define COMPAT_TEST test_thread_flag(TIF_IA32)
-#elif defined(CONFIG_IA64)
-#  define COMPAT_TEST IS_IA32_PROCESS(ia64_task_regs(current))
-#elif defined(CONFIG_ARCH_S390)
-#  define COMPAT_TEST test_thread_flag(TIF_31BIT)
-#else
-#  define COMPAT_TEST test_thread_flag(TIF_32BIT)
-#endif
-
 static ssize_t evdev_write_compat(struct file * file, const char __user * =
buffer, size_t count, loff_t *ppos)
 {
 	struct evdev_list *list =3D file->private_data;
@@ -179,6 +169,9 @@
=20
 	return retval;
 }
+#else
+/* prototype to keep gcc quiet */
+ssize_t evdev_write_compat(struct file * file, const char __user * buffer,=
 size_t count, loff_t *ppos);
 #endif
=20
 static ssize_t evdev_write(struct file * file, const char __user * buffer,=
 size_t count, loff_t *ppos)
@@ -189,10 +182,8 @@
=20
 	if (!list->evdev->exist) return -ENODEV;
=20
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
+	if (is_compat_syscall())
 		return evdev_write_compat(file, buffer, count, ppos);
-#endif
=20
 	while (retval < count) {
=20
@@ -243,6 +234,9 @@
=20
 	return retval;
 }
+#else
+/* prototype to keep gcc quiet */
+ssize_t evdev_read_compat(struct file * file, char __user * buffer, size_t=
 count, loff_t *ppos);
 #endif
=20
 static ssize_t evdev_read(struct file * file, char __user * buffer, size_t=
 count, loff_t *ppos)
@@ -250,10 +244,8 @@
 	struct evdev_list *list =3D file->private_data;
 	int retval;
=20
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
+	if (is_compat_syscall())
 		return evdev_read_compat(file, buffer, count, ppos);
-#endif
=20
 	if (count < sizeof(struct input_event))
 		return -EINVAL;
@@ -484,34 +476,18 @@
=20
 #ifdef CONFIG_COMPAT
=20
-#define BITS_PER_LONG_COMPAT (sizeof(compat_long_t) * 8)
-#define NBITS_COMPAT(x) ((((x)-1)/BITS_PER_LONG_COMPAT)+1)
-#define OFF_COMPAT(x)  ((x)%BITS_PER_LONG_COMPAT)
+#define NBITS_COMPAT(x) ((((x)-1)/BITS_PER_COMPAT_LONG)+1)
+#define OFF_COMPAT(x)  ((x)%BITS_PER_COMPAT_LONG)
 #define BIT_COMPAT(x)  (1UL<<OFF_COMPAT(x))
-#define LONG_COMPAT(x) ((x)/BITS_PER_LONG_COMPAT)
+#define LONG_COMPAT(x) ((x)/BITS_PER_COMPAT_LONG)
 #define test_bit_compat(bit, array) ((array[LONG_COMPAT(bit)] >> OFF_COMPA=
T(bit)) & 1)
=20
-#ifdef __BIG_ENDIAN
 #define bit_to_user(bit, max) \
 do { \
-	int i; \
 	int len =3D NBITS_COMPAT((max)) * sizeof(compat_long_t); \
 	if (len > _IOC_SIZE(cmd)) len =3D _IOC_SIZE(cmd); \
-	for (i =3D 0; i < len / sizeof(compat_long_t); i++) \
-		if (copy_to_user((compat_long_t*) p + i, \
-				 (compat_long_t*) (bit) + i + 1 - ((i % 2) << 1), \
-				 sizeof(compat_long_t))) \
-			return -EFAULT; \
-	return len; \
+	return compat_put_bitmap(p, (bit), len * 8) ? -EFAULT : len; \
 } while (0)
-#else
-#define bit_to_user(bit, max) \
-do { \
-	int len =3D NBITS_COMPAT((max)) * sizeof(compat_long_t); \
-	if (len > _IOC_SIZE(cmd)) len =3D _IOC_SIZE(cmd); \
-	return copy_to_user(p, (bit), len) ? -EFAULT : len; \
-} while (0)
-#endif
=20
 static long evdev_ioctl_compat(struct file *file, unsigned int cmd, unsign=
ed long arg)
 {
@@ -631,6 +607,8 @@
 	}
 	return -EINVAL;
 }
+#else
+#define evdev_ioctl_compat	NULL
 #endif
=20
 static struct file_operations evdev_fops =3D {
@@ -641,9 +619,7 @@
 	.open =3D		evdev_open,
 	.release =3D	evdev_release,
 	.unlocked_ioctl =3D evdev_ioctl,
-#ifdef CONFIG_COMPAT
 	.compat_ioctl =3D	evdev_ioctl_compat,
-#endif
 	.fasync =3D	evdev_fasync,
 	.flush =3D	evdev_flush
 };
diff -ruN linus/include/asm-ppc64/compat.h linus-compat_syscall.2/include/a=
sm-ppc64/compat.h
--- linus/include/asm-ppc64/compat.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-compat_syscall.2/include/asm-ppc64/compat.h	2005-06-29 15:15:27.0=
00000000 +1000
@@ -200,4 +200,6 @@
 	compat_ulong_t __unused6;
 };
=20
+#define is_compat_syscall()	test_tsk_thread_flag(current, TIF_32BIT)
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN linus/include/linux/compat.h linus-compat_syscall.2/include/linux=
/compat.h
--- linus/include/linux/compat.h	2005-06-27 16:08:11.000000000 +1000
+++ linus-compat_syscall.2/include/linux/compat.h	2005-06-29 16:38:46.00000=
0000 +1000
@@ -158,5 +158,15 @@
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
=20
+#else /* CONFIG_COMPAT */
+
+/*
+ * The is_compat_syscall() macro returns true if the current syscall
+ * was done through the comaptibility ABI.  We define it to be zero on
+ * platforms without a compatibility ABI so that the compiler can remove
+ * compatibility code from those platforms.
+ */
+#define is_compat_syscall()	0
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */

--Signature=_Wed__29_Jun_2005_16_41_27_+1000_FqDzN.cblS6YPegk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCwkKdFdBgD/zoJvwRApC/AJ4pRe9Og9ZmoLQuwjgnNGJI/Xx3zwCfTkVh
ZBM4l85WG/fJbtpCs3iq3n8=
=sJNG
-----END PGP SIGNATURE-----

--Signature=_Wed__29_Jun_2005_16_41_27_+1000_FqDzN.cblS6YPegk--
