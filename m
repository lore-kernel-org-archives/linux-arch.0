From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: current_thread_info() vs task_thread_info(current)
Date: Tue, 19 Jul 2011 10:57:37 +1000
Message-ID: <1311037057.25044.346.camel@pasglop>
References: <1310988183.13765.56.camel@twins>
	 <1310990097.25044.307.camel@pasglop>
	 <20110718143731.GA2312@linux.vnet.ibm.com>
	 <1311024983.25044.325.camel@pasglop>
	 <20110719003930.GF2312@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110719003930.GF2312@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

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
