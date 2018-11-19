From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: remove ->mapping_error
Date: Mon, 19 Nov 2018 14:52:17 +0100
Message-ID: <20181119135217.GA16334@lst.de>
References: <20181109084632.22848-1-hch@lst.de> <20181109084632.22848-2-hch@lst.de> <75c72464-1ff6-7c53-2cdb-0c5882c190aa@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <75c72464-1ff6-7c53-2cdb-0c5882c190aa@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 09, 2018 at 02:41:18PM +0000, Robin Murphy wrote:
>> -
>>   #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
>>     #define LOOP_TIMEOUT	100000
>> @@ -2339,7 +2337,7 @@ static dma_addr_t __map_single(struct device *dev,
>>   	paddr &= PAGE_MASK;
>>     	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
>> -	if (address == AMD_IOMMU_MAPPING_ERROR)
>> +	if (address == DMA_MAPPING_ERROR)
>
> This for one is clearly broken, because the IOVA allocator still returns 0 
> on failure here...

Indeed.  And that shows how the original code was making a mess of these
different constants..

> I very much agree with the concept, but I think the way to go about it is 
> to convert the implementations which need it to the standardised 
> *_MAPPING_ERROR value one-by-one, and only then then do the big sweep to 
> remove them all. That has more of a chance of getting worthwhile review and 
> testing from the respective relevant parties (I'll confess I came looking 
> for this bug specifically, since I happened to recall amd_iommu having a 
> tricky implicit reliance on the old DMA_ERROR_CODE being 0 on x86).

I'll see if I can split this out somehow, but I'm not sure it is going
to be all that much more readable..

> In terms of really minimising the error-checking overhead it's a bit of a 
> shame that DMA_MAPPING_ERROR = 0 doesn't seem viable as the thing to 
> standardise on, since that has advantages at the micro-optimisation level 
> for many ISAs - fixing up the legacy IOMMU code doesn't seem 
> insurmountable, but I suspect there may well be non-IOMMU platforms where 
> DMA to physical address 0 is a thing :(

Yes, that is what I'm more worried about.

> (yeah, I know saving a couple of instructions and potential register 
> allocations is down in the noise when we're already going from an indirect 
> call to an inline comparison; I'm mostly just thinking out loud there)

The nice bit of standardizing the value is that we get rid of an
indirect call, which generally is much more of a problem at the
micro-architecture level.
