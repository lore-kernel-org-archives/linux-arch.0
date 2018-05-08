Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55336 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754439AbeEHKFZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 May 2018 06:05:25 -0400
Subject: Re: [PATCH 3/3] dma-debug: unexport dma_debug_resize_entries and
 debug_dma_dump_mappings
References: <20180424140235.9125-1-hch@lst.de>
 <20180424140235.9125-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bb5bb25f-24da-9729-a39b-3b88c65ef628@arm.com>
Date: Tue, 8 May 2018 11:05:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180424140235.9125-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180508100520.271vQZJdh2YjN0D9JIoShMGPSl_m91Ow5E5xWqIIu3g@z>

On 24/04/18 15:02, Christoph Hellwig wrote:
> Only used by the AMD GART driver, which must be built in.

FWIW debug_dma_dump_mappings() is also called by the Intel VT-d driver, 
but the same reasoning still applies. This does rather beg the question 
of whether it's right to have bits of low-level dma-debug internals 
*only* called by a couple of IOMMU drivers, but that can wait for 
another day.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-debug.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 075253cb613b..6a1ebaa83623 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
>   		spin_unlock_irqrestore(&bucket->lock, flags);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_dump_mappings);
>   
>   /*
>    * For each mapping (initial cacheline in the case of
> @@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(dma_debug_resize_entries);
>   
>   /*
>    * DMA-API debugging init code
> 
