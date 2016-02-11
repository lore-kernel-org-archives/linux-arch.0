Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:51460 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbcBKAdH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2016 19:33:07 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 6/8] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Thu, 11 Feb 2016 02:33:30 +0200
Message-ID: <7836168.xWoq7RJUyE@avalon>
In-Reply-To: <1455065878-11906-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1455065878-11906-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, vinod.koul@intel.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
Message-ID: <20160211003330.jxo_KCAa2Wl5GBpqKGPAh07QoRgYaADKNsyVNy2J3Ys@z>

Hi Niklas,

Thank you for the patch.

On Wednesday 10 February 2016 01:57:56 Niklas Söderlund wrote:
> Enable slave transfers to devices behind IPMMU:s by mapping the slave
> addresses using the dma-mapping API.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/dma/sh/rcar-dmac.c | 57 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 743873c..268407c 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1106,21 +1106,68 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t buf_addr, return desc;
>  }
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

Nitpicking, you can align slave with chan on the previous line.

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

Indentation looks weird to me.

> +			return -EIO;
> +		}
> +
> +		slave->xfer_size = size;
> +	}
> +
> +	return 0;
> +}
> +
>  static int rcar_dmac_device_config(struct dma_chan *chan,
>  				   struct dma_slave_config *cfg)
>  {
>  	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> +	int ret;
> 
>  	/*
>  	 * We could lock this, but you shouldn't be configuring the
>  	 * channel, while using it...
>  	 */
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

You could align cfg with chan on the previous line (twice).

With this fixed and the attributes removed as explained by Robin,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	return ret;
>  }
> 
>  static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)

-- 
Regards,

Laurent Pinchart

