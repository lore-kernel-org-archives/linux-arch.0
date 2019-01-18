Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:33797 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfARMqv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2019 07:46:51 -0500
Subject: Re: use generic DMA mapping code in powerpc V4
References: <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
 <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
 <20190115151732.GA2325@lst.de>
 <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
 <20190118083539.GA30479@lst.de>
 <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
 <20190118112842.GA9115@lst.de>
 <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
 <20190118121810.GA13327@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
Date: Fri, 18 Jan 2019 13:46:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190118121810.GA13327@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190118124646.S4RIrKh97oOAaMlLbYDH8J_C_HefC4iYyesHTxyOBpM@z>

Sorry, it's not possible to patch 
'257002094bc5935dd63207a380d9698ab81f0775' with your patch. I also tried 
it manually but without any success.

-- Christian

On 18 January 2019 at 1:18PM, Christoph Hellwig wrote:
> On Fri, Jan 18, 2019 at 01:07:54PM +0100, Christian Zigotzky wrote:
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout 257002094bc5935dd63207a380d9698ab81f0775
>>
>>
>> I get the following error message with your patch:
> Hmm.  Did I attached the wrong patch?  Here is the one I want and just
> applied to that revision:
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 355d16acee6d..e46c9b64ec0d 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -118,8 +118,11 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   			page = NULL;
>   		}
>   	}
> -	if (!page)
> +	if (!page) {
>   		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
> +		if (!page)
> +			pr_warn("failed to allocate memory with gfp 0x%x\n", gfp);
> +	}
>   
>   	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>   		__free_pages(page, page_order);
> @@ -139,6 +142,10 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   		}
>   	}
>   
> +	if (!page) {
> +		pr_warn("failed to allocate DMA memory!\n");
> +		dump_stack();
> +	}
>   	return page;
>   }
>   
>
