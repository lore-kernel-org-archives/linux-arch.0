From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 22/22] signal: Unify and correct copy_siginfo_to_user32
Date: Mon, 15 Jan 2018 18:40:09 -0600
Message-ID: <20180116004009.31036-22-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Among the existing architecture specific versions of
copy_siginfo_to_user32 there are several different implementation
problems.  Some architectures fail to handle all of the cases in in
the siginfo union.  Some architectures perform a blind copy of the
siginfo union when the si_code is negative.  A blind copy suggests the
data is expected to be in 32bit siginfo format, which means that
receiving such a signal via signalfd won't work, or that the data is
in 64bit siginfo and the code is copying nonsense to userspace.

Create a single instance of copy_siginfo_to_user32 that all of the
architectures can share, and teach it to handle all of the cases in
the siginfo union correctly, with the assumption that siginfo is
stored internally to the kernel is 64bit siginfo format.

A special case is made for x86 x32 format.  This is needed as presence
of both x32 and ia32 on x86_64 results in two different 32bit signal
formats.  By allowing this small special case there winds up being
exactly one code base that needs to be maintained between all of the
architectures.  Vastly increasing the testing base and the chances of
finding bugs.

As the x86 copy of copy_siginfo_to_user32 the call of the x86
signal_compat_build_tests were moved into sigaction_compat_abi, so
that they will keep running.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/signal32.c      | 70 ----------------------------
 arch/mips/include/asm/compat.h    |  2 -
 arch/mips/kernel/signal32.c       | 57 -----------------------
 arch/parisc/kernel/signal32.c     | 62 -------------------------
 arch/parisc/kernel/signal32.h     |  2 -
 arch/powerpc/include/asm/compat.h |  2 -
 arch/powerpc/kernel/signal_32.c   | 57 -----------------------
 arch/s390/kernel/compat_signal.c  | 52 ---------------------
 arch/sparc/include/asm/compat.h   |  2 -
 arch/sparc/kernel/signal32.c      | 53 ---------------------
 arch/tile/include/asm/compat.h    |  2 -
 arch/tile/kernel/compat_signal.c  | 55 ----------------------
 arch/x86/include/asm/compat.h     |  4 ++
 arch/x86/include/asm/fpu/signal.h |  6 ---
 arch/x86/kernel/signal_compat.c   | 96 +--------------------------------------
 kernel/signal.c                   | 90 ++++++++++++++++++++++++++++++++++++
 16 files changed, 96 insertions(+), 516 deletions(-)

diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 4377907dbb70..cbc4edd1b1eb 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -125,76 +125,6 @@ static inline int get_sigset_t(sigset_t *set,
 	return 0;
 }
 
-int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
-{
-	int err;
-
-	if (!access_ok(VERIFY_WRITE, to, sizeof(*to)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please be sure
-	 * this code is fixed accordingly.
-	 * It should never copy any pad contained in the structure
-	 * to avoid security leaks, but must copy the generic
-	 * 3 ints plus the relevant union member.
-	 * This routine must convert siginfo from 64bit to 32bit as well
-	 * at the same time.
-	 */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user(from->si_code, &to->si_code);
-	if (from->si_code < 0)
-		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad,
-				      SI_PAD_SIZE);
-	else switch (siginfo_layout(from->si_signo, from->si_code)) {
-	case SIL_KILL:
-		err |= __put_user(from->si_pid, &to->si_pid);
-		err |= __put_user(from->si_uid, &to->si_uid);
-		break;
-	case SIL_TIMER:
-		 err |= __put_user(from->si_tid, &to->si_tid);
-		 err |= __put_user(from->si_overrun, &to->si_overrun);
-		 err |= __put_user(from->si_int, &to->si_int);
-		break;
-	case SIL_POLL:
-		err |= __put_user(from->si_band, &to->si_band);
-		err |= __put_user(from->si_fd, &to->si_fd);
-		break;
-	case SIL_FAULT:
-		err |= __put_user((compat_uptr_t)(unsigned long)from->si_addr,
-				  &to->si_addr);
-#ifdef BUS_MCEERR_AO
-		/*
-		 * Other callers might not initialize the si_lsb field,
-		 * so check explicitly for the right codes here.
-		 */
-		if (from->si_signo == SIGBUS &&
-		    (from->si_code == BUS_MCEERR_AR || from->si_code == BUS_MCEERR_AO))
-			err |= __put_user(from->si_addr_lsb, &to->si_addr_lsb);
-#endif
-		break;
-	case SIL_CHLD:
-		err |= __put_user(from->si_pid, &to->si_pid);
-		err |= __put_user(from->si_uid, &to->si_uid);
-		err |= __put_user(from->si_status, &to->si_status);
-		err |= __put_user(from->si_utime, &to->si_utime);
-		err |= __put_user(from->si_stime, &to->si_stime);
-		break;
-	case SIL_RT:
-		err |= __put_user(from->si_pid, &to->si_pid);
-		err |= __put_user(from->si_uid, &to->si_uid);
-		err |= __put_user(from->si_int, &to->si_int);
-		break;
-	case SIL_SYS:
-		err |= __put_user((compat_uptr_t)(unsigned long)
-				from->si_call_addr, &to->si_call_addr);
-		err |= __put_user(from->si_syscall, &to->si_syscall);
-		err |= __put_user(from->si_arch, &to->si_arch);
-		break;
-	}
-	return err;
-}
-
 /*
  * VFP save/restore code.
  *
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index fe7d445f675f..946681db8dc3 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -126,8 +126,6 @@ typedef u32		compat_old_sigset_t;	/* at least 32 bits */
 
 typedef u32		compat_sigset_word;
 
-#define SI_PAD_SIZE32	(128/sizeof(int) - 3)
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 500b5e4634ea..c4db910a8794 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -76,60 +76,3 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
 
 	return ret;
 }
-
-int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
-{
-	int err;
-
-	if (!access_ok (VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please be sure
-	   this code is fixed accordingly.
-	   It should never copy any pad contained in the structure
-	   to avoid security leaks, but must copy the generic
-	   3 ints plus the relevant union member.
-	   This routine must convert siginfo from 64bit to 32bit as well
-	   at the same time.  */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user(from->si_code, &to->si_code);
-	if (from->si_code < 0)
-		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (siginfo_layout(from->si_signo, from->si_code)) {
-		case SIL_TIMER:
-			err |= __put_user(from->si_tid, &to->si_tid);
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		case SIL_CHLD:
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-		case SIL_KILL:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			break;
-		case SIL_FAULT:
-			err |= __put_user((unsigned long)from->si_addr, &to->si_addr);
-			break;
-		case SIL_POLL:
-			err |= __put_user(from->si_band, &to->si_band);
-			err |= __put_user(from->si_fd, &to->si_fd);
-			break;
-		case SIL_RT:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		case SIL_SYS:
-			err |= __copy_to_user(&to->si_call_addr, &from->si_call_addr,
-					      sizeof(compat_uptr_t));
-			err |= __put_user(from->si_syscall, &to->si_syscall);
-			err |= __put_user(from->si_arch, &to->si_arch);
-			break;
-		}
-	}
-	return err;
-}
diff --git a/arch/parisc/kernel/signal32.c b/arch/parisc/kernel/signal32.c
index 558e32475c35..e8ef3eb69449 100644
--- a/arch/parisc/kernel/signal32.c
+++ b/arch/parisc/kernel/signal32.c
@@ -260,65 +260,3 @@ setup_sigcontext32(struct compat_sigcontext __user *sc, struct compat_regfile __
 
 	return err;
 }
-
-int
-copy_siginfo_to_user32 (compat_siginfo_t __user *to, const siginfo_t *from)
-{
-	compat_uptr_t addr;
-	compat_int_t val;
-	int err;
-
-	if (!access_ok(VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please be sure
-	   this code is fixed accordingly.
-	   It should never copy any pad contained in the structure
-	   to avoid security leaks, but must copy the generic
-	   3 ints plus the relevant union member.
-	   This routine must convert siginfo from 64bit to 32bit as well
-	   at the same time.  */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user(from->si_code, &to->si_code);
-	if (from->si_code < 0)
-		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (siginfo_layout(from->si_signo, from->si_code)) {
-		case SIL_CHLD:
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-		case SIL_KILL:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			break;
-		case SIL_FAULT:
-			addr = ptr_to_compat(from->si_addr);
-			err |= __put_user(addr, &to->si_addr);
-			break;
-		case SIL_POLL:
-			err |= __put_user(from->si_band, &to->si_band);
-			err |= __put_user(from->si_fd, &to->si_fd);
-			break;
-		case SIL_TIMER:
-			err |= __put_user(from->si_tid, &to->si_tid);
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			val = (compat_int_t)from->si_int;
-			err |= __put_user(val, &to->si_int);
-			break;
-		case SIL_RT:
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_pid, &to->si_pid);
-			val = (compat_int_t)from->si_int;
-			err |= __put_user(val, &to->si_int);
-			break;
-		case SIL_SYS:
-			err |= __put_user(ptr_to_compat(from->si_call_addr), &to->si_call_addr);
-			err |= __put_user(from->si_syscall, &to->si_syscall);
-			err |= __put_user(from->si_arch, &to->si_arch);
-			break;
-		}
-	}
-	return err;
-}
diff --git a/arch/parisc/kernel/signal32.h b/arch/parisc/kernel/signal32.h
index d25858e4db63..a271dc0976ce 100644
--- a/arch/parisc/kernel/signal32.h
+++ b/arch/parisc/kernel/signal32.h
@@ -34,8 +34,6 @@ struct compat_ucontext {
 
 /* ELF32 signal handling */
 
-int copy_siginfo_to_user32 (compat_siginfo_t __user *to, const siginfo_t *from);
-
 /* In a deft move of uber-hackery, we decide to carry the top half of all
  * 64-bit registers in a non-portable, non-ABI, hidden structure.
  * Userspace can read the hidden structure if it *wants* but is never
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 8a2363221b0c..62168e1158f1 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -119,8 +119,6 @@ typedef u32		compat_old_sigset_t;
 
 typedef u32		compat_sigset_word;
 
-#define SI_PAD_SIZE32	(128/sizeof(int) - 3)
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index ee62ff7b296c..aded81169648 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -873,63 +873,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 #endif
 
 #ifdef CONFIG_PPC64
-int copy_siginfo_to_user32(struct compat_siginfo __user *d, const siginfo_t *s)
-{
-	int err;
-
-	if (!access_ok (VERIFY_WRITE, d, sizeof(*d)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please be sure
-	 * this code is fixed accordingly.
-	 * It should never copy any pad contained in the structure
-	 * to avoid security leaks, but must copy the generic
-	 * 3 ints plus the relevant union member.
-	 * This routine must convert siginfo from 64bit to 32bit as well
-	 * at the same time.
-	 */
-	err = __put_user(s->si_signo, &d->si_signo);
-	err |= __put_user(s->si_errno, &d->si_errno);
-	err |= __put_user(s->si_code, &d->si_code);
-	if (s->si_code < 0)
-		err |= __copy_to_user(&d->_sifields._pad, &s->_sifields._pad,
-				      SI_PAD_SIZE32);
-	else switch(siginfo_layout(s->si_signo, s->si_code)) {
-	case SIL_CHLD:
-		err |= __put_user(s->si_pid, &d->si_pid);
-		err |= __put_user(s->si_uid, &d->si_uid);
-		err |= __put_user(s->si_utime, &d->si_utime);
-		err |= __put_user(s->si_stime, &d->si_stime);
-		err |= __put_user(s->si_status, &d->si_status);
-		break;
-	case SIL_FAULT:
-		err |= __put_user((unsigned int)(unsigned long)s->si_addr,
-				  &d->si_addr);
-		break;
-	case SIL_POLL:
-		err |= __put_user(s->si_band, &d->si_band);
-		err |= __put_user(s->si_fd, &d->si_fd);
-		break;
-	case SIL_TIMER:
-		err |= __put_user(s->si_tid, &d->si_tid);
-		err |= __put_user(s->si_overrun, &d->si_overrun);
-		err |= __put_user(s->si_int, &d->si_int);
-		break;
-	case SIL_SYS:
-		err |= __put_user(ptr_to_compat(s->si_call_addr), &d->si_call_addr);
-		err |= __put_user(s->si_syscall, &d->si_syscall);
-		err |= __put_user(s->si_arch, &d->si_arch);
-		break;
-	case SIL_RT:
-		err |= __put_user(s->si_int, &d->si_int);
-		/* fallthrough */
-	case SIL_KILL:
-		err |= __put_user(s->si_pid, &d->si_pid);
-		err |= __put_user(s->si_uid, &d->si_uid);
-		break;
-	}
-	return err;
-}
 
 #define copy_siginfo_to_user	copy_siginfo_to_user32
 
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index d77ce14ffa5c..18c1eeb847b2 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -50,58 +50,6 @@ typedef struct
 	struct ucontext32 uc;
 } rt_sigframe32;
 
-int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
-{
-	int err;
-
-	/* If you change siginfo_t structure, please be sure
-	   this code is fixed accordingly.
-	   It should never copy any pad contained in the structure
-	   to avoid security leaks, but must copy the generic
-	   3 ints plus the relevant union member.  
-	   This routine must convert siginfo from 64bit to 32bit as well
-	   at the same time.  */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user(from->si_code, &to->si_code);
-	if (from->si_code < 0)
-		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (siginfo_layout(from->si_signo, from->si_code)) {
-		case SIL_RT:
-			err |= __put_user(from->si_int, &to->si_int);
-			/* fallthrough */
-		case SIL_KILL:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			break;
-		case SIL_CHLD:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-			break;
-		case SIL_FAULT:
-			err |= __put_user((unsigned long) from->si_addr,
-					  &to->si_addr);
-			break;
-		case SIL_POLL:
-			err |= __put_user(from->si_band, &to->si_band);
-			err |= __put_user(from->si_fd, &to->si_fd);
-			break;
-		case SIL_TIMER:
-			err |= __put_user(from->si_tid, &to->si_tid);
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		default:
-			break;
-		}
-	}
-	return err ? -EFAULT : 0;
-}
-
 /* Store registers needed to create the signal frame */
 static void store_sigregs(void)
 {
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index c3688ae98b90..615283e16f22 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -149,8 +149,6 @@ typedef u32		compat_old_sigset_t;
 
 typedef u32		compat_sigset_word;
 
-#define SI_PAD_SIZE32	(128/sizeof(int) - 3)
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 /*
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 8022bb4c65a5..44d379db3f64 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -70,59 +70,6 @@ struct rt_signal_frame32 {
 	/* __siginfo_rwin_t * */u32 rwin_save;
 } __attribute__((aligned(8)));
 
-int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
-{
-	int err;
-
-	if (!access_ok(VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please be sure
-	   this code is fixed accordingly.
-	   It should never copy any pad contained in the structure
-	   to avoid security leaks, but must copy the generic
-	   3 ints plus the relevant union member.
-	   This routine must convert siginfo from 64bit to 32bit as well
-	   at the same time.  */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user(from->si_code, &to->si_code);
-	if (from->si_code < 0)
-		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (siginfo_layout(from->si_signo, from->si_code)) {
-		case SIL_TIMER:
-			err |= __put_user(from->si_tid, &to->si_tid);
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		case SIL_CHLD:
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-		default:
-		case SIL_KILL:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			break;
-		case SIL_FAULT:
-			err |= __put_user(from->si_trapno, &to->si_trapno);
-			err |= __put_user((unsigned long)from->si_addr, &to->si_addr);
-			break;
-		case SIL_POLL:
-			err |= __put_user(from->si_band, &to->si_band);
-			err |= __put_user(from->si_fd, &to->si_fd);
-			break;
-		case SIL_RT:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		}
-	}
-	return err;
-}
-
 /* Checks if the fp is valid.  We always build signal frames which are
  * 16-byte aligned, therefore we can always enforce that the restore
  * frame has that property as well.
diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
index c6b7613256b4..769ff6ac0bf5 100644
--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -110,8 +110,6 @@ struct compat_flock64 {
 
 typedef u32               compat_sigset_word;
 
-#define COMPAT_SI_PAD_SIZE	(128/sizeof(int) - 3)
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
 struct compat_ipc64_perm {
diff --git a/arch/tile/kernel/compat_signal.c b/arch/tile/kernel/compat_signal.c
index 4e7f40a10eb3..a703bd0e0488 100644
--- a/arch/tile/kernel/compat_signal.c
+++ b/arch/tile/kernel/compat_signal.c
@@ -50,61 +50,6 @@ struct compat_rt_sigframe {
 	struct compat_ucontext uc;
 };
 
-int copy_siginfo_to_user32(struct compat_siginfo __user *to, const siginfo_t *from)
-{
-	int err;
-
-	if (!access_ok(VERIFY_WRITE, to, sizeof(struct compat_siginfo)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please make sure that
-	   this code is fixed accordingly.
-	   It should never copy any pad contained in the structure
-	   to avoid security leaks, but must copy the generic
-	   3 ints plus the relevant union member.  */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user(from->si_code, &to->si_code);
-
-	if (from->si_code < 0) {
-		err |= __put_user(from->si_pid, &to->si_pid);
-		err |= __put_user(from->si_uid, &to->si_uid);
-		err |= __put_user(from->si_int, &to->si_int);
-	} else {
-		/*
-		 * First 32bits of unions are always present:
-		 * si_pid === si_band === si_tid === si_addr(LS half)
-		 */
-		err |= __put_user(from->_sifields._pad[0],
-				  &to->_sifields._pad[0]);
-		switch (siginfo_layout(from->si_signo, from->si_code)) {
-		case SIL_FAULT:
-			break;
-		case SIL_CHLD:
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-			/* FALL THROUGH */
-		default:
-		case SIL_KILL:
-			err |= __put_user(from->si_uid, &to->si_uid);
-			break;
-		case SIL_POLL:
-			err |= __put_user(from->si_fd, &to->si_fd);
-			break;
-		case SIL_TIMER:
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		case SIL_RT:
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		}
-	}
-	return err;
-}
-
 /* The assembly shim for this function arranges to ignore the return value. */
 long compat_sys_rt_sigreturn(void)
 {
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 0b76fc91f672..e1c8dab86670 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -249,4 +249,8 @@ static inline bool in_compat_syscall(void)
 }
 #define in_compat_syscall in_compat_syscall	/* override the generic impl */
 
+struct compat_siginfo;
+int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
+		const siginfo_t *from, bool x32_ABI);
+
 #endif /* _ASM_X86_COMPAT_H */
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 4df2754ef380..44bbc39a57b3 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -20,12 +20,6 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 # define ia32_setup_rt_frame	__setup_rt_frame
 #endif
 
-#ifdef CONFIG_COMPAT
-int __copy_siginfo_to_user32(compat_siginfo_t __user *to,
-		const siginfo_t *from, bool x32_ABI);
-#endif
-
-
 extern void convert_from_fxsr(struct user_i387_ia32_struct *env,
 			      struct task_struct *tsk);
 extern void convert_to_fxsr(struct task_struct *tsk,
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 59148de2d83f..ac057f9b0763 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -98,6 +98,8 @@ static inline void signal_compat_build_tests(void)
 
 void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
 {
+	signal_compat_build_tests();
+
 	/* Don't leak in-kernel non-uapi flags to user-space */
 	if (oact)
 		oact->sa.sa_flags &= ~(SA_IA32_ABI | SA_X32_ABI);
@@ -113,97 +115,3 @@ void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
 	if (in_x32_syscall())
 		act->sa.sa_flags |= SA_X32_ABI;
 }
-
-int __copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from,
-		bool x32_ABI)
-{
-	int err = 0;
-
-	signal_compat_build_tests();
-
-	if (!access_ok(VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	put_user_try {
-		/* If you change siginfo_t structure, please make sure that
-		   this code is fixed accordingly.
-		   It should never copy any pad contained in the structure
-		   to avoid security leaks, but must copy the generic
-		   3 ints plus the relevant union member.  */
-		put_user_ex(from->si_signo, &to->si_signo);
-		put_user_ex(from->si_errno, &to->si_errno);
-		put_user_ex(from->si_code, &to->si_code);
-
-		if (from->si_code < 0) {
-			put_user_ex(from->si_pid, &to->si_pid);
-			put_user_ex(from->si_uid, &to->si_uid);
-			put_user_ex(ptr_to_compat(from->si_ptr), &to->si_ptr);
-		} else {
-			/*
-			 * First 32bits of unions are always present:
-			 * si_pid === si_band === si_tid === si_addr(LS half)
-			 */
-			put_user_ex(from->_sifields._pad[0],
-					  &to->_sifields._pad[0]);
-			switch (siginfo_layout(from->si_signo, from->si_code)) {
-			case SIL_FAULT:
-				if (from->si_signo == SIGBUS &&
-				    (from->si_code == BUS_MCEERR_AR ||
-				     from->si_code == BUS_MCEERR_AO))
-					put_user_ex(from->si_addr_lsb, &to->si_addr_lsb);
-
-				if (from->si_signo == SIGSEGV) {
-					if (from->si_code == SEGV_BNDERR) {
-						compat_uptr_t lower = (unsigned long)from->si_lower;
-						compat_uptr_t upper = (unsigned long)from->si_upper;
-						put_user_ex(lower, &to->si_lower);
-						put_user_ex(upper, &to->si_upper);
-					}
-					if (from->si_code == SEGV_PKUERR)
-						put_user_ex(from->si_pkey, &to->si_pkey);
-				}
-				break;
-			case SIL_SYS:
-				put_user_ex(from->si_syscall, &to->si_syscall);
-				put_user_ex(from->si_arch, &to->si_arch);
-				break;
-			case SIL_CHLD:
-				if (!x32_ABI) {
-					put_user_ex(from->si_utime, &to->si_utime);
-					put_user_ex(from->si_stime, &to->si_stime);
-#ifdef CONFIG_X86_X32_ABI
-				} else {
-					put_user_ex(from->si_utime, &to->_sifields._sigchld_x32._utime);
-					put_user_ex(from->si_stime, &to->_sifields._sigchld_x32._stime);
-#endif
-				}
-				put_user_ex(from->si_status, &to->si_status);
-				/* FALL THROUGH */
-			case SIL_KILL:
-				put_user_ex(from->si_uid, &to->si_uid);
-				break;
-			case SIL_POLL:
-				put_user_ex(from->si_fd, &to->si_fd);
-				break;
-			case SIL_TIMER:
-				put_user_ex(from->si_overrun, &to->si_overrun);
-				put_user_ex(ptr_to_compat(from->si_ptr),
-					    &to->si_ptr);
-				break;
-			case SIL_RT:
-				put_user_ex(from->si_uid, &to->si_uid);
-				put_user_ex(from->si_int, &to->si_int);
-				break;
-			}
-		}
-	} put_user_catch(err);
-
-	return err;
-}
-
-/* from syscall's path, where we know the ABI */
-int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
-{
-	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
-}
-
diff --git a/kernel/signal.c b/kernel/signal.c
index bebe44265b8b..069edfef7828 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2815,6 +2815,96 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 }
 
 #ifdef CONFIG_COMPAT
+int copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			   const struct siginfo *from)
+#ifdef CONFIG_X86_X32_ABI
+{
+	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
+}
+int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			     const struct siginfo *from, bool x32_ABI)
+#endif /* CONFIG_X86_X32_ABI */
+{
+	struct compat_siginfo new;
+	memset(&new, 0, sizeof(new));
+
+	new.si_signo = from->si_signo;
+	new.si_errno = from->si_errno;
+	new.si_code  = from->si_code;
+	switch(siginfo_layout(from->si_signo, from->si_code)) {
+	case SIL_KILL:
+		new.si_pid = from->si_pid;
+		new.si_uid = from->si_uid;
+		break;
+	case SIL_TIMER:
+		new.si_tid     = from->si_tid;
+		new.si_overrun = from->si_overrun;
+		new.si_int     = from->si_int;
+		break;
+	case SIL_POLL:
+		new.si_band = from->si_band;
+		new.si_fd   = from->si_fd;
+		break;
+	case SIL_FAULT:
+		new.si_addr = ptr_to_compat(from->si_addr);
+#ifdef __ARCH_SI_TRAPNO
+		new.si_trapno = from->si_trapno;
+#endif
+#ifdef BUS_MCEERR_AR
+		if ((from->si_signo == SIGBUS) && (from->si_code == BUS_MCEERR_AR))
+			new.si_addr_lsb = from->si_addr_lsb;
+#endif
+#ifdef BUS_MCEERR_AO
+		if ((from->si_signo == SIGBUS) && (from->si_code == BUS_MCEERR_AO))
+			new.si_addr_lsb = from->si_addr_lsb;
+#endif
+#ifdef SEGV_BNDERR
+		if ((from->si_signo == SIGSEGV) &&
+		    (from->si_code == SEGV_BNDERR)) {
+			new.si_lower = ptr_to_compat(from->si_lower);
+			new.si_upper = ptr_to_compat(from->si_upper);
+		}
+#endif
+#ifdef SEGV_PKUERR
+		if ((from->si_signo == SIGSEGV) &&
+		    (from->si_code == SEGV_PKUERR))
+			new.si_pkey = from->si_pkey;
+#endif
+
+		break;
+	case SIL_CHLD:
+		new.si_pid    = from->si_pid;
+		new.si_uid    = from->si_uid;
+		new.si_status = from->si_status;
+#ifdef CONFIG_X86_X32_ABI
+		if (x32_ABI) {
+			new._sifields._sigchld_x32._utime = from->si_utime;
+			new._sifields._sigchld_x32._stime = from->si_stime;
+		} else
+#endif
+		{
+			new.si_utime = from->si_utime;
+			new.si_stime = from->si_stime;
+		}
+		break;
+	case SIL_RT:
+		new.si_pid = from->si_pid;
+		new.si_uid = from->si_uid;
+		new.si_int = from->si_int;
+		break;
+	case SIL_SYS:
+		new.si_call_addr = ptr_to_compat(from->si_call_addr);
+		new.si_syscall   = from->si_syscall;
+		new.si_arch      = from->si_arch;
+		break;
+	}
+
+	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
+		return -EFAULT;
+
+	return 0;
+}
+
 int copy_siginfo_from_user32(struct siginfo *to,
 			     const struct compat_siginfo __user *ufrom)
 {
-- 
2.14.1
