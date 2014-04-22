Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:60342 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531AbaDVNwE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 09:52:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/28] nios2: DMA mapping API
Date: Tue, 22 Apr 2014 15:52:00 +0200
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <1397845149-3141-1-git-send-email-lftan@altera.com> <1397845149-3141-4-git-send-email-lftan@altera.com>
In-Reply-To: <1397845149-3141-4-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201404221552.00501.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140422135200.jWrdVwLernIi8s-DOklZ2XTj_egdE1F1J18Nmln5wQg@z>

On Friday 18 April 2014, Ley Foon Tan wrote:

> +static inline int dma_supported(struct device *dev, u64 mask)
> +{
> +	/* we fall back to GFP_DMA when the mask isn't all 1s,
> +	 * so we can't guarantee allocations that must be
> +	 * within a tighter range than GFP_DMA.
> +	 */
> +	if (mask < 0x00ffffff)
> +		return 0;
> +
> +	return 1;
> +}

> +void *dma_alloc_coherent(struct device *dev, size_t size,
> +			    dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +	void *ret;
> +
> +	/* ignore region specifiers */
> +	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
> +
> +	/* optimized page clearing */
> +	gfp |= __GFP_ZERO;
> +
> +	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
> +		gfp |= GFP_DMA;

What is the significance of ZONE_DMA on this architecture?

Do you actually have DMA masters with a 0x00ffffff mask?

	Arnd

