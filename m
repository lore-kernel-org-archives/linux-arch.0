From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow
 interrupts
Date: Tue, 16 Jun 2015 05:37:40 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A59A6@IN01WEMBXB.internal.synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
 <20150615162525.GH3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57004 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbFPFhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2015 01:37:45 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

On Monday 15 June 2015 09:55 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2015 at 05:49:28PM +0530, Vineet Gupta wrote:
>> +	if (arc_pmu->has_interrupts) {
>> +		int irq = platform_get_irq(pdev, 0);
> Hmm, so you're requesting a regular interrupt.
>
> I see your architecture has IRQ priorities, could you play games and
> create NMIs using those?
>
> For example, never mask L1 (assuming that's the highest priority) and
> treat that as an NMI.

I've had this idea before, however, while ARCv2 provides hardware interrupt
priorities, we really can't implement true NMI, because CLRI / SETI used at
backend of loal_irq_save() / restore() impact all priorities (statsu32 register
has a global enable interrupt bit which these wiggle). So e.g. a
spin_lock_irqsave() will lock out even the perf interrupt.

OTOH, we can improve the perf isr path a bit - by not routing it thru regular
interrupt return path (song and dance of CONFIG_PREEMPT_IRQ and possible
preemption). Plus there's a bit more we can do in the isr itself - not looping
thru 32 counters etc using ffs() etc - but I'd rather do that as separate series,
once we have the core support in.

-Vineet
