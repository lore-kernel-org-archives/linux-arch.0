Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58114 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab0DGLbl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2010 07:31:41 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1NzTTv-0004QK-Ng
	for linux-arch@vger.kernel.org; Wed, 07 Apr 2010 11:31:40 +0000
Subject: Re: [patch 3/3] sched: Use local_irq_save_nmi() in cpu_clock()
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20100407112707.GA5143@nowhere>
References: <20100406132807.698467930@chello.nl>
	 <20100406133141.039454288@chello.nl>  <20100407112707.GA5143@nowhere>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 13:31:34 +0200
Message-ID: <1270639894.20295.749.camel@laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: mingo@elte.hu, David Miller <davem@davemloft.net>, acme@redhat.com, paulus@samba.org, Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100407113134.Qb0AmcslXWLIAgFpt-_MmOpijYQXmfqD2WRVXWZ95xI@z>

On Wed, 2010-04-07 at 13:27 +0200, Frederic Weisbecker wrote:
> On Tue, Apr 06, 2010 at 03:28:10PM +0200, Peter Zijlstra wrote:
> > Since we can call cpu_clock() from NMI context fix up the IRQ
> > disabling to conform to the new rules.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > ---
> >  kernel/sched_clock.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/kernel/sched_clock.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/sched_clock.c
> > +++ linux-2.6/kernel/sched_clock.c
> > @@ -241,9 +241,9 @@ unsigned long long cpu_clock(int cpu)
> >  	unsigned long long clock;
> >  	unsigned long flags;
> >  
> > -	local_irq_save(flags);
> > +	local_irq_save_nmi(flags);
> >  	clock = sched_clock_cpu(cpu);
> > -	local_irq_restore(flags);
> > +	local_irq_restore_nmi(flags);
> >  
> >  	return clock;
> >  }
> 
> 
> That seem to add a small overhead in various places.
> Do we want to make local_irq_save_nmi == local_irq_save
> for archs that have native nmi?

That is already so, see 1/3.


