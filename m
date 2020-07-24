From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V5 15/15] x86/kvm: Use generic xfer to guest work function
Date: Thu, 23 Jul 2020 17:17:36 -0700
Message-ID: <20200724001736.GK21891@linux.intel.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.979724969@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40353 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgGXARh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 20:17:37 -0400
Content-Disposition: inline
In-Reply-To: <20200722220520.979724969@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>

On Thu, Jul 23, 2020 at 12:00:09AM +0200, Thomas Gleixner wrote:
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

One nit/question below (though it's really about patch 5).

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>

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

Any reason not to call this xfer_to_guest_mode_work()?  Or handle_work(),
do_work(), etc...  Without the "work" part, it looks like a function that
should be invoked unconditionally.  It's obvious that's not the case if
one looks at the implementation, but it's a bit confusing on the KVM side
of things.

> +			if (r)
> +				return r;
>  			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
>  		}
>  	}
> 
