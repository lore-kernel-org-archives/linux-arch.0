Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:43833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGJNL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 04:13:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] signal: fix building with clang
Date: Thu,  7 Mar 2019 10:11:52 +0100
Message-ID: <20190307091218.2343836-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Nick Desaulniers <ndesaulniers@google.com>, Oleg Nesterov <oleg@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
Message-ID: <20190307091152.oQjy224bW8Uynl-wrdEk2c4HtUbuXlAvWec6iJ6n8cw@z>

clang warns about the sigset_t manipulating functions (sigaddset, sigdelset,
sigisemptyset, ...) because it performs semantic analysis before discarding
dead code, unlike gcc that does this in the reverse order.

The result is a long list of warnings like:

In file included from arch/arm64/include/asm/ftrace.h:21:
include/linux/compat.h:489:10: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
        case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                ^     ~
include/linux/compat.h:138:2: note: array 'sig' declared here
        compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
        ^
include/linux/compat.h:489:42: error: array index 2 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
        case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                                                ^     ~
include/linux/compat.h:138:2: note: array 'sig' declared here
        compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
        ^

As a (rather ugly) workaround, I turn the nice switch()/case statements
into preprocessor conditionals, and where that is not possible, use the
'%' operator to modify the warning case into an operation that clang
will not warn about. Since that only matters for dead code, the actual
behavior does not change.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/uapi/asm/signal.h |  3 +-
 include/linux/signal.h              | 72 ++++++++++++++---------------
 2 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index 53104b10aae2..8e71a2f778f7 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -11,9 +11,10 @@
 #define _UAPI_ASM_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/bitsperlong.h>
 
 #define _NSIG		128
-#define _NSIG_BPW	(sizeof(unsigned long) * 8)
+#define _NSIG_BPW	__BITS_PER_LONG
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
 typedef struct {
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9702016734b1..b967d502ab61 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -82,35 +82,33 @@ static inline int sigismember(sigset_t *set, int _sig)
 
 static inline int sigisemptyset(sigset_t *set)
 {
-	switch (_NSIG_WORDS) {
-	case 4:
-		return (set->sig[3] | set->sig[2] |
-			set->sig[1] | set->sig[0]) == 0;
-	case 2:
-		return (set->sig[1] | set->sig[0]) == 0;
-	case 1:
-		return set->sig[0] == 0;
-	default:
-		BUILD_BUG();
-		return 0;
-	}
+#if _NSIG_WORDS == 4
+	return (set->sig[3] | set->sig[2] |
+		set->sig[1] | set->sig[0]) == 0;
+#elif _NSIG_WORDS == 2
+	return (set->sig[1] | set->sig[0]) == 0;
+#elif _NSIG_WORDS == 1
+	return set->sig[0] == 0;
+#else
+	BUILD_BUG();
+#endif
 }
 
 static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 {
-	switch (_NSIG_WORDS) {
-	case 4:
-		return	(set1->sig[3] == set2->sig[3]) &&
-			(set1->sig[2] == set2->sig[2]) &&
-			(set1->sig[1] == set2->sig[1]) &&
-			(set1->sig[0] == set2->sig[0]);
-	case 2:
-		return	(set1->sig[1] == set2->sig[1]) &&
-			(set1->sig[0] == set2->sig[0]);
-	case 1:
-		return	set1->sig[0] == set2->sig[0];
-	}
+#if _NSIG_WORDS == 4
+	return	(set1->sig[3] == set2->sig[3]) &&
+		(set1->sig[2] == set2->sig[2]) &&
+		(set1->sig[1] == set2->sig[1]) &&
+		(set1->sig[0] == set2->sig[0]);
+#elif _NSIG_WORDS == 2
+	return	(set1->sig[1] == set2->sig[1]) &&
+		(set1->sig[0] == set2->sig[0]);
+#elif _NSIG_WORDS == 1
+	return	set1->sig[0] == set2->sig[0];
+#else
 	return 0;
+#endif
 }
 
 #define sigmask(sig)	(1UL << ((sig) - 1))
@@ -125,14 +123,14 @@ static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
 									\
 	switch (_NSIG_WORDS) {						\
 	case 4:								\
-		a3 = a->sig[3]; a2 = a->sig[2];				\
-		b3 = b->sig[3]; b2 = b->sig[2];				\
-		r->sig[3] = op(a3, b3);					\
-		r->sig[2] = op(a2, b2);					\
+		a3 = a->sig[3%_NSIG_WORDS]; a2 = a->sig[2%_NSIG_WORDS];	\
+		b3 = b->sig[3%_NSIG_WORDS]; b2 = b->sig[2%_NSIG_WORDS];	\
+		r->sig[3%_NSIG_WORDS] = op(a3, b3);			\
+		r->sig[2%_NSIG_WORDS] = op(a2, b2);			\
 		/* fall through */					\
 	case 2:								\
-		a1 = a->sig[1]; b1 = b->sig[1];				\
-		r->sig[1] = op(a1, b1);					\
+		a1 = a->sig[1%_NSIG_WORDS]; b1 = b->sig[1%_NSIG_WORDS];	\
+		r->sig[1%_NSIG_WORDS] = op(a1, b1);			\
 		/* fall through */					\
 	case 1:								\
 		a0 = a->sig[0]; b0 = b->sig[0];				\
@@ -161,10 +159,10 @@ _SIG_SET_BINOP(sigandnsets, _sig_andn)
 static inline void name(sigset_t *set)					\
 {									\
 	switch (_NSIG_WORDS) {						\
-	case 4:	set->sig[3] = op(set->sig[3]);				\
-		set->sig[2] = op(set->sig[2]);				\
+	case 4:	set->sig[3%_NSIG_WORDS] = op(set->sig[3%_NSIG_WORDS]);	\
+		set->sig[2%_NSIG_WORDS] = op(set->sig[2%_NSIG_WORDS]);	\
 		/* fall through */					\
-	case 2:	set->sig[1] = op(set->sig[1]);				\
+	case 2:	set->sig[1%_NSIG_WORDS] = op(set->sig[1%_NSIG_WORDS]);	\
 		/* fall through */					\
 	case 1:	set->sig[0] = op(set->sig[0]);				\
 		    break;						\
@@ -185,7 +183,7 @@ static inline void sigemptyset(sigset_t *set)
 	default:
 		memset(set, 0, sizeof(sigset_t));
 		break;
-	case 2: set->sig[1] = 0;
+	case 2: set->sig[1%_NSIG_WORDS] = 0;
 		/* fall through */
 	case 1:	set->sig[0] = 0;
 		break;
@@ -198,7 +196,7 @@ static inline void sigfillset(sigset_t *set)
 	default:
 		memset(set, -1, sizeof(sigset_t));
 		break;
-	case 2: set->sig[1] = -1;
+	case 2: set->sig[1%_NSIG_WORDS] = -1;
 		/* fall through */
 	case 1:	set->sig[0] = -1;
 		break;
@@ -229,7 +227,7 @@ static inline void siginitset(sigset_t *set, unsigned long mask)
 	default:
 		memset(&set->sig[1], 0, sizeof(long)*(_NSIG_WORDS-1));
 		break;
-	case 2: set->sig[1] = 0;
+	case 2: set->sig[1%_NSIG_WORDS] = 0;
 	case 1: ;
 	}
 }
@@ -241,7 +239,7 @@ static inline void siginitsetinv(sigset_t *set, unsigned long mask)
 	default:
 		memset(&set->sig[1], -1, sizeof(long)*(_NSIG_WORDS-1));
 		break;
-	case 2: set->sig[1] = -1;
+	case 2: set->sig[1%_NSIG_WORDS] = -1;
 	case 1: ;
 	}
 }
-- 
2.20.0
