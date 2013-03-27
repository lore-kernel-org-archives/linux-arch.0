From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 13/34] cris: Use generic idle loop
Date: Wed, 27 Mar 2013 18:10:15 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303271809350.22263@ionos>
References: <20130321214930.752934102@linutronix.de> <20130321215234.148829489@linutronix.de> <20130327150421.GV28422@axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36701 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab3C0RKV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Mar 2013 13:10:21 -0400
In-Reply-To: <20130327150421.GV28422@axis.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>

On Wed, 27 Mar 2013, Jesper Nilsson wrote:
> 
> On Thu, Mar 21, 2013 at 09:53:06PM -0000, Thomas Gleixner wrote:
> [snip]
> > Index: linux-2.6/arch/cris/arch-v32/kernel/process.c
> > ===================================================================
> > --- linux-2.6.orig/arch/cris/arch-v32/kernel/process.c
> > +++ linux-2.6/arch/cris/arch-v32/kernel/process.c
> > @@ -23,12 +23,10 @@ extern void stop_watchdog(void);
> >  /* We use this if we don't have any better idle routine. */
> >  void default_idle(void)
> >  {
> > -	local_irq_disable();
> > -	if (!need_resched()) {
> > -		/* Halt until exception. */
> > -		__asm__ volatile("ei    \n\t"
> > -				 "halt      ");
> > -	}
> > +	/* Halt until exception. */
> > +	__asm__ volatile("ei    \n\t"
> > +			 "halt      ");
> > +	/* CHECKME: Is this really needed ?? */
> >  	local_irq_enable();
> 
> No, that local_irq_enable() is redundant since we already enabled interrupts
> in the assembler directive above.

That's what I thought:) Will remove it.
 
Thanks,

	tglx
