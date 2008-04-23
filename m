From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Wed, 23 Apr 2008 09:50:19 +0200
Message-ID: <1208937019.7115.326.camel@twins>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com>
	 <1208890227-24808-2-git-send-email-jens.axboe@oracle.com>
	 <1208895423.7115.290.camel@twins> <20080423060725.GT12774@kernel.dk>
	 <1208932320.7115.319.camel@twins>  <20080423074933.GB12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080423074933.GB12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

On Wed, 2008-04-23 at 09:49 +0200, Jens Axboe wrote:
> On Wed, Apr 23 2008, Peter Zijlstra wrote:
> > On Wed, 2008-04-23 at 08:07 +0200, Jens Axboe wrote:
> > > On Tue, Apr 22 2008, Peter Zijlstra wrote:
> > > > On Tue, 2008-04-22 at 20:50 +0200, Jens Axboe wrote:
> > > > 
> > > > > +int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
> > > > > +			     int retry, int wait)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +	/* prevent preemption and reschedule on another processor */
> > > > > +	int me = get_cpu();
> > > > > +
> > > > > +	/* Can deadlock when called with interrupts disabled */
> > > > > +	WARN_ON(wait && irqs_disabled());
> > > > 
> > > > With this fallback to wait the above condition isn't sufficient.
> > > 
> > > What deadlock are you concerned with here? Would making cfd_fallback
> > > per-cpu make you feel better?
> > 
> >   CPU0					  CPU1
> > 
> > local_irq_disable()			local_irq_disable()
> > 
> > 					smp_call_function_single(0,..,0)
> > 					  test_and_set_bit_lock()
> > 					  send IPI
> > smp_call_function_single(1,..,0)
> >   while(test_and_set_bit_lock())
> >     cpu_relax();
> > 
> > 
> > This will spin forever, because it needs to handle the IPI in order to
> > free the cfd_fallback thingy, but can't for its waiting for it.
> > 
> > That particular deadlock can indeed be solved by making cfd_fallback
> > per-cpu.
> 
> Right, that is the case I was thinking of. I added per-cpu fallbacks to
> cover that case.

Great, thanks!

> > But if you were to use multiple smp_call_function*() calls under a
> > single IRQ disabled, then that would not be sufficient. Now I can't
> > directly come up with a good reason to need to do that, but still.
> > 
> > You'd need somethine like:
> > 
> > local_irq_disable()
> > 
> > smp_call_function_single(n, func_a,..,0)
> > smp_call_function_single(m, func_b,..,0)
> > 
> > local_irq_enable()
> > 
> > And invite 3 cpus to the party while under memory pressure and you get
> > deadlock potential.
> > 
> > [ if it were both the same function, you'd want to use
> >   smp_call_function() and provide a mask; if it were the same cpu you'd
> >   want to call a function doing both ]
> 
> I think that is plenty far off into theoretical country that we can get
> by with just documenting this limitation. Nobody is doing that currently
> in the kernel, and I see no practical use case for it.

Agreed.
