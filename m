From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCHv2 2/5] parisc: add mm API for DMA to vmalloc/vmap areas
Date: Sat, 02 Jan 2010 15:53:10 -0600
Message-ID: <1262469190.2741.27.camel@mulgrave.site>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
	 <1262467992.2173.247.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47578 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab0ABVxT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jan 2010 16:53:19 -0500
In-Reply-To: <1262467992.2173.247.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>

On Sun, 2010-01-03 at 08:33 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-12-23 at 15:22 -0600, James Bottomley wrote:
> >  #define flush_kernel_dcache_range(start,size) \
> >         flush_kernel_dcache_range_asm((start), (start)+(size));
> > +/* vmap range flushes and invalidates.  Architecturally, we don't need
> > + * the invalidate, because the CPU should refuse to speculate once an
> > + * area has been flushed, so invalidate is left empty */
> > +static inline void flush_kernel_vmap_range(void *vaddr, int size)
> > +{
> > +       unsigned long start = (unsigned long)vaddr;
> > +
> > +       flush_kernel_dcache_range_asm(start, start + size);
> > +}
> > +static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> > +{
> > +}
> 
> Do I understand correctly that for an inbound DMA you will first call
> flush before starting the DMA, then invalidate at the end of the
> transfer ?
> 
> See my other message on that subject but I believe this is a sub-optimal
> semantic. I'd rather expose separately dma_vmap_sync_outbound vs.
> dma_vma_sync_inboud_before vs. dma_vma_sync_inboud_after.

Well, this is such a micro optimisation, is it really worth it?

If I map exactly to architectural operations, it's flush (without
invalidate if possible) before an outbound DMA transfer and nothing
after.  For inbound, it's invalidate before and after (the after only
assuming the architecture can do speculative move in), but doing a flush
first instead of an invalidate on DMA inbound produces a correct result
on architectures I know about.

> On quite a few archs, an invalidate is a lot faster than a flush (since
> it doesn't require a writeback of potentially useless crap to memory)
> and for an inbound transfer that doesn't cross cache line boundaries,
> invalidate is all that's needed for both before and after. On 44x
> additionally I don't need "after" since the core is too dumb to prefetch
> (or rather it's disabled due to erratas).

Your logic assumes the cache line is dirty.  If you look at the XFS
usage, it never seems to do local modifications on a read, so the line
should be clean.  At least on parisc, a flush of a clean cache line is
exactly equivalent to an invalidate.  Even if there's some write into
the read area in xfs I've missed, it's only a few extra cycles because
the lines are mostly clean.

James
