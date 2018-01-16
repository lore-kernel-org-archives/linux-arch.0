From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 09/22] signal/mips: switch mips to generic siginfo
Date: Mon, 15 Jan 2018 18:39:56 -0600
Message-ID: <20180116004009.31036-9-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... having taught the latter that si_errno and si_code might be
swapped.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/mips/include/uapi/asm/siginfo.h | 86 +-----------------------------------
 include/uapi/asm-generic/siginfo.h   |  5 +++
 2 files changed, 6 insertions(+), 85 deletions(-)

diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index f17d8163dec6..262504bd59a5 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -14,8 +14,6 @@
 #define __ARCH_SIGEV_PREAMBLE_SIZE (sizeof(long) + 2*sizeof(int))
 #undef __ARCH_SI_TRAPNO /* exception code needs to fill this ...  */
 
-#define HAVE_ARCH_SIGINFO_T
-
 /*
  * Careful to keep union _sifields from shifting ...
  */
@@ -27,92 +25,10 @@
 #error _MIPS_SZLONG neither 32 nor 64
 #endif
 
-#define __ARCH_SIGSYS
+#define __ARCH_HAS_SWAPPED_SIGINFO
 
 #include <asm-generic/siginfo.h>
 
-/* We can't use generic siginfo_t, because our si_code and si_errno are swapped */
-typedef struct siginfo {
-	int si_signo;
-	int si_code;
-	int si_errno;
-	int __pad0[SI_MAX_SIZE / sizeof(int) - SI_PAD_SIZE - 3];
-
-	union {
-		int _pad[SI_PAD_SIZE];
-
-		/* kill() */
-		struct {
-			__kernel_pid_t _pid;	/* sender's pid */
-			__ARCH_SI_UID_T _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			__kernel_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
-			sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			__kernel_pid_t _pid;	/* sender's pid */
-			__ARCH_SI_UID_T _uid;	/* sender's uid */
-			sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			__kernel_pid_t _pid;	/* which child */
-			__ARCH_SI_UID_T _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			__kernel_clock_t _utime;
-			__kernel_clock_t _stime;
-		} _sigchld;
-
-		/* IRIX SIGCHLD */
-		struct {
-			__kernel_pid_t _pid;	/* which child */
-			__kernel_clock_t _utime;
-			int _status;		/* exit code */
-			__kernel_clock_t _stime;
-		} _irix_sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			void __user *_addr; /* faulting insn/memory ref. */
-#ifdef __ARCH_SI_TRAPNO
-			int _trapno;	/* TRAP # which caused the signal */
-#endif
-			short _addr_lsb;
-			union {
-				/* used when si_code=SEGV_BNDERR */
-				struct {
-					void __user *_lower;
-					void __user *_upper;
-				} _addr_bnd;
-				/* used when si_code=SEGV_PKUERR */
-				__u32 _pkey;
-			};
-		} _sigfault;
-
-		/* SIGPOLL, SIGXFSZ (To do ...)	 */
-		struct {
-			__ARCH_SI_BAND_T _band; /* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		/* SIGSYS */
-		struct {
-			void __user *_call_addr; /* calling user insn */
-			int _syscall;	/* triggering system call number */
-			unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} siginfo_t;
-
 /*
  * si_code values
  * Again these have been chosen to be IRIX compatible.
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 1555805c5ac8..00829f74dcb6 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -48,8 +48,13 @@ typedef union sigval {
 
 typedef struct siginfo {
 	int si_signo;
+#ifndef __ARCH_HAS_SWAPPED_SIGINFO
 	int si_errno;
 	int si_code;
+#else
+	int si_code;
+	int si_errno;
+#endif
 
 	union {
 		int _pad[SI_PAD_SIZE];
-- 
2.14.1
