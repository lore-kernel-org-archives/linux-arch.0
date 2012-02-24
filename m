From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCHv6 7/7] ARM: dma-mapping: add support for IOMMU mapper
Date: Fri, 24 Feb 2012 10:35:55 +0100
Message-ID: <00f301ccf2d7$b5b68570$21239050$%szyprowski@samsung.com>
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
	<1328900324-20946-8-git-send-email-m.szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E378E42AE18@HQMAIL04.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <401E54CE964CD94BAE1EB4A729C7087E378E42AE18-wAPRp6hVlRhDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
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
To: 'Krishna Reddy' <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: 'Shariq Hasnain' <shariq.hasnain-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>, 'Benjamin Herrenschmidt' <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, 'Kyungmin Park' <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, 'KyongHo Cho' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Chunsang Jeong' <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hello,

On Monday, February 13, 2012 8:59 PM Krishna Reddy wrote:

> The implementation looks nice overall. Have few comments.
> 
> > +static struct page **__iommu_alloc_buffer(struct device *dev, size_t
> > +size, gfp_t gfp) {
> > +     struct page **pages;
> > +     int count = size >> PAGE_SHIFT;
> > +     int i=0;
> > +
> > +     pages = kzalloc(count * sizeof(struct page*), gfp);
> > +     if (!pages)
> > +             return NULL;
> 
> kzalloc can fail for any size bigger than PAGE_SIZE, if the system memory is
> fully fragmented.
> If there is a request for size bigger than 4MB, then the pages pointer array won't
> Fit in one page and kzalloc may fail. we should use vzalloc()/vfree()
> when pages pointer array size needed is bigger than PAGE_SIZE.

Right, thanks for spotting this. I will fix this in the next version.

> > +static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping
> > *mapping,
> > +                                   size_t size)
> > +{
> > +     unsigned int order = get_order(size);
> > +     unsigned int align = 0;
> > +     unsigned int count, start;
> > +     unsigned long flags;
> > +
> > +     count = ((PAGE_ALIGN(size) >> PAGE_SHIFT) +
> > +              (1 << mapping->order) - 1) >> mapping->order;
> > +
> > +     if (order > mapping->order)
> > +             align = (1 << (order - mapping->order)) - 1;
> > +
> > +     spin_lock_irqsave(&mapping->lock, flags);
> > +     start = bitmap_find_next_zero_area(mapping->bitmap, mapping-
> > >bits, 0,
> > +                                        count, align);
> 
> Do we need "align" here? Why is it trying to align the memory request to
> size of memory requested? When mapping->order is zero and if the size
> requested is 4MB, order becomes 10.  align is set to 1023.
>  bitmap_find_next_zero_area looks searching for free area from index, which
> is multiple of 1024. Why we can't we say align mask  as 0 and let it allocate from
> next free index? Doesn't mapping->order take care of min alignment needed for dev?

Aligning IO address to the nearest power of 2 of the buffer size matches the behavior 
of the other kernel allocators. alloc_pages does exactly the same thing - the physical 
addresses are aligned to the power of 2. Some driver also depend on this feature and 
allocate arbitrary buffer sizes to get memory aligned to certain values. This is 
considered as a feature not a side effect of the internal buddy allocator 
implementation.

Keeping IO addresses aligned also enables use of pages larger than 4KiB for the IOMMU
mappings if the physical memory got allocated in larger chunk (one can use 64KiB 
mappings only if IO address and physical memory address are 64KiB aligned).

> > +static dma_addr_t __iommu_create_mapping(struct device *dev, struct
> > +page **pages, size_t size) {
> > +     struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> > +     unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > +     dma_addr_t dma_addr, iova;
> > +     int i, ret = ~0;
> > +
> > +     dma_addr = __alloc_iova(mapping, size);
> > +     if (dma_addr == ~0)
> > +             goto fail;
> > +
> > +     iova = dma_addr;
> > +     for (i=0; i<count; ) {
> > +             unsigned int phys = page_to_phys(pages[i]);
> > +             int j = i + 1;
> > +
> > +             while (j < count) {
> > +                     if (page_to_phys(pages[j]) != phys + (j - i) *
> > PAGE_SIZE)
> > +                             break;
> > +                     j++;
> > +             }
> > +
> > +             ret = iommu_map(mapping->domain, iova, phys, (j - i) *
> > PAGE_SIZE, 0);
> > +             if (ret < 0)
> > +                     goto fail;
> > +             iova += (j - i) * PAGE_SIZE;
> > +             i = j;
> > +     }
> > +
> > +     return dma_addr;
> > +fail:
> > +     return ~0;
> > +}
> 
> iommu_map failure should release the iova space allocated using __alloc_iova.

Right, thanks for spotting the bug.

> 
> > +static dma_addr_t arm_iommu_map_page(struct device *dev, struct page
> > *page,
> > +          unsigned long offset, size_t size, enum dma_data_direction dir,
> > +          struct dma_attrs *attrs)
> > +{
> > +     struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> > +     dma_addr_t dma_addr, iova;
> > +     unsigned int phys;
> > +     int ret, len = PAGE_ALIGN(size + offset);
> > +
> > +     if (!arch_is_coherent())
> > +             __dma_page_cpu_to_dev(page, offset, size, dir);
> > +
> > +     dma_addr = iova = __alloc_iova(mapping, len);
> > +     if (iova == ~0)
> > +             goto fail;
> > +
> > +     dma_addr += offset;
> > +     phys = page_to_phys(page);
> > +     ret = iommu_map(mapping->domain, iova, phys, size, 0);
> > +     if (ret < 0)
> > +             goto fail;
> > +
> > +     return dma_addr;
> > +fail:
> > +     return ~0;
> > +}
> 
> iommu_map failure should release the iova space allocated using __alloc_iova.
 
Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
