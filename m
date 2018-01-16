From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 10/22] signal: Remove unnecessary ifdefs now that there is only one struct siginfo
Date: Mon, 15 Jan 2018 18:39:57 -0600
Message-ID: <20180116004009.31036-10-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Remove HAVE_ARCH_SIGINFO_T
Remove __ARCH_SIGSYS

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h             | 2 --
 include/uapi/asm-generic/siginfo.h | 8 --------
 kernel/signal.c                    | 4 ----
 3 files changed, 14 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 87abf0c29ed7..a9bc7e1b077e 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -30,9 +30,7 @@ enum siginfo_layout {
 	SIL_FAULT,
 	SIL_CHLD,
 	SIL_RT,
-#ifdef __ARCH_SIGSYS
 	SIL_SYS,
-#endif
 };
 
 enum siginfo_layout siginfo_layout(int sig, int si_code);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 00829f74dcb6..a650d252de0a 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -44,8 +44,6 @@ typedef union sigval {
 #define __ARCH_SI_ATTRIBUTES
 #endif
 
-#ifndef HAVE_ARCH_SIGINFO_T
-
 typedef struct siginfo {
 	int si_signo;
 #ifndef __ARCH_HAS_SWAPPED_SIGINFO
@@ -128,10 +126,6 @@ typedef struct siginfo {
 	} _sifields;
 } __ARCH_SI_ATTRIBUTES siginfo_t;
 
-/* If the arch shares siginfo, then it has SIGSYS. */
-#define __ARCH_SIGSYS
-#endif
-
 /*
  * How these fields are to be accessed.
  */
@@ -156,11 +150,9 @@ typedef struct siginfo {
 #define si_pkey		_sifields._sigfault._pkey
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
-#ifdef __ARCH_SIGSYS
 #define si_call_addr	_sifields._sigsys._call_addr
 #define si_syscall	_sifields._sigsys._syscall
 #define si_arch		_sifields._sigsys._arch
-#endif
 
 /*
  * si_code values
diff --git a/kernel/signal.c b/kernel/signal.c
index 62c642899290..47c87b1d0b8a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2697,9 +2697,7 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 #endif
 			[SIGCHLD] = { NSIGCHLD, SIL_CHLD },
 			[SIGPOLL] = { NSIGPOLL, SIL_POLL },
-#ifdef __ARCH_SIGSYS
 			[SIGSYS]  = { NSIGSYS,  SIL_SYS },
-#endif
 		};
 		if ((sig < ARRAY_SIZE(filter)) && (si_code <= filter[sig].limit))
 			layout = filter[sig].layout;
@@ -2804,13 +2802,11 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 		err |= __put_user(from->si_uid, &to->si_uid);
 		err |= __put_user(from->si_ptr, &to->si_ptr);
 		break;
-#ifdef __ARCH_SIGSYS
 	case SIL_SYS:
 		err |= __put_user(from->si_call_addr, &to->si_call_addr);
 		err |= __put_user(from->si_syscall, &to->si_syscall);
 		err |= __put_user(from->si_arch, &to->si_arch);
 		break;
-#endif
 	}
 	return err;
 }
-- 
2.14.1
