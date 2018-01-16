From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 20/22] signal: Unify and correct copy_siginfo_from_user32
Date: Mon, 15 Jan 2018 18:40:07 -0600
Message-ID: <20180116004009.31036-20-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The function copy_siginfo_from_user32 is used for two things, in ptrace
since the dawn of siginfo for arbirarily modifying a signal that
user space sees, and in sigqueueinfo to send a signal with arbirary
siginfo data.

Create a single copy of copy_siginfo_from_user32 that all architectures
share, and teach it to handle all of the cases in the siginfo union.

In the generic version of copy_siginfo_from_user32 ensure that all
of the fields in siginfo are initialized so that the siginfo structure
can be safely copied to userspace if necessary.

When copying the embedded sigval union copy the si_int member.  That
ensures the 32bit values passes through the kernel unchanged.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/signal32.c     | 10 -----
 arch/mips/kernel/signal32.c      | 10 -----
 arch/parisc/kernel/signal32.c    | 44 ----------------------
 arch/parisc/kernel/signal32.h    |  1 -
 arch/powerpc/kernel/signal_32.c  |  9 -----
 arch/s390/kernel/compat_signal.c | 48 ------------------------
 arch/sparc/kernel/signal32.c     | 16 --------
 arch/tile/kernel/compat_signal.c | 18 ---------
 arch/x86/kernel/signal_compat.c  | 21 -----------
 include/linux/compat.h           |  2 +-
 kernel/signal.c                  | 81 ++++++++++++++++++++++++++++++++++++++++
 11 files changed, 82 insertions(+), 178 deletions(-)

diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 22711ee8e36c..4377907dbb70 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -195,16 +195,6 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 	return err;
 }
 
-int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
-{
-	if (copy_from_user(to, from, __ARCH_SI_PREAMBLE_SIZE) ||
-	    copy_from_user(to->_sifields._pad,
-			   from->_sifields._pad, SI_PAD_SIZE))
-		return -EFAULT;
-
-	return 0;
-}
-
 /*
  * VFP save/restore code.
  *
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index cf5c7c05e5a3..500b5e4634ea 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -133,13 +133,3 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 	}
 	return err;
 }
-
-int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
-{
-	if (copy_from_user(to, from, 3*sizeof(int)) ||
-	    copy_from_user(to->_sifields._pad,
-			   from->_sifields._pad, SI_PAD_SIZE32))
-		return -EFAULT;
-
-	return 0;
-}
diff --git a/arch/parisc/kernel/signal32.c b/arch/parisc/kernel/signal32.c
index 41afa9cd1f55..558e32475c35 100644
--- a/arch/parisc/kernel/signal32.c
+++ b/arch/parisc/kernel/signal32.c
@@ -261,50 +261,6 @@ setup_sigcontext32(struct compat_sigcontext __user *sc, struct compat_regfile __
 	return err;
 }
 
-int
-copy_siginfo_from_user32 (siginfo_t *to, compat_siginfo_t __user *from)
-{
-	compat_uptr_t addr;
-	int err;
-
-	if (!access_ok(VERIFY_READ, from, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	err = __get_user(to->si_signo, &from->si_signo);
-	err |= __get_user(to->si_errno, &from->si_errno);
-	err |= __get_user(to->si_code, &from->si_code);
-
-	if (to->si_code < 0)
-		err |= __copy_from_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (siginfo_layout(to->si_signo, to->si_code)) {
-		      case SIL_CHLD:
-			err |= __get_user(to->si_utime, &from->si_utime);
-			err |= __get_user(to->si_stime, &from->si_stime);
-			err |= __get_user(to->si_status, &from->si_status);
-		      default:
-		      case SIL_KILL:
-			err |= __get_user(to->si_pid, &from->si_pid);
-			err |= __get_user(to->si_uid, &from->si_uid);
-			break;
-		      case SIL_FAULT:
-			err |= __get_user(addr, &from->si_addr);
-			to->si_addr = compat_ptr(addr);
-			break;
-		      case SIL_POLL:
-			err |= __get_user(to->si_band, &from->si_band);
-			err |= __get_user(to->si_fd, &from->si_fd);
-			break;
-		      case SIL_RT:
-			err |= __get_user(to->si_pid, &from->si_pid);
-			err |= __get_user(to->si_uid, &from->si_uid);
-			err |= __get_user(to->si_int, &from->si_int);
-			break;
-		}
-	}
-	return err;
-}
-
 int
 copy_siginfo_to_user32 (compat_siginfo_t __user *to, const siginfo_t *from)
 {
diff --git a/arch/parisc/kernel/signal32.h b/arch/parisc/kernel/signal32.h
index 719e7417732c..d25858e4db63 100644
--- a/arch/parisc/kernel/signal32.h
+++ b/arch/parisc/kernel/signal32.h
@@ -35,7 +35,6 @@ struct compat_ucontext {
 /* ELF32 signal handling */
 
 int copy_siginfo_to_user32 (compat_siginfo_t __user *to, const siginfo_t *from);
-int copy_siginfo_from_user32 (siginfo_t *to, compat_siginfo_t __user *from);
 
 /* In a deft move of uber-hackery, we decide to carry the top half of all
  * 64-bit registers in a non-portable, non-ABI, hidden structure.
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 9ffd73296f64..ee62ff7b296c 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -933,15 +933,6 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *d, const siginfo_t *s)
 
 #define copy_siginfo_to_user	copy_siginfo_to_user32
 
-int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from)
-{
-	if (copy_from_user(to, from, 3*sizeof(int)) ||
-	    copy_from_user(to->_sifields._pad,
-			   from->_sifields._pad, SI_PAD_SIZE32))
-		return -EFAULT;
-
-	return 0;
-}
 #endif /* CONFIG_PPC64 */
 
 /*
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index ef246940b44c..d77ce14ffa5c 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -102,54 +102,6 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 	return err ? -EFAULT : 0;
 }
 
-int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
-{
-	int err;
-	u32 tmp;
-
-	err = __get_user(to->si_signo, &from->si_signo);
-	err |= __get_user(to->si_errno, &from->si_errno);
-	err |= __get_user(to->si_code, &from->si_code);
-
-	if (to->si_code < 0)
-		err |= __copy_from_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (siginfo_layout(to->si_signo, to->si_code)) {
-		case SIL_RT:
-			err |= __get_user(to->si_int, &from->si_int);
-			/* fallthrough */
-		case SIL_KILL:
-			err |= __get_user(to->si_pid, &from->si_pid);
-			err |= __get_user(to->si_uid, &from->si_uid);
-			break;
-		case SIL_CHLD:
-			err |= __get_user(to->si_pid, &from->si_pid);
-			err |= __get_user(to->si_uid, &from->si_uid);
-			err |= __get_user(to->si_utime, &from->si_utime);
-			err |= __get_user(to->si_stime, &from->si_stime);
-			err |= __get_user(to->si_status, &from->si_status);
-			break;
-		case SIL_FAULT:
-			err |= __get_user(tmp, &from->si_addr);
-			to->si_addr = (void __force __user *)
-				(u64) (tmp & PSW32_ADDR_INSN);
-			break;
-		case SIL_POLL:
-			err |= __get_user(to->si_band, &from->si_band);
-			err |= __get_user(to->si_fd, &from->si_fd);
-			break;
-		case SIL_TIMER:
-			err |= __get_user(to->si_tid, &from->si_tid);
-			err |= __get_user(to->si_overrun, &from->si_overrun);
-			err |= __get_user(to->si_int, &from->si_int);
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
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 54a6159b9cd8..8022bb4c65a5 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -123,22 +123,6 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 	return err;
 }
 
-/* CAUTION: This is just a very minimalist implementation for the
- *          sake of compat_sys_rt_sigqueueinfo()
- */
-int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
-{
-	if (!access_ok(VERIFY_WRITE, from, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	if (copy_from_user(to, from, 3*sizeof(int)) ||
-	    copy_from_user(to->_sifields._pad, from->_sifields._pad,
-			   SI_PAD_SIZE))
-		return -EFAULT;
-
-	return 0;
-}
-
 /* Checks if the fp is valid.  We always build signal frames which are
  * 16-byte aligned, therefore we can always enforce that the restore
  * frame has that property as well.
diff --git a/arch/tile/kernel/compat_signal.c b/arch/tile/kernel/compat_signal.c
index 971d87a1d8cf..4e7f40a10eb3 100644
--- a/arch/tile/kernel/compat_signal.c
+++ b/arch/tile/kernel/compat_signal.c
@@ -105,24 +105,6 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to, const siginfo_t *fr
 	return err;
 }
 
-int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from)
-{
-	int err;
-
-	if (!access_ok(VERIFY_READ, from, sizeof(struct compat_siginfo)))
-		return -EFAULT;
-
-	err = __get_user(to->si_signo, &from->si_signo);
-	err |= __get_user(to->si_errno, &from->si_errno);
-	err |= __get_user(to->si_code, &from->si_code);
-
-	err |= __get_user(to->si_pid, &from->si_pid);
-	err |= __get_user(to->si_uid, &from->si_uid);
-	err |= __get_user(to->si_int, &from->si_int);
-
-	return err;
-}
-
 /* The assembly shim for this function arranges to ignore the return value. */
 long compat_sys_rt_sigreturn(void)
 {
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index feb3ac135d0c..59148de2d83f 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -207,24 +207,3 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
 }
 
-int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
-{
-	int err = 0;
-	u32 ptr32;
-
-	if (!access_ok(VERIFY_READ, from, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	get_user_try {
-		get_user_ex(to->si_signo, &from->si_signo);
-		get_user_ex(to->si_errno, &from->si_errno);
-		get_user_ex(to->si_code, &from->si_code);
-
-		get_user_ex(to->si_pid, &from->si_pid);
-		get_user_ex(to->si_uid, &from->si_uid);
-		get_user_ex(ptr32, &from->si_ptr);
-		to->si_ptr = compat_ptr(ptr32);
-	} get_user_catch(err);
-
-	return err;
-}
diff --git a/include/linux/compat.h b/include/linux/compat.h
index e698ec1908d9..8a9643857c4a 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -510,7 +510,7 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		       unsigned long bitmap_size);
 long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 		       unsigned long bitmap_size);
-int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from);
+int copy_siginfo_from_user32(siginfo_t *to, const struct compat_siginfo __user *from);
 int copy_siginfo_to_user32(struct compat_siginfo __user *to, const siginfo_t *from);
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
diff --git a/kernel/signal.c b/kernel/signal.c
index 4c3f4448c5f1..5211b1b57163 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2814,6 +2814,87 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+int copy_siginfo_from_user32(struct siginfo *to,
+			     const struct compat_siginfo __user *ufrom)
+{
+	struct compat_siginfo from;
+
+	if (copy_from_user(&from, ufrom, sizeof(struct compat_siginfo)))
+		return -EFAULT;
+
+	clear_siginfo(to);
+	to->si_signo = from.si_signo;
+	to->si_errno = from.si_errno;
+	to->si_code  = from.si_code;
+	switch(siginfo_layout(from.si_signo, from.si_code)) {
+	case SIL_KILL:
+		to->si_pid = from.si_pid;
+		to->si_uid = from.si_uid;
+		break;
+	case SIL_TIMER:
+		to->si_tid     = from.si_tid;
+		to->si_overrun = from.si_overrun;
+		to->si_int     = from.si_int;
+		break;
+	case SIL_POLL:
+		to->si_band = from.si_band;
+		to->si_fd   = from.si_fd;
+		break;
+	case SIL_FAULT:
+		to->si_addr = compat_ptr(from.si_addr);
+#ifdef __ARCH_SI_TRAPNO
+		to->si_trapno = from.si_trapno;
+#endif
+#ifdef BUS_MCEERR_AR
+		if ((from.si_signo == SIGBUS) && (from.si_code == BUS_MCEERR_AR))
+			to->si_addr_lsb = from.si_addr_lsb;
+#endif
+#ifdef BUS_MCEER_AO
+		if ((from.si_signo == SIGBUS) && (from.si_code == BUS_MCEERR_AO))
+			to->si_addr_lsb = from.si_addr_lsb;
+#endif
+#ifdef SEGV_BNDERR
+		if ((from.si_signo == SIGSEGV) && (from.si_code == SEGV_BNDERR)) {
+			to->si_lower = compat_ptr(from.si_lower);
+			to->si_upper = compat_ptr(from.si_upper);
+		}
+#endif
+#ifdef SEGV_PKUERR
+		if ((from.si_signo == SIGSEGV) && (from.si_code == SEGV_PKUERR))
+			to->si_pkey = from.si_pkey;
+#endif
+		break;
+	case SIL_CHLD:
+		to->si_pid    = from.si_pid;
+		to->si_uid    = from.si_uid;
+		to->si_status = from.si_status;
+#ifdef CONFIG_X86_X32_ABI
+		if (in_x32_syscall()) {
+			to->si_utime = from._sifields._sigchld_x32._utime;
+			to->si_stime = from._sifields._sigchld_x32._stime;
+		} else
+#endif
+		{
+			to->si_utime = from.si_utime;
+			to->si_stime = from.si_stime;
+		}
+		break;
+	case SIL_RT:
+		to->si_pid = from.si_pid;
+		to->si_uid = from.si_uid;
+		to->si_int = from.si_int;
+		break;
+	case SIL_SYS:
+		to->si_call_addr = compat_ptr(from.si_call_addr);
+		to->si_syscall   = from.si_syscall;
+		to->si_arch      = from.si_arch;
+		break;
+	}
+	return 0;
+}
+#endif /* CONFIG_COMPAT */
+
 /**
  *  do_sigtimedwait - wait for queued signals specified in @which
  *  @which: queued signals to wait for
-- 
2.14.1
