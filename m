From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Mon, 05 Mar 2012 17:07:02 +0100
Message-ID: <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
	<1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
	<20120305134721.0ab0d0e6de56fa30250059b1@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20120305134721.0ab0d0e6de56fa30250059b1-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-language: pl
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Hiroshi Doyu' <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Shariq Hasnain' <shariq.hasnain-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>, 'Benjamin Herrenschmidt' <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, 'Chunsang Jeong' <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Krishna Reddy' <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Kyungmin Park' <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'KyongHo Cho' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hello,

On Monday, March 05, 2012 12:47 PM Hiroshi Doyu wrote:

> On Wed, 29 Feb 2012 16:04:22 +0100
> Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > This patch add a complete implementation of DMA-mapping API for
> > devices that have IOMMU support. All DMA-mapping calls are supported.
> >
> > This patch contains some of the code kindly provided by Krishna Reddy
> > <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> and Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > ---

(snipped)

> > +/**
> > + * arm_iommu_create_mapping
> > + * @bus: pointer to the bus holding the client device (for IOMMU calls)
> > + * @base: start address of the valid IO address space
> > + * @size: size of the valid IO address space
> > + * @order: accuracy of the IO addresses allocations
> > + *
> > + * Creates a mapping structure which holds information about used/unused
> > + * IO address ranges, which is required to perform memory allocation and
> > + * mapping with IOMMU aware functions.
> > + *
> > + * The client device need to be attached to the mapping with
> > + * arm_iommu_attach_device function.
> > + */
> > +struct dma_iommu_mapping *
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > +                        int order)
> > +{
> > +       unsigned int count = (size >> PAGE_SHIFT) - order;
> > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> > +       struct dma_iommu_mapping *mapping;
> > +       int err = -ENOMEM;
> > +
> > +       mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
> > +       if (!mapping)
> > +               goto err;
> > +
> > +       mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > +       if (!mapping->bitmap)
> > +               goto err2;
> > +
> > +       mapping->base = base;
> > +       mapping->bits = bitmap_size;
> 
> Shouldn't the above be as below?
> 
> From 093c77ac6f19899679f2f2447a9d2c684eab7b2e Mon Sep 17 00:00:00 2001
> From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date: Mon, 5 Mar 2012 13:04:38 +0200
> Subject: [PATCH 1/1] dma-mapping: Fix mapping->bits size
> 
> Amount of bits should be mutiplied by BITS_PER_BITE.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mm/dma-mapping.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index e55f425..5ec7747 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1495,7 +1495,7 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t
> size,
>  		goto err2;
> 
>  	mapping->base = base;
> -	mapping->bits = bitmap_size;
> +	mapping->bits = BITS_PER_BYTE * bitmap_size;
>  	mapping->order = order;
>  	spin_lock_init(&mapping->lock);

You are right, thanks for spotting this issue!

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
