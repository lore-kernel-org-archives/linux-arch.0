Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37501 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGKD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 05:03:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so11047526pfh.4
        for <linux-arch@vger.kernel.org>; Thu, 07 Mar 2019 02:03:57 -0800 (PST)
Date: Thu, 07 Mar 2019 11:03:45 +0100
In-Reply-To: <20190307091218.2343836-1-arnd@arndb.de>
References: <20190307091218.2343836-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] signal: fix building with clang
From: Christian Brauner <christian@brauner.io>
Message-ID: <F5AA685F-C48B-4067-A70F-AC942C90F770@brauner.io>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Nick Desaulniers <ndesaulniers@google.com>, Oleg Nesterov <oleg@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
Message-ID: <20190307100345.pj7NrN3c4ZJXPTBMj4TeKFZUYBJSgUJXsOBMxaYeto0@z>

On March 7, 2019 10:11:52 AM GMT+01:00, Arnd Bergmann <arnd@arndb=2Ede> wro=
te:
>clang warns about the sigset_t manipulating functions (sigaddset,
>sigdelset,
>sigisemptyset, =2E=2E=2E) because it performs semantic analysis before
>discarding
>dead code, unlike gcc that does this in the reverse order=2E
>
>The result is a long list of warnings like:
>
>In file included from arch/arm64/include/asm/ftrace=2Eh:21:
>include/linux/compat=2Eh:489:10: error: array index 3 is past the end of
>the array (which contains 2 elements) [-Werror,-Warray-bounds]
>        case 2: v=2Esig[3] =3D (set->sig[1] >> 32); v=2Esig[2] =3D set->s=
ig[1];
>                ^     ~
>include/linux/compat=2Eh:138:2: note: array 'sig' declared here
>        compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
>        ^
>include/linux/compat=2Eh:489:42: error: array index 2 is past the end of
>the array (which contains 2 elements) [-Werror,-Warray-bounds]
>        case 2: v=2Esig[3] =3D (set->sig[1] >> 32); v=2Esig[2] =3D set->s=
ig[1];
>                                                ^     ~
>include/linux/compat=2Eh:138:2: note: array 'sig' declared here
>        compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
>        ^
>
>As a (rather ugly) workaround, I turn the nice switch()/case statements
>into preprocessor conditionals, and where that is not possible, use the
>'%' operator to modify the warning case into an operation that clang
>will not warn about=2E Since that only matters for dead code, the actual
>behavior does not change=2E
>
>Link: https://bugs=2Ellvm=2Eorg/show_bug=2Ecgi?id=3D38789
>Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>---
> arch/mips/include/uapi/asm/signal=2Eh |  3 +-
> include/linux/signal=2Eh              | 72 ++++++++++++++---------------
> 2 files changed, 37 insertions(+), 38 deletions(-)
>
>diff --git a/arch/mips/include/uapi/asm/signal=2Eh
>b/arch/mips/include/uapi/asm/signal=2Eh
>index 53104b10aae2=2E=2E8e71a2f778f7 100644
>--- a/arch/mips/include/uapi/asm/signal=2Eh
>+++ b/arch/mips/include/uapi/asm/signal=2Eh
>@@ -11,9 +11,10 @@
> #define _UAPI_ASM_SIGNAL_H
>=20
> #include <linux/types=2Eh>
>+#include <asm/bitsperlong=2Eh>
>=20
> #define _NSIG		128
>-#define _NSIG_BPW	(sizeof(unsigned long) * 8)
>+#define _NSIG_BPW	__BITS_PER_LONG
> #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
>=20
> typedef struct {
>diff --git a/include/linux/signal=2Eh b/include/linux/signal=2Eh
>index 9702016734b1=2E=2Eb967d502ab61 100644
>--- a/include/linux/signal=2Eh
>+++ b/include/linux/signal=2Eh
>@@ -82,35 +82,33 @@ static inline int sigismember(sigset_t *set, int
>_sig)
>=20
> static inline int sigisemptyset(sigset_t *set)
> {
>-	switch (_NSIG_WORDS) {
>-	case 4:
>-		return (set->sig[3] | set->sig[2] |
>-			set->sig[1] | set->sig[0]) =3D=3D 0;
>-	case 2:
>-		return (set->sig[1] | set->sig[0]) =3D=3D 0;
>-	case 1:
>-		return set->sig[0] =3D=3D 0;
>-	default:
>-		BUILD_BUG();
>-		return 0;
>-	}
>+#if _NSIG_WORDS =3D=3D 4
>+	return (set->sig[3] | set->sig[2] |
>+		set->sig[1] | set->sig[0]) =3D=3D 0;
>+#elif _NSIG_WORDS =3D=3D 2
>+	return (set->sig[1] | set->sig[0]) =3D=3D 0;
>+#elif _NSIG_WORDS =3D=3D 1
>+	return set->sig[0] =3D=3D 0;
>+#else
>+	BUILD_BUG();
>+#endif
> }
>=20
>static inline int sigequalsets(const sigset_t *set1, const sigset_t
>*set2)
> {
>-	switch (_NSIG_WORDS) {
>-	case 4:
>-		return	(set1->sig[3] =3D=3D set2->sig[3]) &&
>-			(set1->sig[2] =3D=3D set2->sig[2]) &&
>-			(set1->sig[1] =3D=3D set2->sig[1]) &&
>-			(set1->sig[0] =3D=3D set2->sig[0]);
>-	case 2:
>-		return	(set1->sig[1] =3D=3D set2->sig[1]) &&
>-			(set1->sig[0] =3D=3D set2->sig[0]);
>-	case 1:
>-		return	set1->sig[0] =3D=3D set2->sig[0];
>-	}
>+#if _NSIG_WORDS =3D=3D 4
>+	return	(set1->sig[3] =3D=3D set2->sig[3]) &&
>+		(set1->sig[2] =3D=3D set2->sig[2]) &&
>+		(set1->sig[1] =3D=3D set2->sig[1]) &&
>+		(set1->sig[0] =3D=3D set2->sig[0]);
>+#elif _NSIG_WORDS =3D=3D 2
>+	return	(set1->sig[1] =3D=3D set2->sig[1]) &&
>+		(set1->sig[0] =3D=3D set2->sig[0]);
>+#elif _NSIG_WORDS =3D=3D 1
>+	return	set1->sig[0] =3D=3D set2->sig[0];
>+#else
> 	return 0;
>+#endif
> }
>=20
> #define sigmask(sig)	(1UL << ((sig) - 1))
>@@ -125,14 +123,14 @@ static inline void name(sigset_t *r, const
>sigset_t *a, const sigset_t *b) \
> 									\
> 	switch (_NSIG_WORDS) {						\
> 	case 4:								\
>-		a3 =3D a->sig[3]; a2 =3D a->sig[2];				\
>-		b3 =3D b->sig[3]; b2 =3D b->sig[2];				\
>-		r->sig[3] =3D op(a3, b3);					\
>-		r->sig[2] =3D op(a2, b2);					\
>+		a3 =3D a->sig[3%_NSIG_WORDS]; a2 =3D a->sig[2%_NSIG_WORDS];	\
>+		b3 =3D b->sig[3%_NSIG_WORDS]; b2 =3D b->sig[2%_NSIG_WORDS];	\
>+		r->sig[3%_NSIG_WORDS] =3D op(a3, b3);			\
>+		r->sig[2%_NSIG_WORDS] =3D op(a2, b2);			\
> 		/* fall through */					\
> 	case 2:								\
>-		a1 =3D a->sig[1]; b1 =3D b->sig[1];				\
>-		r->sig[1] =3D op(a1, b1);					\
>+		a1 =3D a->sig[1%_NSIG_WORDS]; b1 =3D b->sig[1%_NSIG_WORDS];	\
>+		r->sig[1%_NSIG_WORDS] =3D op(a1, b1);			\
> 		/* fall through */					\
> 	case 1:								\
> 		a0 =3D a->sig[0]; b0 =3D b->sig[0];				\
>@@ -161,10 +159,10 @@ _SIG_SET_BINOP(sigandnsets, _sig_andn)
> static inline void name(sigset_t *set)					\
> {									\
> 	switch (_NSIG_WORDS) {						\
>-	case 4:	set->sig[3] =3D op(set->sig[3]);				\
>-		set->sig[2] =3D op(set->sig[2]);				\
>+	case 4:	set->sig[3%_NSIG_WORDS] =3D op(set->sig[3%_NSIG_WORDS]);	\
>+		set->sig[2%_NSIG_WORDS] =3D op(set->sig[2%_NSIG_WORDS]);	\
> 		/* fall through */					\
>-	case 2:	set->sig[1] =3D op(set->sig[1]);				\
>+	case 2:	set->sig[1%_NSIG_WORDS] =3D op(set->sig[1%_NSIG_WORDS]);	\
> 		/* fall through */					\
> 	case 1:	set->sig[0] =3D op(set->sig[0]);				\
> 		    break;						\
>@@ -185,7 +183,7 @@ static inline void sigemptyset(sigset_t *set)
> 	default:
> 		memset(set, 0, sizeof(sigset_t));
> 		break;
>-	case 2: set->sig[1] =3D 0;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D 0;
> 		/* fall through */
> 	case 1:	set->sig[0] =3D 0;
> 		break;
>@@ -198,7 +196,7 @@ static inline void sigfillset(sigset_t *set)
> 	default:
> 		memset(set, -1, sizeof(sigset_t));
> 		break;
>-	case 2: set->sig[1] =3D -1;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D -1;
> 		/* fall through */
> 	case 1:	set->sig[0] =3D -1;
> 		break;
>@@ -229,7 +227,7 @@ static inline void siginitset(sigset_t *set,
>unsigned long mask)
> 	default:
> 		memset(&set->sig[1], 0, sizeof(long)*(_NSIG_WORDS-1));
> 		break;
>-	case 2: set->sig[1] =3D 0;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D 0;
> 	case 1: ;
> 	}
> }
>@@ -241,7 +239,7 @@ static inline void siginitsetinv(sigset_t *set,
>unsigned long mask)
> 	default:
> 		memset(&set->sig[1], -1, sizeof(long)*(_NSIG_WORDS-1));
> 		break;
>-	case 2: set->sig[1] =3D -1;
>+	case 2: set->sig[1%_NSIG_WORDS] =3D -1;
> 	case 1: ;
> 	}
> }

Ugh, it's not pretty but I don't have any objections=2E :)

Acked-by: Christian Brauner <christian@brauner=2Eio>
