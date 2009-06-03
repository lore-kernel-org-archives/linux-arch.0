From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Wed, 3 Jun 2009 18:09:25 +0100
Message-ID: <20090603170925.GA8330@flint.arm.linux.org.uk>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <1244034286.24482.84.camel@pc1117.cambridge.arm.com> <1244045997.21423.303.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39593 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbZFCRKT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2009 13:10:19 -0400
Content-Disposition: inline
In-Reply-To: <1244045997.21423.303.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Wed, Jun 03, 2009 at 12:19:57PM -0400, James Bottomley wrote:
> On Wed, 2009-06-03 at 14:04 +0100, Catalin Marinas wrote:
> >       * Better support for coherent DMA mask - currently ZONE_DMA is
> >         assumed to be in the bottom part of the memory which isn't
> >         always the case. Enabling NUMA may help but it is overkill for
> >         some systems. As above, a more unified solution across
> >         architectures would help
> 
> So ZONE_DMA and coherent memory allocation as represented by the
> coherent mask are really totally separate things.  The idea of ZONE_DMA
> was really that if you had an ISA device, allocations from ZONE_DMA
> would be able to access the allocated memory without bouncing.  Since
> ISA is really going away, this definition has been hijacked.  If your
> problem is just that you need memory allocated on a certain physical
> mask and neither GFP_DMA or GFP_DMA32 cut it for you, then we could
> revisit the kmalloc_mask() proposal again ... but the consensus last
> time was that no-one really had a compelling use case that couldn't be
> covered by GFP_DMA32.

I'm not aware of such a discussion; I keep running into issues here.  In
fact, on ARM the DMA mask is exactly that - it's a 100% proper mask.  It's
not a bunch of zeros in the MSB followed by a bunch of ones down to the
LSB.  It can be a bunch of ones, a bunch of zeros, followed by a bunch of
ones.

The way we occasionally have to deal with this is to trial an allocation,
see if the physical address fits, if not free the page and try again with
GFP_DMA set.

We do certain checks on the DMA mask - notably that a GFP_DMA allocation
will satisfy the mask which has been passed.

I've never submitted the patch which does this in the ARM coherent DMA
allocator, but it's something that occasionally crops up as being
necessary - I've always thought the allocate-by-mask stuff would
eventually be merged.

> >       * PIO block devices and non-coherent hardware - code like mpage.c
> >         assumes that the either the hardware is coherent or the device
> >         driver performs the cache flushing. The latter is true for
> >         DMA-capable device but not for PIO. The issue becomes visible
> >         with write-allocate caches and the device driver may not have
> >         the struct page information to call flush_dcache_page(). A
> >         proposed solution on the ARM lists was to differentiate (via
> >         some flags) between PIO and DMA block devices and use this
> >         information in mpage.c
> 
> flush_dcache_page() is supposed to be for making the data visible to the
> user ... that coherency is supposed to be managed by the block layer.
> The DMA API is specifically aimed at device to kernel space
> coherency ... although if you line up all your aliases, that can also be
> device to userspace.  Technically though we have two separate APIs for
> user<->kernel coherency and device<->kernel coherency.  What's the path
> you're seeing this problem down?  SG_IO to a device doing PIO should be
> handling this correctly.

There's many stories I've heard on what is supposed to take care of the
coherency that I now just close my ears to the problem and chant "it
doesn't exist, people aren't seeing it, mainline folk just don't give
a damn".  Really.  It is a problem on _some_ ARM devices and has been
for several years now, and I've 100% given up caring about it.

So people who see the problem just have to suffer with it, and they have
to accept that the Linux kernel sucks with PIO on ARM hardware.

Unless they use a driver I've written which has the necessary callbacks
in it to ensure cache coherency (like MMC).  IDE... forget it.

Yes, that taste you're experiencing is my bitterness on this subject.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
