Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58480 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeHKChF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Aug 2018 22:37:05 -0400
Date: Sat, 11 Aug 2018 01:04:55 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
Message-ID: <20180811000455.GC6515@ZenIV.linux.org.uk>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-alpha@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Message-ID: <20180811000455.X_3oxSkO_MHWZyZxMODkNAuVW5dRrphFQ3NxucdHNW4@z>

On Mon, Jul 16, 2018 at 03:53:55PM +0530, Firoz Khan wrote:
> systbl.S contain two types of system call entry name which are
> alpha_ni_syscall and sys_ni_syscall. So this patch will unify
> the not-implemented system call entry name as alpha_ni_syscall.

Umm...  The thing is, alpha_ni_syscall should really be called
alpha_syscall_0.  Its use for other not implemented syscalls in
OSF syscall numbers range is a historical accident.

What that thing does is, in addition usual return -ENOSYS, is
the opposite of force_successful_syscall_return().

On alpha the syscall number is passed in r0.  So for every
real syscall we have non-zero current_pt_regs()->r0
and force_successful_syscall_return() simply assigns 0 to
that.

Return value goes in the same register; additionally, register #19
(a3) is left 0 on success and 1 on error.  Normally it's controlled
by the sign of sys_something() return value (left in r0), but for
some syscalls we want to be able to tell the userland that the damn
thing has succeeded, negative result be damned.

The original value of r0 is left in pt_regs; it will be used only
in case of syscall restarts, i.e. *not* in "that's no error" case.
And it's non-zero on any real syscall, so it serves as a nice
available place for storing the "it's not an error" flag.

That works nicely, but leaves a bit of a twist in one case: if we
tried to issue syscall 0, we want it to return -ENOSYS and we want
that to be treated as an error, TYVM.  That's where this trick
comes to bite - unlike the normal case, we have pt_regs->r0
containing zero, which would trigger the "that's no error" logics.

Since -ENOSYS is not a restart-triggering error, we don't need to
preserve the original value of pt_regs->r0 in this case either.
Solution:

alpha_ni_syscall:
	make current_pt_regs()->r0 non-zero
	return -ENOSYS

That's what the comment in
alpha_ni_syscall:
        .prologue 0
        /* Special because it also implements overflow handling via
           syscall number 0.  And if you recall, zero is a special
           trigger for "not an error".  Store large non-zero there.  */
        lda     $0, -ENOSYS
        unop
        stq     $0, 0($sp)
        ret
is about.

Once upon a time it used to have a C part that printed a warning
about unimplemented OSF syscalls.  That's what it's been doing
all over the OSF syscall range, while the native Linux syscall
range uses sys_ni_syscall().

With those warnings about unimplemented OSF syscalls gone (circa 2.4),
alpha_ni_syscall() has shrunk to that little bit of asm and the
only reason it hasn't been replaced with sys_ni_syscall() everywhere
is that extra twist needed in case of syscall #0.

Let's keep it only for syscall #0 and replace the rest with sys_ni_syscall.
And use sys_ni_syscall for "number out range" in ptraced-call case, as
we'd been doing for normal codepath since 2.1.86...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index c64806a2daf5..21840e7042f3 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -473,7 +473,7 @@ entSys:
 	bne     $3, strace
 	beq	$4, 1f
 	ldq	$27, 0($5)
-1:	jsr	$26, ($27), alpha_ni_syscall
+1:	jsr	$26, ($27), sys_ni_syscall
 	ldgp	$gp, 0($26)
 	blt	$0, $syscall_error	/* the call failed */
 	stq	$0, 0($sp)
@@ -587,7 +587,7 @@ strace:
 	/* get the system call pointer.. */
 	lda	$1, NR_SYSCALLS($31)
 	lda	$2, sys_call_table
-	lda	$27, alpha_ni_syscall
+	lda	$27, sys_ni_syscall
 	cmpult	$0, $1, $1
 	s8addq	$0, $2, $2
 	beq	$1, 1f
@@ -843,15 +843,20 @@ sys_rt_sigreturn:
 .end sys_rt_sigreturn
 
 	.align	4
-	.globl	alpha_ni_syscall
-	.ent	alpha_ni_syscall
-alpha_ni_syscall:
+	.globl	alpha_syscall_zero
+	.ent	alpha_syscall_zero
+alpha_syscall_zero:
 	.prologue 0
-	/* Special because it also implements overflow handling via
-	   syscall number 0.  And if you recall, zero is a special
-	   trigger for "not an error".  Store large non-zero there.  */
+	/* Special because it needs to do something opposite to
+	   force_successful_syscall_return().  We use the saved
+	   syscall number for that, zero meaning "not an error".
+	   That works nicely, but for real syscall 0 we need to
+	   make sure that this logics doesn't get confused.
+	   Store a non-zero there - -ENOSYS we need in register
+	   for our return value will do just fine.
+	  */
 	lda	$0, -ENOSYS
 	unop
 	stq	$0, 0($sp)
 	ret
-.end alpha_ni_syscall
+.end alpha_syscall_zero
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 1374e591511f..5b2e8ecb7ce3 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -11,93 +11,93 @@
 	.align 3
 	.globl sys_call_table
 sys_call_table:
-	.quad alpha_ni_syscall			/* 0 */
+	.quad alpha_syscall_zero		/* 0 */
 	.quad sys_exit
 	.quad alpha_fork
 	.quad sys_read
 	.quad sys_write
-	.quad alpha_ni_syscall			/* 5 */
+	.quad sys_ni_syscall			/* 5 */
 	.quad sys_close
 	.quad sys_osf_wait4
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_link
 	.quad sys_unlink			/* 10 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_chdir
 	.quad sys_fchdir
 	.quad sys_mknod
 	.quad sys_chmod				/* 15 */
 	.quad sys_chown
 	.quad sys_osf_brk
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_lseek
 	.quad sys_getxpid			/* 20 */
 	.quad sys_osf_mount
 	.quad sys_umount
 	.quad sys_setuid
 	.quad sys_getxuid
-	.quad alpha_ni_syscall			/* 25 */
+	.quad sys_ni_syscall			/* 25 */
 	.quad sys_ptrace
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 30 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 30 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_access
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 35 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 35 */
 	.quad sys_sync
 	.quad sys_kill
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_setpgid
-	.quad alpha_ni_syscall			/* 40 */
+	.quad sys_ni_syscall			/* 40 */
 	.quad sys_dup
 	.quad sys_alpha_pipe
 	.quad sys_osf_set_program_attributes
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_open				/* 45 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getxgid
 	.quad sys_osf_sigprocmask
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 50 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 50 */
 	.quad sys_acct
 	.quad sys_sigpending
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_ioctl
-	.quad alpha_ni_syscall			/* 55 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall			/* 55 */
+	.quad sys_ni_syscall
 	.quad sys_symlink
 	.quad sys_readlink
 	.quad sys_execve
 	.quad sys_umask				/* 60 */
 	.quad sys_chroot
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getpgrp
 	.quad sys_getpagesize
-	.quad alpha_ni_syscall			/* 65 */
+	.quad sys_ni_syscall			/* 65 */
 	.quad alpha_vfork
 	.quad sys_newstat
 	.quad sys_newlstat
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 70 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 70 */
 	.quad sys_osf_mmap
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_munmap
 	.quad sys_mprotect
 	.quad sys_madvise			/* 75 */
 	.quad sys_vhangup
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getgroups
 	/* map BSD's setpgrp to sys_setpgid for binary compatibility: */
 	.quad sys_setgroups			/* 80 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_setpgid
 	.quad sys_osf_setitimer
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 85 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 85 */
 	.quad sys_osf_getitimer
 	.quad sys_gethostname
 	.quad sys_sethostname
@@ -119,19 +119,19 @@ sys_call_table:
 	.quad sys_bind
 	.quad sys_setsockopt			/* 105 */
 	.quad sys_listen
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 110 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 110 */
 	.quad sys_sigsuspend
 	.quad sys_osf_sigstack
 	.quad sys_recvmsg
 	.quad sys_sendmsg
-	.quad alpha_ni_syscall			/* 115 */
+	.quad sys_ni_syscall			/* 115 */
 	.quad sys_osf_gettimeofday
 	.quad sys_osf_getrusage
 	.quad sys_getsockopt
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 #ifdef CONFIG_OSF4_COMPAT
 	.quad sys_osf_readv			/* 120 */
 	.quad sys_osf_writev
@@ -156,66 +156,66 @@ sys_call_table:
 	.quad sys_mkdir
 	.quad sys_rmdir
 	.quad sys_osf_utimes
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 140 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 140 */
 	.quad sys_getpeername
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getrlimit
 	.quad sys_setrlimit			/* 145 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_setsid
 	.quad sys_quotactl
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getsockname			/* 150 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 155 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 155 */
 	.quad sys_osf_sigaction
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_getdirentries
 	.quad sys_osf_statfs			/* 160 */
 	.quad sys_osf_fstatfs
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_getdomainname		/* 165 */
 	.quad sys_setdomainname
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 170 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 175 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 180 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 185 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 190 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 195 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 170 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 175 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 180 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 185 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 190 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 195 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	/* The OSF swapon has two extra arguments, but we ignore them.  */
 	.quad sys_swapon
 	.quad sys_msgctl			/* 200 */
@@ -231,93 +231,93 @@ sys_call_table:
 	.quad sys_shmctl			/* 210 */
 	.quad sys_shmdt
 	.quad sys_shmget
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 215 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 215 */
+	.quad sys_ni_syscall
 	.quad sys_msync
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 220 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 220 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_stat
 	.quad sys_osf_lstat			/* 225 */
 	.quad sys_osf_fstat
 	.quad sys_osf_statfs64
 	.quad sys_osf_fstatfs64
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 230 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 230 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getpgid
 	.quad sys_getsid
 	.quad sys_sigaltstack			/* 235 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 240 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 240 */
 	.quad sys_osf_sysinfo
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_proplist_syscall
-	.quad alpha_ni_syscall			/* 245 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 250 */
+	.quad sys_ni_syscall			/* 245 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 250 */
 	.quad sys_osf_usleep_thread
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_sysfs
-	.quad alpha_ni_syscall			/* 255 */
+	.quad sys_ni_syscall			/* 255 */
 	.quad sys_osf_getsysinfo
 	.quad sys_osf_setsysinfo
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 260 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 265 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 270 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 275 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 280 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 285 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 290 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 295 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 260 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 265 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 270 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 275 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 280 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 285 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 290 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 295 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 /* linux-specific system calls start at 300 */
 	.quad sys_bdflush			/* 300 */
 	.quad sys_sethae
