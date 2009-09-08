From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: xfs failure on parisc (and presumably other VI cache systems)
	caused by I/O to vmalloc/vmap areas
Date: Tue, 8 Sep 2009 20:00:31 +0100
Message-ID: <20090908190031.GF6538@flint.arm.linux.org.uk>
References: <1252434469.13003.3.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1252434469.13003.3.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 08, 2009 at 01:27:49PM -0500, James Bottomley wrote:
> This bug was observed on parisc, but I would expect it to affect all
> architectures with virtually indexed caches.

I don't think your proposed solution will work for ARM with speculative
prefetching (iow, the latest ARM CPUs.)  If there is a mapping present,
it can be speculatively prefetched from at any time - the CPU designers
have placed no bounds on the amount of speculative prefetching which
may be present in a design.

What this means that for DMA, we will need to handle cache coherency
issues both before and after DMA.

If we're going to allow non-direct mapped (offset mapped in your parlence)
block IO, it makes it impossible to handle cache coherency after DMA
completion - although we can translate (via page table walks) from a
virtual address to a physical, and then to a bus address for DMA, going
back the other way is impossible since there could be many right answers.

What has been annoying me for a while about the current DMA API is that
drivers have to carry around all sorts of information for a DMA mapping,
whether the architecture needs it or not - and sometimes that information
is not what the architecture wants.  To this end, I've been thinking that
something more like:

	struct dma_mapping map;

	err = dma2_map_single(&map, buffer, size, direction);
	if (err)
		...

	addr = dma2_addr(&map);
	/* program controller */

	/* completion */
	dma2_unmap_single(&map);

with similar style interfaces for pages and so forth (scatterlists are
already arch-defined.)  Architectures define the contents of
struct dma_mapping - but it must contain at least the dma address.

What's the advantage of this?  It means that if an architecture needs to
handle cache issues after DMA on unmap via a virtual address, it can
ensure that the correct address is passed through all the way to the
unmap function.  This approach also relieves the driver writer from
having to carry around the direction, size and dma address themselves,
which means we don't need the DMA debug infrastructure to check that
drivers are doing these things correctly.

I seriously doubt, though, that we can revise the DMA API...

In your (and my) case, maybe struct scatterlist also needs to contain
the virtual address as well as the struct page, offset and length?


PS, ARM already does not allow anything but direct-mapped RAM addresses
for dma_map_single(), since we need to be able to translate virtual
addresses to physical for non-coherent L2 cache handling - L1 cache
needs handling via the virtual address and L2 via the physical address.


PPS, you're not the only architecture which has problems with XFS.  ARM
has a long standing issue with it too.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
