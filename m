From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 12/22] signal: unify compat_siginfo_t
Date: Mon, 15 Jan 2018 18:39:59 -0600
Message-ID: <20180116004009.31036-12-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

--EWB Added #ifdef CONFIG_X86_X32_ABI to arch/x86/kernel/signal_compat.c
      Changed #ifdef CONFIG_X86_X32 to #ifdef CONFIG_X86_X32_ABI in
      linux/compat.h

      CONFIG_X86_X32 is set when the user requests X32 support.

      CONFIG_X86_X32_ABI is set when the user requests X32 support
      and the tool-chain has X32 allowing X32 support to be built.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/arm64/include/asm/compat.h   | 63 ---------------------------
 arch/mips/include/asm/compat.h    | 71 ------------------------------
 arch/parisc/include/asm/compat.h  | 63 ---------------------------
 arch/powerpc/include/asm/compat.h | 62 ---------------------------
 arch/s390/include/asm/compat.h    | 72 -------------------------------
 arch/sparc/include/asm/compat.h   | 56 ------------------------
 arch/tile/include/asm/compat.h    | 58 -------------------------
 arch/x86/include/asm/compat.h     | 80 ----------------------------------
 arch/x86/kernel/signal_compat.c   |  4 ++
 include/linux/compat.h            | 90 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 94 insertions(+), 525 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index dd32fe19ec58..c00c62e1a4a3 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -150,69 +150,6 @@ typedef u32		compat_old_sigset_t;
 
 typedef u32		compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[128/sizeof(int) - 3];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid32_t _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid32_t _uid;	/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;	/* which child */
-			__compat_uid32_t _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			compat_uptr_t _addr; /* faulting insn/memory ref. */
-			short _addr_lsb; /* LSB of the reported address */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			compat_long_t _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		/* SIGSYS */
-		struct {
-			compat_uptr_t _call_addr; /* calling user insn */
-			int _syscall;	/* triggering system call number */
-			compat_uint_t _arch;	/* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 49691331ada4..fe7d445f675f 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -126,79 +126,8 @@ typedef u32		compat_old_sigset_t;	/* at least 32 bits */
 
 typedef u32		compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
-/* Can't use the generic version because si_code and si_errno are swapped */
-
 #define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_code;
-	int si_errno;
-
-	union {
-		int _pad[128 / sizeof(int) - 3];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid32_t _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid32_t _uid;	/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;	/* which child */
-			__compat_uid32_t _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			compat_uptr_t _addr;	/* faulting insn/memory ref. */
-#ifdef __ARCH_SI_TRAPNO
-			int _trapno;	/* TRAP # which caused the signal */
-#endif
-			short _addr_lsb; /* LSB of the reported address */
-			struct {
-				compat_uptr_t _lower;
-				compat_uptr_t _upper;
-			} _addr_bnd;
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			compat_long_t _band; /* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		struct {
-			compat_uptr_t _call_addr; /* calling insn */
-			int _syscall;	/* triggering system call number */
-			compat_uint_t _arch;	/* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index cf3bcacec027..c22db5323244 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -130,69 +130,6 @@ typedef u32		compat_old_sigset_t;	/* at least 32 bits */
 
 typedef u32		compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[128/sizeof(int) - 3];
-
-		/* kill() */
-		struct {
-			unsigned int _pid;      /* sender's pid */
-			unsigned int _uid;      /* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;            /* timer id */
-			int _overrun;           /* overrun count */
-			char _pad[sizeof(unsigned int) - sizeof(int)];
-			compat_sigval_t _sigval;        /* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			unsigned int _pid;      /* sender's pid */
-			unsigned int _uid;      /* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			unsigned int _pid;      /* which child */
-			unsigned int _uid;      /* sender's uid */
-			int _status;            /* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			unsigned int _addr;     /* faulting insn/memory ref. */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;      /* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		/* SIGSYS */
-		struct {
-			compat_uptr_t _call_addr; /* calling user insn */
-			int _syscall;	/* triggering system call number */
-			compat_uint_t _arch;	/* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 struct compat_ipc64_perm {
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index e02de2fd56e3..8a2363221b0c 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -119,70 +119,8 @@ typedef u32		compat_old_sigset_t;
 
 typedef u32		compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
 #define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE32];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			__compat_uid_t _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;		/* timer id */
-			int _overrun;			/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			__compat_uid_t _uid;		/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;		/* which child */
-			__compat_uid_t _uid;		/* sender's uid */
-			int _status;			/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			unsigned int _addr; /* faulting insn/memory ref. */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		/* SIGSYS */
-		struct {
-			unsigned int _call_addr; /* calling insn */
-			int _syscall;		 /* triggering system call number */
-			unsigned int _arch;	 /* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 3a187c4932a5..9830fb6b076e 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -189,78 +189,6 @@ typedef u32		compat_old_sigset_t;	/* at least 32 bits */
 
 typedef u32		compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
-typedef struct compat_siginfo {
-	int	si_signo;
-	int	si_errno;
-	int	si_code;
-
-	union {
-		int _pad[128/sizeof(int) - 3];
-
-		/* kill() */
-		struct {
-			pid_t	_pid;	/* sender's pid */
-			uid_t	_uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;		/* timer id */
-			int _overrun;			/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			pid_t			_pid;	/* sender's pid */
-			uid_t			_uid;	/* sender's uid */
-			compat_sigval_t		_sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			pid_t			_pid;	/* which child */
-			uid_t			_uid;	/* sender's uid */
-			int			_status;/* exit code */
-			compat_clock_t		_utime;
-			compat_clock_t		_stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			__u32	_addr;	/* faulting insn/memory ref. - pointer */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int	_band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int	_fd;
-		} _sigpoll;
-	} _sifields;
-} compat_siginfo_t;
-
-/*
- * How these fields are to be accessed.
- */
-#define si_pid		_sifields._kill._pid
-#define si_uid		_sifields._kill._uid
-#define si_status	_sifields._sigchld._status
-#define si_utime	_sifields._sigchld._utime
-#define si_stime	_sifields._sigchld._stime
-#define si_value	_sifields._rt._sigval
-#define si_int		_sifields._rt._sigval.sival_int
-#define si_ptr		_sifields._rt._sigval.sival_ptr
-#define si_addr		_sifields._sigfault._addr
-#define si_band		_sifields._sigpoll._band
-#define si_fd		_sifields._sigpoll._fd
-#define si_tid		_sifields._timer._tid
-#define si_overrun	_sifields._timer._overrun
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 2d9f4fd5f74a..c3688ae98b90 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -149,64 +149,8 @@ typedef u32		compat_old_sigset_t;
 
 typedef u32		compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
 #define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE32];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;		/* timer id */
-			int _overrun;			/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;		/* which child */
-			unsigned int _uid;		/* sender's uid */
-			int _status;			/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			u32 _addr; /* faulting insn/memory ref. */
-			int _trapno;
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
index 59ab9fa784b3..c6b7613256b4 100644
--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -110,66 +110,8 @@ struct compat_flock64 {
 
 typedef u32               compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
 #define COMPAT_SI_PAD_SIZE	(128/sizeof(int) - 3)
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[COMPAT_SI_PAD_SIZE];
-
-		/* kill() */
-		struct {
-			unsigned int _pid;	/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			unsigned int _pid;	/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			unsigned int _pid;	/* which child */
-			unsigned int _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			unsigned int _addr;	/* faulting insn/memory ref. */
-#ifdef __ARCH_SI_TRAPNO
-			int _trapno;	/* TRAP # which caused the signal */
-#endif
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 struct compat_ipc64_perm {
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 1b6886a78562..0b76fc91f672 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -127,86 +127,6 @@ typedef u32		compat_old_sigset_t;	/* at least 32 bits */
 
 typedef u32               compat_sigset_word;
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[128/sizeof(int) - 3];
-
-		/* kill() */
-		struct {
-			unsigned int _pid;	/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			unsigned int _pid;	/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			unsigned int _pid;	/* which child */
-			unsigned int _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGCHLD (x32 version) */
-		struct {
-			unsigned int _pid;	/* which child */
-			unsigned int _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			compat_s64 _utime;
-			compat_s64 _stime;
-		} _sigchld_x32;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			unsigned int _addr;	/* faulting insn/memory ref. */
-			short int _addr_lsb;	/* Valid LSB of the reported address. */
-			union {
-				/* used when si_code=SEGV_BNDERR */
-				struct {
-					compat_uptr_t _lower;
-					compat_uptr_t _upper;
-				} _addr_bnd;
-				/* used when si_code=SEGV_PKUERR */
-				compat_u32 _pkey;
-			};
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		struct {
-			unsigned int _call_addr; /* calling insn */
-			int _syscall;	/* triggering system call number */
-			unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 struct compat_ipc64_perm {
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 85425ea30661..27495909932d 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -75,9 +75,11 @@ static inline void signal_compat_build_tests(void)
 	CHECK_CSI_SIZE  (_sigchld, 5*sizeof(int));
 	CHECK_SI_SIZE   (_sigchld, 8*sizeof(int));
 
+#ifdef CONFIG_X86_X32_ABI
 	CHECK_CSI_OFFSET(_sigchld_x32);
 	CHECK_CSI_SIZE  (_sigchld_x32, 7*sizeof(int));
 	/* no _sigchld_x32 in the generic siginfo_t */
+#endif
 
 	CHECK_CSI_OFFSET(_sigfault);
 	CHECK_CSI_SIZE  (_sigfault, 4*sizeof(int));
@@ -169,9 +171,11 @@ int __copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from,
 				if (!x32_ABI) {
 					put_user_ex(from->si_utime, &to->si_utime);
 					put_user_ex(from->si_stime, &to->si_stime);
+#ifdef CONFIG_X86_X32_ABI
 				} else {
 					put_user_ex(from->si_utime, &to->_sifields._sigchld_x32._utime);
 					put_user_ex(from->si_stime, &to->_sifields._sigchld_x32._stime);
+#endif
 				}
 				put_user_ex(from->si_status, &to->si_status);
 				/* FALL THROUGH */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 0fc36406f32c..8f8e3ef247de 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -157,6 +157,96 @@ struct compat_sigaction {
 	compat_sigset_t			sa_mask __packed;
 };
 
+typedef union compat_sigval {
+	compat_int_t	sival_int;
+	compat_uptr_t	sival_ptr;
+} compat_sigval_t;
+
+typedef struct compat_siginfo {
+	int si_signo;
+#ifndef __ARCH_HAS_SWAPPED_SIGINFO
+	int si_errno;
+	int si_code;
+#else
+	int si_code;
+	int si_errno;
+#endif
+
+	union {
+		int _pad[128/sizeof(int) - 3];
+
+		/* kill() */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			__compat_uid32_t _uid;	/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			compat_timer_t _tid;	/* timer id */
+			int _overrun;		/* overrun count */
+			compat_sigval_t _sigval;	/* same as below */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			__compat_uid32_t _uid;	/* sender's uid */
+			compat_sigval_t _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			compat_pid_t _pid;	/* which child */
+			__compat_uid32_t _uid;	/* sender's uid */
+			int _status;		/* exit code */
+			compat_clock_t _utime;
+			compat_clock_t _stime;
+		} _sigchld;
+
+#ifdef CONFIG_X86_X32_ABI
+		/* SIGCHLD (x32 version) */
+		struct {
+			compat_pid_t _pid;	/* which child */
+			__compat_uid32_t _uid;	/* sender's uid */
+			int _status;		/* exit code */
+			compat_s64 _utime;
+			compat_s64 _stime;
+		} _sigchld_x32;
+#endif
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
+		struct {
+			compat_uptr_t _addr;	/* faulting insn/memory ref. */
+#ifdef __ARCH_SI_TRAPNO
+			int _trapno;	/* TRAP # which caused the signal */
+#endif
+			short int _addr_lsb;	/* Valid LSB of the reported address. */
+			union {
+				/* used when si_code=SEGV_BNDERR */
+				struct {
+					compat_uptr_t _lower;
+					compat_uptr_t _upper;
+				} _addr_bnd;
+				/* used when si_code=SEGV_PKUERR */
+				u32 _pkey;
+			};
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			compat_long_t _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			int _fd;
+		} _sigpoll;
+
+		struct {
+			compat_uptr_t _call_addr; /* calling user insn */
+			int _syscall;	/* triggering system call number */
+			unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
+		} _sigsys;
+	} _sifields;
+} compat_siginfo_t;
+
 /*
  * These functions operate on 32- or 64-bit specs depending on
  * COMPAT_USE_64BIT_TIME, hence the void user pointer arguments.
-- 
2.14.1
