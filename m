Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	by smtps.tip.net.au (Postfix) with ESMTP id 56928368426
	for <linux-arch@vger.kernel.org>; Wed, 23 Mar 2005 17:48:13 +1100 (EST)
Date: Wed, 23 Mar 2005 17:48:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] consolidate shmat usage
Message-Id: <20050323174810.17df4440.sfr@canb.auug.org.au>
In-Reply-To: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Mar_2005_17_48_10_+1100_3OpGRL7mGP9qMR64"
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__23_Mar_2005_17_48_10_+1100_3OpGRL7mGP9qMR64
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch creates sys_shmat and sys_smhatcall and uses them wherever possi=
ble - this tidies up sys_ipc a bit in most cases.  I have not touched um ar=
ch.

I am eventually aiming at consolidating (as much as possible of) sys_ipc
and doing compat_sys_ipc.

I suspetc the conditional compilation of sys_shmat{,call} is a bit much
and have no problem with removing the conditionals.

It builds on ppc64 and ppc.

diffstat looks like this:
 arch/alpha/Kconfig              |    3 +++
 arch/alpha/kernel/osf_sys.c     |   11 +----------
 arch/arm/Kconfig                |    3 +++
 arch/arm/kernel/sys_arm.c       |   22 +++-------------------
 arch/arm26/Kconfig              |    3 +++
 arch/arm26/kernel/sys_arm.c     |   10 +++-------
 arch/cris/Kconfig               |    3 +++
 arch/cris/kernel/sys_cris.c     |   10 +++-------
 arch/frv/Kconfig                |    3 +++
 arch/frv/kernel/sys_frv.c       |   10 +++-------
 arch/h8300/Kconfig              |    3 +++
 arch/h8300/kernel/sys_h8300.c   |   12 ++----------
 arch/i386/Kconfig               |    3 +++
 arch/i386/kernel/sys_i386.c     |   10 +++-------
 arch/m32r/Kconfig               |    3 +++
 arch/m32r/kernel/sys_m32r.c     |   14 +++-----------
 arch/m68k/Kconfig               |    3 +++
 arch/m68k/kernel/sys_m68k.c     |   12 ++----------
 arch/mips/Kconfig               |    3 +++
 arch/mips/kernel/syscall.c      |   26 +++-----------------------
 arch/parisc/Kconfig             |    3 +++
 arch/parisc/kernel/sys_parisc.c |    8 +-------
 arch/ppc/Kconfig                |    3 +++
 arch/ppc/kernel/syscalls.c      |   14 +++-----------
 arch/ppc64/Kconfig              |    3 +++
 arch/ppc64/kernel/syscalls.c    |   11 +++--------
 arch/s390/Kconfig               |    3 +++
 arch/s390/kernel/sys_s390.c     |   12 +++---------
 arch/sh/Kconfig                 |    3 +++
 arch/sh/kernel/sys_sh.c         |   11 +++--------
 arch/sh64/Kconfig               |    6 ++++++
 arch/sh64/kernel/sys_sh64.c     |   26 +++-----------------------
 arch/sparc/Kconfig              |    3 +++
 arch/sparc/kernel/sys_sparc.c   |   13 +++----------
 arch/sparc64/Kconfig            |    3 +++
 arch/sparc64/kernel/sys_sparc.c |   11 +++--------
 arch/v850/Kconfig               |    2 ++
 arch/v850/kernel/syscalls.c     |   14 +++-----------
 arch/x86_64/Kconfig             |    3 +++
 arch/x86_64/kernel/sys_x86_64.c |    3 +--
 include/linux/syscalls.h        |    1 +
 ipc/shm.c                       |   35 +++++++++++++++++++++++++++++++++++
 42 files changed, 150 insertions(+), 208 deletions(-)

Comments?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-compat_sys_ipc.1/arch/alpha/Kconfig linus-compat_sys_ipc.2/=
arch/alpha/Kconfig
--- linus-compat_sys_ipc.1/arch/alpha/Kconfig	2005-01-09 10:05:38.000000000=
 +1100
+++ linus-compat_sys_ipc.2/arch/alpha/Kconfig	2005-03-23 17:12:34.000000000=
 +1100
@@ -21,6 +21,9 @@
 config UID16
 	bool
=20
+config SYS_SHMATCALL
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
=20
diff -ruN linus-compat_sys_ipc.1/arch/alpha/kernel/osf_sys.c linus-compat_s=
ys_ipc.2/arch/alpha/kernel/osf_sys.c
--- linus-compat_sys_ipc.1/arch/alpha/kernel/osf_sys.c	2005-03-14 13:07:08.=
000000000 +1100
+++ linus-compat_sys_ipc.2/arch/alpha/kernel/osf_sys.c	2005-03-23 16:16:25.=
000000000 +1100
@@ -460,16 +460,7 @@
 asmlinkage long
 osf_shmat(int shmid, void __user *shmaddr, int shmflg)
 {
-	unsigned long raddr;
-	long err;
-
-	err =3D do_shmat(shmid, shmaddr, shmflg, &raddr);
-
-	/*
-	 * This works because all user-level addresses are
-	 * non-negative longs!
-	 */
-	return err ? err : (long)raddr;
+	return sys_shmatcall(shmid, shmaddr, shmflg);
 }
=20
=20
diff -ruN linus-compat_sys_ipc.1/arch/arm/Kconfig linus-compat_sys_ipc.2/ar=
ch/arm/Kconfig
--- linus-compat_sys_ipc.1/arch/arm/Kconfig	2005-03-05 12:06:14.000000000 +=
1100
+++ linus-compat_sys_ipc.2/arch/arm/Kconfig	2005-03-23 17:12:45.000000000 +=
1100
@@ -50,6 +50,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/arm/kernel/sys_arm.c linus-compat_sys=
_ipc.2/arch/arm/kernel/sys_arm.c
--- linus-compat_sys_ipc.1/arch/arm/kernel/sys_arm.c	2005-03-17 14:08:05.00=
0000000 +1100
+++ linus-compat_sys_ipc.2/arch/arm/kernel/sys_arm.c	2005-03-23 16:22:00.00=
0000000 +1100
@@ -212,13 +212,9 @@
=20
 	case SHMAT:
 		switch (version) {
-		default: {
-			ulong raddr;
-			ret =3D do_shmat(first, (char __user *)ptr, second, &raddr);
-			if (ret)
-				return ret;
-			return put_user(raddr, (ulong __user *)third);
-		}
+		default:
+			return sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1: /* Of course, we don't support iBCS2! */
 			return -EINVAL;
 		}
@@ -234,18 +230,6 @@
 	}
 }
=20
-asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg,
-			  unsigned long __user *addr)
-{
-	unsigned long ret;
-	long err;
-
-	err =3D do_shmat(shmid, shmaddr, shmflg, &ret);
-	if (err =3D=3D 0)
-		err =3D put_user(ret, addr);
-	return err;
-}
-
 /* Fork a new task - this creates a new program thread.
  * This is called indirectly via a small wrapper
  */
diff -ruN linus-compat_sys_ipc.1/arch/arm26/Kconfig linus-compat_sys_ipc.2/=
arch/arm26/Kconfig
--- linus-compat_sys_ipc.1/arch/arm26/Kconfig	2005-01-16 11:05:29.000000000=
 +1100
+++ linus-compat_sys_ipc.2/arch/arm26/Kconfig	2005-03-23 17:12:54.000000000=
 +1100
@@ -38,6 +38,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/arm26/kernel/sys_arm.c linus-compat_s=
ys_ipc.2/arch/arm26/kernel/sys_arm.c
--- linus-compat_sys_ipc.1/arch/arm26/kernel/sys_arm.c	2005-01-04 17:05:27.=
000000000 +1100
+++ linus-compat_sys_ipc.2/arch/arm26/kernel/sys_arm.c	2005-03-23 16:25:43.=
000000000 +1100
@@ -210,13 +210,9 @@
=20
 	case SHMAT:
 		switch (version) {
-		default: {
-			ulong raddr;
-			ret =3D do_shmat (first, (char *) ptr, second, &raddr);
-			if (ret)
-				return ret;
-			return put_user (raddr, (ulong *) third);
-		}
+		default:
+			return sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
diff -ruN linus-compat_sys_ipc.1/arch/cris/Kconfig linus-compat_sys_ipc.2/a=
rch/cris/Kconfig
--- linus-compat_sys_ipc.1/arch/cris/Kconfig	2005-01-05 17:06:06.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/cris/Kconfig	2005-03-23 17:13:10.000000000 =
+1100
@@ -13,6 +13,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/cris/kernel/sys_cris.c linus-compat_s=
ys_ipc.2/arch/cris/kernel/sys_cris.c
--- linus-compat_sys_ipc.1/arch/cris/kernel/sys_cris.c	2004-06-04 07:19:00.=
000000000 +1000
+++ linus-compat_sys_ipc.2/arch/cris/kernel/sys_cris.c	2005-03-23 16:28:01.=
000000000 +1100
@@ -154,13 +154,9 @@
 	case MSGCTL:
 		return sys_msgctl (first, second, (struct msqid_ds __user *) ptr);
=20
-	case SHMAT: {
-                ulong raddr;
-                ret =3D do_shmat (first, (char __user *) ptr, second, &rad=
dr);
-                if (ret)
-                        return ret;
-                return put_user (raddr, (ulong __user *) third);
-        }
+	case SHMAT:
+		return sys_shmat(first, ptr, second,
+				(unsigned long __user *)third);
 	case SHMDT:=20
 		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
diff -ruN linus-compat_sys_ipc.1/arch/frv/Kconfig linus-compat_sys_ipc.2/ar=
ch/frv/Kconfig
--- linus-compat_sys_ipc.1/arch/frv/Kconfig	2005-01-05 13:48:10.000000000 +=
1100
+++ linus-compat_sys_ipc.2/arch/frv/Kconfig	2005-03-23 17:11:16.000000000 +=
1100
@@ -10,6 +10,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/frv/kernel/sys_frv.c linus-compat_sys=
_ipc.2/arch/frv/kernel/sys_frv.c
--- linus-compat_sys_ipc.1/arch/frv/kernel/sys_frv.c	2005-01-06 12:05:05.00=
0000000 +1100
+++ linus-compat_sys_ipc.2/arch/frv/kernel/sys_frv.c	2005-03-23 17:10:43.00=
0000000 +1100
@@ -188,13 +188,9 @@
=20
 	case SHMAT:
 		switch (version) {
-		default: {
-			ulong raddr;
-			ret =3D do_shmat (first, (char __user *) ptr, second, &raddr);
-			if (ret)
-				return ret;
-			return put_user (raddr, (ulong __user *) third);
-		}
+		default:
+			return sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
diff -ruN linus-compat_sys_ipc.1/arch/h8300/Kconfig linus-compat_sys_ipc.2/=
arch/h8300/Kconfig
--- linus-compat_sys_ipc.1/arch/h8300/Kconfig	2005-01-05 17:06:06.000000000=
 +1100
+++ linus-compat_sys_ipc.2/arch/h8300/Kconfig	2005-03-23 17:13:31.000000000=
 +1100
@@ -25,6 +25,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/h8300/kernel/sys_h8300.c linus-compat=
_sys_ipc.2/arch/h8300/kernel/sys_h8300.c
--- linus-compat_sys_ipc.1/arch/h8300/kernel/sys_h8300.c	2004-03-16 08:12:1=
7.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/h8300/kernel/sys_h8300.c	2005-03-23 16:30:2=
3.000000000 +1100
@@ -236,16 +236,8 @@
 	if (call <=3D SHMCTL)=20
 		switch (call) {
 		case SHMAT:
-			switch (version) {
-			default: {
-				ulong raddr;
-				ret =3D do_shmat (first, (char *) ptr,
-						 second, &raddr);
-				if (ret)
-					return ret;
-				return put_user (raddr, (ulong *) third);
-			}
-			}
+			return sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 		case SHMDT:=20
 			return sys_shmdt ((char *)ptr);
 		case SHMGET:
diff -ruN linus-compat_sys_ipc.1/arch/i386/Kconfig linus-compat_sys_ipc.2/a=
rch/i386/Kconfig
--- linus-compat_sys_ipc.1/arch/i386/Kconfig	2005-03-14 13:07:08.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/i386/Kconfig	2005-03-23 17:13:49.000000000 =
+1100
@@ -25,6 +25,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config GENERIC_ISA_DMA
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/i386/kernel/sys_i386.c linus-compat_s=
ys_ipc.2/arch/i386/kernel/sys_i386.c
--- linus-compat_sys_ipc.1/arch/i386/kernel/sys_i386.c	2004-07-26 05:20:35.=
000000000 +1000
+++ linus-compat_sys_ipc.2/arch/i386/kernel/sys_i386.c	2005-03-23 16:32:42.=
000000000 +1100
@@ -183,13 +183,9 @@
=20
 	case SHMAT:
 		switch (version) {
-		default: {
-			ulong raddr;
-			ret =3D do_shmat (first, (char __user *) ptr, second, &raddr);
-			if (ret)
-				return ret;
-			return put_user (raddr, (ulong __user *) third);
-		}
+		default:
+			return sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
diff -ruN linus-compat_sys_ipc.1/arch/m32r/Kconfig linus-compat_sys_ipc.2/a=
rch/m32r/Kconfig
--- linus-compat_sys_ipc.1/arch/m32r/Kconfig	2005-01-12 06:07:52.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/m32r/Kconfig	2005-03-23 17:09:57.000000000 =
+1100
@@ -16,6 +16,9 @@
 	bool
 	default n
=20
+config SYS_SHMAT
+	def_bool y
+
 config GENERIC_ISA_DMA
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/m32r/kernel/sys_m32r.c linus-compat_s=
ys_ipc.2/arch/m32r/kernel/sys_m32r.c
--- linus-compat_sys_ipc.1/arch/m32r/kernel/sys_m32r.c	2005-03-14 13:07:08.=
000000000 +1100
+++ linus-compat_sys_ipc.2/arch/m32r/kernel/sys_m32r.c	2005-03-23 17:09:15.=
000000000 +1100
@@ -168,17 +168,9 @@
 	case MSGCTL:
 		return sys_msgctl (first, second,
 				   (struct msqid_ds __user *) ptr);
-	case SHMAT: {
-		ulong raddr;
-
-		if (!access_ok(VERIFY_WRITE, (ulong __user *) third,
-				      sizeof(ulong)))
-			return -EFAULT;
-		ret =3D do_shmat (first, (char __user *) ptr, second, &raddr);
-		if (ret)
-			return ret;
-		return put_user (raddr, (ulong __user *) third);
-		}
+	case SHMAT:
+		return sys_shmat(first, ptr, second,
+				(unsigned long __user *)third);
 	case SHMDT:
 		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
diff -ruN linus-compat_sys_ipc.1/arch/m68k/Kconfig linus-compat_sys_ipc.2/a=
rch/m68k/Kconfig
--- linus-compat_sys_ipc.1/arch/m68k/Kconfig	2005-01-16 11:05:29.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/m68k/Kconfig	2005-03-23 17:14:13.000000000 =
+1100
@@ -14,6 +14,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/m68k/kernel/sys_m68k.c linus-compat_s=
ys_ipc.2/arch/m68k/kernel/sys_m68k.c
--- linus-compat_sys_ipc.1/arch/m68k/kernel/sys_m68k.c	2004-05-12 07:28:08.=
000000000 +1000
+++ linus-compat_sys_ipc.2/arch/m68k/kernel/sys_m68k.c	2005-03-23 16:35:35.=
000000000 +1100
@@ -237,16 +237,8 @@
 	if (call <=3D SHMCTL)
 		switch (call) {
 		case SHMAT:
-			switch (version) {
-			default: {
-				ulong raddr;
-				ret =3D do_shmat (first, (char *) ptr,
-						 second, &raddr);
-				if (ret)
-					return ret;
-				return put_user (raddr, (ulong *) third);
-			}
-			}
+			return sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 		case SHMDT:
 			return sys_shmdt ((char *)ptr);
 		case SHMGET:
diff -ruN linus-compat_sys_ipc.1/arch/mips/Kconfig linus-compat_sys_ipc.2/a=
rch/mips/Kconfig
--- linus-compat_sys_ipc.1/arch/mips/Kconfig	2005-03-06 07:08:24.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/mips/Kconfig	2005-03-23 17:14:33.000000000 =
+1100
@@ -21,6 +21,9 @@
 	depends on MIPS64 =3D 'n'
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 mainmenu "Linux/MIPS Kernel Configuration"
=20
 source "init/Kconfig"
diff -ruN linus-compat_sys_ipc.1/arch/mips/kernel/syscall.c linus-compat_sy=
s_ipc.2/arch/mips/kernel/syscall.c
--- linus-compat_sys_ipc.1/arch/mips/kernel/syscall.c	2005-02-04 04:10:36.0=
00000000 +1100
+++ linus-compat_sys_ipc.2/arch/mips/kernel/syscall.c	2005-03-23 16:38:48.0=
00000000 +1100
@@ -349,13 +349,9 @@
=20
 	case SHMAT:
 		switch (version) {
-		default: {
-			ulong raddr;
-			ret =3D do_shmat (first, (char *) ptr, second, &raddr);
-			if (ret)
-				return ret;
-			return put_user (raddr, (ulong *) third);
-		}
+		default:
+			return sys_shmat(first, ptr, second,
+					(unsigned logn __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
@@ -374,22 +370,6 @@
 }
=20
 /*
- * Native ABI that is O32 or N64 version
- */
-asmlinkage long sys_shmat(int shmid, char __user *shmaddr,
-                          int shmflg, unsigned long *addr)
-{
-	unsigned long raddr;
-	int err;
-
-	err =3D do_shmat(shmid, shmaddr, shmflg, &raddr);
-	if (err)
-		return err;
-
-	return put_user(raddr, addr);
-}
-
-/*
  * No implemented yet ...
  */
 asmlinkage int sys_cachectl(char *addr, int nbytes, int op)
diff -ruN linus-compat_sys_ipc.1/arch/parisc/Kconfig linus-compat_sys_ipc.2=
/arch/parisc/Kconfig
--- linus-compat_sys_ipc.1/arch/parisc/Kconfig	2005-03-08 09:11:45.00000000=
0 +1100
+++ linus-compat_sys_ipc.2/arch/parisc/Kconfig	2005-03-23 16:43:18.00000000=
0 +1100
@@ -22,6 +22,9 @@
 config UID16
 	bool
=20
+config SYS_SHMATCALL
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
=20
diff -ruN linus-compat_sys_ipc.1/arch/parisc/kernel/sys_parisc.c linus-comp=
at_sys_ipc.2/arch/parisc/kernel/sys_parisc.c
--- linus-compat_sys_ipc.1/arch/parisc/kernel/sys_parisc.c	2005-03-10 04:08=
:58.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/parisc/kernel/sys_parisc.c	2005-03-23 16:41=
:53.000000000 +1100
@@ -163,13 +163,7 @@
=20
 long sys_shmat_wrapper(int shmid, char __user *shmaddr, int shmflag)
 {
-	unsigned long raddr;
-	int r;
-
-	r =3D do_shmat(shmid, shmaddr, shmflag, &raddr);
-	if (r < 0)
-		return r;
-	return raddr;
+	return sys_shmatcall(shmid, shmaddr, shmflag);
 }
=20
 /* Fucking broken ABI */
diff -ruN linus-compat_sys_ipc.1/arch/ppc/Kconfig linus-compat_sys_ipc.2/ar=
ch/ppc/Kconfig
--- linus-compat_sys_ipc.1/arch/ppc/Kconfig	2005-03-19 10:05:48.000000000 +=
1100
+++ linus-compat_sys_ipc.2/arch/ppc/Kconfig	2005-03-23 16:45:18.000000000 +=
1100
@@ -11,6 +11,9 @@
 config UID16
 	bool
=20
+config SYS_SHMAT
+	def_bool y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/ppc/kernel/syscalls.c linus-compat_sy=
s_ipc.2/arch/ppc/kernel/syscalls.c
--- linus-compat_sys_ipc.1/arch/ppc/kernel/syscalls.c	2005-03-14 13:07:08.0=
00000000 +1100
+++ linus-compat_sys_ipc.2/arch/ppc/kernel/syscalls.c	2005-03-23 16:44:39.0=
00000000 +1100
@@ -114,18 +114,10 @@
 	case MSGCTL:
 		ret =3D sys_msgctl (first, second, (struct msqid_ds __user *) ptr);
 		break;
-	case SHMAT: {
-		ulong raddr;
-
-		if ((ret =3D access_ok(VERIFY_WRITE, (ulong __user *) third,
-				       sizeof(ulong)) ? 0 : -EFAULT))
-			break;
-		ret =3D do_shmat (first, (char __user *) ptr, second, &raddr);
-		if (ret)
-			break;
-		ret =3D put_user (raddr, (ulong __user *) third);
+	case SHMAT:
+		ret =3D sys_shmat(first, ptr, second,
+				(unsigned long __user *)third);
 		break;
-		}
 	case SHMDT:
 		ret =3D sys_shmdt ((char __user *)ptr);
 		break;
diff -ruN linus-compat_sys_ipc.1/arch/ppc64/Kconfig linus-compat_sys_ipc.2/=
arch/ppc64/Kconfig
--- linus-compat_sys_ipc.1/arch/ppc64/Kconfig	2005-03-19 10:05:48.000000000=
 +1100
+++ linus-compat_sys_ipc.2/arch/ppc64/Kconfig	2005-03-23 17:16:50.000000000=
 +1100
@@ -13,6 +13,9 @@
 config UID16
 	bool
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
=20
diff -ruN linus-compat_sys_ipc.1/arch/ppc64/kernel/syscalls.c linus-compat_=
sys_ipc.2/arch/ppc64/kernel/syscalls.c
--- linus-compat_sys_ipc.1/arch/ppc64/kernel/syscalls.c	2005-02-11 13:05:29=
.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/ppc64/kernel/syscalls.c	2005-03-23 16:46:22=
.000000000 +1100
@@ -125,15 +125,10 @@
 		break;
 	case SHMAT:
 		switch (version) {
-		default: {
-			ulong raddr;
-			ret =3D do_shmat(first, (char __user *) ptr,
-					(int)second, &raddr);
-			if (ret)
-				break;
-			ret =3D put_user (raddr, (ulong __user *) third);
+		default:
+			ret =3D sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 			break;
-		}
 		case 1:	/* iBCS2 emulator entry point */
 			ret =3D -EINVAL;
 			if (!segment_eq(get_fs(), get_ds()))
diff -ruN linus-compat_sys_ipc.1/arch/s390/Kconfig linus-compat_sys_ipc.2/a=
rch/s390/Kconfig
--- linus-compat_sys_ipc.1/arch/s390/Kconfig	2005-03-09 06:08:28.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/s390/Kconfig	2005-03-23 16:49:18.000000000 =
+1100
@@ -32,6 +32,9 @@
 	default y
 	depends on ARCH_S390X =3D 'n'
=20
+config SYS_SHMAT
+	def_bool y
+
 source "init/Kconfig"
=20
 menu "Base setup"
diff -ruN linus-compat_sys_ipc.1/arch/s390/kernel/sys_s390.c linus-compat_s=
ys_ipc.2/arch/s390/kernel/sys_s390.c
--- linus-compat_sys_ipc.1/arch/s390/kernel/sys_s390.c	2005-02-11 13:05:29.=
000000000 +1100
+++ linus-compat_sys_ipc.2/arch/s390/kernel/sys_s390.c	2005-03-23 16:48:24.=
000000000 +1100
@@ -187,15 +187,9 @@
                 return sys_msgctl(first, (int)second,
 				   (struct msqid_ds __user *)ptr);
=20
-	case SHMAT: {
-		ulong raddr;
-		ret =3D do_shmat(first, (char __user *)ptr,
-				(int)second, &raddr);
-		if (ret)
-			return ret;
-		return put_user (raddr, (ulong __user *) third);
-		break;
-        }
+	case SHMAT:
+		return sys_shmat(first, ptr, second,
+				(unsigned long __user *)third);
 	case SHMDT:
 		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
diff -ruN linus-compat_sys_ipc.1/arch/sh/Kconfig linus-compat_sys_ipc.2/arc=
h/sh/Kconfig
--- linus-compat_sys_ipc.1/arch/sh/Kconfig	2005-03-09 06:08:28.000000000 +1=
100
+++ linus-compat_sys_ipc.2/arch/sh/Kconfig	2005-03-23 16:50:48.000000000 +1=
100
@@ -18,6 +18,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/sh/kernel/sys_sh.c linus-compat_sys_i=
pc.2/arch/sh/kernel/sys_sh.c
--- linus-compat_sys_ipc.1/arch/sh/kernel/sys_sh.c	2004-03-25 08:30:37.0000=
00000 +1100
+++ linus-compat_sys_ipc.2/arch/sh/kernel/sys_sh.c	2005-03-23 16:50:15.0000=
00000 +1100
@@ -225,14 +225,9 @@
 		switch (call) {
 		case SHMAT:
 			switch (version) {
-			default: {
-				ulong raddr;
-				ret =3D do_shmat (first, (char __user *) ptr,
-						 second, &raddr);
-				if (ret)
-					return ret;
-				return put_user (raddr, (ulong __user *) third);
-			}
+			default:
+				return sys_shmat(first, ptr, second,
+						(unsigned long __user *)third);
 			case 1:	/* iBCS2 emulator entry point */
 				if (!segment_eq(get_fs(), get_ds()))
 					return -EINVAL;
diff -ruN linus-compat_sys_ipc.1/arch/sh64/Kconfig linus-compat_sys_ipc.2/a=
rch/sh64/Kconfig
--- linus-compat_sys_ipc.1/arch/sh64/Kconfig	2005-03-09 06:08:28.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/sh64/Kconfig	2005-03-23 17:17:01.000000000 =
+1100
@@ -21,6 +21,12 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
+config SYS_SHMATCALL
+	def_boot y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/sh64/kernel/sys_sh64.c linus-compat_s=
ys_ipc.2/arch/sh64/kernel/sys_sh64.c
--- linus-compat_sys_ipc.1/arch/sh64/kernel/sys_sh64.c	2005-03-09 06:08:28.=
000000000 +1100
+++ linus-compat_sys_ipc.2/arch/sh64/kernel/sys_sh64.c	2005-03-23 17:07:07.=
000000000 +1100
@@ -245,14 +245,9 @@
 		switch (call) {
 		case SHMAT:
 			switch (version) {
-			default: {
-				ulong raddr;
-				ret =3D do_shmat (first, (char __user *) ptr,
-						 second, &raddr);
-				if (ret)
-					return ret;
-				return put_user (raddr, (ulong __user *) third);
-			}
+			default:
+				return sys_shmat(first, ptr, second,
+						(unsigned long __user *)third);
 			case 1:	/* iBCS2 emulator entry point */
 				if (!segment_eq(get_fs(), get_ds()))
 					return -EINVAL;
@@ -283,18 +278,3 @@
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
-
-/* Copy from mips version */
-asmlinkage long sys_shmatcall(int shmid, char __user *shmaddr,
-		int shmflg)
-{
-	unsigned long raddr;
-	int err;
-
-	err =3D do_shmat(shmid, shmaddr, shmflg, &raddr);
-	if (err)
-		return err;
-
-	err =3D raddr;
-	return err;
-}
diff -ruN linus-compat_sys_ipc.1/arch/sparc/Kconfig linus-compat_sys_ipc.2/=
arch/sparc/Kconfig
--- linus-compat_sys_ipc.1/arch/sparc/Kconfig	2005-01-23 18:05:20.000000000=
 +1100
+++ linus-compat_sys_ipc.2/arch/sparc/Kconfig	2005-03-23 17:16:56.000000000=
 +1100
@@ -13,6 +13,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 config HIGHMEM
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/sparc/kernel/sys_sparc.c linus-compat=
_sys_ipc.2/arch/sparc/kernel/sys_sparc.c
--- linus-compat_sys_ipc.1/arch/sparc/kernel/sys_sparc.c	2005-03-14 13:07:0=
8.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/sparc/kernel/sys_sparc.c	2005-03-23 16:54:2=
2.000000000 +1100
@@ -185,17 +185,10 @@
 		switch (call) {
 		case SHMAT:
 			switch (version) {
-			case 0: default: {
-				ulong raddr;
-				err =3D do_shmat (first, (char __user *) ptr, second, &raddr);
-				if (err)
-					goto out;
-				err =3D -EFAULT;
-				if (put_user (raddr, (ulong __user *) third))
-					goto out;
-				err =3D 0;
+			case 0: default:
+				err =3D sys_shmat(first, ptr, second,
+						(unsigned long __user *)third);
 				goto out;
-				}
 			case 1:	/* iBCS2 emulator entry point */
 				err =3D -EINVAL;
 				goto out;
diff -ruN linus-compat_sys_ipc.1/arch/sparc64/Kconfig linus-compat_sys_ipc.=
2/arch/sparc64/Kconfig
--- linus-compat_sys_ipc.1/arch/sparc64/Kconfig	2005-02-19 07:06:16.0000000=
00 +1100
+++ linus-compat_sys_ipc.2/arch/sparc64/Kconfig	2005-03-23 16:57:31.0000000=
00 +1100
@@ -16,6 +16,9 @@
 	bool
 	default y
=20
+config SYS_SHMAT
+	def_bool y
+
 source "init/Kconfig"
=20
 config SYSVIPC_COMPAT
diff -ruN linus-compat_sys_ipc.1/arch/sparc64/kernel/sys_sparc.c linus-comp=
at_sys_ipc.2/arch/sparc64/kernel/sys_sparc.c
--- linus-compat_sys_ipc.1/arch/sparc64/kernel/sys_sparc.c	2005-02-11 13:05=
:29.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/sparc64/kernel/sys_sparc.c	2005-03-23 16:56=
:46.000000000 +1100
@@ -259,14 +259,9 @@
 	}
 	if (call <=3D SHMCTL) {
 		switch (call) {
-		case SHMAT: {
-			ulong raddr;
-			err =3D do_shmat(first, ptr, (int)second, &raddr);
-			if (!err) {
-				if (put_user(raddr,
-					     (ulong __user *) third))
-					err =3D -EFAULT;
-			}
+		case SHMAT:
+			err =3D sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 			goto out;
 		}
 		case SHMDT:
diff -ruN linus-compat_sys_ipc.1/arch/v850/Kconfig linus-compat_sys_ipc.2/a=
rch/v850/Kconfig
--- linus-compat_sys_ipc.1/arch/v850/Kconfig	2005-01-05 17:06:07.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/v850/Kconfig	2005-03-23 17:03:41.000000000 =
+1100
@@ -13,6 +13,8 @@
 config UID16
 	bool
 	default n
+config SYS_SHMAT
+	def_bool n
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN linus-compat_sys_ipc.1/arch/v850/kernel/syscalls.c linus-compat_s=
ys_ipc.2/arch/v850/kernel/syscalls.c
--- linus-compat_sys_ipc.1/arch/v850/kernel/syscalls.c	2005-03-14 13:07:08.=
000000000 +1100
+++ linus-compat_sys_ipc.2/arch/v850/kernel/syscalls.c	2005-03-23 17:02:45.=
000000000 +1100
@@ -101,18 +101,10 @@
 		break;
 	case SHMAT:
 		switch (version) {
-		default: {
-			ulong raddr;
-
-			if ((ret =3D access_ok(VERIFY_WRITE, (ulong*) third,
-					       sizeof(ulong)) ? 0 : -EFAULT))
-				break;
-			ret =3D do_shmat (first, (char *) ptr, second, &raddr);
-			if (ret)
-				break;
-			ret =3D put_user (raddr, (ulong *) third);
+		default:
+			ret =3D sys_shmat(first, ptr, second,
+					(unsigned long __user *)third);
 			break;
-			}
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				break;
diff -ruN linus-compat_sys_ipc.1/arch/x86_64/Kconfig linus-compat_sys_ipc.2=
/arch/x86_64/Kconfig
--- linus-compat_sys_ipc.1/arch/x86_64/Kconfig	2005-03-09 06:08:28.00000000=
0 +1100
+++ linus-compat_sys_ipc.2/arch/x86_64/Kconfig	2005-03-23 17:06:10.00000000=
0 +1100
@@ -78,6 +78,9 @@
 	bool
 	default y
=20
+config SYS_SHMATCALL
+	def_bool y
+
 source "init/Kconfig"
=20
=20
diff -ruN linus-compat_sys_ipc.1/arch/x86_64/kernel/sys_x86_64.c linus-comp=
at_sys_ipc.2/arch/x86_64/kernel/sys_x86_64.c
--- linus-compat_sys_ipc.1/arch/x86_64/kernel/sys_x86_64.c	2005-03-23 12:17=
:49.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/x86_64/kernel/sys_x86_64.c	2005-03-23 17:04=
:33.000000000 +1100
@@ -154,8 +154,7 @@
=20
 asmlinkage long wrap_sys_shmat(int shmid, char __user *shmaddr, int shmflg)
 {
-	unsigned long raddr;
-	return do_shmat(shmid,shmaddr,shmflg,&raddr) ?: (long)raddr;
+	return sys_shmatcall(shmid, shmaddr, shmflg);
 }
=20
 asmlinkage long sys_time64(long __user * tloc)
diff -ruN linus-compat_sys_ipc.1/include/linux/syscalls.h linus-compat_sys_=
ipc.2/include/linux/syscalls.h
--- linus-compat_sys_ipc.1/include/linux/syscalls.h	2005-01-05 17:06:08.000=
000000 +1100
+++ linus-compat_sys_ipc.2/include/linux/syscalls.h	2005-03-23 16:11:15.000=
000000 +1100
@@ -458,6 +458,7 @@
 				const struct timespec __user *timeout);
 asmlinkage long sys_shmat(int shmid, char __user *shmaddr,
 				int shmflg, unsigned long __user *addr);
+asmlinkage long sys_shmatcall(int shmid, char __user *shmaddr, int shmflg);
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
 asmlinkage long sys_shmdt(char __user *shmaddr);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf=
);
diff -ruN linus-compat_sys_ipc.1/ipc/shm.c linus-compat_sys_ipc.2/ipc/shm.c
--- linus-compat_sys_ipc.1/ipc/shm.c	2005-03-18 04:08:16.000000000 +1100
+++ linus-compat_sys_ipc.2/ipc/shm.c	2005-03-23 17:18:28.000000000 +1100
@@ -771,6 +771,41 @@
 	return err;
 }
=20
+#ifdef CONFIG_SYS_SHMAT
+/*
+ * Attach a shared memory segment.  This version of the system
+ * call returns the attached address through the last parameter.
+ */
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg,
+		unsigned long __user *addr)
+{
+	ulong raddr;
+	long ret;
+
+	if (!access_ok(VERIFY_WRITE, addr, sizeof(*addr)))
+		return -EFAULT;
+	ret =3D do_shmat(shmid, shmaddr, shmflg, &raddr);
+	if (ret =3D=3D 0)
+		ret =3D __put_user(raddr, addr);
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_SYS_SHMATCALL
+/*
+ * Attach a shared memory segment.  This version of the system
+ * call returns the attached address as its return value
+ */
+asmlinkage long sys_shmatcall(int shmid, char __user *shmaddr, int shmflg)
+{
+	ulong raddr;
+	long ret;
+
+	ret =3D do_shmat(shmid, shmaddr, shmflg, &raddr);
+	return ret ? ret : raddr;
+}
+#endif
+
 /*
  * detach and kill segment if marked destroyed.
  * The work is done in shm_close.

--Signature=_Wed__23_Mar_2005_17_48_10_+1100_3OpGRL7mGP9qMR64
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCQREq4CJfqux9a+8RApW6AJ9GIJL6sNcWBTYuE5JSaWsfNTWGnACcCGaL
Ma0jLHCQMh6IgFGiofFqbY0=
=Wbe7
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Mar_2005_17_48_10_+1100_3OpGRL7mGP9qMR64--
