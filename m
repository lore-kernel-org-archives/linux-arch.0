From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Date: Sat, 19 May 2012 06:26:23 +0100
Message-ID: <20120519052622.GA20945@ZenIV.linux.org.uk>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
 <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
 <20120518195610.GV22082@ZenIV.linux.org.uk>
 <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
 <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
 <20120518222422.GX22082@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:52216 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab2ESF0j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 May 2012 01:26:39 -0400
Content-Disposition: inline
In-Reply-To: <20120518222422.GX22082@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Grant Grundler <grantgrundler@gmail.com>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, May 18, 2012 at 11:24:22PM +0100, Al Viro wrote:

> And no, I don't have any good suggestions on how to fix it right now.  Depends
> on how does gdb on parisc play with pt_regs, among other things...

I think we might be able to cheat and pull off the following:
	* stop restoring r28 on restarts.  Behaviour of syscall should not
depend on the value of r28 at the moment we enter it and it does clobber
r28 in all cases - that's where the return value goes to, after all.  And
the instruction we are restarting would better be a syscall.
	* with that done, we can reuse ->orig_r28 for any purpose.  In
particular, we can use it as "no restarts allowed" flag.  Just have it set
to zero instead of r28 in linux_gateway_entry and hpux_gateway_page, then
in syscall_restart() and insert_restart_trampoline() check that
it's still 0, go away if it isn't and set it to 1 otherwise.  Set
it to 1 in sigreturn, to make it indifferent to what we might or might
not find in r28 stored in sigcontext (strictly speaking that's not needed,
but it's less brittle than relying on rather subtle properties of what
could end up in sigcontext and trampoline; the whole thing is a nice
example of how easily subtle things break and how long does that stay
unnoticed)

	Another potential solution would be a trick a-la MIPS, but you are
already using that slot in regs->gr[] for "is it a syscall" flag (psw for
interrupt, 0 for syscall) and touching that is very likely to end up with
very unhappy gdb...

So how about the following:

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
index 12c1ed3..b4dd2c1 100644
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -88,6 +88,7 @@ restore_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs)
 	err |= __copy_from_user(regs->iaoq, sc->sc_iaoq, sizeof(regs->iaoq));
 	err |= __copy_from_user(regs->iasq, sc->sc_iasq, sizeof(regs->iasq));
 	err |= __get_user(regs->sar, &sc->sc_sar);
+	regs->orig_r28 = 1; /* no restarts for sigreturn */
 	DBG(2,"restore_sigcontext: iaoq is 0x%#lx / 0x%#lx\n", 
 			regs->iaoq[0],regs->iaoq[1]);
 	DBG(2,"restore_sigcontext: r28 is %ld\n", regs->gr[28]);
@@ -471,6 +472,9 @@ handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
 static inline void
 syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
 {
+	if (regs->orig_r28)
+		return;
+	regs->orig_r28 = 1; /* no more restarts */
 	/* Check the return code */
 	switch (regs->gr[28]) {
 	case -ERESTART_RESTARTBLOCK:
@@ -493,8 +497,6 @@ syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
 		 * we have to do is fiddle the return pointer.
 		 */
 		regs->gr[31] -= 8; /* delayed branching */
-		/* Preserve original r28. */
-		regs->gr[28] = regs->orig_r28;
 		break;
 	}
 }
@@ -502,6 +504,9 @@ syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
 static inline void
 insert_restart_trampoline(struct pt_regs *regs)
 {
+	if (regs->orig_r28)
+		return;
+	regs->orig_r28 = 1; /* no more restarts */
 	switch(regs->gr[28]) {
 	case -ERESTART_RESTARTBLOCK: {
 		/* Restart the system call - no handlers present */
@@ -536,9 +541,6 @@ insert_restart_trampoline(struct pt_regs *regs)
 		flush_user_icache_range(regs->gr[30], regs->gr[30] + 4);
 
 		regs->gr[31] = regs->gr[30] + 8;
-		/* Preserve original r28. */
-		regs->gr[28] = regs->orig_r28;
-
 		return;
 	}
 	case -ERESTARTNOHAND:
@@ -550,9 +552,6 @@ insert_restart_trampoline(struct pt_regs *regs)
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
 	
