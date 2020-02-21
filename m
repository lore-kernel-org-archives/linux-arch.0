From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: support setting memory uncached in
 place
Date: Fri, 21 Feb 2020 15:16:56 +0100
Message-ID: <20200221141656.GF6968@lst.de>
References: <20200220170139.387354-1-hch@lst.de> <20200220170139.387354-2-hch@lst.de> <502fa745-ddad-f91b-52bc-52edecf8fdbc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55676 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgBUORC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 09:17:02 -0500
Content-Disposition: inline
In-Reply-To: <502fa745-ddad-f91b-52bc-52edecf8fdbc@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:21:35PM +0000, Robin Murphy wrote:
>> @@ -196,10 +192,15 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>>     	memset(ret, 0, size);
>>   -	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
>> -	    dma_alloc_need_uncached(dev, attrs)) {
>> +	if (dma_alloc_need_uncached(dev, attrs)) {
>>   		arch_dma_prep_coherent(page, size);
>> -		ret = uncached_kernel_address(ret);
>> +
>> +		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED)) {
>> +			if (!arch_dma_set_uncached(ret, size))
>> +				goto out_free_pages;
>> +		} else if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT)) {
>> +			ret = uncached_kernel_address(ret);
>
> Hmm, would we actually need to keep ARCH_HAS_UNCACHED_SEGMENT? If 
> arch_dma_set_uncached() returned void*/ERR_PTR instead, then it could work 
> for both cases (with arch_dma_clear_uncached() being a no-op for segments).

Yes, I think so.  I was a little worried about what to do with
cached_kernel_address() in that scheme, but it turns out with the recent
round of dma-direct cleanup that is actually entirely unused now.
