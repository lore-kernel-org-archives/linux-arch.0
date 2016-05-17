Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32415 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbcEQOzs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2016 10:55:48 -0400
Date: Tue, 17 May 2016 10:54:45 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCHv6 3/8] dma-mapping: add dma_{map,unmap}_resource
Message-ID: <20160517145445.GE4074@char.us.oracle.com>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, linux-arch@vger.kernel.org, geert+renesas@glider.be, arnd@arndb.de, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com
Message-ID: <20160517145445.Zs2X8IDxfeGCf5mBXhXjicJv_0hYJcJILz8wauIAKBA@z>

>  
> -In some circumstances dma_map_single() and dma_map_page() will fail to create
> -a mapping. A driver can check for these errors by testing the returned
> -DMA address with dma_mapping_error(). A non-zero return value means the mapping
> -could not be created and the driver should take appropriate action (e.g.
> -reduce current DMA mapping usage or delay and try again later).
> +In some circumstances dma_map_single(), dma_map_page() and dma_map_resource()
> +will fail to create a mapping. A driver can check for these errors by testing
> +the returned DMA address with dma_mapping_error(). A non-zero return value
> +means the mapping could not be created and the driver should take appropriate
> +action (e.g. reduce current DMA mapping usage or delay and try again later).

This looks like it belongs to another patch?
