Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:50135 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbcEQOvM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2016 10:51:12 -0400
Date: Tue, 17 May 2016 10:50:02 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCHv6 2/8] dma-debug: add support for resource mappings
Message-ID: <20160517145002.GD4074@char.us.oracle.com>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462812247-3414-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, linux-arch@vger.kernel.org, geert+renesas@glider.be, arnd@arndb.de, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com
Message-ID: <20160517145002.P3NEaSSxHW_kZnX_Cdj6WCA63eYPDf1S29CoFOX4jWY@z>

> +void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
> +			    int direction, dma_addr_t dma_addr)
> +{
> +	struct dma_debug_entry *entry;
> +
> +	if (unlikely(dma_debug_disabled()))
> +		return;
> +
> +	entry = dma_entry_alloc();
> +	if (!entry)
> +		return;
> +
> +	entry->type		= dma_debug_resource;
> +	entry->dev		= dev;
> +	entry->pfn		= __phys_to_pfn(addr);
> +	entry->offset		= addr - PHYS_PFN(entry->pfn);

Is that right? 

__phys_to_pfn(addr) is PHYS_PFN(addr), so what you get here is

addr - PHYS_PFN(PHYS_PFN(addr)) ?


> +	entry->size		= size;
> +	entry->dev_addr		= dma_addr;
> +	entry->direction	= direction;
> +	entry->map_err_type	= MAP_ERR_NOT_CHECKED;
> +
> +	add_dma_entry(entry);
> +}
> +EXPORT_SYMBOL(debug_dma_map_resource);
> +
