Return-Path: <minyard@acm.org>
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50394 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263135AbUCSWmE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 17:42:04 -0500
Message-ID: <405B773B.8010705@acm.org>
Date: Fri, 19 Mar 2004 16:42:03 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Re: signal-race-fix.patch
References: <20040319120151.380dcbc9.akpm@osdl.org> <20040319141258.338c91b1.davem@redhat.com>
In-Reply-To: <20040319141258.338c91b1.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090506030107020608040401"
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090506030107020608040401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>On Fri, 19 Mar 2004 12:01:51 -0800
>Andrew Morton <akpm@osdl.org> wrote:
>
>  
>
>>We have an SMP race in the signal code.  A fix for x86 is below.  All archs
>>need updating.
>>    
>>
>
>I think the fix may need fixing :-)
>
>Now that we're passing a stack local k_sigaction into handle_signal()
>the real sigaction is not being updated f.e. when SA_ONESHOT causes
>ka->sa.sa_handler to be set to SIG_DFL.  Only the stack local copy
>is going to be set like this, not the one in the signals struct which
>is where it is needed.
>
>I noticed this while coding up the sparc versions which I'll defer until
>this is cleared up.
>  
>
BTW, here is a new patch that covers that problem.

-Corey

--------------090506030107020608040401
Content-Type: text/plain;
 name="sigrace-fix2-2.6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigrace-fix2-2.6.diff"

--- linux.orig/include/linux/signal.h	2004-02-19 19:28:23.000000000 -0600
+++ linux/include/linux/signal.h	2004-03-19 08:07:45.000000000 -0600
@@ -213,7 +213,7 @@
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
-extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
+extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 #endif
 
 #endif /* __KERNEL__ */
--- linux.orig/kernel/signal.c	2004-03-16 17:20:06.000000000 -0600
+++ linux/kernel/signal.c	2004-03-19 16:39:57.000000000 -0600
@@ -1692,7 +1692,8 @@
 	return 1;
 }
 
-int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie)
+int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka,
+			  struct pt_regs *regs, void *cookie)
 {
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
@@ -1761,8 +1762,15 @@
 		ka = &current->sighand->action[signr-1];
 		if (ka->sa.sa_handler == SIG_IGN) /* Do nothing.  */
 			continue;
-		if (ka->sa.sa_handler != SIG_DFL) /* Run the handler.  */
+		if (ka->sa.sa_handler != SIG_DFL) {
+			/* Run the handler.  */
+			*return_ka = *ka;
+
+			if (ka->sa.sa_flags & SA_ONESHOT)
+				ka->sa.sa_handler = SIG_DFL;
+
 			break; /* will return non-zero "signr" value */
+		}
 
 		/*
 		 * Now we are doing the default action for this signal.
--- linux.orig/arch/i386/kernel/signal.c	2004-03-16 17:19:41.000000000 -0600
+++ linux/arch/i386/kernel/signal.c	2004-03-19 16:38:50.000000000 -0600
@@ -502,11 +502,9 @@
  */	
 
 static void
-handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
-	struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
+	      sigset_t *oldset,	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
@@ -534,9 +532,6 @@
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
@@ -555,6 +550,7 @@
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 
 	/*
 	 * We want the common case to go fast, which
@@ -573,7 +569,7 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -583,7 +579,7 @@
 		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka, oldset, regs);
 		return 1;
 	}
 

--------------090506030107020608040401--
