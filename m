From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow
 interrupts
Date: Mon, 15 Jun 2015 17:48:16 +0200
Message-ID: <20150615154816.GG3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41314 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbFOPsV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2015 11:48:21 -0400
Content-Disposition: inline
In-Reply-To: <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Arnaldo Carvalho de Melo <acme@kernel.org>

On Tue, Jun 09, 2015 at 05:49:28PM +0530, Vineet Gupta wrote:
> From: Alexey Brodkin <abrodkin@synopsys.com>

-ENOCHANGELOG

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---

>  struct arc_pmu {
>  	struct pmu	pmu;
> +	int		has_interrupts;

we have pmu::flags & PERF_PMU_CAP_NO_INTERRUPT


> @@ -186,7 +189,8 @@ static int arc_pmu_event_init(struct perf_event *event)
>  		hwc->last_period = hwc->sample_period;
>  		local64_set(&hwc->period_left, hwc->sample_period);
>  	} else
> -		return -ENOENT;
> +		if (!arc_pmu->has_interrupts)
> +			return -ENOENT;

Same as before, first determine if the event is yours, then return a
fatal error.

> @@ -307,6 +311,17 @@ static void arc_pmu_stop(struct perf_event *event, int flags)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
>  
> +	/* Disable interrupt for this counter */
> +	if (is_sampling_event(event)) {

but but but, a sampling event needs the interrupt enabled?

> +		/*
> +		 * Reset interrupt flag by writing of 1. This is required
> +		 * to make sure pending interrupt was not left.
> +		 */

Would not typically the interrupt latch be a property of the interrupt
controller, not the device generating it?

That is, how can the device programming affect pending interrupts?

> +		write_aux_reg(ARC_REG_PCT_INT_ACT, 1 << idx);
> +		write_aux_reg(ARC_REG_PCT_INT_CTRL,
> +			      read_aux_reg(ARC_REG_PCT_INT_CTRL) & ~(1 << idx));
> +	}
> +

> +	if (is_sampling_event(event)) {
> +		/* Mimic full counter overflow as other arches do */

With this you mean the pretending we have 63bit of overflow counter?

> +		write_aux_reg(ARC_REG_PCT_INT_CNTL, arc_pmu->max_period &
> +						    0xffffffff);

Would not (u32)arc_pmu->max_period, be clearer?

> +		write_aux_reg(ARC_REG_PCT_INT_CNTH,
> +			      (arc_pmu->max_period >> 32));

But should you not program: min(period, max_period) instead? If the
requested period is shorter than your max period you do not want to
program the max. Or are you missing a negative somewhere?

That is, program the max_period for !sampling events to deal with
overflow folding.

> +
> +		/* Enable interrupt for this counter */
> +		write_aux_reg(ARC_REG_PCT_INT_CTRL,
> +			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
> +	}
> +
>  	write_aux_reg(ARC_REG_PCT_CONFIG, 0);
>  	write_aux_reg(ARC_REG_PCT_COUNTL, 0);
>  	write_aux_reg(ARC_REG_PCT_COUNTH, 0);
