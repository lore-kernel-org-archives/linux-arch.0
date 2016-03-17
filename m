Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:33806 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936159AbcCQQnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2016 12:43:25 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 6/9] dmaengine: rcar-dmac: group slave configuration
Date: Thu, 17 Mar 2016 13:28:50 +0200
Message-ID: <5083144.aEzMy68lFX@avalon>
In-Reply-To: <1457404974-1800-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1457404974-1800-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
Message-ID: <20160317112850.gksZy2wCIxeZytkylG0MqZ6AhkQNZmkwwzTrEez51QM@z>

Hi Niklas,

Thank you for the patch.

On Tuesday 08 March 2016 03:42:51 Niklas Söderlund wrote:
> Group slave address and transfer size in own structs for source and
> destination. This is in preparation for hooking up the dma-mapping API
> to the slave addresses.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/sh/rcar-dmac.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 01cf82f..b3911fe 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -118,14 +118,22 @@ struct rcar_dmac_desc_page {
>  	sizeof(struct rcar_dmac_xfer_chunk))
> 
>  /*
> + * struct rcar_dmac_chan_slave - Slave configuration
> + * @slave_addr: slave memory address
> + * @xfer_size: size (in bytes) of hardware transfers
> + */
> +struct rcar_dmac_chan_slave {
> +	phys_addr_t slave_addr;
> +	unsigned int xfer_size;
> +};
> +
> +/*
>   * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
>   * @chan: base DMA channel object
>   * @iomem: channel I/O memory base
>   * @index: index of this channel in the controller
> - * @src_xfer_size: size (in bytes) of hardware transfers on the source side
> - * @dst_xfer_size: size (in bytes) of hardware transfers on the
> destination side - * @src_slave_addr: slave source memory address
> - * @dst_slave_addr: slave destination memory address
> + * @src: slave memory address and size on the source side
> + * @dst: slave memory address and size on the destination side
>   * @mid_rid: hardware MID/RID for the DMA client using this channel
>   * @lock: protects the channel CHCR register and the desc members
>   * @desc.free: list of free descriptors
> @@ -142,10 +150,8 @@ struct rcar_dmac_chan {
>  	void __iomem *iomem;
>  	unsigned int index;
> 
> -	unsigned int src_xfer_size;
> -	unsigned int dst_xfer_size;
> -	phys_addr_t src_slave_addr;
> -	phys_addr_t dst_slave_addr;
> +	struct rcar_dmac_chan_slave src;
> +	struct rcar_dmac_chan_slave dst;
>  	int mid_rid;
> 
>  	spinlock_t lock;
> @@ -793,13 +799,13 @@ static void rcar_dmac_chan_configure_desc(struct
> rcar_dmac_chan *chan, case DMA_DEV_TO_MEM:
>  		chcr = RCAR_DMACHCR_DM_INC | RCAR_DMACHCR_SM_FIXED
> 
>  		     | RCAR_DMACHCR_RS_DMARS;
> 
> -		xfer_size = chan->src_xfer_size;
> +		xfer_size = chan->src.xfer_size;
>  		break;
> 
>  	case DMA_MEM_TO_DEV:
>  		chcr = RCAR_DMACHCR_DM_FIXED | RCAR_DMACHCR_SM_INC
> 
>  		     | RCAR_DMACHCR_RS_DMARS;
> 
> -		xfer_size = chan->dst_xfer_size;
> +		xfer_size = chan->dst.xfer_size;
>  		break;
> 
>  	case DMA_MEM_TO_MEM:
> @@ -1038,7 +1044,7 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct
> scatterlist *sgl, }
> 
>  	dev_addr = dir == DMA_DEV_TO_MEM
> -		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
> +		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
>  	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
>  				      dir, flags, false);
>  }
> @@ -1093,7 +1099,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t buf_addr, }
> 
>  	dev_addr = dir == DMA_DEV_TO_MEM
> -		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
> +		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
>  	desc = rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
>  				      dir, flags, true);
> 
> @@ -1110,10 +1116,10 @@ static int rcar_dmac_device_config(struct dma_chan
> *chan, * We could lock this, but you shouldn't be configuring the
>  	 * channel, while using it...
>  	 */
> -	rchan->src_slave_addr = cfg->src_addr;
> -	rchan->dst_slave_addr = cfg->dst_addr;
> -	rchan->src_xfer_size = cfg->src_addr_width;
> -	rchan->dst_xfer_size = cfg->dst_addr_width;
> +	rchan->src.slave_addr = cfg->src_addr;
> +	rchan->dst.slave_addr = cfg->dst_addr;
> +	rchan->src.xfer_size = cfg->src_addr_width;
> +	rchan->dst.xfer_size = cfg->dst_addr_width;
> 
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart

