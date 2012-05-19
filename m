Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36593 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab2ESNhT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 May 2012 09:37:19 -0400
Date: Sat, 19 May 2012 14:37:12 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Message-ID: <20120519133712.GA11514@ZenIV.linux.org.uk>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
 <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
 <20120518195610.GV22082@ZenIV.linux.org.uk>
 <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
 <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
 <20120518222422.GX22082@ZenIV.linux.org.uk>
 <20120519052622.GA20945@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120519052622.GA20945@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Grant Grundler <grantgrundler@gmail.com>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
Message-ID: <20120519133712.y8BeFLZJ8FDf-16FWUSH7cNm4teARgdmODvpFkZxiag@z>

On Sat, May 19, 2012 at 06:26:23AM +0100, Al Viro wrote:
> diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
> index 12c1ed3..b4dd2c1 100644
> --- a/arch/parisc/kernel/signal.c
> +++ b/arch/parisc/kernel/signal.c
> @@ -88,6 +88,7 @@ restore_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs)
>  	err |= __copy_from_user(regs->iaoq, sc->sc_iaoq, sizeof(regs->iaoq));
>  	err |= __copy_from_user(regs->iasq, sc->sc_iasq, sizeof(regs->iasq));
>  	err |= __get_user(regs->sar, &sc->sc_sar);
> +	regs->orig_r28 = 1; /* no restarts for sigreturn */
>  	DBG(2,"restore_sigcontext: iaoq is 0x%#lx / 0x%#lx\n", 
>  			regs->iaoq[0],regs->iaoq[1]);
>  	DBG(2,"restore_sigcontext: r28 is %ld\n", regs->gr[28]);

... only that part should be done in sys_rt_sigreturn() instead, or we'll miss
it for 32bit-on-64bit case.

diff --git a/arch/parisc/hpux/gate.S b/arch/parisc/hpux/gate.S
index 38a1c1b..0114688 100644
--- a/arch/parisc/hpux/gate.S
+++ b/arch/parisc/hpux/gate.S
@@ -71,7 +71,7 @@ ENTRY(hpux_gateway_page)
 	STREG	%r26, TASK_PT_GR26(%r1)	 	/* 1st argument */
 	STREG	%r27, TASK_PT_GR27(%r1)		/* user dp */
 	STREG   %r28, TASK_PT_GR28(%r1)         /* return value 0 */
-	STREG   %r28, TASK_PT_ORIG_R28(%r1)     /* return value 0 (saved for signals) */
+	STREG   %r0, TASK_PT_ORIG_R28(%r1)     /* don't prohibit restarts */
 	STREG   %r29, TASK_PT_GR29(%r1)         /* 8th argument */
 	STREG	%r31, TASK_PT_GR31(%r1)		/* preserve syscall return ptr */
 	
diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
index 12c1ed3..369b1c4 100644
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -115,6 +115,8 @@ sys_rt_sigreturn(struct pt_regs *regs, int in_syscall)
 		(usp - sigframe_size);
 	DBG(2,"sys_rt_sigreturn: frame is %p\n", frame);
 
+	regs->orig_r28 = 1; /* no restarts for sigreturn */
+
 #ifdef CONFIG_64BIT
 	compat_frame = (struct compat_rt_sigframe __user *)frame;
 	
@@ -471,6 +473,9 @@ handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
 static inline void
 syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
 {
+	if (regs->orig_r28)
+		return;
+	regs->orig_r28 = 1; /* no more restarts */
 	/* Check the return code */
 	switch (regs->gr[28]) {
 	case -ERESTART_RESTARTBLOCK:
@@ -493,8 +498,6 @@ syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
 		 * we have to do is fiddle the return pointer.
 		 */
 		regs->gr[31] -= 8; /* delayed branching */
-		/* Preserve original r28. */
-		regs->gr[28] = regs->orig_r28;
 		break;
 	}
 }
@@ -502,6 +505,9 @@ syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
 static inline void
 insert_restart_trampoline(struct pt_regs *regs)
 {
+	if (regs->orig_r28)
+		return;
+	regs->orig_r28 = 1; /* no more restarts */
 	switch(regs->gr[28]) {
 	case -ERESTART_RESTARTBLOCK: {
 		/* Restart the system call - no handlers present */
@@ -536,9 +542,6 @@ insert_restart_trampoline(struct pt_regs *regs)
 		flush_user_icache_range(regs->gr[30], regs->gr[30] + 4);
 
 		regs->gr[31] = regs->gr[30] + 8;
-		/* Preserve original r28. */
-		regs->gr[28] = regs->orig_r28;
-
 		return;
 	}
 	case -ERESTARTNOHAND:
@@ -550,9 +553,6 @@ insert_restart_trampoline(struct pt_regs *regs)
 		 * slot of the branch external instruction.
 		 */
 		regs->gr[31] -= 8;
-		/* Preserve original r28. */
-		regs->gr[28] = regs->orig_r28;
-
 		return;
 	}
 	default:
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 82a52b2..54a9cbf 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -156,7 +156,7 @@ linux_gateway_entry:
 	STREG	%r26, TASK_PT_GR26(%r1)	 	/* 1st argument */
 	STREG	%r27, TASK_PT_GR27(%r1)		/* user dp */
 	STREG   %r28, TASK_PT_GR28(%r1)         /* return value 0 */
-	STREG   %r28, TASK_PT_ORIG_R28(%r1)     /* return value 0 (saved for signals) */
+	STREG   %r0, TASK_PT_ORIG_R28(%r1)      /* don't prohibit restarts */
 	STREG	%r29, TASK_PT_GR29(%r1)		/* return value 1 */
 	STREG	%r31, TASK_PT_GR31(%r1)		/* preserve syscall return ptr */
 	
