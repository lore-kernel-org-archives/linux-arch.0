From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: SMP barriers semantics
Date: Fri, 23 Apr 2010 17:23:50 +0100
Message-ID: <1272039830.15107.76.camel@e102109-lin.cambridge.arm.com>
References: <20100406142054.GE5288@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42278 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755375Ab0DWQ2I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2010 12:28:08 -0400
In-Reply-To: <20100406142054.GE5288@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Tue, 2010-04-06 at 15:20 +0100, Nick Piggin wrote:
> On Tue, Mar 23, 2010 at 10:24:07AM +0000, Catalin Marinas wrote:
> > On Mon, 2010-03-22 at 12:02 +0000, Nick Piggin wrote:
> > > So IMO, we need to take all these out of lock primitives and just
> > > increase awareness of it. Get rid of mmiowb. wmb() should be enough
> > > to keep mmio stores inside the store to drop any lock (by definition).
> >
> > I think we have different scenarios for wmb and mmiowb (my
> > understanding). One is when the driver writes to a coherent DMA buffer
> > (usually uncached) and it than need to drain the write buffer before
> > informing the device to start the transfer. That's where wmb() would be
> > used (with normal uncached memory).
> >
> > The mmiowb() may need to go beyond the CPU write-buffer level into the
> > PCI bus etc. but only for relative ordering of the I/O accesses. The
> > memory-barriers.txt suggests that mmiowb(). My understanding is that
> > mmiowb() drains any mmio buffers while wmb() drains normal memory
> > buffers.
> 
> No barriers are defined to drain anything, only order. wmb() is defined
> to order all memory stores, so all previous stores cached and IO are
> seen before all subsequent stores. And considering that we are talking
> about IO, "seen" obviously means seen by the device as well as other
> CPUs.

Indeed, the barriers aren't defined to drain anything, though they may
do it on specific implementations (or when "seen" actually requires
draining).

The Documentation/DMA-API.txt file mentions that the CPU write buffer
may need to be flushed after writing coherent memory but the kernel
doesn't define any primitive for doing this. Hence my assumption that
this is the job of wmb().

> What is needed is to make the default accessors strongly ordered and
> so driver writers can be really dumb about it, and IO / spinlock etc
> synchronization "just works".

On ARM, the I/O accessors are ordered with respect to device memory
accesses but not with respect to normal non-cacheable memory
(dma_alloc_coherent). If we want to make the writel etc. accessors
ordered with respect to the normal non-cacheable memory, that would be
really expensive on several ARM platforms. Apart from the CPU barrier (a
full one - DSB - to drain the write buffer), some platforms require
draining the write buffer of the L2 cache as well (by writing to other
registers to the L2 cache controller).

So I'm more in favour of having stronger semantics for wmb() and leaving
the I/O accessors semantics to only ensure device memory ordering.

-- 
Catalin
