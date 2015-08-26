From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/6] ARCv2: perf: Support sampling events using
 overflow interrupts
Date: Wed, 26 Aug 2015 15:07:52 +0200
Message-ID: <20150826130752.GC19282@twins.programming.kicks-ass.net>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
 <1440426023-2792-4-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41606 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbHZNIA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2015 09:08:00 -0400
Content-Disposition: inline
In-Reply-To: <1440426023-2792-4-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, Arnaldo Carvalho de Melo <acme@kernel.org>

On Mon, Aug 24, 2015 at 05:20:20PM +0300, Alexey Brodkin wrote:
> @@ -139,9 +141,11 @@ static int arc_pmu_event_init(struct perf_event *event)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int ret;
>  
> -	hwc->sample_period  = arc_pmu->max_period;
> -	hwc->last_period = hwc->sample_period;
> -	local64_set(&hwc->period_left, hwc->sample_period);
> +	if (!is_sampling_event(event)) {
> +		hwc->sample_period  = arc_pmu->max_period;
> +		hwc->last_period = hwc->sample_period;
> +		local64_set(&hwc->period_left, hwc->sample_period);
> +	}

So here we set a max_period sample period for !sampling events such that
we can properly deal with (short) counter overflow and accumulate into a
64bit value.

>  	switch (event->attr.type) {
>  	case PERF_TYPE_HARDWARE:
> @@ -243,6 +247,11 @@ static void arc_pmu_start(struct perf_event *event, int flags)
>  
>  	arc_pmu_event_set_period(event);
>  
> +	/* Enable interrupt for this counter */
> +	if (is_sampling_event(event))
> +		write_aux_reg(ARC_REG_PCT_INT_CTRL,
> +			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
> +

Yet here you fail to actually enable the interrupt for the non sampling
events, which makes the above not work.

>  	/* enable ARC pmu here */
>  	write_aux_reg(ARC_REG_PCT_INDEX, idx);
>  	write_aux_reg(ARC_REG_PCT_CONFIG, hwc->config);
