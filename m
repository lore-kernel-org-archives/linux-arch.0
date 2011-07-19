Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57134 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab1GSBAA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Jul 2011 21:00:00 -0400
Subject: Re: current_thread_info() vs task_thread_info(current)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20110719003930.GF2312@linux.vnet.ibm.com>
References: <1310988183.13765.56.camel@twins>
	 <1310990097.25044.307.camel@pasglop>
	 <20110718143731.GA2312@linux.vnet.ibm.com>
	 <1311024983.25044.325.camel@pasglop>
	 <20110719003930.GF2312@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 10:57:37 +1000
Message-ID: <1311037057.25044.346.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20110719005737.ID08BM_DlWi6SEiT0bVGxzu2paLavR2HLt4RqOW_gL8@z>

On Mon, 2011-07-18 at 17:39 -0700, Paul E. McKenney wrote:
> > Hrm, no I don't see that happening no. The preempt count when
> exiting an
> > irq or softirq stack should be the exact same as when entering it,
> which
> > is why we don't bother copying it over. Do you see any case where
> that
> > wouldn't hold ?
> 
> Nope, other than seeing preempt_count() transition from zero to three
> across a spin_unlock_irqrestore() for no good reason that I could see.

Do you have a nice repro-case ? :-)

That sounds really nasty ... smells really like something bad's
happening from an interrupt, but we don't copy back the preempt-count
from the interrupt stacks at all, so that's really really odd.

Cheers,
Ben.


