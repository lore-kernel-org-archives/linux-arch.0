Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261712AbUKMAb1@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:25216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262739AbUKMAaw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Nov 2004 19:30:52 -0500
Date: Fri, 12 Nov 2004 16:34:42 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
Message-Id: <20041112163442.45fc966f.akpm@osdl.org>
In-Reply-To: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Jeff Dike <jdike@addtoit.com>
Cc: blaisorblade_spam@yahoo.it, bstroesser@fujitsu-siemens.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


(removed linux-kernel, added linux-arch)

Jeff Dike <jdike@addtoit.com> wrote:
>
> >From Bodo Stroesser - If the user stack limit is reached or the
> signal stack assigned with sigaltstack() is invalid when a user signal
> handler with SA_ONSTACK has to be started, the signal mask of the
> interrupted user program is modified. This happens because the mask,
> that should be used with the handler only, is written to
> "current->blocked" even if the handler could not be started. But
> without a handler, no rewrite of the original mask at sys_sigreturn
> will be done. A slightly different case is sys_sigsuspend(), where the
> mask is already modified when kern_do_signal() is started. "*oldset" and
> "current->blocked" are not equal here and thus current->blocked has to
> be set to *oldset, if an error occurs in handle_signal().
> For both cases I've written small tests, and with the patch the result
> is OK.
> This issue is relevant for other architectures too (e.g. i386, I've
> seen).

Could you send one of the test apps?  This is something which the arch
maintainers might want to look into fixing, thanks.


> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: 2.6.9/arch/um/kernel/signal_kern.c
> ===================================================================
> --- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 16:24:18.000000000 -0500
> +++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:26.000000000 -0500
> @@ -79,7 +79,14 @@
>  	else
>  		err = setup_signal_stack_sc(sp, signr, ka, regs, oldset);
>  
> -	if (!err && !(ka->sa.sa_flags & SA_NODEFER)) {
> +	if(err){
> +		spin_lock_irq(&current->sighand->siglock);
> +		current->blocked = *oldset;
> +		recalc_sigpending();
> +		spin_unlock_irq(&current->sighand->siglock);
> +		force_sigsegv(signr, current);
> +	}
> +	else if(!(ka->sa.sa_flags & SA_NODEFER)){
>  		spin_lock_irq(&current->sighand->siglock);
>  		sigorsets(&current->blocked, &current->blocked, 
>  			  &ka->sa.sa_mask);
> @@ -87,9 +94,6 @@
>  		recalc_sigpending();
>  		spin_unlock_irq(&current->sighand->siglock);
>  	}
> -
> -	if(err)
> -		force_sigsegv(signr, current);
>  }
>  
>  static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
