Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:10421 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S964901AbWJ1Whf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Oct 2006 18:37:35 -0400
Date: Sat, 28 Oct 2006 18:37:30 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Generic compat_sys_rt_sigqueueinfo
Message-ID: <20061028223730.GC3243@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Every 32-on-64 arch (except parisc) was implementing effectively the
same sys32_rt_sigqueueinfo. Add a generic implementation taken from
x86_64 and add it to kernel/compat.c, which required the addition of
copy_siginfo_from_user32 on mips and powerpc. sparc64 had a sufficient
implementation for this purpose, so crib it for both those platforms.

This yields a nice clean up and is one step towards cleaning up some
of the compat signals mess parisc has been carrying out of tree for a few
years.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
--
[N.B. the modification to powerpc is probably wrong, since it seems
 to require a wrapper for handling the signed ints like sparc64 and s390
 have. -- Kyle]

 arch/ia64/ia32/ia32_entry.S        |    2 +-
 arch/ia64/ia32/ia32_signal.c       |   15 ---------------
 arch/mips/kernel/scall64-n32.S     |    2 +-
 arch/mips/kernel/scall64-o32.S     |    2 +-
 arch/mips/kernel/signal32.c        |   31 ++++++++++++++++---------------
 arch/parisc/kernel/syscall_table.S |    2 +-
 arch/powerpc/kernel/signal_32.c    |   33 +++++++++++++--------------------
 arch/s390/kernel/compat_linux.c    |   15 ---------------
 arch/s390/kernel/compat_wrapper.S  |    2 +-
 arch/sparc64/kernel/sys_sparc32.c  |   16 ----------------
 arch/x86_64/ia32/ia32entry.S       |    2 +-
 arch/x86_64/ia32/sys_ia32.c        |   15 ---------------
 kernel/compat.c                    |   17 +++++++++++++++++
 13 files changed, 52 insertions(+), 102 deletions(-)

diff --git a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
index a32cd59..8d41c2c 100644
--- a/arch/ia64/ia32/ia32_entry.S
+++ b/arch/ia64/ia32/ia32_entry.S
@@ -388,7 +388,7 @@ ia32_syscall_table:
 	data8 sys32_rt_sigprocmask /* 175 */
 	data8 sys_rt_sigpending
 	data8 compat_sys_rt_sigtimedwait
-	data8 sys32_rt_sigqueueinfo
+	data8 compat_sys_rt_sigqueueinfo
 	data8 sys32_rt_sigsuspend
 	data8 sys32_pread	  /* 180 */
 	data8 sys32_pwrite
diff --git a/arch/ia64/ia32/ia32_signal.c b/arch/ia64/ia32/ia32_signal.c
index b3355a9..00341ff 100644
--- a/arch/ia64/ia32/ia32_signal.c
+++ b/arch/ia64/ia32/ia32_signal.c
@@ -588,21 +588,6 @@ sys32_rt_sigprocmask (int how, compat_si
 }
 
 asmlinkage long
-sys32_rt_sigqueueinfo (int pid, int sig, compat_siginfo_t __user *uinfo)
-{
-	mm_segment_t old_fs = get_fs();
-	siginfo_t info;
-	int ret;
-
-	if (copy_siginfo_from_user32(&info, uinfo))
-		return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *) &info);
-	set_fs(old_fs);
-	return ret;
-}
-
-asmlinkage long
 sys32_sigaction (int sig, struct old_sigaction32 __user *act, struct old_sigaction32 __user *oact)
 {
 	struct k_sigaction new_ka, old_ka;
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 67b92a1..013efe9 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -247,7 +247,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_capset
 	PTR	sys32_rt_sigpending		/* 6125 */
 	PTR	compat_sys_rt_sigtimedwait
-	PTR	sys32_rt_sigqueueinfo
+	PTR	compat_sys_rt_sigqueueinfo
 	PTR	sysn32_rt_sigsuspend
 	PTR	sys32_sigaltstack
 	PTR	compat_sys_utime		/* 6130 */
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 2875c4a..e9bc5a6 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -403,7 +403,7 @@ sys_call_table:
 	PTR	sys32_rt_sigprocmask 		/* 4195 */
 	PTR	sys32_rt_sigpending
 	PTR	compat_sys_rt_sigtimedwait
-	PTR	sys32_rt_sigqueueinfo
+	PTR	compat_sys_rt_sigqueueinfo
 	PTR	sys32_rt_sigsuspend
 	PTR	sys32_pread			/* 4200 */
 	PTR	sys32_pwrite
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c86a5dd..b680e7d 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -463,6 +463,22 @@ int copy_siginfo_to_user32(compat_siginf
 	return err;
 }
 
+/* CAUTION: This is just a very minimalist implementation for the
+ *	    sake of compat_sys_rt_sigqueueinfo(), cribbed from sparc64.
+ */
+int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
+{
+	if (!access_ok(VERIFY_WRITE, from, sizeof(compat_siginfo_t)))
+		return -EFAULT;
+
+	if (copy_from_user(to, from, 3*sizeof(int)) ||
+	    copy_from_user(to->_sifields._pad, from->_sifields._pad,
+			   SI_PAD_SIZE))
+		return -EFAULT;
+
+	return 0;
+}
+
 save_static_function(sys32_sigreturn);
 __attribute_used__ noinline static void
 _sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
@@ -950,21 +966,6 @@ asmlinkage int sys32_rt_sigpending(compa
 	return ret;
 }
 
-asmlinkage int sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t __user *uinfo)
-{
-	siginfo_t info;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if (copy_from_user (&info, uinfo, 3*sizeof(int)) ||
-	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *)&info);
-	set_fs (old_fs);
-	return ret;
-}
-
 asmlinkage long
 sys32_waitid(int which, compat_pid_t pid,
 	     compat_siginfo_t __user *uinfo, int options,
diff --git a/arch/parisc/kernel/syscall_table.S b/arch/parisc/kernel/syscall_table.S
index 701d66a..c91605b 100644
--- a/arch/parisc/kernel/syscall_table.S
+++ b/arch/parisc/kernel/syscall_table.S
@@ -282,7 +282,7 @@ #endif
 	 * to worry about faulting trying to copy in a larger 64-bit
 	 * struct from a 32-bit user-space app.
 	 */
-	ENTRY_SAME(rt_sigqueueinfo)
+	ENTRY_COMP(rt_sigqueueinfo)
 	ENTRY_SAME(rt_sigsuspend_wrapper) /* not really SAME -- see the code */
 	ENTRY_SAME(chown)		/* 180 */
 	/* setsockopt() used by iptables: SO_SET_REPLACE/SO_SET_ADD_COUNTERS */
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 320353f..6bdc1a4 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -573,7 +573,6 @@ long compat_sys_rt_sigpending(compat_sig
 	return ret;
 }
 
-
 int copy_siginfo_to_user32(struct compat_siginfo __user *d, siginfo_t *s)
 {
 	int err;
@@ -629,30 +628,24 @@ int copy_siginfo_to_user32(struct compat
 	return err;
 }
 
-#define copy_siginfo_to_user	copy_siginfo_to_user32
-
-/*
- * Note: it is necessary to treat pid and sig as unsigned ints, with the
- * corresponding cast to a signed int to insure that the proper conversion
- * (sign extension) between the register representation of a signed int
- * (msr in 32-bit mode) and the register representation of a signed int
- * (msr in 64-bit mode) is performed.
+/* CAUTION: This is just a very minimalist implementation for the
+ *	    sake of compat_sys_rt_sigqueueinfo(), cribbed from sparc64.
  */
-long compat_sys_rt_sigqueueinfo(u32 pid, u32 sig, compat_siginfo_t __user *uinfo)
+int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
 {
-	siginfo_t info;
-	int ret;
-	mm_segment_t old_fs = get_fs();
+	if (!access_ok(VERIFY_WRITE, from, sizeof(compat_siginfo_t)))
+		return -EFAULT;
 
-	if (copy_from_user (&info, uinfo, 3*sizeof(int)) ||
-	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE32))
+	if (copy_from_user(to, from, 3*sizeof(int)) ||
+	    copy_from_user(to->_sifields._pad, from->_sifields._pad,
+			   SI_PAD_SIZE))
 		return -EFAULT;
-	set_fs (KERNEL_DS);
-	/* The __user pointer cast is valid becasuse of the set_fs() */
-	ret = sys_rt_sigqueueinfo((int)pid, (int)sig, (siginfo_t __user *) &info);
-	set_fs (old_fs);
-	return ret;
+
+	return 0;
 }
+
+#define copy_siginfo_to_user	copy_siginfo_to_user32
+
 /*
  *  Start Alternate signal stack support
  *
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 2001767..7566d07 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -514,21 +514,6 @@ asmlinkage long sys32_rt_sigpending(comp
 	return ret;
 }
 
-asmlinkage long
-sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t __user *uinfo)
-{
-	siginfo_t info;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-	
-	if (copy_siginfo_from_user32(&info, uinfo))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *) &info);
-	set_fs (old_fs);
-	return ret;
-}
-
 /*
  * sys32_execve() executes a new program after the asm stub has set
  * things up for us.  This should basically do what I want it to.
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index cb0efae..251844c 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -857,7 +857,7 @@ sys32_rt_sigqueueinfo_wrapper:
 	lgfr	%r2,%r2			# int
 	lgfr	%r3,%r3			# int
 	llgtr	%r4,%r4			# siginfo_emu31_t *
-	jg	sys32_rt_sigqueueinfo	# branch to system call
+	jg	compat_sys_rt_sigqueueinfo	# branch to system call
 
 	.globl compat_sys_rt_sigsuspend_wrapper
 compat_sys_rt_sigsuspend_wrapper:
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index e27cb71..16ff6ff 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -601,22 +601,6 @@ asmlinkage long sys32_rt_sigpending(comp
 	return ret;
 }
 
-asmlinkage long compat_sys_rt_sigqueueinfo(int pid, int sig,
-					   struct compat_siginfo __user *uinfo)
-{
-	siginfo_t info;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-	
-	if (copy_siginfo_from_user32(&info, uinfo))
-		return -EFAULT;
-
-	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *) &info);
-	set_fs (old_fs);
-	return ret;
-}
-
 asmlinkage long compat_sys_sigaction(int sig, struct old_sigaction32 __user *act,
 				     struct old_sigaction32 __user *oact)
 {
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index b4aa875..9fa991a 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -577,7 +577,7 @@ #endif
 	.quad sys32_rt_sigprocmask	/* 175 */
 	.quad sys32_rt_sigpending
 	.quad compat_sys_rt_sigtimedwait
-	.quad sys32_rt_sigqueueinfo
+	.quad compat_sys_rt_sigqueueinfo
 	.quad stub32_rt_sigsuspend
 	.quad sys32_pread		/* 180 */
 	.quad sys32_pwrite
diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
index c9bac3a..db10734 100644
--- a/arch/x86_64/ia32/sys_ia32.c
+++ b/arch/x86_64/ia32/sys_ia32.c
@@ -628,21 +628,6 @@ sys32_rt_sigpending(compat_sigset_t __us
 	return ret;
 }
 
-asmlinkage long
-sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t __user *uinfo)
-{
-	siginfo_t info;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-	
-	if (copy_siginfo_from_user32(&info, uinfo))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *)&info);
-	set_fs (old_fs);
-	return ret;
-}
-
 /* These are here just in case some old ia32 binary calls it. */
 asmlinkage long
 sys32_pause(void)
diff --git a/kernel/compat.c b/kernel/compat.c
index 75573e5..cc77247 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -837,6 +837,23 @@ compat_sys_rt_sigtimedwait (compat_sigse
 
 }
 
+asmlinkage long compat_sys_rt_sigqueueinfo(int pid, int sig,
+	struct compat_siginfo __user *uinfo)
+{
+	mm_segment_t old_fs = get_fs();
+	siginfo_t info;
+	int ret;
+
+	if (copy_siginfo_from_user32(&info, uinfo))
+		return -EFAULT;
+
+	set_fs(KERNEL_DS);
+	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *)&info);
+	set_fs(old_fs);
+
+	return ret;
+}
+
 #ifdef __ARCH_WANT_COMPAT_SYS_TIME
 
 /* compat_time_t is a 32 bit "long" and needs to get converted. */
