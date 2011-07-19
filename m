From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: current_thread_info() vs task_thread_info(current)
Date: Mon, 18 Jul 2011 20:04:04 -0700
Message-ID: <20110719030404.GA2355@linux.vnet.ibm.com>
References: <1310988183.13765.56.camel@twins>
 <1310990097.25044.307.camel@pasglop>
 <20110718143731.GA2312@linux.vnet.ibm.com>
 <1311024983.25044.325.camel@pasglop>
 <20110719003930.GF2312@linux.vnet.ibm.com>
 <1311037057.25044.346.camel@pasglop>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40534 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab1GSDEH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Jul 2011 23:04:07 -0400
Content-Disposition: inline
In-Reply-To: <1311037057.25044.346.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Jul 19, 2011 at 10:57:37AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2011-07-18 at 17:39 -0700, Paul E. McKenney wrote:
> > > Hrm, no I don't see that happening no. The preempt count when
> > exiting an
> > > irq or softirq stack should be the exact same as when entering it,
> > which
> > > is why we don't bother copying it over. Do you see any case where
> > that
> > > wouldn't hold ?
> > 
> > Nope, other than seeing preempt_count() transition from zero to three
> > across a spin_unlock_irqrestore() for no good reason that I could see.
> 
> Do you have a nice repro-case ? :-)
> 
> That sounds really nasty ... smells really like something bad's
> happening from an interrupt, but we don't copy back the preempt-count
> from the interrupt stacks at all, so that's really really odd.

Good question...  The system I reproduced on four times over the
weekend is out of commission.  Trying the same test on another system
with a minimal patch -- will let you know how it goes.

							Thanx, Paul
