From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Date: Wed, 14 Mar 2018 15:43:47 +0100
Message-ID: <20180314144614.1632190-2-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314144614.1632190-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314144614.1632190-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

The frv, tile and blackfin architectures are being removed, so
we can clean up this header by removing all the special cases
except those for ia64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/siginfo.h | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 85dc965afd89..b2ebf16c391a 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -179,28 +179,13 @@ typedef struct siginfo {
  * SIGILL si_codes
  */
 #define ILL_ILLOPC	1	/* illegal opcode */
-#ifdef __bfin__
-# define ILL_ILLPARAOP	2	/* illegal opcode combine */
-#endif
 #define ILL_ILLOPN	2	/* illegal operand */
 #define ILL_ILLADR	3	/* illegal addressing mode */
 #define ILL_ILLTRP	4	/* illegal trap */
-#ifdef __bfin__
-# define ILL_ILLEXCPT	4	/* unrecoverable exception */
-#endif
 #define ILL_PRVOPC	5	/* privileged opcode */
 #define ILL_PRVREG	6	/* privileged register */
 #define ILL_COPROC	7	/* coprocessor error */
 #define ILL_BADSTK	8	/* internal stack error */
-#ifdef __bfin__
-# define ILL_CPLB_VI	9	/* D/I CPLB protect violation */
-# define ILL_CPLB_MISS	10	/* D/I CPLB miss */
-# define ILL_CPLB_MULHIT 11	/* D/I CPLB multiple hit */
-#endif
-#ifdef __tile__
-# define ILL_DBLFLT	9	/* double fault */
-# define ILL_HARDWALL	10	/* user networks hardwall violation */
-#endif
 #ifdef __ia64__
 # define ILL_BADIADDR	9	/* unimplemented instruction address */
 # define __ILL_BREAK	10	/* illegal break */
@@ -219,9 +204,6 @@ typedef struct siginfo {
 #define FPE_FLTRES	6	/* floating point inexact result */
 #define FPE_FLTINV	7	/* floating point invalid operation */
 #define FPE_FLTSUB	8	/* subscript out of range */
-#ifdef __frv__
-# define FPE_MDAOVF	9	/* media overflow */
-#endif
 #ifdef __ia64__
 # define __FPE_DECOVF	9	/* decimal overflow */
 # define __FPE_DECDIV	10	/* decimal division by zero */
@@ -236,11 +218,7 @@ typedef struct siginfo {
  */
 #define SEGV_MAPERR	1	/* address not mapped to object */
 #define SEGV_ACCERR	2	/* invalid permissions for mapped object */
-#ifdef __bfin__
-# define SEGV_STACKFLOW	3	/* stack overflow */
-#else
-# define SEGV_BNDERR	3	/* failed address bound checks */
-#endif
+#define SEGV_BNDERR	3	/* failed address bound checks */
 #ifdef __ia64__
 # define __SEGV_PSTKOVF	4	/* paragraph stack overflow */
 #else
@@ -254,12 +232,8 @@ typedef struct siginfo {
 #define BUS_ADRALN	1	/* invalid address alignment */
 #define BUS_ADRERR	2	/* non-existent physical address */
 #define BUS_OBJERR	3	/* object specific hardware error */
-#ifdef __bfin__
-# define BUS_OPFETCH	4	/* error from instruction fetch */
-#else
 /* hardware memory error consumed on a machine check: action required */
-# define BUS_MCEERR_AR	4
-#endif
+#define BUS_MCEERR_AR	4
 /* hardware memory error detected in process but not consumed: action optional*/
 #define BUS_MCEERR_AO	5
 #define NSIGBUS		5
@@ -271,12 +245,6 @@ typedef struct siginfo {
 #define TRAP_TRACE	2	/* process trace trap */
 #define TRAP_BRANCH     3	/* process taken branch trap */
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
-#ifdef __bfin__
-# define TRAP_STEP	1	/* single-step breakpoint */
-# define TRAP_TRACEFLOW	2	/* trace buffer overflow */
-# define TRAP_WATCHPT	3	/* watchpoint match */
-# define TRAP_ILLTRAP	4	/* illegal trap */
-#endif
 #define NSIGTRAP	4
 
 /*
-- 
2.9.0
