From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch V5 15/15] x86/kvm: Use generic xfer to guest work function
Date: Fri, 24 Jul 2020 16:24:26 +0200
Message-ID: <20200724142426.GA651711@gmail.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.979724969@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOYb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 10:24:31 -0400
Content-Disposition: inline
In-Reply-To: <20200722220520.979724969@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Use the generic infrastructure to check for and handle pending work before
> transitioning into guest mode.
> 
> This now handles TIF_NOTIFY_RESUME as well which was ignored so
> far. Handling it is important as this covers task work and task work will
> be used to offload the heavy lifting of POSIX CPU timers to thread context.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V5: Rename exit -> xfer
> ---
>  arch/x86/kvm/Kconfig   |    1 +
>  arch/x86/kvm/vmx/vmx.c |   11 +++++------
>  arch/x86/kvm/x86.c     |   15 ++++++---------
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -42,6 +42,7 @@ config KVM
>  	select HAVE_KVM_MSI
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select HAVE_KVM_NO_POLL
> +	select KVM_XFER_TO_GUEST_WORK
>  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>  	select KVM_VFIO
>  	select SRCU
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/tboot.h>
>  #include <linux/trace_events.h>
> +#include <linux/entry-kvm.h>
>  
>  #include <asm/apic.h>
>  #include <asm/asm.h>
> @@ -5376,14 +5377,12 @@ static int handle_invalid_guest_state(st

>  
>  	return 1;
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -56,6 +56,7 @@
>  #include <linux/sched/stat.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/entry-kvm.h>
>  
>  #include <trace/events/kvm.h>
>  
> @@ -1585,7 +1586,7 @@ EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
>  bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
> -		need_resched() || signal_pending(current);
> +		xfer_to_guest_mode_work_pending();
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_exit_request);
>  
> @@ -8676,15 +8677,11 @@ static int vcpu_run(struct kvm_vcpu *vcp
>  			break;
>  		}
>  
> -		if (signal_pending(current)) {
> -			r = -EINTR;
> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
> -			++vcpu->stat.signal_exits;
> -			break;
> -		}
> -		if (need_resched()) {
> +		if (xfer_to_guest_mode_work_pending()) {
>  			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -			cond_resched();
> +			r = xfer_to_guest_mode(vcpu);
> +			if (r)
> +				return r;
>  			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
>  		}
>  	}

So this chunk replaces vcpu_run()'s cond_resched() call with a call to 
xfer_to_guest_mode(), which checks NEED_RESCHED & acts upon it, among 
other things.

But:

>  		}
>  
>  		/*
> -		 * Note, return 1 and not 0, vcpu_run() is responsible for
> -		 * morphing the pending signal into the proper return code.
> +		 * Note, return 1 and not 0, vcpu_run() will invoke
> +		 * xfer_to_guest_mode() which will create a proper return
> +		 * code.
>  		 */
> -		if (signal_pending(current))
> +		if (__xfer_to_guest_mode_work_pending())
>  			return 1;
> -
> -		if (need_resched())
> -			schedule();
>  	}

AFAICS this chunk removes a conditional reschedule point from 
handle_invalid_guest_state() and replaces it with 
__xfer_to_guest_mode_work_pending().

But __xfer_to_guest_mode_work_pending() doesn't do the cond-resched of 
the full xfer_to_guest_mode_work() function - so we essentially lose a 
cond_resched() here.

Is this side effect intended, was the cond_resched() superfluous?

The logic is quite a maze, and the KVM code was missing a few of the 
state checks, so maybe this is all for the better - just wanted to 
mention it, in case it matters.

Thanks,

	Ingo
