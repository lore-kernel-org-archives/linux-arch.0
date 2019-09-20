Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:45584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389000AbfITO3Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Sep 2019 10:29:25 -0400
Date: Fri, 20 Sep 2019 15:29:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC patch 07/15] arm64/syscall: Remove obscure flag check
Message-ID: <20190920142920.GB21231@arrakis.emea.arm.com>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.145400160@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150809.145400160@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190920142920.6qRZDbLgivF-nrxaYMMw0w1cha0QTTlk21eRil95Nlc@z>

On Thu, Sep 19, 2019 at 05:03:21PM +0200, Thomas Gleixner wrote:
> The syscall handling code has an obscure check of pending work which does a
> shortcut before returning to user space. It calls into the exit work code
> when the flags at entry time required an entry into the slowpath. That does
> not make sense because the underlying work functionality will reevaluate
> the flags anyway and not do anything.

The current C code was just matching the original behaviour in asm
(converted by commit f37099b6992a0b81). The idea IIRC was to always pair
a syscall_trace_enter() with a syscall_trace_exit() irrespective of the
thread flag changes. I think the behaviour is preserved with your patch
if no-one clears the work flags during el0_svc_common().

> @@ -105,33 +103,15 @@ static void el0_svc_common(struct pt_reg
>  	user_exit();
>  
>  	scno = syscall_enter_from_usermode(regs, scno);
> -	if (scno == NO_SYSCALL)
> -		goto trace_exit;
> -
> -	invoke_syscall(regs, scno, sc_nr, syscall_table);
> +	if (scno != NO_SYSCALL)
> +		invoke_syscall(regs, scno, sc_nr, syscall_table);
>  
> -	/*
> -	 * The tracing status may have changed under our feet, so we have to
> -	 * check again. However, if we were tracing entry, then we always trace
> -	 * exit regardless, as the old entry assembly did.
> -	 */
> -	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		local_daif_mask();
> -		flags = current_thread_info()->flags;
> -		if (!has_syscall_work(flags)) {
> -			/*
> -			 * We're off to userspace, where interrupts are
> -			 * always enabled after we restore the flags from
> -			 * the SPSR.
> -			 */
> -			trace_hardirqs_on();
> -			return;
> -		}
> +	local_daif_mask();
> +	if (has_syscall_work(current_thread_info()->flags) ||
> +	    IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
>  		local_daif_restore(DAIF_PROCCTX);
> +		syscall_trace_exit(regs);
>  	}

That's missing a trace_hardirqs_on() (off done in local_daif_mask())
before returning.

> -
> -trace_exit:
> -	syscall_trace_exit(regs);
>  }

-- 
Catalin
