From: Jamie Lokier <jamie@shareable.org>
Subject: Re: SMP barriers semantics
Date: Fri, 23 Apr 2010 17:56:28 +0100
Message-ID: <20100423165628.GA15349@shareable.org>
References: <20100406142054.GE5288@laptop> <1272039830.15107.76.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:33468 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab0DWQ4z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2010 12:56:55 -0400
Content-Disposition: inline
In-Reply-To: <1272039830.15107.76.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nick Piggin <npiggin@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

Catalin Marinas wrote:
> On ARM, the I/O accessors are ordered with respect to device memory
> accesses but not with respect to normal non-cacheable memory
> (dma_alloc_coherent). If we want to make the writel etc. accessors
> ordered with respect to the normal non-cacheable memory, that would be
> really expensive on several ARM platforms. Apart from the CPU barrier (a
> full one - DSB - to drain the write buffer), some platforms require
> draining the write buffer of the L2 cache as well (by writing to other
> registers to the L2 cache controller).

It is useful to call it non-cacheable memory if the only way to make
it device-visible is an instruction to the L2 cache controller asking
it to flush? :-)

On at least one ARM-compatible core I know of, you can disable write
buffering for a region, independent of caching.  Is it possible in
general, to make dma_alloc_coherent on ARM return unbuffered uncached memory?

> So I'm more in favour of having stronger semantics for wmb() and leaving
> the I/O accessors semantics to only ensure device memory ordering.

From the above, I'm thinking the semantics for wmb() should include:

   - Flushes any buffered writes to memory which is mapped uncached,
     but does not have to flush buffered writes to cached memory.

So if the arch always mapped uncached memory also unbuffered, wmb()
won't have to flush the CPU write buffer, which can be expensive as you say.

You probably already planned on this, but it's good to make
it explicit in any docs - if that's an agreeable semantic.

-- Jamie
