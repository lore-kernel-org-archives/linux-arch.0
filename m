From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 15/22] signal/ia64: Move the ia64 specific si_codes to asm-generic/siginfo.h
Date: Mon, 15 Jan 2018 18:40:02 -0600
Message-ID: <20180116004009.31036-15-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Having si_codes in many different files simply encourages duplicate
definitions that can cause problems later.  To avoid that merge the
ia64 specific si_codes into uapi/asm-generic/siginfo.h

Update the sanity checks in arch/x86/kernel/signal_compat.c to expect
the now lager NSIGILL and NSIGFPE.  As nothing excpe the larger count
is exposed on x86 no additional code needs to be updated.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/include/uapi/asm/siginfo.h | 27 ---------------------------
 arch/x86/kernel/signal_compat.c      |  4 ++--
 include/uapi/asm-generic/siginfo.h   | 22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/siginfo.h b/arch/ia64/include/uapi/asm/siginfo.h
index 66839031b767..5aa454ed89db 100644
--- a/arch/ia64/include/uapi/asm/siginfo.h
+++ b/arch/ia64/include/uapi/asm/siginfo.h
@@ -27,38 +27,11 @@
 #define __ISR_VALID_BIT	0
 #define __ISR_VALID	(1 << __ISR_VALID_BIT)
 
-/*
- * SIGILL si_codes
- */
-#define ILL_BADIADDR	9	/* unimplemented instruction address */
-#define __ILL_BREAK	10	/* illegal break */
-#define __ILL_BNDMOD	11	/* bundle-update (modification) in progress */
-#undef NSIGILL
-#define NSIGILL		11
-
 /*
  * SIGFPE si_codes
  */
 #ifdef __KERNEL__
 #define FPE_FIXME	0	/* Broken dup of SI_USER */
 #endif /* __KERNEL__ */
-#define __FPE_DECOVF	9	/* decimal overflow */
-#define __FPE_DECDIV	10	/* decimal division by zero */
-#define __FPE_DECERR	11	/* packed decimal error */
-#define __FPE_INVASC	12	/* invalid ASCII digit */
-#define __FPE_INVDEC	13	/* invalid decimal digit */
-#undef NSIGFPE
-#define NSIGFPE		13
-
-/*
- * SIGSEGV si_codes
- */
-#define __SEGV_PSTKOVF	4	/* paragraph stack overflow */
-#undef NSIGSEGV
-#define NSIGSEGV	4
-
-#undef NSIGTRAP
-#define NSIGTRAP	4
-
 
 #endif /* _UAPI_ASM_IA64_SIGINFO_H */
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 27495909932d..feb3ac135d0c 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -25,8 +25,8 @@ static inline void signal_compat_build_tests(void)
 	 * limits also have to look at this code.  Make sure any
 	 * new fields are handled in copy_siginfo_to_user32()!
 	 */
-	BUILD_BUG_ON(NSIGILL  != 8);
-	BUILD_BUG_ON(NSIGFPE  != 8);
+	BUILD_BUG_ON(NSIGILL  != 11);
+	BUILD_BUG_ON(NSIGFPE  != 13);
 	BUILD_BUG_ON(NSIGSEGV != 4);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 4);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index eef4d778a5d4..2f0ae4607603 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -186,7 +186,12 @@ typedef struct siginfo {
 #define ILL_PRVREG	6	/* privileged register */
 #define ILL_COPROC	7	/* coprocessor error */
 #define ILL_BADSTK	8	/* internal stack error */
-#define NSIGILL		8
+#ifdef __ia64__
+# define ILL_BADIADDR	9	/* unimplemented instruction address */
+# define __ILL_BREAK	10	/* illegal break */
+# define __ILL_BNDMOD	11	/* bundle-update (modification) in progress */
+#endif
+#define NSIGILL		11
 
 /*
  * SIGFPE si_codes
@@ -199,7 +204,14 @@ typedef struct siginfo {
 #define FPE_FLTRES	6	/* floating point inexact result */
 #define FPE_FLTINV	7	/* floating point invalid operation */
 #define FPE_FLTSUB	8	/* subscript out of range */
-#define NSIGFPE		8
+#ifdef __ia64__
+# define __FPE_DECOVF	9	/* decimal overflow */
+# define __FPE_DECDIV	10	/* decimal division by zero */
+# define __FPE_DECERR	11	/* packed decimal error */
+# define __FPE_INVASC	12	/* invalid ASCII digit */
+# define __FPE_INVDEC	13	/* invalid decimal digit */
+#endif
+#define NSIGFPE		13
 
 /*
  * SIGSEGV si_codes
@@ -207,7 +219,11 @@ typedef struct siginfo {
 #define SEGV_MAPERR	1	/* address not mapped to object */
 #define SEGV_ACCERR	2	/* invalid permissions for mapped object */
 #define SEGV_BNDERR	3	/* failed address bound checks */
-#define SEGV_PKUERR	4	/* failed protection key checks */
+#ifdef __ia64__
+# define __SEGV_PSTKOVF	4	/* paragraph stack overflow */
+#else
+# define SEGV_PKUERR	4	/* failed protection key checks */
+#endif
 #define NSIGSEGV	4
 
 /*
-- 
2.14.1
