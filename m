From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/6] ARCv2: perf: Support sampling events using
 overflow interrupts
Date: Wed, 26 Aug 2015 16:35:18 +0200
Message-ID: <20150826143518.GV16853@twins.programming.kicks-ass.net>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
 <1440426023-2792-4-git-send-email-abrodkin@synopsys.com>
 <20150826130752.GC19282@twins.programming.kicks-ass.net>
 <1440595040.15478.44.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56387 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbHZOfY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2015 10:35:24 -0400
Content-Disposition: inline
In-Reply-To: <1440595040.15478.44.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "acme@kernel.org" <acme@kernel.org>

On Wed, Aug 26, 2015 at 01:17:20PM +0000, Alexey Brodkin wrote:
> Hi Peter,
> 
> On Wed, 2015-08-26 at 15:07 +0200, Peter Zijlstra wrote:
> > On Mon, Aug 24, 2015 at 05:20:20PM +0300, Alexey Brodkin wrote:
> > > @@ -139,9 +141,11 @@ static int arc_pmu_event_init(struct perf_event *event)
> > >  	struct hw_perf_event *hwc = &event->hw;
> > >  	int ret;
> > >  
> > > -	hwc->sample_period  = arc_pmu->max_period;
> > > -	hwc->last_period = hwc->sample_period;
> > > -	local64_set(&hwc->period_left, hwc->sample_period);
> > > +	if (!is_sampling_event(event)) {
> > > +		hwc->sample_period  = arc_pmu->max_period;
> > > +		hwc->last_period = hwc->sample_period;
> > > +		local64_set(&hwc->period_left, hwc->sample_period);
> > > +	}
> > 
> > So here we set a max_period sample period for !sampling events such that
> > we can properly deal with (short) counter overflow and accumulate into a
> > 64bit value.
> > 
> > >  	switch (event->attr.type) {
> > >  	case PERF_TYPE_HARDWARE:
> > > @@ -243,6 +247,11 @@ static void arc_pmu_start(struct perf_event *event, int flags)
> > >  
> > >  	arc_pmu_event_set_period(event);
> > >  
> > > +	/* Enable interrupt for this counter */
> > > +	if (is_sampling_event(event))
> > > +		write_aux_reg(ARC_REG_PCT_INT_CTRL,
> > > +			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
> > > +
> > 
> > Yet here you fail to actually enable the interrupt for the non sampling
> > events, which makes the above not work.
> 
> Indeed we intentionally leave interrupts disabled for non-sampling events.
>  [1] We have quite large counters so we don't expect to overflow normally
>  [2] We may re-use the same code for hardware that lacks support of IRQs in PCT.
>      See we check if IRQs are available and if not set PERF_PMU_CAP_NO_INTERRUPT
>      that will guarantee we won't get sampling event and for non-sampling events
>      we won't use IRQs.

Tricky, I was seeing is_isa_arcv2() calls elsewhere, so I figured you'd
make it conditional on that.

But sure, if you think you can live with 1 this'll work.
