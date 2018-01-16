From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 18/22] signal/blackfin: Move the blackfin specific si_codes to asm-generic/siginfo.h
Date: Mon, 15 Jan 2018 18:40:05 -0600
Message-ID: <20180116004009.31036-18-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Having si_codes in many different files simply encourages duplicate definitions
that can cause problems later.  To avoid that merge the blackfin specific si_codes
into uapi/asm-generic/siginfo.h

Update copy_siginfo_to_user to copy with the absence of BUS_MCEERR_AR that blackfin
defines to be something else.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/blackfin/include/uapi/asm/siginfo.h | 32 --------------------------------
 include/uapi/asm-generic/siginfo.h       | 29 +++++++++++++++++++++++++++--
 kernel/signal.c                          |  9 ++++++---
 3 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/blackfin/include/uapi/asm/siginfo.h b/arch/blackfin/include/uapi/asm/siginfo.h
index b1db506c8d2e..8c505170f4d0 100644
--- a/arch/blackfin/include/uapi/asm/siginfo.h
+++ b/arch/blackfin/include/uapi/asm/siginfo.h
@@ -15,36 +15,4 @@
 
 #define si_uid16	_sifields._kill._uid
 
-#define ILL_ILLPARAOP	2	/* illegal opcode combine ********** */
-#define ILL_ILLEXCPT	4	/* unrecoverable exception ********** */
-#define ILL_CPLB_VI	9	/* D/I CPLB protect violation ******** */
-#define ILL_CPLB_MISS	10	/* D/I CPLB miss ******** */
-#define ILL_CPLB_MULHIT	11	/* D/I CPLB multiple hit ******** */
-#undef NSIGILL
-#define NSIGILL         11
-
-/*
- * SIGBUS si_codes
- */
-#define BUS_OPFETCH	4	/* error from instruction fetch ******** */
-#undef NSIGBUS
-#define NSIGBUS		4
-
-/*
- * SIGTRAP si_codes
- */
-#define TRAP_STEP	1	/* single-step breakpoint************* */
-#define TRAP_TRACEFLOW	2	/* trace buffer overflow ************* */
-#define TRAP_WATCHPT	3	/* watchpoint match      ************* */
-#define TRAP_ILLTRAP	4	/* illegal trap          ************* */
-#undef NSIGTRAP
-#define NSIGTRAP	4
-
-/*
- * SIGSEGV si_codes
- */
-#define SEGV_STACKFLOW	3	/* stack overflow */
-#undef NSIGSEGV
-#define NSIGSEGV	3
-
 #endif /* _UAPI_BFIN_SIGINFO_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 7a268db1c44f..254afc31e3be 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -179,13 +179,24 @@ typedef struct siginfo {
  * SIGILL si_codes
  */
 #define ILL_ILLOPC	1	/* illegal opcode */
+#ifdef __bfin__
+# define ILL_ILLPARAOP	2	/* illegal opcode combine */
+#endif
 #define ILL_ILLOPN	2	/* illegal operand */
 #define ILL_ILLADR	3	/* illegal addressing mode */
 #define ILL_ILLTRP	4	/* illegal trap */
+#ifdef __bfin__
+# define ILL_ILLEXCPT	4	/* unrecoverable exception */
+#endif
 #define ILL_PRVOPC	5	/* privileged opcode */
 #define ILL_PRVREG	6	/* privileged register */
 #define ILL_COPROC	7	/* coprocessor error */
 #define ILL_BADSTK	8	/* internal stack error */
+#ifdef __bfin__
+# define ILL_CPLB_VI	9	/* D/I CPLB protect violation */
+# define ILL_CPLB_MISS	10	/* D/I CPLB miss */
+# define ILL_CPLB_MULHIT 11	/* D/I CPLB multiple hit */
+#endif
 #ifdef __tile__
 # define ILL_DBLFLT	9	/* double fault */
 # define ILL_HARDWALL	10	/* user networks hardwall violation */
@@ -225,7 +236,11 @@ typedef struct siginfo {
  */
 #define SEGV_MAPERR	1	/* address not mapped to object */
 #define SEGV_ACCERR	2	/* invalid permissions for mapped object */
-#define SEGV_BNDERR	3	/* failed address bound checks */
+#ifdef __bfin__
+# define SEGV_STACKFLOW	3	/* stack overflow */
+#else
+# define SEGV_BNDERR	3	/* failed address bound checks */
+#endif
 #ifdef __ia64__
 # define __SEGV_PSTKOVF	4	/* paragraph stack overflow */
 #else
@@ -239,8 +254,12 @@ typedef struct siginfo {
 #define BUS_ADRALN	1	/* invalid address alignment */
 #define BUS_ADRERR	2	/* non-existent physical address */
 #define BUS_OBJERR	3	/* object specific hardware error */
+#ifdef __bfin__
+# define BUS_OPFETCH	4	/* error from instruction fetch */
+#else
 /* hardware memory error consumed on a machine check: action required */
-#define BUS_MCEERR_AR	4
+# define BUS_MCEERR_AR	4
+#endif
 /* hardware memory error detected in process but not consumed: action optional*/
 #define BUS_MCEERR_AO	5
 #define NSIGBUS		5
@@ -252,6 +271,12 @@ typedef struct siginfo {
 #define TRAP_TRACE	2	/* process trace trap */
 #define TRAP_BRANCH     3	/* process taken branch trap */
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
+#ifdef __bfin__
+# define TRAP_STEP	1	/* single-step breakpoint */
+# define TRAP_TRACEFLOW	2	/* trace buffer overflow */
+# define TRAP_WATCHPT	3	/* watchpoint match */
+# define TRAP_ILLTRAP	4	/* illegal trap */
+#endif
 #define NSIGTRAP	4
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index 47c87b1d0b8a..4c3f4448c5f1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2770,13 +2770,16 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 		err |= __put_user(from->si_flags, &to->si_flags);
 		err |= __put_user(from->si_isr, &to->si_isr);
 #endif
-#ifdef BUS_MCEERR_AO
 		/*
 		 * Other callers might not initialize the si_lsb field,
 		 * so check explicitly for the right codes here.
 		 */
-		if (from->si_signo == SIGBUS &&
-		    (from->si_code == BUS_MCEERR_AR || from->si_code == BUS_MCEERR_AO))
+#ifdef BUS_MCEERR_AR
+		if (from->si_signo == SIGBUS && from->si_code == BUS_MCEERR_AR)
+			err |= __put_user(from->si_addr_lsb, &to->si_addr_lsb);
+#endif
+#ifdef BUS_MCEERR_AO
+		if (from->si_signo == SIGBUS && from->si_code == BUS_MCEERR_AO)
 			err |= __put_user(from->si_addr_lsb, &to->si_addr_lsb);
 #endif
 #ifdef SEGV_BNDERR
-- 
2.14.1
