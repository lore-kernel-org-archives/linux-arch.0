From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Wed, 03 Jun 2009 20:08:36 +0100
Message-ID: <1244056116.3425.39.camel@pc1117.cambridge.arm.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	 <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
	 <1244045997.21423.303.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <1244045997.21423.303.camel@mulgrave.site>
Sender: linux-embedded-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-06-03 at 12:19 -0400, James Bottomley wrote:
> On Wed, 2009-06-03 at 14:04 +0100, Catalin Marinas wrote:
> > On Tue, 2009-06-02 at 15:22 +0000, James Bottomley wrote:
> > > So what we're looking for is a proposal to discuss the issues
> > > most affecting embedded architectures, or preview any features affecting
> > > the main kernel which embedded architectures might need ... or any other
> > > topics from embedded architectures which might need discussion or
> > > debate.
> > 
> > Some issues that come up on embedded systems (and not only):
> > 
> >       * Multiple coherency domains for devices - the system may have
> >         multiple bus levels, coherency ports, cache levels etc. Some
> >         devices in the system (but not all) may be able to "see" various
> >         cache levels but the DMA API (at least on ARM) cannot handle
> >         this. It may be useful to discuss how other embedded
> >         architectures handle this and come up with a unified solution
> 
> So this is partially what the dma_sync_for_{device|cpu} is supposed to
> be helping with.  By and large, the DMA API tries to hide the
> complexities of coherency domains from the user.  The actual API, as far
> as it goes, seems to do this OK.

Yes, the dma_sync_* API is probably OK. The actual implementation should
become aware of various coherency domains on the same system (it could
hold this information in one of the bus-related structures). Currently,
devices that can access the CPU (inner or outer) cache have drivers
modified to avoid calling the dma_sync_* functions (since other devices
need such functions).

If other embedded architectures face similar issues, it is worth
discussing and maybe come up with a common solution (of course, like
most topics, they could simply be discussed on the mailing lists rather
than at the KS).

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

Russell already commented on this. As an example, I have a platform with
two blocks of RAM - 512MB @ 0x20000000 and 512MB @ 0x70000000 - but only
the higher one allows DMA.

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

I'm referring to kernel<->user coherency issues and yes,
flush_dcache_page() is the function supposed to handle this. It's only
that it isn't always called in the block or VFS layers (for example, to
be able to use ext2 over compact flash using pata I had to add a hack so
that flush_dcache_page is called from mpage_end_io_read).

Some devices like Russell's mmci.c use scatter lists and they have
access to the page structure and perform the flushing. I noticed that
for some block devices you can't easily retrieve the page structure (I
would need to check the code for more precise references). But if the
driver is somehow marked as PIO, the VFS layer could ensure the
coherency.

> >       * Mixed endianness devices in the same system - this may only need
> >         dedicated readl_be/writel_be etc. macros but it could also be
> >         done by having bus-aware readl/writel-like macros
> 
> We have ioreadXbe for this exact case (similar problem on parisc)

OK, probably not worth a new topic. As it was mentioned on
linux-embedded already, it may just need better documention (there is no
reference to ioread* in Documentation/ and most devices seem to use
readl/writel etc.).

> >       * Asymmetric MP:
> >               * Different CPU frequencies
> >               * Different CPU features (e.g. floating point only one
> >                 some CPUs): scheduler awareness, per-CPU hwcap bits (in
> >                 case user space wants to set the affinity) 
> >               * Asymmetric workload balancing for power consumption (may
> >                 be better to load 1 CPU at 60% than 4 at 15%) 
> 
> This actually just works(tm) for me on a voyager system running SMP with
> a mixed 486/586 set of processors ... what's the problem?  The only
> issue I see is that you have to set the capabilities of the boot CPU to
> the intersection of the mixture otherwise setup goes wrong, but
> otherwise it seems to work OK.

You can set the capabilities to the intersection of the CPU features but
that's not the goal. We'll see multiprocessor systems with only one (out
of 2, 4 etc.) of the CPUs having some features (like media processing
instructions). That's the case on embedded where the number of gates is
limited and the battery saving is important but you want to use the
extra features and not limit them. So the code I currently have for such
configuration is to trap the undefined instructions and set the CPU
affinity to the faulty threads (the affinity could be reset after some
time). Could it be done better? I think that's worth discussing.

-- 
Catalin
