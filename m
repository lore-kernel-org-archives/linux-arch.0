From: Nick Piggin <npiggin@suse.de>
Subject: Re: SMP barriers semantics
Date: Mon, 22 Mar 2010 23:02:03 +1100
Message-ID: <20100322120203.GL17637@laptop>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
 <20100303005529.GA3879@brick.ozlabs.ibm.com>
 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
 <20100312123105.GB4400@linux-mips.org>
 <1268792716.2335.170.camel@pasglop>
 <20100317134243.GA15235@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50138 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab0CVMCU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 08:02:20 -0400
Content-Disposition: inline
In-Reply-To: <20100317134243.GA15235@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Wed, Mar 17, 2010 at 01:42:43PM +0000, Jamie Lokier wrote:
> Benjamin Herrenschmidt wrote:
> > Maybe we can agree on a set of relaxed accessors defined specifically
> > with those semantics (more relaxed implies use of raw_*) :
> > 
> >   - order is guaranteed between MMIOs
> >   - no order is guaranteed between MMIOs and spinlocks
> 
> No order between MMIOs and spinlocks will be fun :-)

There isn't anyway, and things are pretty messed up in this area
already. We have mmiowb. Some architectures do a bit of mmio vs
lock synchronization. Eg. powerpc. But it doesn't do barriers on
some other locks like bit spinlocks or mutexes or rwsems or
semaphores blah blah.

When this came up I grepped a couple of drivers and found possible
problems straight away.

So IMO, we need to take all these out of lock primitives and just
increase awareness of it. Get rid of mmiowb. wmb() should be enough
to keep mmio stores inside the store to drop any lock (by definition).

Actually I think having an io_acquire_barrier() / io_release_barrier()
for the purpose of keeping ios inside locks is a good idea (paired
inside the actual lock/unlock functions). This basically gives them
a self-documenting property.


> >   - a read access is not guaranteed to be performed until the read value
> >     is actually consumed by the processor
> 
> How do you define 'consumed'?  It's not obvious: see
> read_barrier_depends() on Alpha, and elsewhere speculative read
> optimisations (including by the compiler on IA64, in theory).
> 
> > Along with barriers along the line of (that's where we may want to
> > discuss a bit I believe)
> > 
> >   - io_to_mem_rbarrier() : orders MMIO read vs. subsequent memory read
> >   - mem_to_io_wbarrier() : order memory write vs. subsequent MMIO write
> >                            (includes spin_unlock ?)
> >   - io_to_mem_barrier()  : order any MMIO s. subsequent memory accesses
> >   - mem_to_io_barrier()  : order memory accesses vs any subsequent MMIO
> >   - flush_io_read(val)   : takes value from MMIO read, enforce it's
> >                            before completed further instructions are
> >                            issued, acts as compiler&execution barrier. 
> > 
> > What do you guys think ? I think io_to_mem_rbarrier() and
> > mem_to_io_wbarrier() cover most useful cases, except maybe the IO vs.
> > locks.
> 
> I'm thinking the current scheme with "heavy" barriers that serialise
> everything is better - because it's simple to understand.  I think the
> above set are likely to be accidentally misused, and even pass review
> occasionally when they are wrong, even if it's just due to brain farts.
> 
> The "heavy" barrier names could change from rmb/mb/wmb to
> io_rmb/io_mb/io_wmb or something.
> 
> Is there any real performance advantage expected from more
> fine-grained MMIO barriers?
> 
> Another approach is a flags argument to a single macro:
> barrier(BARRIER_MMIO_READ_BEFORE | BARRIER_MEM_READ_AFTER), etc.

This is just syntax really. Like you I also prefer sticking to simpler
barriers. I would like to see any new barrier introduced on a case by
case basis with before/after numbers and allow discussion on whether it
can be avoided.

So many cases people get the simple barriers wrong...
