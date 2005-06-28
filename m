Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 18:14:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RFC: is_compat_task (Was: Re: input compat stuff)
Message-Id: <20050628181453.387e0fac.sfr@canb.auug.org.au>
In-Reply-To: <20050628072710.GA29916@lst.de>
References: <20050628072710.GA29916@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__28_Jun_2005_18_14_53_+1000_d+vYktrN1bQYsK9a"
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Tue__28_Jun_2005_18_14_53_+1000_d+vYktrN1bQYsK9a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jun 2005 09:27:10 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> besides this beeing butt ugly didn't we have a rule about never checking
> task flags whether we're a compat process?  And if we're going to allow
> it it should be done properly.

So, I have been thinking about this patch for a while (wondering how badly
flamed I would get when I posted it :-)).  What do you all think?  Is this
a reasonable thing to do?

We also need sometimes to tell if an mm is 32bit, I think?  Any
suggestions?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/include/asm-ia64/compat.h linus-willy.3/include/asm-ia64/co=
mpat.h
--- linus/include/asm-ia64/compat.h	2005-06-27 16:08:06.000000000 +1000
+++ linus-willy.3/include/asm-ia64/compat.h	2005-06-27 18:06:35.000000000 +=
1000
@@ -4,6 +4,11 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/sched.h>
+
+#include <asm/system.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
=20
 #define COMPAT_USER_HZ	100
=20
@@ -196,4 +201,9 @@
 	return (void __user *) (((regs->r12 & 0xffffffff) & -16) - len);
 }
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return IS_IA32_PROCESS(ia64_task_regs(t));
+}
+
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN linus/include/asm-mips/compat.h linus-willy.3/include/asm-mips/co=
mpat.h
--- linus/include/asm-mips/compat.h	2005-06-27 16:08:07.000000000 +1000
+++ linus-willy.3/include/asm-mips/compat.h	2005-06-27 18:06:35.000000000 +=
1000
@@ -4,7 +4,9 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/sched.h>
 #include <asm/page.h>
+#include <asm/processor.h>
=20
 #define COMPAT_USER_HZ	100
=20
@@ -142,4 +144,9 @@
 #define __COMPAT_ENDIAN_SWAP__ 	1
 #endif
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return (t->thread.mflags & MF_ABI_MASK) =3D=3D MF_O32;
+}
+
 #endif /* _ASM_COMPAT_H */
diff -ruN linus/include/asm-parisc/compat.h linus-willy.3/include/asm-paris=
c/compat.h
--- linus/include/asm-parisc/compat.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-willy.3/include/asm-parisc/compat.h	2005-06-27 18:06:35.000000000=
 +1000
@@ -142,4 +142,9 @@
 	return (void __user *)regs->gr[30];
 }
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return personality(t->personality) =3D=3D PER_LINUX32;
+}
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff -ruN linus/include/asm-ppc64/compat.h linus-willy.3/include/asm-ppc64/=
compat.h
--- linus/include/asm-ppc64/compat.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-willy.3/include/asm-ppc64/compat.h	2005-06-27 18:06:35.000000000 =
+1000
@@ -200,4 +200,9 @@
 	compat_ulong_t __unused6;
 };
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_32BIT);
+}
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN linus/include/asm-s390/compat.h linus-willy.3/include/asm-s390/co=
mpat.h
--- linus/include/asm-s390/compat.h	2005-06-27 16:08:09.000000000 +1000
+++ linus-willy.3/include/asm-s390/compat.h	2005-06-27 18:06:35.000000000 +=
1000
@@ -195,4 +195,10 @@
 	compat_ulong_t __unused1;
 	compat_ulong_t __unused2;
 };
+
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_31BIT);
+}
+
 #endif /* _ASM_S390X_COMPAT_H */
diff -ruN linus/include/asm-sparc64/compat.h linus-willy.3/include/asm-spar=
c64/compat.h
--- linus/include/asm-sparc64/compat.h	2005-06-27 16:08:10.000000000 +1000
+++ linus-willy.3/include/asm-sparc64/compat.h	2005-06-27 18:06:35.00000000=
0 +1000
@@ -4,6 +4,7 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/sched.h>
=20
 #define COMPAT_USER_HZ	100
=20
@@ -233,4 +234,9 @@
 	unsigned int	__unused2;
 };
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_32BIT);
+}
+
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN linus/include/asm-x86_64/compat.h linus-willy.3/include/asm-x86_6=
4/compat.h
--- linus/include/asm-x86_64/compat.h	2005-06-27 16:08:10.000000000 +1000
+++ linus-willy.3/include/asm-x86_64/compat.h	2005-06-27 18:06:35.000000000=
 +1000
@@ -202,4 +202,9 @@
 	return (void __user *)regs->rsp - len;=20
 }
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_IA32);
+}
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN linus/include/linux/compat.h linus-willy.3/include/linux/compat.h
--- linus/include/linux/compat.h	2005-06-27 16:08:11.000000000 +1000
+++ linus-willy.3/include/linux/compat.h	2005-06-27 18:06:35.000000000 +1000
@@ -158,5 +158,9 @@
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
=20
+#else /* CONFIG_COMPAT */
+
+#define is_compat_task(x)	0
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */

--Signature=_Tue__28_Jun_2005_18_14_53_+1000_d+vYktrN1bQYsK9a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCwQb9FdBgD/zoJvwRAqXmAJ9COBKrOKQS+NNnsc+wG7Xn8L9zLACgoOAn
IbCMNg2DHDeX2Mzik98vvUo=
=Gj8Y
-----END PGP SIGNATURE-----

--Signature=_Tue__28_Jun_2005_18_14_53_+1000_d+vYktrN1bQYsK9a--
