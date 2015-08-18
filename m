From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/8] ARCv2: perf: implement exclusion of event
 counting in user or kernel mode
Date: Wed, 19 Aug 2015 01:37:13 +0200
Message-ID: <20150818233713.GP20948@worktop>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-7-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52363 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbHRXhS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2015 19:37:18 -0400
Content-Disposition: inline
In-Reply-To: <1438787614-14074-7-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, Arnaldo Carvalho de Melo <acme@kernel.org>

On Wed, Aug 05, 2015 at 06:13:32PM +0300, Alexey Brodkin wrote:
> +	hwc->config = 0;
> +
> +	if (is_isa_arcv2()) {
> +		/* "exclude user" means "count only kernel" */
> +		if (event->attr.exclude_user)
> +			hwc->config |= ARC_REG_PCT_CONFIG_KERN;
> +
> +		/* "exclude kernel" means "count only user" */
> +		if (event->attr.exclude_kernel)
> +			hwc->config |= ARC_REG_PCT_CONFIG_USER;
> +	}
> +
>  	switch (event->attr.type) {
>  	case PERF_TYPE_HARDWARE:
>  		if (event->attr.config >= PERF_COUNT_HW_MAX)
>  			return -ENOENT;
>  		if (arc_pmu->ev_hw_idx[event->attr.config] < 0)
>  			return -ENOENT;
> -		hwc->config = arc_pmu->ev_hw_idx[event->attr.config];
> +		hwc->config |= arc_pmu->ev_hw_idx[event->attr.config];

So I would still very much like perf_event_attr::config to reflect the
value you'll program into hardware.

If you want to do that weird 4 character lookup thing, use a special
hardware event (possibly 0 if that is not a valid value), and stuff the
4 chars in ::config1
