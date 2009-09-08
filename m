From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: xfs failure on parisc (and presumably other VI cache systems)
	caused by I/O to vmalloc/vmap areas
Date: Tue, 8 Sep 2009 22:39:10 +0100
Message-ID: <20090908213910.GH6538@flint.arm.linux.org.uk>
References: <1252434469.13003.3.camel@mulgrave.site> <20090908190031.GF6538@flint.arm.linux.org.uk> <1252437112.13003.39.camel@mulgrave.site> <20090908201619.GG6538@flint.arm.linux.org.uk> <1252442352.13003.132.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1252442352.13003.132.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 08, 2009 at 08:39:12PM +0000, James Bottomley wrote:
> On Tue, 2009-09-08 at 21:16 +0100, Russell King wrote:
> > On Tue, Sep 08, 2009 at 07:11:52PM +0000, James Bottomley wrote:
> > > The architecturally prescribed fix for this on parisc is to purge the
> > > TLB entry as well.  Without a TLB entry, the CPU is forbidden from doing
> > > speculative reads.  This obviously works only as long as the kernel
> > > never touches the page during DMA, of course ...
> > > 
> > > Isn't this also true for arm?
> > 
> > There appears to be nothing architected along those lines for ARM.
> > From the architectural point of view, any "normal memory" mapping is
> > a candidate for speculative accesses provided access is permitted via
> > the page permissions.
> > 
> > In other words, if the CPU is permitted to access a memory page, it
> > is a candidate for speculative accesses.
> 
> So the parisc architectural feature is simply a statement of fact for VI
> cache architectures: if you don't have a TLB entry for a page, you can't
> do cache operations for it.

That is also true for ARM - you can't perform cache maintainence on a
page without there being a valid page table entry...

> We have a software TLB interrupt and the
> CPU can't interrupt for a speculation, so it's restricted to the
> existing TLB entries in its cache for speculative move ins.

though this is where we differ, since the hardware walks the page tables
and doesn't require any interrupts to do this.

> So now we know what the problem is, if arm can't operate this way,
> what's your suggestion for fixing this ... I take it you have a DMA
> coherence index like we do that flushes the cache on DMA ops?

DMA on ARM continues to be totally non-coherent with the caches.  There
is no hardware help with this.  So, with these speculative accessing
CPUs, we will need to do software cache maintainence both before _and_
after the DMA in the case of DMA from device.

Maintainence before the DMA is required to ensure that the cache
doesn't write out dirty cache lines to the region which is being
DMA'd to.  Maintainence after the DMA is needed to invalidate any
stale data, whether it be pre-existing or speculatively loaded.

What this means is that we need to have the correct virtual address
in the unmap operation to ensure that subsequent CPU reads access
the newly DMA'd data.

The alternative solution I can see is to ensure that subsystems which
do DMA from (eg) vmalloc'd regions are not selectable for ARM.

It's also worth noting that we do have this restriction already in
place across _all_ ARM CPUs for the DMA APIs which take virtual
addresses - we only accept direct mapped kernel addresses via
those APIs since we use virt_to_phys() for L2 cache maintainence.
Walking page tables, especially with high PTE support (ARM has
joined those architectures supporting highmem), sounds to me very
unfunny.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
