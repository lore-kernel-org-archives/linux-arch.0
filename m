Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46176 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435AbcBJKte (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Feb 2016 05:49:34 -0500
Subject: Re: [PATCH v3 6/8] dmaengine: rcar-dmac: add iommu support for slave
 transfers
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56BB15BB.30806@arm.com>
Date: Wed, 10 Feb 2016 10:49:31 +0000
MIME-Version: 1.0
In-Reply-To: <1455065878-11906-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, geert+renesas@glider.be, vinod.koul@intel.com, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com
Message-ID: <20160210104931.YXs7D2VKzeP8Xr9iisF7MAsaDG35HWBFhWXAf66kjxo@z>

On 10/02/16 00:57, Niklas Söderlund wrote:
> Enable slave transfers to devices behind IPMMU:s by mapping the slave
> addresses using the dma-mapping API.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>   drivers/dma/sh/rcar-dmac.c | 57 ++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 743873c..268407c 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1106,21 +1106,68 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>   	return desc;
>   }
>
> +static int rcar_dmac_set_slave_addr(struct dma_chan *chan,
> +				     struct rcar_dmac_chan_slave *slave,
> +				     phys_addr_t addr, size_t size)
> +{
> +	struct dma_attrs attrs;
> +	enum dma_data_direction dir;
> +
> +	init_dma_attrs(&attrs);
> +	dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
> +	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);

Now that we have a way to deal with MMIO addresses properly, we don't 
need these any more.

Robin.

> +
> +	/*
> +	 * We can't know the direction at this time, see documentation for
> +	 * 'direction' in struct dma_slave_config.
> +	 */
> +	dir = DMA_BIDIRECTIONAL;
> +
> +	if (slave->xfer_size) {
> +		dma_unmap_resource(chan->device->dev, slave->slave_addr,
> +				slave->xfer_size, dir, &attrs);
> +		slave->slave_addr = 0;
> +		slave->xfer_size = 0;
> +	}
> +
> +	if (size) {
> +		slave->slave_addr = dma_map_resource(chan->device->dev, addr,
> +				size, dir, &attrs);
> +
> +		if (dma_mapping_error(chan->device->dev, slave->slave_addr)) {
> +			struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> +
> +			dev_err(chan->device->dev,
> +					"chan%u: failed to map %zx@%pap",
> +					rchan->index, size, &addr);
> +			return -EIO;
> +		}
> +
> +		slave->xfer_size = size;
> +	}
> +
> +	return 0;
> +}
> +
>   static int rcar_dmac_device_config(struct dma_chan *chan,
>   				   struct dma_slave_config *cfg)
>   {
>   	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> +	int ret;
>
>   	/*
>   	 * We could lock this, but you shouldn't be configuring the
>   	 * channel, while using it...
>   	 */
> -	rchan->src.slave_addr = cfg->src_addr;
> -	rchan->dst.slave_addr = cfg->dst_addr;
> -	rchan->src.xfer_size = cfg->src_addr_width;
> -	rchan->dst.xfer_size = cfg->dst_addr_width;
>
> -	return 0;
> +	ret = rcar_dmac_set_slave_addr(chan, &rchan->src, cfg->src_addr,
> +			cfg->src_addr_width);
> +	if (ret)
> +		return ret;
> +
> +	ret = rcar_dmac_set_slave_addr(chan, &rchan->dst, cfg->dst_addr,
> +			cfg->dst_addr_width);
> +	return ret;
>   }
>
>   static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)
>

