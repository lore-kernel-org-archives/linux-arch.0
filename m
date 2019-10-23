Return-Path: <sean.j.christopherson@intel.com>
Date: Wed, 23 Oct 2019 07:55:41 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 16/17] kvm/workpending: Provide infrastructure for
 work before entering a guest
Message-ID: <20191023145541.GI329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123119.173422855@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123119.173422855@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023145541._xgPh9R9UxuZmCtvecYgepcpSwxIuQuE-8OaAPuP7tY@z>

On Wed, Oct 23, 2019 at 02:27:21PM +0200, Thomas Gleixner wrote:
> Entering a guest is similar to exiting to user space. Pending work like
> handling signals, rescheduling, task work etc. needs to be handled before
> that.
> 
> Provide generic infrastructure to avoid duplication of the same handling code
> all over the place.
> 
> The kvm_exit code is split up into a KVM specific part and a generic
> builtin core part to avoid multiple exports for the actual work
> functions. The exit to guest mode handling is slightly different from the
> exit to usermode handling, e.g. vs. rseq, so a separate function is used.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> +/**
> + * exit_to_guestmode - Check and handle pending work which needs to be
> + *		       handled before returning to guest mode

Nit: I'd prefer "transferring" or "transitioning" over "returning".  KVM
could bail out of the very first run of a guest in order to handle work,
in which case the kernel isn't technically returning to guest mode as it's
never been there.  The comment might trip up VMX folks that understand the
difference between VMLAUNCH and VMRESUME, but not the purpose of this code.

> + * @kvm:	Pointer to the guest instance
> + * @vcpu:	Pointer to current's VCPU data
> + *
> + * Returns: 0 or an error code
> + */
> +static inline int exit_to_guestmode(struct kvm *kvm, struct kvm_vcpu *vcpu)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	int r = 0;
> +
> +	if (unlikely(ti_work & EXIT_TO_GUESTMODE_WORK)) {
> +		if (ti_work & _TIF_SIGPENDING) {
> +			vcpu->run->exit_reason = KVM_EXIT_INTR;
> +			vcpu->stat.signal_exits++;
> +			return -EINTR;
> +		}
> +		core_exit_to_guestmode_work(ti_work);
> +		r = arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> +	}
> +	return r;
> +}
> +
> +/**
> + * _exit_to_guestmode_work_pending - Check if work is pending which needs to be
> + *				     handled before returning to guest mode

Same pedantic comment on "returning".

> + *
> + * Returns: True if work pending, False otherwise.
> + */
> +static inline bool exit_to_guestmode_work_pending(void)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	return !!(ti_work & EXIT_TO_GUESTMODE_WORK);
> +
> +}
> +#endif /* CONFIG_KVM_EXIT_TO_GUEST_WORK */
> +
>  #endif
