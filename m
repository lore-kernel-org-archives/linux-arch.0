From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 6/8] dmaengine: rcar-dmac: add iommu support for slave
 transfers
Date: Mon, 7 Mar 2016 11:33:49 +0530
Message-ID: <20160307060349.GE11154@localhost>
References: <1455655184-14478-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455655184-14478-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48000 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbcCGF7l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 7 Mar 2016 00:59:41 -0500
Content-Disposition: inline
In-Reply-To: <1455655184-14478-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org

On Tue, Feb 16, 2016 at 09:39:42PM +0100, Niklas S=F6derlund wrote:
> Enable slave transfers to devices behind IPMMU:s by mapping the slave

IPMMU:s ?

> addresses using the dma-mapping API.
>=20
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
=2Ese>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 52 ++++++++++++++++++++++++++++++++++++=
+++++-----
>  1 file changed, 47 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 743873c..6a24847 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1106,21 +1106,63 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *ch=
an, dma_addr_t buf_addr,
>  	return desc;
>  }
> =20
> +static int rcar_dmac_set_slave_addr(struct dma_chan *chan,
> +				     struct rcar_dmac_chan_slave *slave,
> +				     phys_addr_t addr, size_t size)
> +{
> +	enum dma_data_direction dir;
> +
> +	/*
> +	 * We can't know the direction at this time, see documentation for
> +	 * 'direction' in struct dma_slave_config.
> +	 */

Okay so we are mapping on the device config, which doesn't seem intutiv=
e.
Why is this not done during prepare calls?

> +	dir =3D DMA_BIDIRECTIONAL;
> +
> +	if (slave->xfer_size) {
> +		dma_unmap_resource(chan->device->dev, slave->slave_addr,
> +				   slave->xfer_size, dir, NULL);
> +		slave->slave_addr =3D 0;
> +		slave->xfer_size =3D 0;
> +	}
> +
> +	if (size) {
> +		slave->slave_addr =3D dma_map_resource(chan->device->dev, addr,
> +				size, dir, NULL);
> +
> +		if (dma_mapping_error(chan->device->dev, slave->slave_addr)) {
> +			struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> +
> +			dev_err(chan->device->dev,
> +				"chan%u: failed to map %zx@%pap", rchan->index,
> +				size, &addr);
> +			return -EIO;
> +		}
> +
> +		slave->xfer_size =3D size;
> +	}
> +
> +	return 0;
> +}
> +
>  static int rcar_dmac_device_config(struct dma_chan *chan,
>  				   struct dma_slave_config *cfg)
>  {
>  	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> +	int ret;
> =20
>  	/*
>  	 * We could lock this, but you shouldn't be configuring the
>  	 * channel, while using it...
>  	 */
> -	rchan->src.slave_addr =3D cfg->src_addr;
> -	rchan->dst.slave_addr =3D cfg->dst_addr;
> -	rchan->src.xfer_size =3D cfg->src_addr_width;
> -	rchan->dst.xfer_size =3D cfg->dst_addr_width;
> =20
> -	return 0;
> +	ret =3D rcar_dmac_set_slave_addr(chan, &rchan->src, cfg->src_addr,
> +				       cfg->src_addr_width);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rcar_dmac_set_slave_addr(chan, &rchan->dst, cfg->dst_addr,
> +				       cfg->dst_addr_width);
> +	return ret;
>  }
> =20
>  static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)
> --=20
> 2.7.1
>=20

--=20
~Vinod
