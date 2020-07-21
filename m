From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V4 15/15] x86/kvm: Use generic exit to guest work function
Date: Tue, 21 Jul 2020 13:27:45 -0700
Message-ID: <20200721202745.GJ22083@linux.intel.com>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.855490955@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721110809.855490955@linutronix.de>
Sender: kvm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:21PM +0200, Thomas Gleixner wrote:
> Use the generic infrastructure to check for and handle pending work before
> entering into guest mode.
> 
> This now handles TIF_NOTIFY_RESUME as well which was ignored so
> far. Handling it is important as this covers task work and task work will
> be used to offload the heavy lifting of POSIX CPU timers to thread context.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
> +	select KVM_EXIT_TO_GUEST_WORK
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
>  		}
>  
>  		/*
> -		 * Note, return 1 and not 0, vcpu_run() is responsible for
> -		 * morphing the pending signal into the proper return code.
> +		 * Note, return 1 and not 0, vcpu_run() will invoke
> +		 * exit_to_guest_mode() which will create a proper return
> +		 * code.
>  		 */
> -		if (signal_pending(current))
> +		if (__exit_to_guest_mode_work_pending())

I whined about this back in v2[*].  "exit to guest mode" is confusing becuase
virt terminology is "enter to guest" and "exit from guest", whereas the
kernel's terminology here is "exit from kernel to guest".

My past and current self still like XFER_TO_GUEST as the base terminology.

[*] https://lkml.kernel.org/r/20191023144848.GH329@linux.intel.com

>  			return 1;
> -
> -		if (need_resched())
> -			schedule();
>  	}
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
> +		exit_to_guest_mode_work_pending();
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
> +		if (exit_to_guest_mode_work_pending()) {
>  			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -			cond_resched();
> +			r = exit_to_guest_mode(vcpu);
> +			if (r)

This loses the stat.signal_exits accounting.  Maybe this?

			if (r) {
				if (r == -EINTR)
					++vcpu->stat.signal_exits;
				return r;
			}

> +				return r;
>  			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
>  		}
>  	}
> 
