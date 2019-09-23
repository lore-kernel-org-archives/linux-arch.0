Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731460AbfIWIrZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 04:47:25 -0400
Date: Mon, 23 Sep 2019 10:47:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
Message-ID: <20190923084718.GG2349@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150809.446771597@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190923084718.PNLi06X7ReqVWVT57BycCI6de89xgSvlnKx3mhLhL1I@z>

On Thu, Sep 19, 2019 at 05:03:24PM +0200, Thomas Gleixner wrote:
> To prepare for converting the exit to usermode code to the generic version,
> move the irqflags tracing into C code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c          |   10 ++++++++++
>  arch/x86/entry/entry_32.S        |   11 +----------
>  arch/x86/entry/entry_64.S        |   10 ++--------
>  arch/x86/entry/entry_64_compat.S |   21 ---------------------
>  4 files changed, 13 insertions(+), 39 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -102,6 +102,8 @@ static void exit_to_usermode_loop(struct
>  	struct thread_info *ti = current_thread_info();
>  	u32 cached_flags;
>  
> +	trace_hardirqs_off();

Bah.. so this gets called from:

 - C code, with IRQs disabled
 - entry_64.S:error_exit
 - entry_32.S:resume_userspace

The first obviously doesn't need this annotation, but this patch doesn't
remove the TRACE_IRQS_OFF from entry_64.S and only the 32bit case is
changed.

Is that entry_64.S case an oversight, or do we need an extensive comment
on this one?

>  	addr_limit_user_check();
>  
>  	lockdep_assert_irqs_disabled();
> @@ -137,6 +139,8 @@ static void exit_to_usermode_loop(struct
>  	user_enter_irqoff();
>  
>  	mds_user_clear_cpu_buffers();
> +

	/* Return to userspace (IRET) will re-enable interrupts */
> +	trace_hardirqs_on();
>  }
