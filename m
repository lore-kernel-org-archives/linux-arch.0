From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2 2/5] parisc: add mm API for DMA to vmalloc/vmap areas
Date: Sun, 03 Jan 2010 08:33:12 +1100
Message-ID: <1262467992.2173.247.camel@pasglop>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-12-23 at 15:22 -0600, James Bottomley wrote:
>  #define flush_kernel_dcache_range(start,size) \
>         flush_kernel_dcache_range_asm((start), (start)+(size));
> +/* vmap range flushes and invalidates.  Architecturally, we don't need
> + * the invalidate, because the CPU should refuse to speculate once an
> + * area has been flushed, so invalidate is left empty */
> +static inline void flush_kernel_vmap_range(void *vaddr, int size)
> +{
> +       unsigned long start = (unsigned long)vaddr;
> +
> +       flush_kernel_dcache_range_asm(start, start + size);
> +}
> +static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> +{
> +}

Do I understand correctly that for an inbound DMA you will first call
flush before starting the DMA, then invalidate at the end of the
transfer ?

See my other message on that subject but I believe this is a sub-optimal
semantic. I'd rather expose separately dma_vmap_sync_outbound vs.
dma_vma_sync_inboud_before vs. dma_vma_sync_inboud_after.

On quite a few archs, an invalidate is a lot faster than a flush (since
it doesn't require a writeback of potentially useless crap to memory)
and for an inbound transfer that doesn't cross cache line boundaries,
invalidate is all that's needed for both before and after. On 44x
additionally I don't need "after" since the core is too dumb to prefetch
(or rather it's disabled due to erratas).

Cheers,
Ben.


