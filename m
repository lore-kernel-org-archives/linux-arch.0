From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/24] C6X: process management
Date: Mon, 22 Aug 2011 22:55:49 +0200
Message-ID: <1606029.05YQUzWRG5@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-9-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61979 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1HVU40 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 16:56:26 -0400
In-Reply-To: <1314043785-2880-9-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:29 Mark Salter wrote:

> diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
> new file mode 100644
> index 0000000..d7bc66f
> --- /dev/null
> +++ b/arch/c6x/kernel/process.c
>
> +/* hooks for board specific support */
> +void	(*c6x_restart)(void);
> +void	(*c6x_halt)(void);
> +void	(*c6x_power_off)(void);
> +
> +/*
> + * power off function, if any
> + */
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL(pm_power_off);
> +
> +/*
> + * power management idle function, if any..
> + */
> +void (*pm_idle)(void);
> +EXPORT_SYMBOL(pm_idle);

You probably don't want two levels of indirection for the power_off
callback, so just reassign pm_power_off from a driver when needed.

> +static void default_idle(void)
> +{
> +	asm volatile ("IDLE\n");
> +}
> +
> +/*
> + * The idle loop for C64x
> + */
> +void cpu_idle(void)
> +{
> +	/* endless idle loop with no priority at all */
> +	while (1) {
> +		tick_nohz_stop_sched_tick(1);
> +		while (!need_resched()) {
> +			void (*idle)(void);
> +
> +			smp_rmb();
> +			idle = pm_idle;
> +			if (!idle)
> +				idle = default_idle;
> +			idle();
> +		}
> +		tick_nohz_restart_sched_tick();
> +
> +		preempt_enable_no_resched();
> +		schedule();
> +		preempt_disable();
> +	}
> +}

Hmm, I'm having a small deja-vue here. I think I just commented on the same
bug in the hexagon architecture patches ;-)

You need to disable all interrupts before checking need_resched() and keep
them disabled until returning from the idle function. Otherwise you might
not wake up (or wake up late) after an interrupt handler has set
need_resched() and waits for interrupts to process while you have entered
the idle call.

	Arnd
