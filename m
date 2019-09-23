From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC patch 09/15] entry: Provide generic exit to usermode
 functionality
Date: Mon, 23 Sep 2019 10:30:42 +0200
Message-ID: <20190923083042.GE2349@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.340471236@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919150809.340471236@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 19, 2019 at 05:03:23PM +0200, Thomas Gleixner wrote:
> +static unsigned long core_exit_to_usermode_work(struct pt_regs *regs,
> +						unsigned long ti_work)
> +{
> +	/*
> +	 * Before returning to user space ensure that all pending work
> +	 * items have been completed.
> +	 */
> +	while (ti_work & EXIT_TO_USERMODE_WORK) {
> +
> +		local_irq_enable_exit_to_user(ti_work);
> +
> +		if (ti_work & _TIF_NEED_RESCHED)
> +			schedule();
> +
> +		if (ti_work & _TIF_UPROBE)
> +			uprobe_notify_resume(regs);
> +
> +		if (ti_work & _TIF_PATCH_PENDING)
> +			klp_update_patch_state(current);
> +
> +		if (ti_work & _TIF_SIGPENDING)
> +			arch_do_signal(regs);
> +
> +		if (ti_work & _TIF_NOTIFY_RESUME) {
> +			clear_thread_flag(TIF_NOTIFY_RESUME);
> +			tracehook_notify_resume(regs);
> +			rseq_handle_notify_resume(NULL, regs);
> +		}
> +
> +		/* Architecture specific TIF work */
> +		arch_exit_to_usermode_work(regs, ti_work);
> +
> +		/*
> +		 * Disable interrupts and reevaluate the work flags as they
> +		 * might have changed while interrupts and preemption was
> +		 * enabled above.
> +		 */
> +		local_irq_disable_exit_to_user();
> +		ti_work = READ_ONCE(current_thread_info()->flags);
> +	}
> +	/*
> +	 * Was checked in exit_to_usermode_work() already, but the above
> +	 * loop might have wreckaged it.
> +	 */
> +	addr_limit_user_check();
> +	return ti_work;
> +}
> +
> +static void do_exit_to_usermode(struct pt_regs *regs)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	lockdep_sys_exit();
> +
> +	addr_limit_user_check();
> +
> +	if (unlikely(ti_work & EXIT_TO_USERMODE_WORK))
> +		ti_work = core_exit_to_usermode_work(regs, ti_work);

would it make sense to do:

	lockdep_sys_exit();
	addr_limit_user_check();

here instead of before core_exit_to_usermode_work(); that would also
allow getting rid of that second addr_limit_user_check() invocation.

And movind that lockdep check later would catch any of the
EXIT_TO_USERMODE_WORK users leaking a lock.

> +
> +	arch_exit_to_usermode(regs, ti_work);
> +	/* Return to userspace right after this which turns on interrupts */
> +	trace_hardirqs_on();
> +}
