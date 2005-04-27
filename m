Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 27 Apr 2005 16:27:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] consolidate sys_shmat
Message-Id: <20050427162709.6851e14b.sfr@canb.auug.org.au>
In-Reply-To: <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
	<20050323174810.17df4440.sfr@canb.auug.org.au>
	<20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk>
	<20050405180132.15e386cd.sfr@canb.auug.org.au>
	<20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__27_Apr_2005_16_27_09_+1000_8TyWT5n/K3ahn9=."
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__27_Apr_2005_16_27_09_+1000_8TyWT5n/K3ahn9=.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have minimised this patch a bit.  It now just consolidates sys_shmat and
in doing so, "fixes" the ABIs for MIPS(64) and ARM.  ARM glibc does not
use the sys_shmnat syscall directly so far (as far as I can see) and on
MIPS64, the ABI that glibc seems to expect (I am pretty much guessing) is
the fixed one.

I would like to get this to Andrew (and Linus) pretty soon as it would be
best if we don't have a "release" kernel with the incorrect ABI in it.

If everyone is happy, I will send this to Andrew tomorrow (or so).

diffstat look like this:

 arch/alpha/kernel/osf_sys.c              |   16 ----------------
 arch/alpha/kernel/systbls.S              |    2 +-
 arch/arm/kernel/sys_arm.c                |   12 ------------
 arch/ia64/kernel/entry.S                 |    2 +-
 arch/ia64/kernel/sys_ia64.c              |   14 --------------
 arch/mips/kernel/syscall.c               |   16 ----------------
 arch/parisc/kernel/sys_parisc.c          |   11 -----------
 arch/parisc/kernel/syscall_table.S       |    2 +-
 arch/sh64/kernel/sys_sh64.c              |   15 ---------------
 arch/sh64/kernel/syscalls.S              |    2 +-
 arch/um/include/sysdep-x86_64/syscalls.h |    3 +--
 arch/um/sys-x86_64/syscalls.c            |    7 -------
 arch/x86_64/kernel/sys_x86_64.c          |    6 ------
 include/asm-x86_64/unistd.h              |    2 +-
 include/linux/syscalls.h                 |    3 +--
 ipc/shm.c                                |   14 ++++++++++++++
 kernel/sys_ni.c                          |    1 +
 17 files changed, 22 insertions(+), 106 deletions(-)

I have built this on PPC64 (which doesn't use sys_shmat) and X86_64 (which
does) both with and without CONFIG_SYSVIPC.

One slight downside is that there is now a sys_shmat defined even on those
architectures that don't use it (it is a very small function) - but maybe
we should be deprecating the use of sys_ipc anyway :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/alpha/kernel/osf_sys.c linus-sys_shmat.1/arch/alpha/k=
ernel/osf_sys.c
--- linus/arch/alpha/kernel/osf_sys.c	2005-04-26 15:37:54.000000000 +1000
+++ linus-sys_shmat.1/arch/alpha/kernel/osf_sys.c	2005-04-27 12:13:13.00000=
0000 +1000
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
diff -ruNp linus/arch/alpha/kernel/systbls.S linus-sys_shmat.1/arch/alpha/k=
ernel/systbls.S
--- linus/arch/alpha/kernel/systbls.S	2005-04-26 15:37:54.000000000 +1000
+++ linus-sys_shmat.1/arch/alpha/kernel/systbls.S	2005-04-27 12:13:01.00000=
0000 +1000
@@ -227,7 +227,7 @@ sys_call_table:
 	.quad sys_semop
 	.quad osf_utsname
 	.quad sys_lchown
-	.quad osf_shmat
+	.quad sys_shmat
 	.quad sys_shmctl			/* 210 */
 	.quad sys_shmdt
 	.quad sys_shmget
diff -ruNp linus/arch/arm/kernel/sys_arm.c linus-sys_shmat.1/arch/arm/kerne=
l/sys_arm.c
--- linus/arch/arm/kernel/sys_arm.c	2005-04-26 15:37:54.000000000 +1000
+++ linus-sys_shmat.1/arch/arm/kernel/sys_arm.c	2005-04-27 13:01:21.0000000=
00 +1000
@@ -227,18 +227,6 @@ asmlinkage int sys_ipc(uint call, int fi
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
diff -ruNp linus/arch/ia64/kernel/entry.S linus-sys_shmat.1/arch/ia64/kerne=
l/entry.S
--- linus/arch/ia64/kernel/entry.S	2005-04-26 15:37:54.000000000 +1000
+++ linus-sys_shmat.1/arch/ia64/kernel/entry.S	2005-04-27 13:02:53.00000000=
0 +1000
@@ -1417,7 +1417,7 @@ sys_call_table:
 	data8 sys_msgrcv
 	data8 sys_msgctl
 	data8 sys_shmget
-	data8 ia64_shmat
+	data8 sys_shmat
 	data8 sys_shmdt				// 1115
 	data8 sys_shmctl
 	data8 sys_syslog
diff -ruNp linus/arch/ia64/kernel/sys_ia64.c linus-sys_shmat.1/arch/ia64/ke=
rnel/sys_ia64.c
--- linus/arch/ia64/kernel/sys_ia64.c	2005-04-26 15:37:54.000000000 +1000
+++ linus-sys_shmat.1/arch/ia64/kernel/sys_ia64.c	2005-04-27 13:05:40.00000=
0000 +1000
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
diff -ruNp linus/arch/mips/kernel/syscall.c linus-sys_shmat.1/arch/mips/ker=
nel/syscall.c
--- linus/arch/mips/kernel/syscall.c	2005-04-26 15:37:55.000000000 +1000
+++ linus-sys_shmat.1/arch/mips/kernel/syscall.c	2005-04-27 13:06:51.000000=
000 +1000
@@ -374,22 +374,6 @@ asmlinkage int sys_ipc (uint call, int f
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
diff -ruNp linus/arch/parisc/kernel/sys_parisc.c linus-sys_shmat.1/arch/par=
isc/kernel/sys_parisc.c
--- linus/arch/parisc/kernel/sys_parisc.c	2005-04-26 15:37:55.000000000 +10=
00
+++ linus-sys_shmat.1/arch/parisc/kernel/sys_parisc.c	2005-04-27 13:07:40.0=
00000000 +1000
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
diff -ruNp linus/arch/parisc/kernel/syscall_table.S linus-sys_shmat.1/arch/=
parisc/kernel/syscall_table.S
--- linus/arch/parisc/kernel/syscall_table.S	2005-04-26 15:37:55.000000000 =
+1000
+++ linus-sys_shmat.1/arch/parisc/kernel/syscall_table.S	2005-04-27 13:07:5=
8.000000000 +1000
@@ -297,7 +297,7 @@
 	ENTRY_DIFF(msgrcv)
 	ENTRY_SAME(msgget)		/* 190 */
 	ENTRY_SAME(msgctl)
-	ENTRY_SAME(shmat_wrapper)
+	ENTRY_SAME(shmat)
 	ENTRY_SAME(shmdt)
 	ENTRY_SAME(shmget)
 	ENTRY_SAME(shmctl)		/* 195 */
diff -ruNp linus/arch/sh64/kernel/sys_sh64.c linus-sys_shmat.1/arch/sh64/ke=
rnel/sys_sh64.c
--- linus/arch/sh64/kernel/sys_sh64.c	2005-04-26 15:37:55.000000000 +1000
+++ linus-sys_shmat.1/arch/sh64/kernel/sys_sh64.c	2005-04-27 13:11:39.00000=
0000 +1000
@@ -283,18 +283,3 @@ asmlinkage int sys_uname(struct old_utsn
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
diff -ruNp linus/arch/sh64/kernel/syscalls.S linus-sys_shmat.1/arch/sh64/ke=
rnel/syscalls.S
--- linus/arch/sh64/kernel/syscalls.S	2005-04-26 15:37:55.000000000 +1000
+++ linus-sys_shmat.1/arch/sh64/kernel/syscalls.S	2005-04-27 13:11:54.00000=
0000 +1000
@@ -268,7 +268,7 @@ sys_call_table:
 	.long sys_msgrcv
 	.long sys_msgget
 	.long sys_msgctl
-	.long sys_shmatcall
+	.long sys_shmat
 	.long sys_shmdt			/* 245 */
 	.long sys_shmget
 	.long sys_shmctl
diff -ruNp linus/arch/um/include/sysdep-x86_64/syscalls.h linus-sys_shmat.1=
/arch/um/include/sysdep-x86_64/syscalls.h
--- linus/arch/um/include/sysdep-x86_64/syscalls.h	2005-04-26 15:37:56.0000=
00000 +1000
+++ linus-sys_shmat.1/arch/um/include/sysdep-x86_64/syscalls.h	2005-04-27 1=
3:10:09.000000000 +1000
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
diff -ruNp linus/arch/um/sys-x86_64/syscalls.c linus-sys_shmat.1/arch/um/sy=
s-x86_64/syscalls.c
--- linus/arch/um/sys-x86_64/syscalls.c	2005-04-26 15:37:56.000000000 +1000
+++ linus-sys_shmat.1/arch/um/sys-x86_64/syscalls.c	2005-04-27 13:10:44.000=
000000 +1000
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
diff -ruNp linus/arch/x86_64/kernel/sys_x86_64.c linus-sys_shmat.1/arch/x86=
_64/kernel/sys_x86_64.c
--- linus/arch/x86_64/kernel/sys_x86_64.c	2005-04-26 15:37:56.000000000 +10=
00
+++ linus-sys_shmat.1/arch/x86_64/kernel/sys_x86_64.c	2005-04-27 13:11:09.0=
00000000 +1000
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
diff -ruNp linus/include/asm-x86_64/unistd.h linus-sys_shmat.1/include/asm-=
x86_64/unistd.h
--- linus/include/asm-x86_64/unistd.h	2005-04-26 15:38:02.000000000 +1000
+++ linus-sys_shmat.1/include/asm-x86_64/unistd.h	2005-04-27 13:12:58.00000=
0000 +1000
@@ -76,7 +76,7 @@ __SYSCALL(__NR_madvise, sys_madvise)
 #define __NR_shmget                             29
 __SYSCALL(__NR_shmget, sys_shmget)
 #define __NR_shmat                              30
-__SYSCALL(__NR_shmat, wrap_sys_shmat)
+__SYSCALL(__NR_shmat, sys_shmat)
 #define __NR_shmctl                             31
 __SYSCALL(__NR_shmctl, sys_shmctl)
=20
diff -ruNp linus/include/linux/syscalls.h linus-sys_shmat.1/include/linux/s=
yscalls.h
--- linus/include/linux/syscalls.h	2005-04-26 15:38:02.000000000 +1000
+++ linus-sys_shmat.1/include/linux/syscalls.h	2005-04-27 11:44:01.00000000=
0 +1000
@@ -456,8 +456,7 @@ asmlinkage long sys_semctl(int semid, in
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
 				const struct timespec __user *timeout);
-asmlinkage long sys_shmat(int shmid, char __user *shmaddr,
-				int shmflg, unsigned long __user *addr);
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg);
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
 asmlinkage long sys_shmdt(char __user *shmaddr);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf=
);
diff -ruNp linus/ipc/shm.c linus-sys_shmat.1/ipc/shm.c
--- linus/ipc/shm.c	2005-04-26 15:38:03.000000000 +1000
+++ linus-sys_shmat.1/ipc/shm.c	2005-04-27 13:50:58.000000000 +1000
@@ -28,6 +28,8 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
+#include <linux/ptrace.h>
+
 #include <asm/uaccess.h>
=20
 #include "util.h"
@@ -771,6 +773,18 @@ out:
 	return err;
 }
=20
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg)
+{
+	unsigned long ret;
+	long err;
+
+	err =3D do_shmat(shmid, shmaddr, shmflg, &ret);
+	if (err)
+		return err;
+	force_successful_syscall_return();
+	return (long)ret;
+}
+
 /*
  * detach and kill segment if marked destroyed.
  * The work is done in shm_close.
diff -ruNp linus/kernel/sys_ni.c linus-sys_shmat.1/kernel/sys_ni.c
--- linus/kernel/sys_ni.c	2005-04-26 15:38:03.000000000 +1000
+++ linus-sys_shmat.1/kernel/sys_ni.c	2005-04-27 13:23:04.000000000 +1000
@@ -52,6 +52,7 @@ cond_syscall(sys_msgsnd);
 cond_syscall(sys_msgrcv);
 cond_syscall(sys_msgctl);
 cond_syscall(sys_shmget);
+cond_syscall(sys_shmat);
 cond_syscall(sys_shmdt);
 cond_syscall(sys_shmctl);
 cond_syscall(sys_mq_open);

--Signature=_Wed__27_Apr_2005_16_27_09_+1000_8TyWT5n/K3ahn9=.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCbzDF4CJfqux9a+8RAvUSAJ9rBJoP6g1PRNqVJPeSF7x9PDGubgCeOZm/
11ls9JA5RA9GEPR2GUWhBoo=
=ibby
-----END PGP SIGNATURE-----

--Signature=_Wed__27_Apr_2005_16_27_09_+1000_8TyWT5n/K3ahn9=.--
