From: Nick Piggin <npiggin@suse.de>
Subject: Re: SMP barriers semantics
Date: Wed, 7 Apr 2010 00:20:54 +1000
Message-ID: <20100406142054.GE5288@laptop>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
 <20100303005529.GA3879@brick.ozlabs.ibm.com>
 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
 <20100312123105.GB4400@linux-mips.org>
 <1268792716.2335.170.camel@pasglop>
 <20100317134243.GA15235@shareable.org>
 <20100322120203.GL17637@laptop>
 <1269339847.29545.42.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48215 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab0DFOVD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 Apr 2010 10:21:03 -0400
Content-Disposition: inline
In-Reply-To: <1269339847.29545.42.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jamie Lokier <jamie@shareable.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Tue, Mar 23, 2010 at 10:24:07AM +0000, Catalin Marinas wrote:
> On Mon, 2010-03-22 at 12:02 +0000, Nick Piggin wrote:
> > On Wed, Mar 17, 2010 at 01:42:43PM +0000, Jamie Lokier wrote:
> > > Benjamin Herrenschmidt wrote:
> > > > Maybe we can agree on a set of relaxed accessors defined specifically
> > > > with those semantics (more relaxed implies use of raw_*) :
> > > >
> > > >   - order is guaranteed between MMIOs
> > > >   - no order is guaranteed between MMIOs and spinlocks
> > >
> > > No order between MMIOs and spinlocks will be fun :-)
> > 
> > There isn't anyway, and things are pretty messed up in this area
> > already. We have mmiowb. Some architectures do a bit of mmio vs
> > lock synchronization. Eg. powerpc. But it doesn't do barriers on
> > some other locks like bit spinlocks or mutexes or rwsems or
> > semaphores blah blah.
> > 
> > When this came up I grepped a couple of drivers and found possible
> > problems straight away.
> > 
> > So IMO, we need to take all these out of lock primitives and just
> > increase awareness of it. Get rid of mmiowb. wmb() should be enough
> > to keep mmio stores inside the store to drop any lock (by definition).
> 
> I think we have different scenarios for wmb and mmiowb (my
> understanding). One is when the driver writes to a coherent DMA buffer
> (usually uncached) and it than need to drain the write buffer before
> informing the device to start the transfer. That's where wmb() would be
> used (with normal uncached memory).
> 
> The mmiowb() may need to go beyond the CPU write-buffer level into the
> PCI bus etc. but only for relative ordering of the I/O accesses. The
> memory-barriers.txt suggests that mmiowb(). My understanding is that
> mmiowb() drains any mmio buffers while wmb() drains normal memory
> buffers.

No barriers are defined to drain anything, only order. wmb() is defined
to order all memory stores, so all previous stores cached and IO are
seen before all subsequent stores. And considering that we are talking
about IO, "seen" obviously means seen by the device as well as other
CPUs.

mmiowb was introduced because this was too heavy on some platforms
(specifically ia64-sn2). And basically they weakened wmb() semantics
and introduced this heavier operation to solve the problem of ordering
IO from different CPUs.

Problem with that is that you can't just redefine an existing age old
API to be weaker. And also because semantics of wmb() get much more
complex (look at the mmiowb calls added by non-SGI people and most are
wrong). And also, code that is tested and works on most common platforms
does not work on others.

What is needed is to make the default accessors strongly ordered and
so driver writers can be really dumb about it, and IO / spinlock etc
synchronization "just works".

So as I said, it's much easier for the smart powerpc programmer to spot
the suboptimal sequence of a few mmio accesses and relax them than it is
for the dumb device driver writer to debug strange reports that aren't
reproduceable on their x86.

(I don't call driver writers dumb but the easier the driver APIs are to
use the better)
 

> > Actually I think having an io_acquire_barrier() / io_release_barrier()
> > for the purpose of keeping ios inside locks is a good idea (paired
> > inside the actual lock/unlock functions). This basically gives them
> > a self-documenting property.
> 
> Is there any architecture where mmio accesses are speculated? Do we need
> an io_acquire_barrier()? At least on ARM, device memory access is not
> restartable by definition, which means that it cannot in general be
> speculated. If that's true for other architectures as well, we wouldn't
> need anything more than mmiowb() (but I may be wrong here).

I would like acquire because it looks nice -- may help with reading 
the code, and we might be able to hook debug checks into them.

But hmm, I don't know if we even need acquire/release IO barriers at
all. Might be better to just fix up wmb(), get rid of mmiowb(),
strengthen IO accessors, and then just add special case barriers as
the need arises.
