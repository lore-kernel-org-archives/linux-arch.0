From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/6] ARCv2: perf: Support sampling events using
 overflow interrupts
Date: Wed, 26 Aug 2015 16:32:42 +0200
Message-ID: <20150826143242.GU16853@twins.programming.kicks-ass.net>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
 <1440426023-2792-4-git-send-email-abrodkin@synopsys.com>
 <20150826131225.GD19282@twins.programming.kicks-ass.net>
 <1440595268.15478.47.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54115 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbHZOcr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2015 10:32:47 -0400
Content-Disposition: inline
In-Reply-To: <1440595268.15478.47.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "acme@kernel.org" <acme@kernel.org>

On Wed, Aug 26, 2015 at 01:21:08PM +0000, Alexey Brodkin wrote:
> Hi Peter,
> 
> On Wed, 2015-08-26 at 15:12 +0200, Peter Zijlstra wrote:
> > On Mon, Aug 24, 2015 at 05:20:20PM +0300, Alexey Brodkin wrote:
> > > @@ -295,6 +317,16 @@ static int arc_pmu_add(struct perf_event *event, int flags)
> > >  	}
> > >  
> > >  	write_aux_reg(ARC_REG_PCT_INDEX, idx);
> > > +
> > > +	arc_pmu->act_counter[idx] = event;
> > > +
> > > +	if (is_sampling_event(event)) {
> > > +		/* Mimic full counter overflow as other arches do */
> > > +		write_aux_reg(ARC_REG_PCT_INT_CNTL, (u32)arc_pmu->max_period);
> > > +		write_aux_reg(ARC_REG_PCT_INT_CNTH,
> > > +			      (arc_pmu->max_period >> 32));
> > > +	}
> > > +
> > 
> > pmu::add should call pmu::start when PERF_EF_START, without that it
> > should not start the counter, only schedule it.
> > 
> > (although currently all pmu::add() calls will have EF_START set)
> 
> And that's what we do, don't we?
> ----------------------->8-----------------------
> 	if (flags & PERF_EF_START)
> 		arc_pmu_start(event, PERF_EF_RELOAD);
> ----------------------->8-----------------------
> 

D'uh indeed! I read that above as enabling it, while what it really does
it simply program the interrupt thresholds.
