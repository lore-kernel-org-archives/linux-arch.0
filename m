From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
Date: Wed, 03 Jun 2009 12:19:57 -0400
Message-ID: <1244045997.21423.303.camel@mulgrave.site>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	 <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37339 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755456AbZFCQT7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2009 12:19:59 -0400
In-Reply-To: <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Wed, 2009-06-03 at 14:04 +0100, Catalin Marinas wrote:
> Hi,
> 
> On Tue, 2009-06-02 at 15:22 +0000, James Bottomley wrote:
> > So what we're looking for is a proposal to discuss the issues
> > most affecting embedded architectures, or preview any features affecting
> > the main kernel which embedded architectures might need ... or any other
> > topics from embedded architectures which might need discussion or
> > debate.
> 
> Some issues that come up on embedded systems (and not only):
> 
>       * Multiple coherency domains for devices - the system may have
>         multiple bus levels, coherency ports, cache levels etc. Some
>         devices in the system (but not all) may be able to "see" various
>         cache levels but the DMA API (at least on ARM) cannot handle
>         this. It may be useful to discuss how other embedded
>         architectures handle this and come up with a unified solution

So this is partially what the dma_sync_for_{device|cpu} is supposed to
be helping with.  By and large, the DMA API tries to hide the
complexities of coherency domains from the user.  The actual API, as far
as it goes, seems to do this OK.  We have synchronisation issues that
mmiowb() and friends help with ... what's the actual problem here?

>       * Better support for coherent DMA mask - currently ZONE_DMA is
>         assumed to be in the bottom part of the memory which isn't
>         always the case. Enabling NUMA may help but it is overkill for
>         some systems. As above, a more unified solution across
>         architectures would help

So ZONE_DMA and coherent memory allocation as represented by the
coherent mask are really totally separate things.  The idea of ZONE_DMA
was really that if you had an ISA device, allocations from ZONE_DMA
would be able to access the allocated memory without bouncing.  Since
ISA is really going away, this definition has been hijacked.  If your
problem is just that you need memory allocated on a certain physical
mask and neither GFP_DMA or GFP_DMA32 cut it for you, then we could
revisit the kmalloc_mask() proposal again ... but the consensus last
time was that no-one really had a compelling use case that couldn't be
covered by GFP_DMA32.

>       * PIO block devices and non-coherent hardware - code like mpage.c
>         assumes that the either the hardware is coherent or the device
>         driver performs the cache flushing. The latter is true for
>         DMA-capable device but not for PIO. The issue becomes visible
>         with write-allocate caches and the device driver may not have
>         the struct page information to call flush_dcache_page(). A
>         proposed solution on the ARM lists was to differentiate (via
>         some flags) between PIO and DMA block devices and use this
>         information in mpage.c

flush_dcache_page() is supposed to be for making the data visible to the
user ... that coherency is supposed to be managed by the block layer.
The DMA API is specifically aimed at device to kernel space
coherency ... although if you line up all your aliases, that can also be
device to userspace.  Technically though we have two separate APIs for
user<->kernel coherency and device<->kernel coherency.  What's the path
you're seeing this problem down?  SG_IO to a device doing PIO should be
handling this correctly.

>       * Mixed endianness devices in the same system - this may only need
>         dedicated readl_be/writel_be etc. macros but it could also be
>         done by having bus-aware readl/writel-like macros

We have ioreadXbe for this exact case (similar problem on parisc)

>       * Asymmetric MP:
>               * Different CPU frequencies
>               * Different CPU features (e.g. floating point only one
>                 some CPUs): scheduler awareness, per-CPU hwcap bits (in
>                 case user space wants to set the affinity) 
>               * Asymmetric workload balancing for power consumption (may
>                 be better to load 1 CPU at 60% than 4 at 15%) 

This actually just works(tm) for me on a voyager system running SMP with
a mixed 486/586 set of processors ... what's the problem?  The only
issue I see is that you have to set the capabilities of the boot CPU to
the intersection of the mixture otherwise setup goes wrong, but
otherwise it seems to work OK.

James
