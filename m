Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261578AbULBJ4S@vger.kernel.org>
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:56457 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261572AbULBJ4S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Dec 2004 04:56:18 -0500
Message-ID: <41AEE6A1.4020200@fujitsu-siemens.com>
Date: Thu, 02 Dec 2004 10:55:45 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>	 <20041112163442.45fc966f.akpm@osdl.org>	 <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org> <1101826791.26071.108.camel@hades.cambridge.redhat.com>
In-Reply-To: <1101826791.26071.108.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it, linux-arch@vger.kernel.org, jdike@ccure.user-mode-linux.org
List-ID: <linux-arch.vger.kernel.org>

David Woodhouse wrote:
> On Sun, 2004-11-14 at 17:13 -0500, Jeff Dike wrote:
> 
>>	sigmasking.c - Makes sure that when a signal is (not) delivered to
>>a bogus stack, that a segfault is delivered then, and not after returning
>>to userspace.  This is the test relevant to the patch that Andrew replied
>>to.
I don't know much about ppc64 and also don't have a machine to test.
So, I'm commenting the code only. If I've missed something, sorry for that.

The changes we did in UML, fiy two major issues:
1) they correct the sigmask after a segfault that happened in signal-delivery
2) they immediately deliver that SIGSEGV, before returning to user.

AFAICS, the patch seems to cover the first, but not the second.
If a SIGSEGV is forced since the stackframe/sigcontext for a signal-handler
could not be created, this SIGSEGV is queued only. To deliver it, do_signal()
must be called again, which normally won't happen (with the exception of
sys_sigretrun/sys_rt_sigreturn). Thus, SIGSEGV stays in the queue until the
next interrupt or syscall happens. IMHO this behavior is bad.
So, in UML we changed (kern_)do_signal, to loop over get_signal_to_deliver
and handle_signal, until a signal is delivered correctly or the task exits.

Bodo
> 
> 
> Corresponding patch for ppc64. Are we actually going to fix this for all
> architectures?
> 
> 
> 
> ------------------------------------------------------------------------
> 
> ===== arch/ppc64/kernel/signal.c 1.44 vs edited =====
> --- 1.44/arch/ppc64/kernel/signal.c	2004-10-28 08:39:49 +01:00
> +++ edited/arch/ppc64/kernel/signal.c	2004-11-26 14:13:18 +00:00
> @@ -387,7 +387,7 @@
>  	return 0;
>  }
>  
> -static void setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
> +static int setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
>  		sigset_t *set, struct pt_regs *regs)
>  {
>  	/* Handler is *really* a pointer to the function descriptor for
> @@ -452,7 +452,7 @@
>  	if (err)
>  		goto badframe;
>  
> -	return;
> +	return 0;
>  
>  badframe:
>  #if DEBUG_SIG
> @@ -460,17 +460,19 @@
>  	       regs, frame, newsp);
>  #endif
>  	force_sigsegv(signr, current);
> +	return -1;
>  }
>  
>  
>  /*
>   * OK, we're invoking a handler
>   */
> -static void handle_signal(unsigned long sig, struct k_sigaction *ka,
> -			  siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
> +static int handle_signal(unsigned long sig, struct k_sigaction *ka,
> +			 siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
>  {
>  	/* Set up Signal Frame */
> -	setup_rt_frame(sig, ka, info, oldset, regs);
> +	if (setup_rt_frame(sig, ka, info, oldset, regs))
> +	    return 0;
>  
>  	if (!(ka->sa.sa_flags & SA_NODEFER)) {
>  		spin_lock_irq(&current->sighand->siglock);
> @@ -479,6 +481,8 @@
>  		recalc_sigpending();
>  		spin_unlock_irq(&current->sighand->siglock);
>  	}
> +
> +	return 1;
>  }
>  
>  static inline void syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
> @@ -538,8 +542,7 @@
>  		/* Whee!  Actually deliver the signal.  */
>  		if (TRAP(regs) == 0x0C00)
>  			syscall_restart(regs, &ka);
> -		handle_signal(signr, &ka, &info, oldset, regs);
> -		return 1;
> +		return handle_signal(signr, &ka, &info, oldset, regs);
>  	}
>  
>  	if (TRAP(regs) == 0x0C00) {	/* System Call! */
> ===== arch/ppc64/kernel/signal32.c 1.61 vs edited =====
> --- 1.61/arch/ppc64/kernel/signal32.c	2004-10-28 08:39:49 +01:00
> +++ edited/arch/ppc64/kernel/signal32.c	2004-11-26 14:13:18 +00:00
> @@ -653,9 +653,9 @@
>   * Set up a signal frame for a "real-time" signal handler
>   * (one which gets siginfo).
>   */
> -static void handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
> -			       siginfo_t *info, sigset_t *oldset,
> -			       struct pt_regs * regs, unsigned long newsp)
> +static int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
> +			      siginfo_t *info, sigset_t *oldset,
> +			      struct pt_regs * regs, unsigned long newsp)
>  {
>  	struct rt_sigframe32 __user *rt_sf;
>  	struct mcontext32 __user *frame;
> @@ -704,14 +704,14 @@
>  	regs->trap = 0;
>  	regs->result = 0;
>  
> -	return;
> +	return 1;
>  
>  badframe:
>  #if DEBUG_SIG
>  	printk("badframe in handle_rt_signal, regs=%p frame=%p newsp=%lx\n",
>  	       regs, frame, newsp);
>  #endif
> -	force_sigsegv(sig, current);
> +	return 0;
>  }
>  
>  static long do_setcontext32(struct ucontext32 __user *ucp, struct pt_regs *regs, int sig)
> @@ -822,7 +822,7 @@
>  /*
>   * OK, we're invoking a handler
>   */
> -static void handle_signal32(unsigned long sig, struct k_sigaction *ka,
> +static int handle_signal32(unsigned long sig, struct k_sigaction *ka,
>  			    siginfo_t *info, sigset_t *oldset,
>  			    struct pt_regs * regs, unsigned long newsp)
>  {
> @@ -867,14 +867,14 @@
>  	regs->trap = 0;
>  	regs->result = 0;
>  
> -	return;
> +	return 1;
>  
>  badframe:
>  #if DEBUG_SIG
>  	printk("badframe in handle_signal, regs=%p frame=%x newsp=%x\n",
>  	       regs, frame, *newspp);
>  #endif
> -	force_sigsegv(sig, current);
> +	return 0;
>  }
>  
>  /*
> @@ -984,11 +984,20 @@
>  
>  	/* Whee!  Actually deliver the signal.  */
>  	if (ka.sa.sa_flags & SA_SIGINFO)
> -		handle_rt_signal32(signr, &ka, &info, oldset, regs, newsp);
> +		ret = handle_rt_signal32(signr, &ka, &info, oldset, regs, newsp);
>  	else
> -		handle_signal32(signr, &ka, &info, oldset, regs, newsp);
> +		ret = handle_signal32(signr, &ka, &info, oldset, regs, newsp);
>  
> -	if (!(ka.sa.sa_flags & SA_NODEFER)) {
> +	if (!ret) {
> +		/* Setting up the stack frame failed, but if we came here
> +		   from sigsuspend we may already have masked signals. 
> +		   Put back the old sigmask before forcing SEGV. */
> +		spin_lock_irq(&current->sighand->siglock);
> +		current->blocked = *oldset;
> +		recalc_sigpending();
> +		spin_unlock_irq(&current->sighand->siglock);
> +		force_sigsegv(signr, current);
> +	} else if (!(ka.sa.sa_flags & SA_NODEFER)) {
>  		spin_lock_irq(&current->sighand->siglock);
>  		sigorsets(&current->blocked, &current->blocked,
>  			  &ka.sa.sa_mask);
