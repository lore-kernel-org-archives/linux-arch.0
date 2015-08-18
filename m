From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period" for
 future use with interrupts
Date: Tue, 18 Aug 2015 19:52:03 +0200
Message-ID: <20150818175203.GM20948@worktop>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
 <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36234 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbHRRwL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2015 13:52:11 -0400
Content-Disposition: inline
In-Reply-To: <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, Arnaldo Carvalho de Melo <acme@kernel.org>

On Wed, Aug 05, 2015 at 06:13:29PM +0300, Alexey Brodkin wrote:
> Even though this hardware implementation allows for more flexibility,
> in Linux kernel we decided to mimic behavior of other architectures this
> way:
> 
>  [1] Set limit value as half of counter's max value (to allow counter to
>      run after reaching it limit, see below for more explanation):
>  ---------->8-----------
>  arc_pmu->max_period = (1ULL << counter_size) / 2 - 1ULL;
>  ---------->8-----------

> @@ -317,10 +365,11 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	arc_pmu->n_counters = pct_bcr.c;
> -	arc_pmu->counter_size = 32 + (pct_bcr.s << 4);
> +	counter_size = 32 + (pct_bcr.s << 4);
> +	arc_pmu->max_period = (1ULL << counter_size) - 1ULL;
>  

I don't see that /2 there..
