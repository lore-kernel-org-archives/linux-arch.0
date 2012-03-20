From: Subash Patel <subashrp@gmail.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Tue, 20 Mar 2012 19:20:37 +0530
Message-ID: <4F688B2D.20808@gmail.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com> <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com> <CAHQjnOO5DLOj8Fw=ZriSnXg8W3k7y8Dnu--Peqe6JJX0xGMhoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAHQjnOO5DLOj8Fw=ZriSnXg8W3k7y8Dnu--Peqe6JJX0xGMhoQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Krishna Reddy <vdumpa@nvidia.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>
List-Id: linux-arch.vger.kernel.org

Sorry for digging this very late. But as part of integrating dma_map v7 
& sysmmu v12 on 3.3-rc5, I am facing below issue:

a) By un-selecting IOMMU in menu config, I am able to allocate memory in 
vb2-dma-contig

b) When I enable SYSMMU support for the IP's, I am receiving below fault:

Unhandled fault: external abort on non-linefetch (0x818) at 0xb6f55000

I think this has something to do with the access to the SYSMMU registers 
for writing the page table. Has anyone of you faced this issue while 
testing these(dma_map+iommu) patches on kernel mentioned above? This 
must be something related to recent changes, as I didn't have issues 
with these patches on 3.2 kernel.

Regards,
Subash


On 03/02/2012 01:35 PM, KyongHo Cho wrote:
> On Thu, Mar 1, 2012 at 12:04 AM, Marek Szyprowski
> <m.szyprowski@samsung.com>  wrote:
>> +/**
>> + * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
>> + * @dev: valid struct device pointer
>> + * @sg: list of buffers
>> + * @nents: number of buffers to map
>> + * @dir: DMA transfer direction
>> + *
>> + * Map a set of buffers described by scatterlist in streaming mode for DMA.
>> + * The scatter gather list elements are merged together (if possible) and
>> + * tagged with the appropriate dma address and length. They are obtained via
>> + * sg_dma_{address,length}.
>> + */
>> +int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>> +                    enum dma_data_direction dir, struct dma_attrs *attrs)
>> +{
>> +       struct scatterlist *s = sg, *dma = sg, *start = sg;
>> +       int i, count = 0;
>> +       unsigned int offset = s->offset;
>> +       unsigned int size = s->offset + s->length;
>> +       unsigned int max = dma_get_max_seg_size(dev);
>> +
>> +       for (i = 1; i<  nents; i++) {
>> +               s->dma_address = ARM_DMA_ERROR;
>> +               s->dma_length = 0;
>> +
>> +               s = sg_next(s);
>> +
>> +               if (s->offset || (size&  ~PAGE_MASK) || size + s->length>  max) {
>> +                       if (__map_sg_chunk(dev, start, size,&dma->dma_address,
>> +                           dir)<  0)
>> +                               goto bad_mapping;
>> +
>> +                       dma->dma_address += offset;
>> +                       dma->dma_length = size - offset;
>> +
>> +                       size = offset = s->offset;
>> +                       start = s;
>> +                       dma = sg_next(dma);
>> +                       count += 1;
>> +               }
>> +               size += s->length;
>> +       }
>> +       if (__map_sg_chunk(dev, start, size,&dma->dma_address, dir)<  0)
>> +               goto bad_mapping;
>> +
>> +       dma->dma_address += offset;
>> +       dma->dma_length = size - offset;
>> +
>> +       return count+1;
>> +
>> +bad_mapping:
>> +       for_each_sg(sg, s, count, i)
>> +               __iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
>> +       return 0;
>> +}
>> +
> This looks that the given sg list specifies the list of physical
> memory chunks and
> the list of IO virtual memory chunks at the same time after calling
> arm_dma_map_sg().
> It can happen that dma_address and dma_length of a sg entry does not
> correspond to
> physical memory information of the sg entry.
>
> I think it is beneficial for handling IO virtual memory.
>
> However, I worry about any other problems caused by a single sg entry contains
> information from 2 different context.
>
> Regards,
>
> Cho KyongHo.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
