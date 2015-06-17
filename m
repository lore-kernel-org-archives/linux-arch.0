From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow
 interrupts
Date: Wed, 17 Jun 2015 17:18:27 +0530
Message-ID: <55815E8B.9090600@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com> <1433852372-29494-5-git-send-email-vgupta@synopsys.com> <20150615162525.GH3644@twins.programming.kicks-ass.net> <C2D7FE5348E1B147BCA15975FBA23075665A59A6@IN01WEMBXB.internal.synopsys.com> <20150616090713.GJ3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:33997 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328AbbFQLsp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 07:48:45 -0400
In-Reply-To: <20150616090713.GJ3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Chuck Jordan <Chuck.Jordan@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

On Tuesday 16 June 2015 02:37 PM, Peter Zijlstra wrote:
> On Tue, Jun 16, 2015 at 05:37:40AM +0000, Vineet Gupta wrote:
>> > On Monday 15 June 2015 09:55 PM, Peter Zijlstra wrote:
>>> > > On Tue, Jun 09, 2015 at 05:49:28PM +0530, Vineet Gupta wrote:
>>>> > >> +	if (arc_pmu->has_interrupts) {
>>>> > >> +		int irq = platform_get_irq(pdev, 0);
>>> > > Hmm, so you're requesting a regular interrupt.
>>> > >
>>> > > I see your architecture has IRQ priorities, could you play games and
>>> > > create NMIs using those?
>>> > >
>>> > > For example, never mask L1 (assuming that's the highest priority) and
>>> > > treat that as an NMI.
>> > 
>> > I've had this idea before, however, while ARCv2 provides hardware interrupt
>> > priorities, we really can't implement true NMI, because CLRI / SETI used at
>> > backend of loal_irq_save() / restore() impact all priorities (statsu32 register
>> > has a global enable interrupt bit which these wiggle). So e.g. a
>> > spin_lock_irqsave() will lock out even the perf interrupt.
> Hmm, bugger. I (of course) only looked at the kernel source, since that
> is all I have, and the current arch/arc/ frobs with those two En bits in
> status32.
> 
> So arcv2 changed all that, shame.

Turns out that it is possible to implement NMI on ARCv2 in a pretty
straightforward way.

Our RTOS Guru, Chuck, told me off list, that instead of using CLRI / SETI, we can
use SETI with different args which would keep the stat32.IE enabled all the times,
but wiggle the stat32.E[ ] to change the intr prio level, effectively locking out
only lower prio interrupts in any local_irq_save() / restore() region.
But isn't this defying the irq disable/enable semantics and could lead to
potential breach of *some* critical section.

Neverthless, doing this requires some more changes in ARCv2 support code - so for
now we will go with the normal interrupts and later bolt on the NMI emulation.
