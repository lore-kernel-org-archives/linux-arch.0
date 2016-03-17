Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:33785 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936290AbcCQQnX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2016 12:43:23 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 5/9] dmaengine: rcar-dmac: slave address are physical
Date: Thu, 17 Mar 2016 13:30:20 +0200
Message-ID: <1661205.m6h487t3oE@avalon>
In-Reply-To: <1457404974-1800-6-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1457404974-1800-6-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
Message-ID: <20160317113020.QCG6nrS-zweGOjTtt8S29FCp06KFy1EYTYkzfyjPb7Y@z>

Hi Niklas,

Thank you for the patch.

On Tuesday 08 March 2016 03:42:50 Niklas Söderlund wrote:
> Slave addresses coming from a client is physical not dma. Store the
> address using the correct data type. This is in preparation for hooking
> up the dma-mapping API to the slave addresses.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/dma/sh/rcar-dmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7820d07..01cf82f 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -144,8 +144,8 @@ struct rcar_dmac_chan {
> 
>  	unsigned int src_xfer_size;
>  	unsigned int dst_xfer_size;
> -	dma_addr_t src_slave_addr;
> -	dma_addr_t dst_slave_addr;
> +	phys_addr_t src_slave_addr;
> +	phys_addr_t dst_slave_addr;

This moves the cast from phys_addr_t to dma_addr_t from the driver's DMA 
engine operations to other places. I'm not sure there's much value in doing 
so. I'd squash this patch with 7/9, the result will be easier to review.

>  	int mid_rid;
> 
>  	spinlock_t lock;

-- 
Regards,

Laurent Pinchart

