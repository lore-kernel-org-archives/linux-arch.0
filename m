From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v3 4/6] ARCv2: perf: implement exclusion of event
 counting in user or kernel mode
Date: Mon, 24 Aug 2015 14:30:53 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075CFB8557D@IN01WEMBXB.internal.synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
 <1440426023-2792-5-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:38275 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbbHXOcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2015 10:32:54 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "peterz@infradead.org" <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>

On Monday 24 August 2015 07:50 PM, Alexey Brodkin wrote:
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> ---
>
> No changes since v2.
>
> No changes since v1.
>
> ....
>  	}
>  
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

With raw events patch dropped - this hunk need not be present.

>  		pr_debug("init event %d with h/w %d \'%s\'\n",
>  			 (int) event->attr.config, (int) hwc->config,
>  			 arc_pmu_ev_hw_map[event->attr.config]);
> @@ -163,7 +175,7 @@ static int arc_pmu_event_init(struct perf_event *event)
>  		ret = arc_pmu_cache_event(event->attr.config);
>  		if (ret < 0)
>  			return ret;
> -		hwc->config = arc_pmu->ev_hw_idx[ret];
> +		hwc->config |= arc_pmu->ev_hw_idx[ret];
>  		return 0;
>  	default:
>  		return -ENOENT;
