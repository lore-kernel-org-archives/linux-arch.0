From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 08/22] signal/ia64: switch the last arch-specific copy_siginfo_to_user() to generic version
Date: Mon, 15 Jan 2018 18:39:55 -0600
Message-ID: <20180116004009.31036-8-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/include/uapi/asm/siginfo.h |  2 --
 arch/ia64/kernel/signal.c            | 52 ------------------------------------
 kernel/signal.c                      |  9 ++++---
 3 files changed, 5 insertions(+), 58 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/siginfo.h b/arch/ia64/include/uapi/asm/siginfo.h
index 3c5417d66628..66839031b767 100644
--- a/arch/ia64/include/uapi/asm/siginfo.h
+++ b/arch/ia64/include/uapi/asm/siginfo.h
@@ -11,8 +11,6 @@
 
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 
-#define HAVE_ARCH_COPY_SIGINFO_TO_USER
-
 #include <asm-generic/siginfo.h>
 
 #define si_imm		_sifields._sigfault._imm	/* as per UNIX SysV ABI spec */
diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index a254cc98f95c..54547c7cf8a2 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -105,58 +105,6 @@ restore_sigcontext (struct sigcontext __user *sc, struct sigscratch *scr)
 	return err;
 }
 
-int
-copy_siginfo_to_user (siginfo_t __user *to, const siginfo_t *from)
-{
-	if (!access_ok(VERIFY_WRITE, to, sizeof(siginfo_t)))
-		return -EFAULT;
-	if (from->si_code < 0) {
-		if (__copy_to_user(to, from, sizeof(siginfo_t)))
-			return -EFAULT;
-		return 0;
-	} else {
-		int err;
-
-		/*
-		 * If you change siginfo_t structure, please be sure this code is fixed
-		 * accordingly.  It should never copy any pad contained in the structure
-		 * to avoid security leaks, but must copy the generic 3 ints plus the
-		 * relevant union member.
-		 */
-		err = __put_user(from->si_signo, &to->si_signo);
-		err |= __put_user(from->si_errno, &to->si_errno);
-		err |= __put_user(from->si_code, &to->si_code);
-		switch (siginfo_layout(from->si_signo, from->si_code)) {
-		      case SIL_FAULT:
-			err |= __put_user(from->si_flags, &to->si_flags);
-			err |= __put_user(from->si_isr, &to->si_isr);
-		      case SIL_POLL:
-			err |= __put_user(from->si_addr, &to->si_addr);
-			err |= __put_user(from->si_imm, &to->si_imm);
-			break;
-		      case SIL_TIMER:
-			err |= __put_user(from->si_tid, &to->si_tid);
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			err |= __put_user(from->si_ptr, &to->si_ptr);
-			break;
-		      case SIL_RT:
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_ptr, &to->si_ptr);
-			break;
-		      case SIL_CHLD:
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-		      case SIL_KILL:
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_pid, &to->si_pid);
-			break;
-		}
-		return err;
-	}
-}
-
 long
 ia64_rt_sigreturn (struct sigscratch *scr)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 18aa55c1bb4f..62c642899290 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2729,8 +2729,6 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 	return layout;
 }
 
-#ifndef HAVE_ARCH_COPY_SIGINFO_TO_USER
-
 int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 {
 	int err;
@@ -2769,6 +2767,11 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 #ifdef __ARCH_SI_TRAPNO
 		err |= __put_user(from->si_trapno, &to->si_trapno);
 #endif
+#ifdef __ia64__
+		err |= __put_user(from->si_imm, &to->si_imm);
+		err |= __put_user(from->si_flags, &to->si_flags);
+		err |= __put_user(from->si_isr, &to->si_isr);
+#endif
 #ifdef BUS_MCEERR_AO
 		/*
 		 * Other callers might not initialize the si_lsb field,
@@ -2812,8 +2815,6 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 	return err;
 }
 
-#endif
-
 /**
  *  do_sigtimedwait - wait for queued signals specified in @which
  *  @which: queued signals to wait for
-- 
2.14.1
