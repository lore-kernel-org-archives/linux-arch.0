Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266705AbUHZBqy@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:35254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266683AbUHZBqy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 21:46:54 -0400
Date: Wed, 25 Aug 2004 18:46:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/8] signal handling race fix
In-Reply-To: <20040825172751.13a3b2d5.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408251843130.17766@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
 <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org> <20040825160913.681d6868.davem@redhat.com>
 <Pine.LNX.4.58.0408251702230.17766@ppc970.osdl.org> <20040825172751.13a3b2d5.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, minyard@acm.org, Russell King <rmk@arm.linux.org.uk>
List-ID: <linux-arch.vger.kernel.org>



On Wed, 25 Aug 2004, David S. Miller wrote:
> 
> I'll then convert Sparc's signal code over to using this
> force_sigsegv() stuff, I just call exit() directly currently
> which isn't so nice.

Ok, I've merged (hopefully correctly) Andrew's series. It was _much_ 
smaller after removing the renaming, some whitespace stuff, and using the 
generic cleanup patch.

I also, just to check, tried to do the ARM conversion just to see what it 
looks like when the patch hasn't gone through several different 
incarnations and some hand-editing.. Russell, can you check my test patch 
(appended).

Can architecture people check the result of their respective 
architectures? I'll check x86 and ppc64 myself, but..

		Linus

----
===== arch/arm/kernel/signal.c 1.34 vs edited =====
--- 1.34/arch/arm/kernel/signal.c	2004-08-25 17:37:25 -07:00
+++ edited/arch/arm/kernel/signal.c	2004-08-25 18:38:23 -07:00
@@ -573,12 +573,12 @@
  * OK, we're invoking a handler
  */	
 static void
-handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+handle_signal(unsigned long sig, struct k_sigaction *ka,
+	      siginfo_t *info, sigset_t *oldset,
 	      struct pt_regs * regs, int syscall)
 {
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = current;
-	struct k_sigaction *ka = &tsk->sighand->action[sig-1];
 	int usig = sig;
 	int ret;
 
@@ -633,11 +633,8 @@
 		spin_unlock_irq(&tsk->sighand->siglock);
 	}
 
-	if (ret == 0) {
-		if (ka->sa.sa_flags & SA_ONESHOT)
-			ka->sa.sa_handler = SIG_DFL;
+	if (ret == 0)
 		return;
-	}
 
 	force_sigsegv(sig, tsk);
 }
@@ -653,6 +650,7 @@
  */
 static int do_signal(sigset_t *oldset, struct pt_regs *regs, int syscall)
 {
+	struct k_sigaction ka;
 	siginfo_t info;
 	int signr;
 
@@ -673,9 +671,9 @@
 	if (current->ptrace & PT_SINGLESTEP)
 		ptrace_cancel_bpt(current);
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
-		handle_signal(signr, &info, oldset, regs, syscall);
+		handle_signal(signr, &ka, &info, oldset, regs, syscall);
 		if (current->ptrace & PT_SINGLESTEP)
 			ptrace_set_bpt(current);
 		return 1;
