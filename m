From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: SMP barriers semantics
Date: Tue, 23 Mar 2010 10:24:07 +0000
Message-ID: <1269339847.29545.42.camel@e102109-lin.cambridge.arm.com>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
	 <20100303005529.GA3879@brick.ozlabs.ibm.com>
	 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
	 <20100312123105.GB4400@linux-mips.org> <1268792716.2335.170.camel@pasglop>
	 <20100317134243.GA15235@shareable.org>  <20100322120203.GL17637@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:56783 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750826Ab0CWKYb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2010 06:24:31 -0400
In-Reply-To: <20100322120203.GL17637@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Mon, 2010-03-22 at 12:02 +0000, Nick Piggin wrote:
> On Wed, Mar 17, 2010 at 01:42:43PM +0000, Jamie Lokier wrote:
> > Benjamin Herrenschmidt wrote:
> > > Maybe we can agree on a set of relaxed accessors defined specifically
> > > with those semantics (more relaxed implies use of raw_*) :
> > >
> > >   - order is guaranteed between MMIOs
> > >   - no order is guaranteed between MMIOs and spinlocks
> >
> > No order between MMIOs and spinlocks will be fun :-)
> 
> There isn't anyway, and things are pretty messed up in this area
> already. We have mmiowb. Some architectures do a bit of mmio vs
> lock synchronization. Eg. powerpc. But it doesn't do barriers on
> some other locks like bit spinlocks or mutexes or rwsems or
> semaphores blah blah.
> 
> When this came up I grepped a couple of drivers and found possible
> problems straight away.
> 
> So IMO, we need to take all these out of lock primitives and just
> increase awareness of it. Get rid of mmiowb. wmb() should be enough
> to keep mmio stores inside the store to drop any lock (by definition).

I think we have different scenarios for wmb and mmiowb (my
understanding). One is when the driver writes to a coherent DMA buffer
(usually uncached) and it than need to drain the write buffer before
informing the device to start the transfer. That's where wmb() would be
used (with normal uncached memory).

The mmiowb() may need to go beyond the CPU write-buffer level into the
PCI bus etc. but only for relative ordering of the I/O accesses. The
memory-barriers.txt suggests that mmiowb(). My understanding is that
mmiowb() drains any mmio buffers while wmb() drains normal memory
buffers.

> Actually I think having an io_acquire_barrier() / io_release_barrier()
> for the purpose of keeping ios inside locks is a good idea (paired
> inside the actual lock/unlock functions). This basically gives them
> a self-documenting property.

Is there any architecture where mmio accesses are speculated? Do we need
an io_acquire_barrier()? At least on ARM, device memory access is not
restartable by definition, which means that it cannot in general be
speculated. If that's true for other architectures as well, we wouldn't
need anything more than mmiowb() (but I may be wrong here).

Thanks.

-- 
Catalin
