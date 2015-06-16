From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow
 interrupts
Date: Tue, 16 Jun 2015 11:07:13 +0200
Message-ID: <20150616090713.GJ3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
 <20150615162525.GH3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A59A6@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41537 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838AbbFPJH3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2015 05:07:29 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665A59A6@IN01WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

On Tue, Jun 16, 2015 at 05:37:40AM +0000, Vineet Gupta wrote:
> On Monday 15 June 2015 09:55 PM, Peter Zijlstra wrote:
> > On Tue, Jun 09, 2015 at 05:49:28PM +0530, Vineet Gupta wrote:
> >> +	if (arc_pmu->has_interrupts) {
> >> +		int irq = platform_get_irq(pdev, 0);
> > Hmm, so you're requesting a regular interrupt.
> >
> > I see your architecture has IRQ priorities, could you play games and
> > create NMIs using those?
> >
> > For example, never mask L1 (assuming that's the highest priority) and
> > treat that as an NMI.
> 
> I've had this idea before, however, while ARCv2 provides hardware interrupt
> priorities, we really can't implement true NMI, because CLRI / SETI used at
> backend of loal_irq_save() / restore() impact all priorities (statsu32 register
> has a global enable interrupt bit which these wiggle). So e.g. a
> spin_lock_irqsave() will lock out even the perf interrupt.

Hmm, bugger. I (of course) only looked at the kernel source, since that
is all I have, and the current arch/arc/ frobs with those two En bits in
status32.

So arcv2 changed all that, shame.

> OTOH, we can improve the perf isr path a bit - by not routing it thru regular
> interrupt return path (song and dance of CONFIG_PREEMPT_IRQ and possible
> preemption). Plus there's a bit more we can do in the isr itself - not looping
> thru 32 counters etc using ffs() etc - but I'd rather do that as separate series,
> once we have the core support in.

Yeah, borderline useful though, the reason the NMI thing is so useful is
that you can profile _inside_ IRQ-disabled regions. Now your
local_irq_enable() et al will be the hottest functions ever :-)

Regular interrupts are really only useful for userspace profiling, which
if plenty useful on its own of course. But kernel profiling is very
handy too :-)
