From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 8 Aug 2016 17:48:28 +0100
Message-ID: <20160808164828.GH12649@leverpostej>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36917 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbcHHQsl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2016 12:48:41 -0400
Content-Disposition: inline
In-Reply-To: <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>, lorenzo.pieralisi@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi,

[adding Lorenzo]

On Mon, Aug 08, 2016 at 12:03:38PM -0400, Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> 
> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> This commit suitably tags x86, arm64, and tile idle routines,
> and only adds in the minimal framework for other architectures.

> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 659963d40bb4..fe7f93b7b11b 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -122,6 +122,7 @@ SECTIONS
>  			ENTRY_TEXT
>  			TEXT_TEXT
>  			SCHED_TEXT
> +			CPUIDLE_TEXT
>  			LOCK_TEXT
>  			KPROBES_TEXT
>  			HYPERVISOR_TEXT
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 5bb61de23201..64f088ca3192 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -48,11 +48,13 @@
>   *
>   *	Idle the processor (wait for interrupt).
>   */
> +	.pushsection ".cpuidle.text","ax"
>  ENTRY(cpu_do_idle)
>  	dsb	sy				// WFI may enter a low-power mode
>  	wfi
>  	ret
>  ENDPROC(cpu_do_idle)
> +	.popsection

From a quick scan it looks like we only call this with interrupts
disabled, and we have no NMI. So shouldn't we be annotating
arch_cpu_idle(), which calls this and subsequently enables interrupts?

I'm also not sure what you need to do for PSCI, which is the preferred
(FW-backed) idle mechanism for arm64. The infrastrucure for that is
spread over a few files:

  arch/arm64/kernel/sleep.S
  arch/arm64/kernel/smccc-call.S
  arch/arm64/kernel/suspend.c
  drivers/cpuidle/cpuidle-arm.c
  drivers/firmware/psci.c

I'm not sure where we'd be an an interruptible state, and therefore I'm
not immediately sure what we should annotate.

Thanks,
Mark.
