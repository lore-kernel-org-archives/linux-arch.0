From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Fri, 06 Mar 2009 10:12:13 +0100
Message-ID: <1236330733.6326.15.camel@laptop>
References: <1235996477.5330.174.camel@laptop>
	 <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
	 <1236329922.7260.127.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:41659 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbZCFJM0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2009 04:12:26 -0500
In-Reply-To: <1236329922.7260.127.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2009-03-06 at 19:58 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2009-03-02 at 09:11 -0800, Linus Torvalds wrote:
> > 
> > On Mon, 2 Mar 2009, Peter Zijlstra wrote:
> > > 
> > > Would you be willing to take such a patch?
> > 
> > Yes - some day.
> > 
> > The "irq's disabled fastpath" thing has been there since pretty much day 
> > one, because some irq handlers always wanted it. Making it the default 
> > (and the only choice) is fine.
> 
>  .../...
> 
> I tend to disagree... (not -that- strongly but I felt like saying it
> anyway :-) some archs have a reasonably nice support in the PIC for
> interrupt priorities, allowing higher priority interrupts to "preempt"
> lower priority ones, which this would effectively render useless.
> 
> Also, while yes, I agree, interrupts handlers -should- be short in
> practice IDE is far from being the only example where this is not the
> case and so we would delay timer interrupts for example for a
> significant amount of time (or serial, that's another good example).
> 
> Also, we use the priority on some platform to have a high priority used
> as a kind of "debugger" NMI .. ie, we don't have a real NMI but it's
> better than nothing and here too, this would break it.

If you have distinct interrupt priorities, you can

1) provide an interrupt stack for each priority
2) mask all lower priorities when handling one

Would that not work?

> I don't see us having such a strong benefit from this... in fact, with
> things like -rt, interrupts get moved to threads no ? Thus they
> typically run with interrupts enabled... why have a different behaviour
> on non-rt ? or I am missing something ? (I'm not terribly familiar with
> the -rt stuff here so I probably am missing something).

Threaded interrupts are quite a different beast. To make best use of
them device drivers will have to be re-written. Hence the opt-in
approach.

The problems with enabling irqs in hardirq handlers are that you get
unlimited irq nesting, which is bad for your stack, furthermore, somehow
people thing it makes things 'faster' because the irq-off latency goes
down.

The latter just isn't true, as you still have preemption disabled, so
everything but irqs still suffers.

The only way to make things low-latency is to pull work out of
non-preemptable context. Using threaded IRQs is one way to do that.
