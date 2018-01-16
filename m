From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 07/22] ia64/signal: switch to generic struct siginfo
Date: Mon, 15 Jan 2018 18:39:54 -0600
Message-ID: <20180116004009.31036-7-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

... at a cost of added small ifdef __ia64__ in asm-generic siginfo.h,
that is.

-- EWB Corrected the comment on _flags to reflect the move

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/include/uapi/asm/siginfo.h | 67 ------------------------------------
 include/uapi/asm-generic/siginfo.h   |  5 +++
 2 files changed, 5 insertions(+), 67 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/siginfo.h b/arch/ia64/include/uapi/asm/siginfo.h
index f3a02a10c3a3..3c5417d66628 100644
--- a/arch/ia64/include/uapi/asm/siginfo.h
+++ b/arch/ia64/include/uapi/asm/siginfo.h
@@ -11,77 +11,10 @@
 
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 
-#define HAVE_ARCH_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
-typedef struct siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-	int __pad0;
-
-	union {
-		int _pad[SI_PAD_SIZE];
-
-		/* kill() */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			timer_t _tid;		/* timer id */
-			int _overrun;		/* overrun count */
-			char _pad[sizeof(__ARCH_SI_UID_T) - sizeof(int)];
-			sigval_t _sigval;	/* must overlay ._rt._sigval! */
-			int _sys_private;	/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
-			sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			pid_t _pid;		/* which child */
-			uid_t _uid;		/* sender's uid */
-			int _status;		/* exit code */
-			clock_t _utime;
-			clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			void __user *_addr;	/* faulting insn/memory ref. */
-			int _imm;		/* immediate value for "break" */
-			unsigned int _flags;	/* see below */
-			unsigned long _isr;	/* isr */
-			short _addr_lsb;	/* lsb of faulting address */
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
-		/* SIGPOLL */
-		struct {
-			long _band;	/* POLL_IN, POLL_OUT, POLL_MSG (XPG requires a "long") */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} siginfo_t;
-
 #define si_imm		_sifields._sigfault._imm	/* as per UNIX SysV ABI spec */
 #define si_flags	_sifields._sigfault._flags
 /*
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 2d3348afb2f0..1555805c5ac8 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -90,6 +90,11 @@ typedef struct siginfo {
 			void __user *_addr; /* faulting insn/memory ref. */
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
+#endif
+#ifdef __ia64__
+			int _imm;		/* immediate value for "break" */
+			unsigned int _flags;	/* see ia64 si_flags */
+			unsigned long _isr;	/* isr */
 #endif
 			short _addr_lsb; /* LSB of the reported address */
 			union {
-- 
2.14.1
