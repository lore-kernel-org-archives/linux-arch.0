From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: SMP barriers semantics
Date: Fri, 23 Apr 2010 18:25:00 +0100
Message-ID: <1272043500.15107.87.camel@e102109-lin.cambridge.arm.com>
References: <20100406142054.GE5288@laptop>
	 <1272039830.15107.76.camel@e102109-lin.cambridge.arm.com>
	 <20100423165628.GA15349@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50661 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755081Ab0DWR3G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2010 13:29:06 -0400
In-Reply-To: <20100423165628.GA15349@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Nick Piggin <npiggin@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Fri, 2010-04-23 at 17:56 +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > On ARM, the I/O accessors are ordered with respect to device memory
> > accesses but not with respect to normal non-cacheable memory
> > (dma_alloc_coherent). If we want to make the writel etc. accessors
> > ordered with respect to the normal non-cacheable memory, that would be
> > really expensive on several ARM platforms. Apart from the CPU barrier (a
> > full one - DSB - to drain the write buffer), some platforms require
> > draining the write buffer of the L2 cache as well (by writing to other
> > registers to the L2 cache controller).
> 
> It is useful to call it non-cacheable memory if the only way to make
> it device-visible is an instruction to the L2 cache controller asking
> it to flush? :-)

It's not the cache itself but only its write buffer. Ideally, the DSB
should get through to the L2 cache as well there are platforms that
don't do this.

> On at least one ARM-compatible core I know of, you can disable write
> buffering for a region, independent of caching.  Is it possible in
> general, to make dma_alloc_coherent on ARM return unbuffered uncached memory?

On recent ARM cores, it's only the Strongly Ordered memory that can have
the write buffering disabled. But using such mapping for
dma_alloc_coherent() introduces other problems like cache attribute
aliases for a physical location (since the kernel maps the RAM as Normal
memory already). Such aliases are not allowed hence we moved to Normal
Non-cacheable for dma_alloc_coherent().

> > So I'm more in favour of having stronger semantics for wmb() and leaving
> > the I/O accessors semantics to only ensure device memory ordering.
> 
> From the above, I'm thinking the semantics for wmb() should include:
> 
>    - Flushes any buffered writes to memory which is mapped uncached,
>      but does not have to flush buffered writes to cached memory.

Yes.

> So if the arch always mapped uncached memory also unbuffered, wmb()
> won't have to flush the CPU write buffer, which can be expensive as you say.
> 
> You probably already planned on this, but it's good to make
> it explicit in any docs - if that's an agreeable semantic.

The patches for the ARM platform to make wmb() drain the write buffers
(DSB + L2 cache sync) are already in mainline. That was the only way to
allow drivers using dma_alloc_coherent() to work correctly.

-- 
Catalin
