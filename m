From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 07/31] arm64: Process management
Date: Thu, 16 Aug 2012 17:09:39 +0200
Message-ID: <20120816150939.GH7141@distanz.ch>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On 2012-08-14 at 19:52:08 +0200, Catalin Marinas <catalin.marinas@arm.com> wrote:
> +void cpu_idle(void)
> +{
> +	local_fiq_enable();
> +
> +	/* endless idle loop with no priority at all */
> +	while (1) {
> +		tick_nohz_idle_enter();
> +		rcu_idle_enter();
> +		while (!need_resched()) {
> +			/*
> +			 * We need to disable interrupts here to ensure
> +			 * we don't miss a wakeup call.
> +			 */
> +			local_irq_disable();
> +			if (!need_resched()) {
> +				stop_critical_timings();
> +				pm_idle();
> +				start_critical_timings();
> +				/*
> +				 * pm_idle functions should always return
> +				 * with IRQs enabled.
> +				 */
> +				WARN_ON(irqs_disabled());
> +			} else {
> +				local_irq_enable();
> +			}
> +		}
> +		rcu_idle_exit();
> +		tick_nohz_idle_exit();
> +		preempt_enable_no_resched();
> +		schedule();
> +		preempt_disable();

You could use schedule_preempt_disabled() instead of the above 3 calls.
See http://lkml.kernel.org/n/tip-24swm5zut3h9c4a6s46x8rws@git.kernel.org

Cheers
Tobias
