Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 1 Jul 2005 15:01:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH, for review 3/3] fix evdev
Message-Id: <20050701150139.4ff1b467.sfr@canb.auug.org.au>
In-Reply-To: <20050701145642.6a3d6542.sfr@canb.auug.org.au>
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
	<20050701145642.6a3d6542.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__1_Jul_2005_15_01_39_+1000_leX4=MaEU4fy1rDD"
To: Andi Kleen <ak@suse.de>
Cc: davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Fri__1_Jul_2005_15_01_39_+1000_leX4=MaEU4fy1rDD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is drivers/input/evdev.c fixed to use the new infrastructure and the e=
xisting compat bitmap copying routine.
---
 evdev.c |   54 ++++++++++++------------------------------------------
 1 files changed, 12 insertions(+), 42 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-compat_write.4/drivers/input/evdev.c linus-compat_write.5/d=
rivers/input/evdev.c
--- linus-compat_write.4/drivers/input/evdev.c	2005-06-28 10:05:26.00000000=
0 +1000
+++ linus-compat_write.5/drivers/input/evdev.c	2005-07-01 00:51:37.00000000=
0 +1000
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
@@ -179,6 +169,8 @@
=20
 	return retval;
 }
+#else
+#define evdev_write_compat	NULL
 #endif
=20
 static ssize_t evdev_write(struct file * file, const char __user * buffer,=
 size_t count, loff_t *ppos)
@@ -189,11 +181,6 @@
=20
 	if (!list->evdev->exist) return -ENODEV;
=20
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
-		return evdev_write_compat(file, buffer, count, ppos);
-#endif
-
 	while (retval < count) {
=20
 		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event)))
@@ -243,6 +230,8 @@
=20
 	return retval;
 }
+#else
+#define evdev_read_compat	NULL
 #endif
=20
 static ssize_t evdev_read(struct file * file, char __user * buffer, size_t=
 count, loff_t *ppos)
@@ -250,11 +239,6 @@
 	struct evdev_list *list =3D file->private_data;
 	int retval;
=20
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
-		return evdev_read_compat(file, buffer, count, ppos);
-#endif
-
 	if (count < sizeof(struct input_event))
 		return -EINVAL;
=20
@@ -484,34 +468,18 @@
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
@@ -631,19 +599,21 @@
 	}
 	return -EINVAL;
 }
+#else
+#define evdev_ioctl_compat	NULL
 #endif
=20
 static struct file_operations evdev_fops =3D {
 	.owner =3D	THIS_MODULE,
 	.read =3D		evdev_read,
+	.compat_read =3D	evdev_read_compat,
 	.write =3D	evdev_write,
+	.compat_write =3D	evdev_write_compat,
 	.poll =3D		evdev_poll,
 	.open =3D		evdev_open,
 	.release =3D	evdev_release,
 	.unlocked_ioctl =3D evdev_ioctl,
-#ifdef CONFIG_COMPAT
 	.compat_ioctl =3D	evdev_ioctl_compat,
-#endif
 	.fasync =3D	evdev_fasync,
 	.flush =3D	evdev_flush
 };

--Signature=_Fri__1_Jul_2005_15_01_39_+1000_leX4=MaEU4fy1rDD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxM4zFdBgD/zoJvwRAraiAJ4q/bhzifPUIFkKUb1VzNVobXhINACgiIf4
K4rD5QYUBpOGDvf4GPMaOns=
=Dtnd
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Jul_2005_15_01_39_+1000_leX4=MaEU4fy1rDD--
