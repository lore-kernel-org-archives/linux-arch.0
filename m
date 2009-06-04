From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Thu, 4 Jun 2009 17:29:08 +0100
Message-ID: <200906041729.10513.arnd@arndb.de>
References: <200905282104.55818.arnd@arndb.de> <20090604143803.GD24491@flint.arm.linux.org.uk> <20090604144909.GE24491@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49614 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760117AbZFDQ3V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2009 12:29:21 -0400
In-Reply-To: <20090604144909.GE24491@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 04 June 2009, Russell King wrote:
> The following assumption has been made by the kernel:
> 
> 	maximum_physical_address = dma_mask
> 
> Yes, that's _physical_ address, not bus specific DMA address:

Right, this is an oversimplification that I did not expect the kernel
to make, and it seems to stem from the days before we had the dma
mapping API.
 
> void blk_queue_bounce_limit(struct request_queue *q, u64 dma_mask)
> {
>         unsigned long b_pfn = dma_mask >> PAGE_SHIFT;
> ...
>         q->bounce_pfn = b_pfn;
> }
> 
> static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>                                              struct bio *bio)
> {
> ...
>                         high = page_to_pfn(bv->bv_page) > q->bounce_pfn;
> }
> 
> It's not "is this page DMA-able according to the DMA mask" it's effectively
> "is this page's physical address greater than the maximum physical address
> that can be DMA'd from".
> 
> As I've already pointed out, there are ARM platforms where this is just
> a total nonsense.

Agreed. I still think that a per-device limit combined with the set of
per-bus remapping rules should handle all cases right, but the block
bounce buffer handling seems to prevent that. Looking at
scsi_cacluclate_bounce_limit:

u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
{
	struct device *host_dev;
	u64 bounce_limit = 0xffffffff;

	if (shost->unchecked_isa_dma)
		return BLK_BOUNCE_ISA;
	/*
	 * Platforms with virtual-DMA translation
	 * hardware have no practical limit.
	 */
	if (!PCI_DMA_BUS_IS_PHYS)
		return BLK_BOUNCE_ANY;

	host_dev = scsi_get_device(shost);
	if (host_dev && host_dev->dma_mask)
		bounce_limit = *host_dev->dma_mask;

	return bounce_limit;
}

This is more or less hardcoding all the common cases
(ISA, PCI with IOMMU, and phys address limit per device),
but not the one you are interested in.

The bounce buffer handling is more or less an older and simpler
way of doing the swiotlb, maybe you can simply unset the
(horribly misnamed) PCI_DMA_BUS_IS_PHYS in order to effectively
disable bounce buffers at the block layer and instead do them
in the dma mapping layer in the form of swiotlb.

Are there similar problems outside of the block layer?
It seems that in networking, device drivers themselves are
always in charge of the allocation, so unlike block drivers,
they can do the right thing on all platforms that have this
problem.

> As I say, what is the DMA mask?  Is it really a limit?

I still don't think this is the right question to ask. The way that
the code is structured, it's very clear that it treats a mask and
a limit the same way. Simply assuming that it's a mask that can contain
zeroes gets you into trouble.

> Is it really supposed to be a mask?

Would it solve any problem if it were a mask? All uses essentially
come down to the point where you allocate memory and decide between
GFP_DMA, GFP_DMA32, GFP_NORMAL or GFP_HIGHMEM. If none of them
fit into the mask, you still lose. Also, a bitmask is not enough
to encode a range, as I mentioned before.

	Arnd <><
