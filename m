From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period" for
 future use with interrupts
Date: Tue, 18 Aug 2015 19:55:27 +0200
Message-ID: <20150818175527.GN20948@worktop>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45626 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbHRRzf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2015 13:55:35 -0400
Content-Disposition: inline
In-Reply-To: <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, Arnaldo Carvalho de Melo <acme@kernel.org>

On Wed, Aug 05, 2015 at 06:13:29PM +0300, Alexey Brodkin wrote:
> +static int arc_pmu_event_set_period(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	s64 left = local64_read(&hwc->period_left);
> +	s64 period = hwc->sample_period;
> +	int idx = hwc->idx;
> +	int overflow = 0;
> +	u64 value;
> +
> +	if (unlikely(left <= -period)) {
> +		/* left underflowed by more than period. */
> +		left = period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		overflow = 1;
> +	} else	if (unlikely(left <= 0)) {
> +		/* left underflowed by less than period. */
> +		left += period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		overflow = 1;
> +	}
> +
> +	if (left > arc_pmu->max_period) {
> +		left = arc_pmu->max_period;
> +		local64_set(&hwc->period_left, left);

Given that you set counter_size to 32+bct_bcr.s << 4, I'm assuming these
counters are not 64bit wide (or at least the hardware has the option of
not being full width).

That means this local64_set() is wrong.

The purpose here is to emulate a longer period with a short counter. So
even though we have to take the interrupt to observe the counter width
overflow and reprogram, we must not decrease the @left value.

Doing so will trigger one of the above two cases and result in @overflow
== 1, even though we've not actually had hwc->sample_period counts.

> +	}
> +
> +	value = arc_pmu->max_period - left;
> +	local64_set(&hwc->prev_count, value);
> +
> +	/* Select counter */
> +	write_aux_reg(ARC_REG_PCT_INDEX, idx);
> +
> +	/* Write value */
> +	write_aux_reg(ARC_REG_PCT_COUNTL, (u32)value);
> +	write_aux_reg(ARC_REG_PCT_COUNTH, (value >> 32));
> +
> +	perf_event_update_userpage(event);
> +
> +	return overflow;
> +}
