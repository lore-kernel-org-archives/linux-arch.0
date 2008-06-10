From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/10] Add generic helpers for arch IPI function calls
Date: Tue, 10 Jun 2008 10:44:43 -0500
Message-ID: <1213112683.3440.20.camel@localhost.localdomain>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com>
	 <1212051504-12561-2-git-send-email-jens.axboe@oracle.com>
	 <1213109485.24701.107.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:36180 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752984AbYFJPot (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jun 2008 11:44:49 -0400
In-Reply-To: <1213109485.24701.107.camel@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com, Russell King <rmk+lkml@arm.linux.org.uk>

On Tue, 2008-06-10 at 15:51 +0100, Catalin Marinas wrote:
> Hi,
> 
> On Thu, 2008-05-29 at 10:58 +0200, Jens Axboe wrote:
> > This adds kernel/smp.c which contains helpers for IPI function calls. In
> > addition to supporting the existing smp_call_function() in a more efficient
> > manner, it also adds a more scalable variant called smp_call_function_single()
> > for calling a given function on a single CPU only.
> [...]
> > + * You must not call this function with disabled interrupts or from a
> > + * hardware interrupt handler or from a bottom half handler.
> > + */
> > +int smp_call_function_mask(cpumask_t mask, void (*func)(void *), void *info,
> > +			   int wait)
> > +{
> > +	struct call_function_data d;
> > +	struct call_function_data *data = NULL;
> > +	cpumask_t allbutself;
> > +	unsigned long flags;
> > +	int cpu, num_cpus;
> > +
> > +	/* Can deadlock when called with interrupts disabled */
> > +	WARN_ON(irqs_disabled());
> 
> I was thinking whether this condition can be removed and allow the
> smp_call_function*() to be called with IRQs disabled. At a quick look,
> it seems to be possible if the csd_flag_wait() function calls the IPI
> handlers directly when the IRQs are disabled (see the patch below).
> 
> This would be useful on ARM11MPCore based systems where the cache
> maintenance operations are not detected by the snoop control unit and
> this affects the DMA calls like dma_map_single(). There doesn't seem to
> be any restriction on calls to dma_map_single() and hence we cannot
> broadcast the cache operation to the other CPUs. I could implement this
> in the ARM specific code using spin_try_lock (on an IPI-specific lock
> held during the cross-call) and polling for an IPI if a lock cannot be
> acquired (meaning that a different CPU is issuing an IPI) but I was
> wondering whether this would be possible in a more generic way.
> 
> Please let me know what you think or whether deadlocks are still
> possible (or any other solution apart from hardware fixes :-)). Thanks.

I don't see how your proposal fixes the deadlocks.  The problem is that
on a lot of arch's IPIs are normal interrupts.  If interrupts are
disabled, you don't see them.

The deadlock scenario is CPU1 enters smp_call_function() with IRQ's
disabled as CPU2 does the same thing and spins on the call_lock.  Now
CPU1 is waiting for an ack for its IPI to CPU2, but CPU2 will never see
the IPI until it enables interrupts.

One way to mitigate the effects of this is to enable interrupts if the
architecture code finds the call_lock (x86 implementation) held against
it, then re-disable before trying to get the lock again.  But really, in
order to make smp_call_function work in interrupt disabled sections, the
interrupt handler has to be modified to bar all non-IPI interrupts until
the critical section is over (otherwise there's no point allowing it
with disabled interrupts because an smp_call_function becomes a de facto
interrupt enable again).  If you really want to see how something like
this works, the voyager code has it (because interrupt disabling in the
VIC is expensive).  But it's quite a lot of code ...

James
