From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 04/10] ARM: dma-mapping: remove offset parameter to prepare for generic dma_ops
Date: Wed, 11 Apr 2012 12:18:39 +0000
Message-ID: <201204111218.39800.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com> <201204101143.27915.arnd@arndb.de> <012e01cd17db$5f165c30$1d431490$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61466 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2DKMSt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Apr 2012 08:18:49 -0400
In-Reply-To: <012e01cd17db$5f165c30$1d431490$%szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, 'Krishna Reddy' <vdumpa@nvidia.com>, 'KyongHo Cho' <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'Hiroshi Doyu' <hdoyu@nvidia.com>, 'Subash Patel' <subashrp@gmail.com>

On Wednesday 11 April 2012, Marek Szyprowski wrote:
> Well, range sync functions are available from the early days of the dma 
> mapping api (at least that's what I've found reading the change log and
> old patches). They are the correct way of doing a partial syncs on the 
> buffer (usually used by the network device drivers). This patch changes
> only the internal implementation of the dma bounce functions to let 
> them tunnel through dma_map_ops structure. The driver api stays
> unchanged, so driver are obliged to call dma_*_range_* functions to
> keep code clean and easy to understand. 
> 
> The only drawback I can see from this patch is reduced detection of
> the dma api abuse. Let us consider the following code:
> 
> dma_addr = dma_map_single(dev, ptr, 64, DMA_TO_DEVICE);
> dma_sync_single_range_for_cpu(dev, dma_addr+16, 0, 32, DMA_TO_DEVICE);
> 
> Without the patch such code fails, because dma bounce code is unable
> to find the bounce buffer for the given dma_address. After the patch
> the sync call will be equivalent to: 
> 
>         dma_sync_single_range_for_cpu(dev, dma_addr, 16, 32, DMA_TO_DEVICE);
> 
> which succeeds.
> 
> I don't consider this as a real problem. DMA API abuse should be caught
> by debug_dma_* function family, so we can simplify the internal low-level
> implementation without losing anything.
> 

Ok, fair enough. Can you put the above text into the changelog?

	Arnd
