Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfIWLz6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 07:55:58 -0400
Date: Mon, 23 Sep 2019 13:55:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
Message-ID: <20190923115551.GZ2386@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
 <20190923084718.GG2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909231227050.2003@nanos.tec.linutronix.de>
 <20190923114920.GF2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923114920.GF2332@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, jgross@suse.com
Message-ID: <20190923115551.CXpfGub9HNtu5JItFUMsqx6zZVdB4e5z2D1Wo58cEPQ@z>

On Mon, Sep 23, 2019 at 01:49:20PM +0200, Peter Zijlstra wrote:
> While walking the kids to school I wondered WTH we need to call
> TRACE_IRQS_OFF in the first place. If this is the return from exception
> path, interrupts had better be disabled already (in exception enter).
> 
> For entry_64.S we have:
> 
>   - idtentry_part; which does TRACE_IRQS_OFF at the start and error_exit
>     at the end.
> 
>   - xen_do_hypervisor_callback, xen_failsafe_callback -- which are
>     confusing.
> 
> So in the normal case, it appears we can simply do:
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index b7c3ea4cb19d..e9cf59ac554e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1368,8 +1368,6 @@ END(error_entry)
>  
>  ENTRY(error_exit)
>  	UNWIND_HINT_REGS
> -	DISABLE_INTERRUPTS(CLBR_ANY)
> -	TRACE_IRQS_OFF
>  	testb	$3, CS(%rsp)
>  	jz	retint_kernel
>  	jmp	retint_user
> 
> and all should be well. This leaves Xen...
> 
> For entry_32.S it looks like nothing uses 'resume_userspace' so that
> ENTRY can go away. Which then leaves:
> 
>  * ret_from_intr:
>   - common_spurious: TRACE_IRQS_OFF
>   - common_interrupt: TRACE_IRQS_OFF
>   - BUILD_INTERRUPT3: TRACE_IRQS_OFF
>   - xen_do_upcall: ...
> 
>  * ret_from_exception:
>   - xen_failsafe_callback: ...
>   - common_exception_read_cr2: TRACE_IRQS_OFF
>   - common_exception: TRACE_IRQS_OFF
>   - int3: TRACE_IRQS_OFF
> 
> Which again suggests:
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index f83ca5aa8b77..7a19e7413a8e 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -825,9 +825,6 @@ END(ret_from_fork)
>  	cmpl	$USER_RPL, %eax
>  	jb	restore_all_kernel		# not returning to v8086 or userspace
>  
> -ENTRY(resume_userspace)
> -	DISABLE_INTERRUPTS(CLBR_ANY)
> -	TRACE_IRQS_OFF
>  	movl	%esp, %eax
>  	call	prepare_exit_to_usermode
>  	jmp	restore_all
> 
> with the notable exception (oh teh pun!) being Xen... _again_.
> 
> With these patchlets on, we'd want prepare_exit_to_usermode() to
> validate the IRQ state, but AFAICT it _should_ all just 'work' (famous
> last words).
> 
> Cc Juergen because Xen

Arrgh.. faults!! they do local_irq_enable() but never disable them
again. Arguably those functions should be symmetric and restore IF when
they muck with it instead of relying on the exit path fixing things up.
