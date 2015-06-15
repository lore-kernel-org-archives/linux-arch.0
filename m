From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] ARC: perf: support RAW events
Date: Mon, 15 Jun 2015 17:30:29 +0200
Message-ID: <20150615153029.GE3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-2-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41188 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbbFOPaf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2015 11:30:35 -0400
Content-Disposition: inline
In-Reply-To: <1433852372-29494-2-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Arnaldo Carvalho de Melo <acme@kernel.org>

On Tue, Jun 09, 2015 at 05:49:25PM +0530, Vineet Gupta wrote:
> +/*
> + * Raw events are specified in hex value of ASCII chars:
> + *
> + * In PCT register CC_NAME{0,1} event name string[] is saved from LSB side:
> + * e.g. cycles corresponds to ARC "crun" and is saved as 0x6e757263
> + *							    n u r c
> + * However in perf cmdline they are specified in human order as r6372756e
> + *
> + * Thus event from cmdline requires an word swap
> + */
> +static int arc_pmu_raw_event(u64 config)
> +{
> +	int i;
> +	char name[sizeof(u64) + 1] = {0};
> +	u64 swapped = __swab64(config);
> +
> +	/* Trim leading zeroes */
> +	for (i = 0; i < sizeof(u64); i++)
> +		if (!(swapped & 0xFF))
> +			swapped = swapped >> 8;
> +		else
> +			break;
> +
> +	for (i = 0; i < arc_pmu->n_events; i++) {
> +		if (swapped == arc_pmu->raw_events[i])
> +			break;
> +	}
> +
> +	if (i == arc_pmu->n_events)
> +		return -ENOENT;
> +
> +	memcpy(name, &swapped, sizeof(u64));
> +
> +	pr_debug("Initializing raw event: %s\n", name);
> +
> +	return i;
> +}

Urgh, what? Why?

raw is just that _raw_, no mucking about with the value.

If you want convenience, provide the event/format stuff so you can
write:

	perf record -e 'cpu/c=0xff,r=0cff,u=0xff,n=0xff'

Or whatever that syntax was again (I keep forgetting).
