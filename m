From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/10] Add generic helpers for arch IPI function calls
Date: Wed, 11 Jun 2008 11:13:35 +0100
Message-ID: <1213179215.19224.61.camel@pc1117.cambridge.arm.com>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com>
	 <1212051504-12561-2-git-send-email-jens.axboe@oracle.com>
	 <1213109485.24701.107.camel@pc1117.cambridge.arm.com>
	 <20080610154716.GF15481@linux.vnet.ibm.com>
	 <1213116788.24701.133.camel@pc1117.cambridge.arm.com>
	 <20080611032531.GC8228@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754861AbYFKKXY@vger.kernel.org>
In-Reply-To: <20080611032531.GC8228@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: paulmck@linux.vnet.ibm.com, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, Russell King <rmk+lkml@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Wed, 2008-06-11 at 05:25 +0200, Nick Piggin wrote:
> On Tue, Jun 10, 2008 at 05:53:08PM +0100, Catalin Marinas wrote:
> > On Tue, 2008-06-10 at 08:47 -0700, Paul E. McKenney wrote:
> > > On Tue, Jun 10, 2008 at 03:51:25PM +0100, Catalin Marinas wrote:
> > > > I was thinking whether this condition can be removed and allow =
the
> > > > smp_call_function*() to be called with IRQs disabled. At a quic=
k look,
> > > > it seems to be possible if the csd_flag_wait() function calls t=
he IPI
> > > > handlers directly when the IRQs are disabled (see the patch bel=
ow).
> > [...]
> > > There were objections last month:  http://lkml.org/lkml/2008/5/3/=
167
> >=20
> > Thanks, I missed this discussion.
> >=20
> > > The issue was that this permits some interrupts to arrive despite
> > > interrupts being disabled.  There seemed to be less resistance to
> > > doing this in the wait=3D=3D1 case, however.
> >=20
> > The "(wait =3D=3D 1) && irqs_disabled()" case is what I would be in=
terested
> > in. In the patch you proposed, this doesn't seem to be allowed (at =
least
> > from the use of WARN_ON). However, from your post in May:
> >=20
> > > 5.	If you call smp_call_function() with irqs disabled, then you
> > > 	are guaranteed that no other CPU's smp_call_function() handler
> > > 	will be invoked while smp_call_function() is executing.
> >=20
> > this would be possible but no one need this functionality yet.
> >=20
> > Would one use-case (ARM SMP and DMA cache maintenance) be enough to
> > implement this or I should add it to the ARM-specific code?
>=20
> How will you implement it? You have to be able to wait *somewhere*
> (either before or after the smp_call_function call) with interrupts
> enabled. It is not enough just to eg. use a spinlock around
> smp_call_function, because other CPUs might also be trying to call
> down the same path also with interrupts disabled, and they'll wait
> forever on the spinlock.

With the generic IPI patches, I think it is just a matter of polling fo=
r
incoming IPIs in the csd_flag_wait() if interrupts are disabled since n=
o
spinlock is held when issuing the IPI (smp_call_function can be called
concurrently).

If I do it in the ARM-specific code, I would duplicate the
smp_call_function (but avoid the call_single_queue, maybe just like the
current ARM implementation) and use a spinlock around the IPI
invocation. If interrupts are allowed to be disabled, the spin_lock()
would actually be a spin_trylock() (or spin_trylock_irqsave()),
something like below (untested). It can be improved for the IRQs-enable=
d
case to reduce the latency.

smp_call_function(...)
{
	...
	/*
	 * disable IRQs so that we can call this function from
	 * =EF=BB=BFinterrupt context
	 */
	local_irq_save(flags)
	while (!spin_trylock(&call_function_lock)) {
		/* other CPU is sending an IPI, just poll for it */
		smp_call_function_interrupt();
	}
	/* acquired the lock, do the IPI stuff */
	...

	/*=20
	 * wait for the other CPUs to complete the IPI. No other CPU=20
	 * is waiting for completion because of the call_function_lock
	 */
	...

	spin_unlock(=EF=BB=BF&call_function_lock);
	local_irq_restore(flags);
}

One issue I saw raised with the polling loop is that it calls an
interrupt handler outside an interrupt context and with IRQs disabled.
There shouldn't be any issue with the existing code since
smp_call_function assumes interrupts enabled anyway. Whoever needs this
functionality should take greater care with IRQs disabled (in my case,
only calling some cache maintenance operations is OK).

Regarding the interrupt latency, it would be higher since the IPI is no=
t
that cheap but (in ARM SMP case) calling dma_map_single/sg (especially
with TO_DEVICE) with interrupts disabled I think is pretty bad already
as it involves flushing the caches for that range and time-consuming.

If dma_map_single/sg would be disallowed with interrupts disabled or
from interrupt context, we would no longer need the above workarounds
for smp_call_function on ARM.

Regards.

--=20
Catalin
