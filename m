Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	by smtps.tip.net.au (Postfix) with ESMTP id 0CA8E368023
	for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2005 18:05:52 +1000 (EST)
Date: Tue, 5 Apr 2005 18:05:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] consolidate shmat usage
Message-Id: <20050405180550.09c9fc40.sfr@canb.auug.org.au>
In-Reply-To: <20050323174810.17df4440.sfr@canb.auug.org.au>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
	<20050323174810.17df4440.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__5_Apr_2005_18_05_50_+1000_aFUNj8loJ4VOWbxy"
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Tue__5_Apr_2005_18_05_50_+1000_aFUNj8loJ4VOWbxy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch creates sys_shmat and sys_smhatcall and uses them wherever
possible - this tidies up sys_ipc a bit in most cases.

I am eventually aiming at consolidating (as much as possible of) sys_ipc
and doing compat_sys_ipc.

It has been built on i386, ppc64 and x86_64 with and without CONFIG_SYSVIPC.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/alpha/kernel/osf_sys.c linus-compat_sys_ipc.2/arch/al=
pha/kernel/osf_sys.c
--- linus/arch/alpha/kernel/osf_sys.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/alpha/kernel/osf_sys.c	2005-04-05 15:39:55.=
000000000 +1000
@@ -457,22 +457,6 @@ osf_getdomainname(char __user *name, int
 	return 0;
 }
=20
-asmlinkage long
-osf_shmat(int shmid, void __user *shmaddr, int shmflg)
-{
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
-}
-
-
 /*
  * The following stuff should move into a header file should it ever
  * be labeled "officially supported."  Right now, there is just enough
diff -ruNp linus/arch/alpha/kernel/systbls.S linus-compat_sys_ipc.2/arch/al=
pha/kernel/systbls.S
--- linus/arch/alpha/kernel/systbls.S	2004-09-16 21:51:57.000000000 +1000
+++ linus-compat_sys_ipc.2/arch/alpha/kernel/systbls.S	2005-04-05 15:39:41.=
000000000 +1000
@@ -227,7 +227,7 @@ sys_call_table:
 	.quad sys_semop
 	.quad osf_utsname
 	.quad sys_lchown
-	.quad osf_shmat
+	.quad sys_shmat
 	.quad sys_shmctl			/* 210 */
 	.quad sys_shmdt
 	.quad sys_shmget
diff -ruNp linus/arch/arm/kernel/calls.S linus-compat_sys_ipc.2/arch/arm/ke=
rnel/calls.S
--- linus/arch/arm/kernel/calls.S	2005-03-17 14:08:05.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/arm/kernel/calls.S	2005-04-05 15:25:13.0000=
00000 +1000
@@ -319,7 +319,7 @@ __syscall_start:
 		.long	sys_msgrcv
 		.long	sys_msgget
 		.long	sys_msgctl
-/* 305 */	.long	sys_shmat
+/* 305 */	.long	sys_shmat4
 		.long	sys_shmdt
 		.long	sys_shmget
 		.long	sys_shmctl
diff -ruNp linus/arch/arm/kernel/sys_arm.c linus-compat_sys_ipc.2/arch/arm/=
kernel/sys_arm.c
--- linus/arch/arm/kernel/sys_arm.c	2005-03-17 14:08:05.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/arm/kernel/sys_arm.c	2005-04-05 15:24:55.00=
0000000 +1000
@@ -212,13 +212,9 @@ asmlinkage int sys_ipc(uint call, int fi
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1: /* Of course, we don't support iBCS2! */
 			return -EINVAL;
 		}
@@ -234,18 +230,6 @@ asmlinkage int sys_ipc(uint call, int fi
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
diff -ruNp linus/arch/arm26/kernel/sys_arm.c linus-compat_sys_ipc.2/arch/ar=
m26/kernel/sys_arm.c
--- linus/arch/arm26/kernel/sys_arm.c	2005-01-04 17:05:27.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/arm26/kernel/sys_arm.c	2005-04-05 15:25:25.=
000000000 +1000
@@ -210,13 +210,9 @@ asmlinkage int sys_ipc (uint call, int f
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
diff -ruNp linus/arch/cris/kernel/sys_cris.c linus-compat_sys_ipc.2/arch/cr=
is/kernel/sys_cris.c
--- linus/arch/cris/kernel/sys_cris.c	2004-06-04 07:19:00.000000000 +1000
+++ linus-compat_sys_ipc.2/arch/cris/kernel/sys_cris.c	2005-04-05 15:25:43.=
000000000 +1000
@@ -154,13 +154,9 @@ asmlinkage int sys_ipc (uint call, int f
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
+		return sys_shmat4(first, ptr, second,
+				(unsigned long __user *)third);
 	case SHMDT:=20
 		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
diff -ruNp linus/arch/frv/kernel/sys_frv.c linus-compat_sys_ipc.2/arch/frv/=
kernel/sys_frv.c
--- linus/arch/frv/kernel/sys_frv.c	2005-01-06 12:05:05.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/frv/kernel/sys_frv.c	2005-04-05 15:30:08.00=
0000000 +1000
@@ -188,13 +188,9 @@ asmlinkage long sys_ipc(unsigned long ca
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
diff -ruNp linus/arch/h8300/kernel/sys_h8300.c linus-compat_sys_ipc.2/arch/=
h8300/kernel/sys_h8300.c
--- linus/arch/h8300/kernel/sys_h8300.c	2004-03-16 08:12:17.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/h8300/kernel/sys_h8300.c	2005-04-05 15:26:0=
3.000000000 +1000
@@ -236,16 +236,8 @@ asmlinkage int sys_ipc (uint call, int f
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 		case SHMDT:=20
 			return sys_shmdt ((char *)ptr);
 		case SHMGET:
diff -ruNp linus/arch/i386/kernel/sys_i386.c linus-compat_sys_ipc.2/arch/i3=
86/kernel/sys_i386.c
--- linus/arch/i386/kernel/sys_i386.c	2004-07-26 05:20:35.000000000 +1000
+++ linus-compat_sys_ipc.2/arch/i386/kernel/sys_i386.c	2005-04-05 16:41:47.=
000000000 +1000
@@ -131,7 +131,7 @@ asmlinkage int old_select(struct sel_arg
 asmlinkage int sys_ipc (uint call, int first, int second,
 			int third, void __user *ptr, long fifth)
 {
-	int version, ret;
+	int version;
=20
 	version =3D call >> 16; /* hack for backward compatibility */
 	call &=3D 0xffff;
@@ -183,13 +183,9 @@ asmlinkage int sys_ipc (uint call, int f
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
diff -ruNp linus/arch/ia64/kernel/entry.S linus-compat_sys_ipc.2/arch/ia64/=
kernel/entry.S
--- linus/arch/ia64/kernel/entry.S	2005-02-04 04:10:36.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/ia64/kernel/entry.S	2005-04-05 16:15:31.000=
000000 +1000
@@ -1417,7 +1417,7 @@ sys_call_table:
 	data8 sys_msgrcv
 	data8 sys_msgctl
 	data8 sys_shmget
-	data8 ia64_shmat
+	data8 sys_shmat
 	data8 sys_shmdt				// 1115
 	data8 sys_shmctl
 	data8 sys_syslog
diff -ruNp linus/arch/ia64/kernel/sys_ia64.c linus-compat_sys_ipc.2/arch/ia=
64/kernel/sys_ia64.c
--- linus/arch/ia64/kernel/sys_ia64.c	2005-02-04 04:10:36.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/ia64/kernel/sys_ia64.c	2005-04-05 16:15:16.=
000000000 +1000
@@ -93,20 +93,6 @@ sys_getpagesize (void)
 }
=20
 asmlinkage unsigned long
-ia64_shmat (int shmid, void __user *shmaddr, int shmflg)
-{
-	unsigned long raddr;
-	int retval;
-
-	retval =3D do_shmat(shmid, shmaddr, shmflg, &raddr);
-	if (retval < 0)
-		return retval;
-
-	force_successful_syscall_return();
-	return raddr;
-}
-
-asmlinkage unsigned long
 ia64_brk (unsigned long brk)
 {
 	unsigned long rlim, retval, newbrk, oldbrk;
diff -ruNp linus/arch/m32r/kernel/sys_m32r.c linus-compat_sys_ipc.2/arch/m3=
2r/kernel/sys_m32r.c
--- linus/arch/m32r/kernel/sys_m32r.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/m32r/kernel/sys_m32r.c	2005-04-05 15:29:47.=
000000000 +1000
@@ -168,17 +168,9 @@ asmlinkage int sys_ipc(uint call, int fi
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
+		return sys_shmat4(first, ptr, second,
+				(unsigned long __user *)third);
 	case SHMDT:
 		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
diff -ruNp linus/arch/m68k/kernel/sys_m68k.c linus-compat_sys_ipc.2/arch/m6=
8k/kernel/sys_m68k.c
--- linus/arch/m68k/kernel/sys_m68k.c	2004-05-12 07:28:08.000000000 +1000
+++ linus-compat_sys_ipc.2/arch/m68k/kernel/sys_m68k.c	2005-04-05 15:26:44.=
000000000 +1000
@@ -237,16 +237,8 @@ asmlinkage int sys_ipc (uint call, int f
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 		case SHMDT:
 			return sys_shmdt ((char *)ptr);
 		case SHMGET:
diff -ruNp linus/arch/mips/kernel/scall64-64.S linus-compat_sys_ipc.2/arch/=
mips/kernel/scall64-64.S
--- linus/arch/mips/kernel/scall64-64.S	2005-02-04 04:10:36.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/mips/kernel/scall64-64.S	2005-04-05 15:27:0=
4.000000000 +1000
@@ -236,7 +236,7 @@ sys_call_table:
 	PTR	sys_mincore
 	PTR	sys_madvise
 	PTR	sys_shmget
-	PTR	sys_shmat
+	PTR	sys_shmat4
 	PTR	sys_shmctl			/* 5030 */
 	PTR	sys_dup
 	PTR	sys_dup2
diff -ruNp linus/arch/mips/kernel/syscall.c linus-compat_sys_ipc.2/arch/mip=
s/kernel/syscall.c
--- linus/arch/mips/kernel/syscall.c	2005-02-04 04:10:36.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/mips/kernel/syscall.c	2005-04-05 15:27:19.0=
00000000 +1000
@@ -349,13 +349,9 @@ asmlinkage int sys_ipc (uint call, int f
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned logn __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
@@ -374,22 +370,6 @@ asmlinkage int sys_ipc (uint call, int f
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
diff -ruNp linus/arch/parisc/kernel/sys_parisc.c linus-compat_sys_ipc.2/arc=
h/parisc/kernel/sys_parisc.c
--- linus/arch/parisc/kernel/sys_parisc.c	2005-03-10 04:08:58.000000000 +11=
00
+++ linus-compat_sys_ipc.2/arch/parisc/kernel/sys_parisc.c	2005-04-05 15:41=
:29.000000000 +1000
@@ -161,17 +161,6 @@ asmlinkage unsigned long sys_mmap(unsign
 	}
 }
=20
-long sys_shmat_wrapper(int shmid, char __user *shmaddr, int shmflag)
-{
-	unsigned long raddr;
-	int r;
-
-	r =3D do_shmat(shmid, shmaddr, shmflag, &raddr);
-	if (r < 0)
-		return r;
-	return raddr;
-}
-
 /* Fucking broken ABI */
=20
 #ifdef CONFIG_64BIT
diff -ruNp linus/arch/parisc/kernel/syscall_table.S linus-compat_sys_ipc.2/=
arch/parisc/kernel/syscall_table.S
--- linus/arch/parisc/kernel/syscall_table.S	2005-01-16 07:07:51.000000000 =
+1100
+++ linus-compat_sys_ipc.2/arch/parisc/kernel/syscall_table.S	2005-04-05 15=
:43:04.000000000 +1000
@@ -297,7 +297,7 @@
 	ENTRY_DIFF(msgrcv)
 	ENTRY_SAME(msgget)		/* 190 */
 	ENTRY_SAME(msgctl)
-	ENTRY_SAME(shmat_wrapper)
+	ENTRY_SAME(shmat)
 	ENTRY_SAME(shmdt)
 	ENTRY_SAME(shmget)
 	ENTRY_SAME(shmctl)		/* 195 */
diff -ruNp linus/arch/ppc/kernel/syscalls.c linus-compat_sys_ipc.2/arch/ppc=
/kernel/syscalls.c
--- linus/arch/ppc/kernel/syscalls.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/ppc/kernel/syscalls.c	2005-04-05 15:27:36.0=
00000000 +1000
@@ -114,18 +114,10 @@ sys_ipc (uint call, int first, int secon
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
+		ret =3D sys_shmat4(first, ptr, second,
+				(unsigned long __user *)third);
 		break;
-		}
 	case SHMDT:
 		ret =3D sys_shmdt ((char __user *)ptr);
 		break;
diff -ruNp linus/arch/ppc64/kernel/syscalls.c linus-compat_sys_ipc.2/arch/p=
pc64/kernel/syscalls.c
--- linus/arch/ppc64/kernel/syscalls.c	2005-03-29 16:06:36.000000000 +1000
+++ linus-compat_sys_ipc.2/arch/ppc64/kernel/syscalls.c	2005-04-05 15:27:50=
.000000000 +1000
@@ -125,15 +125,10 @@ sys_ipc (uint call, int first, unsigned=20
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
+			ret =3D sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 			break;
-		}
 		case 1:	/* iBCS2 emulator entry point */
 			ret =3D -EINVAL;
 			if (!segment_eq(get_fs(), get_ds()))
diff -ruNp linus/arch/s390/kernel/sys_s390.c linus-compat_sys_ipc.2/arch/s3=
90/kernel/sys_s390.c
--- linus/arch/s390/kernel/sys_s390.c	2005-02-11 13:05:29.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/s390/kernel/sys_s390.c	2005-04-05 15:28:06.=
000000000 +1000
@@ -187,15 +187,9 @@ asmlinkage long sys_ipc(uint call, int f
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
+		return sys_shmat4(first, ptr, second,
+				(unsigned long __user *)third);
 	case SHMDT:
 		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
diff -ruNp linus/arch/sh/kernel/sys_sh.c linus-compat_sys_ipc.2/arch/sh/ker=
nel/sys_sh.c
--- linus/arch/sh/kernel/sys_sh.c	2004-03-25 08:30:37.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/sh/kernel/sys_sh.c	2005-04-05 15:28:25.0000=
00000 +1000
@@ -225,14 +225,9 @@ asmlinkage int sys_ipc(uint call, int fi
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
+				return sys_shmat4(first, ptr, second,
+						(unsigned long __user *)third);
 			case 1:	/* iBCS2 emulator entry point */
 				if (!segment_eq(get_fs(), get_ds()))
 					return -EINVAL;
diff -ruNp linus/arch/sh64/kernel/sys_sh64.c linus-compat_sys_ipc.2/arch/sh=
64/kernel/sys_sh64.c
--- linus/arch/sh64/kernel/sys_sh64.c	2005-03-09 06:08:28.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/sh64/kernel/sys_sh64.c	2005-04-05 15:29:28.=
000000000 +1000
@@ -245,14 +245,9 @@ asmlinkage int sys_ipc(uint call, int fi
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
+				return sys_shmat4(first, ptr, second,
+						(unsigned long __user *)third);
 			case 1:	/* iBCS2 emulator entry point */
 				if (!segment_eq(get_fs(), get_ds()))
 					return -EINVAL;
@@ -283,18 +278,3 @@ asmlinkage int sys_uname(struct old_utsn
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
diff -ruNp linus/arch/sh64/kernel/syscalls.S linus-compat_sys_ipc.2/arch/sh=
64/kernel/syscalls.S
--- linus/arch/sh64/kernel/syscalls.S	2005-03-09 06:08:28.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/sh64/kernel/syscalls.S	2005-04-05 15:34:10.=
000000000 +1000
@@ -268,7 +268,7 @@ sys_call_table:
 	.long sys_msgrcv
 	.long sys_msgget
 	.long sys_msgctl
-	.long sys_shmatcall
+	.long sys_shmat
 	.long sys_shmdt			/* 245 */
 	.long sys_shmget
 	.long sys_shmctl
diff -ruNp linus/arch/sparc/kernel/sys_sparc.c linus-compat_sys_ipc.2/arch/=
sparc/kernel/sys_sparc.c
--- linus/arch/sparc/kernel/sys_sparc.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/sparc/kernel/sys_sparc.c	2005-04-05 15:28:3=
9.000000000 +1000
@@ -185,17 +185,10 @@ asmlinkage int sys_ipc (uint call, int f
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
+				err =3D sys_shmat4(first, ptr, second,
+						(unsigned long __user *)third);
 				goto out;
-				}
 			case 1:	/* iBCS2 emulator entry point */
 				err =3D -EINVAL;
 				goto out;
diff -ruNp linus/arch/sparc64/kernel/sys_sparc.c linus-compat_sys_ipc.2/arc=
h/sparc64/kernel/sys_sparc.c
--- linus/arch/sparc64/kernel/sys_sparc.c	2005-02-11 13:05:29.000000000 +11=
00
+++ linus-compat_sys_ipc.2/arch/sparc64/kernel/sys_sparc.c	2005-04-05 15:28=
:54.000000000 +1000
@@ -259,14 +259,9 @@ asmlinkage long sys_ipc(unsigned int cal
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
+			err =3D sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 			goto out;
 		}
 		case SHMDT:
diff -ruNp linus/arch/um/include/sysdep-x86_64/syscalls.h linus-compat_sys_=
ipc.2/arch/um/include/sysdep-x86_64/syscalls.h
--- linus/arch/um/include/sysdep-x86_64/syscalls.h	2005-04-01 05:09:16.0000=
00000 +1000
+++ linus-compat_sys_ipc.2/arch/um/include/sysdep-x86_64/syscalls.h	2005-04=
-05 15:44:11.000000000 +1000
@@ -26,7 +26,6 @@ extern syscall_handler_t *ia32_sys_call_
 extern long old_mmap(unsigned long addr, unsigned long len,
 		     unsigned long prot, unsigned long flags,
 		     unsigned long fd, unsigned long pgoff);
-extern syscall_handler_t wrap_sys_shmat;
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_arch_prctl;
=20
@@ -36,7 +35,7 @@ extern syscall_handler_t sys_arch_prctl;
 	[ __NR_mincore ] =3D (syscall_handler_t *) sys_mincore, \
 	[ __NR_madvise ] =3D (syscall_handler_t *) sys_madvise, \
 	[ __NR_shmget ] =3D (syscall_handler_t *) sys_shmget, \
-	[ __NR_shmat ] =3D (syscall_handler_t *) wrap_sys_shmat, \
+	[ __NR_shmat ] =3D (syscall_handler_t *) sys_shmat, \
 	[ __NR_shmctl ] =3D (syscall_handler_t *) sys_shmctl, \
 	[ __NR_semop ] =3D (syscall_handler_t *) sys_semop, \
 	[ __NR_semget ] =3D (syscall_handler_t *) sys_semget, \
diff -ruNp linus/arch/um/sys-i386/syscalls.c linus-compat_sys_ipc.2/arch/um=
/sys-i386/syscalls.c
--- linus/arch/um/sys-i386/syscalls.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/um/sys-i386/syscalls.c	2005-04-05 16:24:10.=
000000000 +1000
@@ -143,13 +143,9 @@ long sys_ipc (uint call, int first, int=20
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
+			return sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
diff -ruNp linus/arch/um/sys-x86_64/syscalls.c linus-compat_sys_ipc.2/arch/=
um/sys-x86_64/syscalls.c
--- linus/arch/um/sys-x86_64/syscalls.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/um/sys-x86_64/syscalls.c	2005-04-05 15:45:5=
1.000000000 +1000
@@ -14,13 +14,6 @@
 #include "asm/prctl.h" /* XXX This should get the constants from libc */
 #include "choose-mode.h"
=20
-asmlinkage long wrap_sys_shmat(int shmid, char __user *shmaddr, int shmflg)
-{
-	unsigned long raddr;
-
-	return do_shmat(shmid, shmaddr, shmflg, &raddr) ?: (long) raddr;
-}
-
 #ifdef CONFIG_MODE_TT
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
=20
diff -ruNp linus/arch/v850/kernel/syscalls.c linus-compat_sys_ipc.2/arch/v8=
50/kernel/syscalls.c
--- linus/arch/v850/kernel/syscalls.c	2005-03-14 13:07:08.000000000 +1100
+++ linus-compat_sys_ipc.2/arch/v850/kernel/syscalls.c	2005-04-05 15:29:12.=
000000000 +1000
@@ -101,18 +101,10 @@ sys_ipc (uint call, int first, int secon
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
+			ret =3D sys_shmat4(first, ptr, second,
+					(unsigned long __user *)third);
 			break;
-			}
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				break;
diff -ruNp linus/arch/x86_64/kernel/sys_x86_64.c linus-compat_sys_ipc.2/arc=
h/x86_64/kernel/sys_x86_64.c
--- linus/arch/x86_64/kernel/sys_x86_64.c	2005-04-01 05:09:16.000000000 +10=
00
+++ linus-compat_sys_ipc.2/arch/x86_64/kernel/sys_x86_64.c	2005-04-05 15:46=
:08.000000000 +1000
@@ -152,12 +152,6 @@ asmlinkage long sys_uname(struct new_uts
 	return err ? -EFAULT : 0;
 }
=20
-asmlinkage long wrap_sys_shmat(int shmid, char __user *shmaddr, int shmflg)
-{
-	unsigned long raddr;
-	return do_shmat(shmid,shmaddr,shmflg,&raddr) ?: (long)raddr;
-}
-
 asmlinkage long sys_time64(long __user * tloc)
 {
 	struct timeval now;=20
diff -ruNp linus/include/asm-x86_64/unistd.h linus-compat_sys_ipc.2/include=
/asm-x86_64/unistd.h
--- linus/include/asm-x86_64/unistd.h	2005-04-01 05:09:17.000000000 +1000
+++ linus-compat_sys_ipc.2/include/asm-x86_64/unistd.h	2005-04-05 15:46:35.=
000000000 +1000
@@ -76,7 +76,7 @@ __SYSCALL(__NR_madvise, sys_madvise)
 #define __NR_shmget                             29
 __SYSCALL(__NR_shmget, sys_shmget)
 #define __NR_shmat                              30
-__SYSCALL(__NR_shmat, wrap_sys_shmat)
+__SYSCALL(__NR_shmat, sys_shmat)
 #define __NR_shmctl                             31
 __SYSCALL(__NR_shmctl, sys_shmctl)
=20
diff -ruNp linus/include/linux/syscalls.h linus-compat_sys_ipc.2/include/li=
nux/syscalls.h
--- linus/include/linux/syscalls.h	2005-01-05 17:06:08.000000000 +1100
+++ linus-compat_sys_ipc.2/include/linux/syscalls.h	2005-04-05 15:34:33.000=
000000 +1000
@@ -456,8 +456,9 @@ asmlinkage long sys_semctl(int semid, in
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
 				const struct timespec __user *timeout);
-asmlinkage long sys_shmat(int shmid, char __user *shmaddr,
+asmlinkage long sys_shmat4(int shmid, char __user *shmaddr,
 				int shmflg, unsigned long __user *addr);
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg);
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
 asmlinkage long sys_shmdt(char __user *shmaddr);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf=
);
diff -ruNp linus/ipc/shm.c linus-compat_sys_ipc.2/ipc/shm.c
--- linus/ipc/shm.c	2005-03-18 04:08:16.000000000 +1100
+++ linus-compat_sys_ipc.2/ipc/shm.c	2005-04-05 16:14:58.000000000 +1000
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
+#include <linux/ptrace.h>	/* for force_successful_syscall_return() */
 #include <asm/uaccess.h>
=20
 #include "util.h"
@@ -772,6 +773,40 @@ out:
 }
=20
 /*
+ * Attach a shared memory segment.  This version of the system
+ * call returns the attached address through the last parameter.
+ */
+asmlinkage long sys_shmat4(int shmid, char __user *shmaddr, int shmflg,
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
+
+/*
+ * Attach a shared memory segment.  This version of the system
+ * call returns the attached address as its return value
+ */
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg)
+{
+	ulong raddr;
+	long ret;
+
+	ret =3D do_shmat(shmid, shmaddr, shmflg, &raddr);
+	if (ret < 0)
+		return ret;
+	force_successful_syscall_return();
+	return raddr;
+}
+
+/*
  * detach and kill segment if marked destroyed.
  * The work is done in shm_close.
  */
diff -ruNp linus/kernel/sys_ni.c linus-compat_sys_ipc.2/kernel/sys_ni.c
--- linus/kernel/sys_ni.c	2005-03-29 16:06:38.000000000 +1000
+++ linus-compat_sys_ipc.2/kernel/sys_ni.c	2005-04-05 16:34:41.000000000 +1=
000
@@ -76,6 +76,8 @@ cond_syscall(sys_request_key);
 cond_syscall(sys_keyctl);
 cond_syscall(compat_sys_keyctl);
 cond_syscall(compat_sys_socketcall);
+cond_syscall(sys_shmat);
+cond_syscall(sys_shmat4);
=20
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);

--Signature=_Tue__5_Apr_2005_18_05_50_+1000_aFUNj8loJ4VOWbxy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUkbe4CJfqux9a+8RAhOqAJ9r+HkZmiSWNylWWv63CirlSi6z2QCgjRC4
MhJunFEGTo7Ixa0khH/HyDo=
=Wn+M
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Apr_2005_18_05_50_+1000_aFUNj8loJ4VOWbxy--
