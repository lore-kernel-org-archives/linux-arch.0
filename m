From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/8] ARCv2: perf: Support sampling events using
 overflow interrupts
Date: Wed, 19 Aug 2015 00:12:15 +0200
Message-ID: <20150818221215.GO20948@worktop>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-5-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55595 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbHRWMT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2015 18:12:19 -0400
Content-Disposition: inline
In-Reply-To: <1438787614-14074-5-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, Arnaldo Carvalho de Melo <acme@kernel.org>

On Wed, Aug 05, 2015 at 06:13:30PM +0300, Alexey Brodkin wrote:
> @@ -319,6 +336,20 @@ static int arc_pmu_add(struct perf_event *event, int flags)
>  	}
>  
>  	write_aux_reg(ARC_REG_PCT_INDEX, idx);
> +
> +	arc_pmu->act_counter[idx] = event;
> +
> +	if (is_sampling_event(event)) {
> +		/* Mimic full counter overflow as other arches do */
> +		write_aux_reg(ARC_REG_PCT_INT_CNTL, (u32)arc_pmu->max_period);
> +		write_aux_reg(ARC_REG_PCT_INT_CNTH,
> +			      (arc_pmu->max_period >> 32));
> +
> +		/* Enable interrupt for this counter */
> +		write_aux_reg(ARC_REG_PCT_INT_CTRL,
> +			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
> +	}

*confused* pmu::add should only start on flags & PERF_EF_START, and then
we start with hwc->sample_period, not the max_period.

> +
>  	write_aux_reg(ARC_REG_PCT_CONFIG, 0);
>  	write_aux_reg(ARC_REG_PCT_COUNTL, 0);
>  	write_aux_reg(ARC_REG_PCT_COUNTH, 0);
