Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC014C48BE5
	for <linux-arch@archiver.kernel.org>; Tue, 15 Jun 2021 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0669613B3
	for <linux-arch@archiver.kernel.org>; Tue, 15 Jun 2021 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhFOTiz (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:38:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42222 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFOTix (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 15:38:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltErg-00Fcn5-4f; Tue, 15 Jun 2021 13:36:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltErd-00FD1D-31; Tue, 15 Jun 2021 13:36:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        <87pmwsytb3.fsf@disp2133>
        <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
Date:   Tue, 15 Jun 2021 14:36:38 -0500
In-Reply-To: <87fsxjorgs.fsf@disp2133> (Eric W. Biederman's message of "Tue,
        15 Jun 2021 14:30:59 -0500")
Message-ID: <87zgvqor7d.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltErd-00FD1D-31;;;mid=<87zgvqor7d.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1909YnOYcFSiYVi0oR0aRPcgsSUaILVtc0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] alpha: Add extra switch_stack frames in exit, exec, and kernel threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


While thinking about the information leaks fixed in 77f6ab8b7768
("don't dump the threads that had been already exiting when zapped.")
I realized the problem is much more general than just coredumps and
exit_mm.  We have io_uring threads, PTRACE_EVENT_EXEC and
PTRACE_EVENT_EXIT where ptrace is allowed to access userspace
registers, but on some architectures has not saved them.

The function alpha_switch_to does something reasonable it saves the
floating point registers and the caller saved registers and switches
to a different thread.  Any register the caller is not expected to
save it does not save.

Meanhile the system call entry point on alpha also does something
reasonable.  The system call entry point saves the all but the caller
saved integer registers and doesn't touch the floating point registers
as the kernel code does not touch them.

This is a nice happy fast path until the kernel wants to access the
user space's registers through ptrace or similar.  As user spaces's
caller saved registers may be saved at an unpredictable point in the
kernel code's stack, the routime which may stop and make the userspace
registers available must be wrapped by code that will first save a
switch stack frame at the bottom of the call stack, call the code that
may access those registers and then pop the switch stack frame.

The practical problem with this code structure is that this results in
a game of whack-a-mole wrapping different kernel system calls.  Loosing
the game of whack-a-mole results in a security hole where userspace can
write arbitrary data to the kernel stack.

I looked and there nothing I can do that is not arch specific, so
whack the moles with a minimal backportable fix.

This change survives boot testing on qemu-system-alpha.

Cc: stable@vger.kernel.org
Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 45c1a159b85b ("Add PTRACE_O_TRACEVFORKDONE and PTRACE_O_TRACEEXIT facilities.")
Fixes: a0691b116f6a ("Add new ptrace event tracing mechanism")
History-tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/entry.S              | 21 +++++++++++++++++++++
 arch/alpha/kernel/process.c            | 11 ++++++++++-
 arch/alpha/kernel/syscalls/syscall.tbl |  8 ++++----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index e227f3a29a43..98bb5b805089 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -785,6 +785,7 @@ ret_from_kernel_thread:
 	mov	$9, $27
 	mov	$10, $16
 	jsr	$26, ($9)
+	lda	$sp, SWITCH_STACK_SIZE($sp)
 	br	$31, ret_to_user
 .end ret_from_kernel_thread
 
@@ -811,6 +812,26 @@ alpha_\name:
 fork_like fork
 fork_like vfork
 fork_like clone
+fork_like exit
+fork_like exit_group
+
+.macro	exec_like name
+	.align	4
+	.globl	alpha_\name
+	.ent	alpha_\name
+	.cfi_startproc
+alpha_\name:
+	.prologue 0
+	DO_SWITCH_STACK
+	jsr	$26, sys_\name
+	UNDO_SWITCH_STACK
+	ret
+	.cfi_endproc
+.end	alpha_\name
+.endm
+
+exec_like execve
+exec_like execveat
 
 .macro	sigreturn_like name
 	.align	4
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5112ab996394..edbfe03f4b2c 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -251,8 +251,17 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
 		/* kernel thread */
+		/*
+		 * Give it *two* switch stacks, one for the kernel
+		 * state return that is used up by alpha_switch_to,
+		 * and one for the "user state" which is accessed
+		 * by ptrace.
+		 */
+		childstack--;
+		childti->pcb.ksp = (unsigned long) childstack;
+
 		memset(childstack, 0,
-			sizeof(struct switch_stack) + sizeof(struct pt_regs));
+			2*sizeof(struct switch_stack) + sizeof(struct pt_regs));
 		childstack->r26 = (unsigned long) ret_from_kernel_thread;
 		childstack->r9 = usp;	/* function */
 		childstack->r10 = kthread_arg;
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 3000a2e8ee21..5f85f3c11ed4 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -8,7 +8,7 @@
 # The <abi> is always "common" for this file
 #
 0	common	osf_syscall			alpha_syscall_zero
-1	common	exit				sys_exit
+1	common	exit				alpha_exit
 2	common	fork				alpha_fork
 3	common	read				sys_read
 4	common	write				sys_write
@@ -65,7 +65,7 @@
 56	common	osf_revoke			sys_ni_syscall
 57	common	symlink				sys_symlink
 58	common	readlink			sys_readlink
-59	common	execve				sys_execve
+59	common	execve				alpha_execve
 60	common	umask				sys_umask
 61	common	chroot				sys_chroot
 62	common	osf_old_fstat			sys_ni_syscall
@@ -333,7 +333,7 @@
 400	common	io_getevents			sys_io_getevents
 401	common	io_submit			sys_io_submit
 402	common	io_cancel			sys_io_cancel
-405	common	exit_group			sys_exit_group
+405	common	exit_group			alpha_exit_group
 406	common	lookup_dcookie			sys_lookup_dcookie
 407	common	epoll_create			sys_epoll_create
 408	common	epoll_ctl			sys_epoll_ctl
@@ -441,7 +441,7 @@
 510	common	renameat2			sys_renameat2
 511	common	getrandom			sys_getrandom
 512	common	memfd_create			sys_memfd_create
-513	common	execveat			sys_execveat
+513	common	execveat			alpha_execveat
 514	common	seccomp				sys_seccomp
 515	common	bpf				sys_bpf
 516	common	userfaultfd			sys_userfaultfd
-- 
2.20.1

