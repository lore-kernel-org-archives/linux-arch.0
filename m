From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 21/22] arm64: replace ZONE_DMA with ZONE_DMA32
Date: Wed, 10 Jan 2018 16:55:46 +0100
Message-ID: <20180110155546.GB18903@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
	<20180110080932.14157-22-hch@lst.de>
	<0371cef8-d980-96da-9cb5-3609c39be18a@arm.com>
	<20180110155517.GA18774@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180110155517.GA18774-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 10, 2018 at 04:55:17PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 12:58:14PM +0000, Robin Murphy wrote:
> > On 10/01/18 08:09, Christoph Hellwig wrote:
> >> arm64 uses ZONE_DMA for allocations below 32-bits.  These days we
> >> name the zone for that ZONE_DMA32, which will allow to use the
> >> dma-direct and generic swiotlb code as-is, so rename it.
> >
> > I do wonder if we could also "upgrade" GFP_DMA to GFP_DMA32 somehow when 
> > !ZONE_DMA - there are almost certainly arm64 drivers out there using a 
> > combination of GFP_DMA and streaming mappings which will no longer get the 
> > guaranteed 32-bit addresses they expect after this. I'm not sure quite how 
> > feasible that is, though :/
> 
> I can't find anything obvious in the tree. The alternative would be
> to keep ZONE_DMA and set ARCH_ZONE_DMA_BITS.
> 
> > That said, I do agree that this is an appropriate change (the legacy of 
> > GFP_DMA is obviously horrible), so, provided we get plenty of time to find 
> > and fix the fallout when it lands:
> >
> > Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> I was hoping to get this into 4.15.  What would be proper time to
> fix the fallout?

Err, 4.16 of course.
