Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47923 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcBWJ6a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2016 04:58:30 -0500
Date: Tue, 23 Feb 2016 10:58:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Interesting csd deadlock on ARC
Message-ID: <20160223095824.GH6356@twins.programming.kicks-ass.net>
References: <56C6BA82.1060909@synopsys.com>
 <56CBEC66.2030401@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56CBEC66.2030401@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Noam Camus <noamc@ezchip.com>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <20160223095824.26A17mMls6wWJkQ9EPkGV1pA2NNRWHRapOkNTlFDD0Q@z>

On Tue, Feb 23, 2016 at 10:51:42AM +0530, Vineet Gupta wrote:
> On Friday 19 February 2016 12:17 PM, Vineet Gupta wrote:
> > Hi Peter,
> > 
> > I've been debugging a csd_lock_wait() deadlock on SMP+PREEMPT ARC HS38x2 and it
> > turned out to be lot more interesting than I'd hoped for. This is stock v4.4
> > 
> > Trouble starts with an IPI to self which doesn't get delivered as the inter-core
> > interrupt providing h/w is not capable of IPI to self (which I found as part of
> > debugging this). Subsequent IPIs from other cores to this core get elided as well
> > due to the IPI coalescing optimization in arch/arc/kernel/smp.c: ipi_send_msg_one()
> > 
> > There are ways to use a different h/w mechanism to solve the trigger issue and I'd
> > hoped to just implement arch_irq_work_raise(). 

Yes, there are other architectures that use other means for self-IPI,
IIRC PowerPC has to program their timer in the past to generate a local
interrupt.

> > But the trouble is the call stack
> > for this issue: IPI to self is triggered from
> > 
> > sys_sched_setscheduler
> >    __balance_callback
> >        pull_rt_task
> >          irq_work_queue_on  <-- called with @cpu == self
> > 
> > Looking into irq_work.c, irq_work_queue() is what is semantically needed,
> > specifically arch_irq_work_raise() will not be called, which means I need
> > arch_send_call_function_single_ipi() to be able to IPI to self cpu also. Is that
> > expected from arch code....
> 
> What I actually meant was is it OK for irq_work_queue_on() to be called locally
> (is this a sched bug/optimization(. Further if it is OK to be called, does it need
> to do behave more like irq_work_queue() i.e. call arch_irq_work_raise() or
> arch_send_call_function_single_ipi() is expected to handle sending IPI to self !

Right, so I'm not actually sure we started out with this requirement.
But you're not the first to run into this, see:

  lkml.kernel.org/r/CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com

Initially I think irq_work_queue_on() was only used remotely, but I
think it makes sense to allow the current cpu, esp. since people seem to
be using it like that.

Now the distinct difference between arch_irq_work_raise() and
arch_send_call_function_single_ipi() is that arch_irq_work_raise()
should be NMI-safe.

So on x86 it has to be extra careful about the lapic state, whereas the
regular IPI code doesn't.

I seem to have forgotten the status of NMIs on ARC, but this is
something to make a note of.
