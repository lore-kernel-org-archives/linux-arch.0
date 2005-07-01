Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 1 Jul 2005 14:58:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH, for review 2/3] hook up compat_sys_{read,write} syscalls
Message-Id: <20050701145842.724c1317.sfr@canb.auug.org.au>
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
 boundary="Signature=_Fri__1_Jul_2005_14_58_42_+1000_C3pW4=R4V9xYkd//"
To: ak@suse.de
Cc: davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Fri__1_Jul_2005_14_58_42_+1000_C3pW4=R4V9xYkd//
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch just hooks the compat_sys_{read,write} into the appropriate sysc=
all tables.

Please check and comment.
---

 ia64/ia32/ia32_entry.S        |    4 ++--
 mips/kernel/scall64-n32.S     |    4 ++--
 mips/kernel/scall64-o32.S     |    4 ++--
 parisc/kernel/syscall_table.S |    4 ++--
 ppc64/kernel/misc.S           |    4 ++--
 s390/kernel/compat_linux.c    |   16 ----------------
 s390/kernel/compat_wrapper.S  |   12 ++++++------
 s390/kernel/syscalls.S        |    4 ++--
 sparc64/kernel/systbls.S      |    2 +-
 x86_64/ia32/ia32entry.S       |    4 ++--
 10 files changed, 21 insertions(+), 37 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-compat_write.3/arch/ia64/ia32/ia32_entry.S linus-compat_wri=
te.4/arch/ia64/ia32/ia32_entry.S
--- linus-compat_write.3/arch/ia64/ia32/ia32_entry.S	2005-06-27 16:07:59.00=
0000000 +1000
+++ linus-compat_write.4/arch/ia64/ia32/ia32_entry.S	2005-07-01 13:58:03.00=
0000000 +1000
@@ -213,8 +213,8 @@
 	data8 sys_ni_syscall	  /* 0	-  old "setup(" system call*/
 	data8 sys_exit
 	data8 sys32_fork
-	data8 sys_read
-	data8 sys_write
+	data8 compat_sys_read
+	data8 compat_sys_write
 	data8 sys32_open	  /* 5 */
 	data8 sys_close
 	data8 sys32_waitpid
diff -ruN linus-compat_write.3/arch/mips/kernel/scall64-n32.S linus-compat_=
write.4/arch/mips/kernel/scall64-n32.S
--- linus-compat_write.3/arch/mips/kernel/scall64-n32.S	2005-06-27 16:08:00=
.000000000 +1000
+++ linus-compat_write.4/arch/mips/kernel/scall64-n32.S	2005-07-01 13:59:26=
.000000000 +1000
@@ -117,8 +117,8 @@
 	END(handle_sysn32)
=20
 EXPORT(sysn32_call_table)
-	PTR	sys_read			/* 6000 */
-	PTR	sys_write
+	PTR	compat_sys_read			/* 6000 */
+	PTR	compat_sys_write
 	PTR	sys_open
 	PTR	sys_close
 	PTR	sys_newstat
diff -ruN linus-compat_write.3/arch/mips/kernel/scall64-o32.S linus-compat_=
write.4/arch/mips/kernel/scall64-o32.S
--- linus-compat_write.3/arch/mips/kernel/scall64-o32.S	2005-06-27 16:08:00=
.000000000 +1000
+++ linus-compat_write.4/arch/mips/kernel/scall64-o32.S	2005-07-01 13:59:40=
.000000000 +1000
@@ -205,8 +205,8 @@
 	PTR	sys32_syscall			/* 4000 */
 	PTR	sys_exit
 	PTR	sys_fork
-	PTR	sys_read
-	PTR	sys_write
+	PTR	compat_sys_read
+	PTR	compat_sys_write
 	PTR	sys_open			/* 4005 */
 	PTR	sys_close
 	PTR	sys_waitpid
diff -ruN linus-compat_write.3/arch/parisc/kernel/syscall_table.S linus-com=
pat_write.4/arch/parisc/kernel/syscall_table.S
--- linus-compat_write.3/arch/parisc/kernel/syscall_table.S	2005-06-27 16:0=
8:00.000000000 +1000
+++ linus-compat_write.4/arch/parisc/kernel/syscall_table.S	2005-07-01 14:0=
1:50.000000000 +1000
@@ -63,8 +63,8 @@
 	ENTRY_SAME(restart_syscall)	/* 0 */
 	ENTRY_SAME(exit)
 	ENTRY_SAME(fork_wrapper)
-	ENTRY_SAME(read)
-	ENTRY_SAME(write)
+	ENTRY_COMP(read)
+	ENTRY_COMP(write)
 	ENTRY_SAME(open)		/* 5 */
 	ENTRY_SAME(close)
 	ENTRY_SAME(waitpid)
diff -ruN linus-compat_write.3/arch/ppc64/kernel/misc.S linus-compat_write.=
4/arch/ppc64/kernel/misc.S
--- linus-compat_write.3/arch/ppc64/kernel/misc.S	2005-06-27 16:08:00.00000=
0000 +1000
+++ linus-compat_write.4/arch/ppc64/kernel/misc.S	2005-07-01 14:02:23.00000=
0000 +1000
@@ -857,8 +857,8 @@
 	.llong .sys_restart_syscall	/* 0 */
 	.llong .sys_exit
 	.llong .ppc_fork
-	.llong .sys_read
-	.llong .sys_write
+	.llong .compat_sys_read
+	.llong .compat_sys_write
 	.llong .sys32_open		/* 5 */
 	.llong .sys_close
 	.llong .sys32_waitpid
diff -ruN linus-compat_write.3/arch/s390/kernel/compat_linux.c linus-compat=
_write.4/arch/s390/kernel/compat_linux.c
--- linus-compat_write.3/arch/s390/kernel/compat_linux.c	2005-06-27 16:08:0=
0.000000000 +1000
+++ linus-compat_write.4/arch/s390/kernel/compat_linux.c	2005-07-01 14:06:3=
6.000000000 +1000
@@ -980,22 +980,6 @@
 	return error;
 }
=20
-asmlinkage long sys32_read(unsigned int fd, char * buf, size_t count)
-{
-	if ((compat_ssize_t) count < 0)
-		return -EINVAL;=20
-
-	return sys_read(fd, buf, count);
-}
-
-asmlinkage long sys32_write(unsigned int fd, char * buf, size_t count)
-{
-	if ((compat_ssize_t) count < 0)
-		return -EINVAL;=20
-
-	return sys_write(fd, buf, count);
-}
-
 asmlinkage long sys32_clone(struct pt_regs regs)
 {
         unsigned long clone_flags;
diff -ruN linus-compat_write.3/arch/s390/kernel/compat_wrapper.S linus-comp=
at_write.4/arch/s390/kernel/compat_wrapper.S
--- linus-compat_write.3/arch/s390/kernel/compat_wrapper.S	2005-06-27 16:08=
:00.000000000 +1000
+++ linus-compat_write.4/arch/s390/kernel/compat_wrapper.S	2005-07-01 14:09=
:52.000000000 +1000
@@ -13,19 +13,19 @@
 	lgfr	%r2,%r2			# int
 	jg	sys_exit		# branch to sys_exit
    =20
-	.globl  sys32_read_wrapper=20
-sys32_read_wrapper:
+	.globl  compat_read_wrapper
+compat_sys_read_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
 	llgfr	%r4,%r4			# size_t
-	jg	sys32_read		# branch to sys_read
+	jg	compat_sys_read		# branch to sys_read
=20
-	.globl  sys32_write_wrapper=20
-sys32_write_wrapper:
+	.globl  compat_write_wrapper
+compat_sys_write_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# const char *
 	llgfr	%r4,%r4			# size_t
-	jg	sys32_write		# branch to system call
+	jg	compat_sys_write	# branch to system call
=20
 	.globl  sys32_open_wrapper=20
 sys32_open_wrapper:
diff -ruN linus-compat_write.3/arch/s390/kernel/syscalls.S linus-compat_wri=
te.4/arch/s390/kernel/syscalls.S
--- linus-compat_write.3/arch/s390/kernel/syscalls.S	2005-06-27 16:08:00.00=
0000000 +1000
+++ linus-compat_write.4/arch/s390/kernel/syscalls.S	2005-07-01 14:10:05.00=
0000000 +1000
@@ -11,8 +11,8 @@
 NI_SYSCALL							/* 0 */
 SYSCALL(sys_exit,sys_exit,sys32_exit_wrapper)
 SYSCALL(sys_fork_glue,sys_fork_glue,sys_fork_glue)
-SYSCALL(sys_read,sys_read,sys32_read_wrapper)
-SYSCALL(sys_write,sys_write,sys32_write_wrapper)
+SYSCALL(sys_read,sys_read,compat_sys_read_wrapper)
+SYSCALL(sys_write,sys_write,compat_sys_write_wrapper)
 SYSCALL(sys_open,sys_open,sys32_open_wrapper)			/* 5 */
 SYSCALL(sys_close,sys_close,sys32_close_wrapper)
 SYSCALL(sys_restart_syscall,sys_restart_syscall,sys_restart_syscall)
diff -ruN linus-compat_write.3/arch/sparc64/kernel/systbls.S linus-compat_w=
rite.4/arch/sparc64/kernel/systbls.S
--- linus-compat_write.3/arch/sparc64/kernel/systbls.S	2005-06-27 16:08:00.=
000000000 +1000
+++ linus-compat_write.4/arch/sparc64/kernel/systbls.S	2005-07-01 14:12:24.=
000000000 +1000
@@ -20,7 +20,7 @@
=20
 	.globl sys_call_table32
 sys_call_table32:
-/*0*/	.word sys_restart_syscall, sys32_exit, sys_fork, sys_read, sys_write
+/*0*/	.word sys_restart_syscall, sys32_exit, sys_fork, compat_sys_read, co=
mpat_sys_write
 /*5*/	.word sys32_open, sys_close, sys32_wait4, sys32_creat, sys_link
 /*10*/  .word sys_unlink, sunos_execv, sys_chdir, sys32_chown16, sys32_mkn=
od
 /*15*/	.word sys_chmod, sys32_lchown16, sparc_brk, sys32_perfctr, sys32_ls=
eek
diff -ruN linus-compat_write.3/arch/x86_64/ia32/ia32entry.S linus-compat_wr=
ite.4/arch/x86_64/ia32/ia32entry.S
--- linus-compat_write.3/arch/x86_64/ia32/ia32entry.S	2005-06-27 16:08:00.0=
00000000 +1000
+++ linus-compat_write.4/arch/x86_64/ia32/ia32entry.S	2005-07-01 14:12:50.0=
00000000 +1000
@@ -305,8 +305,8 @@
 	.quad sys_restart_syscall
 	.quad sys_exit
 	.quad stub32_fork
-	.quad sys_read
-	.quad sys_write
+	.quad compat_sys_read
+	.quad compat_sys_write
 	.quad sys32_open		/* 5 */
 	.quad sys_close
 	.quad sys32_waitpid

--Signature=_Fri__1_Jul_2005_14_58_42_+1000_C3pW4=R4V9xYkd//
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxM2DFdBgD/zoJvwRAjMsAJ9NADTHTSZYQbDgbmbwqakcJ9Rj5QCfQMH5
Rf1NDmNv7nFRoIwNMNkyh9U=
=BUnU
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Jul_2005_14_58_42_+1000_C3pW4=R4V9xYkd//--
