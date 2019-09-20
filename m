Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406276AbfITMVV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Sep 2019 08:21:21 -0400
Date: Fri, 20 Sep 2019 13:21:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC patch 04/15] arm64/entry: Use generic syscall entry function
Message-ID: <20190920122116.GA21231@arrakis.emea.arm.com>
References: <20190919150314.054351477@linutronix.de>
 <20190919150808.830764150@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150808.830764150@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190920122117.T6YXGSj_4bLNRWsZRBCJtHYzQ0lNY_ODjO7AGxygdRU@z>

On Thu, Sep 19, 2019 at 05:03:18PM +0200, Thomas Gleixner wrote:
>  #ifdef CONFIG_ARM64_ERRATUM_1463225
> @@ -97,19 +97,16 @@ static void el0_svc_common(struct pt_reg
>  
>  	regs->orig_x0 = regs->regs[0];
>  	regs->syscallno = scno;
> +	/* Set default error number */
> +	regs->regs[0] = -ENOSYS;

I think this corrupts the first argument of all valid syscalls.
SC_ARM64_REGS_TO_ARGS uses regs[0] instead of orig_x0. ptrace should be
fine since it calls syscall_get_arguments() which uses orig_x0.

We could change the SC_ARM64_REGS_TO_ARGS macro though (in theory there
shouldn't be any performance hit as it's already cached).

>  
>  	cortex_a76_erratum_1463225_svc_handler();
>  	local_daif_restore(DAIF_PROCCTX);
>  	user_exit();
>  
> -	if (has_syscall_work(flags)) {
> -		/* set default errno for user-issued syscall(-1) */
> -		if (scno == NO_SYSCALL)
> -			regs->regs[0] = -ENOSYS;
> -		scno = syscall_trace_enter(regs);
> -		if (scno == NO_SYSCALL)
> -			goto trace_exit;
> -	}
> +	scno = syscall_enter_from_usermode(regs, scno);
> +	if (scno == NO_SYSCALL)
> +		goto trace_exit;
>  
>  	invoke_syscall(regs, scno, sc_nr, syscall_table);

-- 
Catalin
