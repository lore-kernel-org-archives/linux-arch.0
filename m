From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH -mm 1/2] scsi: remove dma_is_consistent usage in 53c700
Date: Tue, 29 Jun 2010 06:27:06 +0900
Message-ID: <20100628212706.GB301@linux-sh.org>
References: <1277633423-5700-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1277651328.4366.7.camel@mulgrave.site> <20100628123503Z.fujita.tomonori@lab.ntt.co.jp> <1277736958.10879.43.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1277736958.10879.43.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, akpm@linux-foundation.org, grundler@parisc-linux.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 28, 2010 at 09:55:58AM -0500, James Bottomley wrote:
> On Mon, 2010-06-28 at 12:37 +0900, FUJITA Tomonori wrote:
> > Seems that on some architectures (arm and mips at least),
> > dma_get_cache_alignment() could greater than L1_CACHE_BYTES. But they
> > simply return the possible maximum size of cache size like:
> > 
> > static inline int dma_get_cache_alignment(void)
> > {
> > 	/* XXX Largest on any MIPS */
> > 	return 128;
> > }
> > 
> > So practically, we should be safe. I guess that we can simply convert
> > them to return L1_CACHE_BYTES.
> 
> As long as that's architecturally true, yes.   I mean I can't imagine
> any architecture that had a dma alignment requirement that was greater
> than its L1 cache width ... but I've been surprised be for making
> "Obviously this can't happen ..." type statements where MIPS is
> concerned.
> 
> > Some PARISC and mips are only the fully non-coherent architectures
> > that we support now?
> 
> I think there might be some ARM SoC systems as well ... there were some
> strange ones that had tight limits on the addresses the other SoC
> components could DMA to which made it very difficult to make consistent
> areas.
> 
We had similar cases on SH where even though we can generally provide
consistent memory, it may not be visible or usable by certain
peripherals. On some of the earlier CPUs when the on-chip bus was being
overhauled there was an on-chip DMAC and a PCI DMAC on different
interconnects with their own addressing limitations. PCI DMA needed
buffers to be allocated from PCI space and would simply generate address
errors for anything on any of the other interconnects. On those systems
we could provide consistent memory for other PCI devices if and only if
we happened to have a PCI video card or something else with spare device
memory on the bus inserted -- which in turn would not be visible on any
other interconnects. In those cases it worked out that the DMA alignment
for PCI memory and L1 line size were the same, but that was really more
by coincidence than design.

There are still similar cases remaining. Most SH CPUs have a snoop
controller for snooping PCI <-> external memory transactions, but most
CPUs do not enable it on account of not being able to have the CPU enter
idle states while the controller is active. It's only been with the SMP
parts that a generic snoop controller has been provided that has general
L1 visibility.

> >  We can remove the above checking if
> > dma_get_cache_alignment() is <= L1_CACHE_BYTES on PARISC and mips?
> 
> I don't think we need to check, just document that
> dma_get_cache_alignment cannot be greater than the L1 cache stride.
> 
Looking at the MIPS stuff, it also seems like there are cases where
L1_CACHE_BYTES == 32 while the kmalloc minalign value is bumped to 128
for certain CPU configurations, and kept at 32 for others. Those sorts of
values look a lot more like the L2 cache stride than the L1, perhaps
something to do with the snoop controller on exotic ccNUMA
configurations?
