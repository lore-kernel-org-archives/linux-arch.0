From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/8] ARCv2: perf: implement "event_set_period" for future
 use with interrupts
Date: Mon, 15 Jun 2015 17:38:31 +0200
Message-ID: <20150615153831.GF3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-4-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38128 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbbFOPii (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2015 11:38:38 -0400
Content-Disposition: inline
In-Reply-To: <1433852372-29494-4-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Arnaldo Carvalho de Melo <acme@kernel.org>

On Tue, Jun 09, 2015 at 05:49:27PM +0530, Vineet Gupta wrote:
> @@ -99,8 +99,7 @@ static void arc_perf_event_update(struct perf_event *event,
>  	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
>  				 new_raw_count) != prev_raw_count);
>  
> -	delta = (new_raw_count - prev_raw_count) &
> -		((1ULL << arc_pmu->counter_size) - 1ULL);
> +	delta = (new_raw_count - prev_raw_count) & arc_pmu->max_period;

I don't know how your PMU works, but you seem to be assuming new_raw >
prev_raw, which implies its counting up.

Now, typically these things trigger when they reach 0, so when we're
counting up that would mean your values are negative.

In that case, where's the sign extension?

> @@ -182,6 +181,13 @@ static int arc_pmu_event_init(struct perf_event *event)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int ret;
>  
> +	if (!is_sampling_event(event)) {
> +		hwc->sample_period  = arc_pmu->max_period;
> +		hwc->last_period = hwc->sample_period;
> +		local64_set(&hwc->period_left, hwc->sample_period);
> +	} else
> +		return -ENOENT;

-ENOENT is wrong for is_sampling_event().

Either the event is for this PMU, in which case you should return a
fatal error, or its not (-ENOENT is correct in that case).
