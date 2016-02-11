From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v3 6/8] dmaengine: rcar-dmac: add iommu support for slave
	transfers
Date: Thu, 11 Feb 2016 02:33:30 +0200
Message-ID: <7836168.xWoq7RJUyE@avalon>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<1455065878-11906-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455065878-11906-7-git-send-email-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 February 2016 01:57:56 Niklas S=F6derlund wrote:
> Enable slave transfers to devices behind IPMMU:s by mapping the slave
> addresses using the dma-mapping API.
> =

> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
> ---
>  drivers/dma/sh/rcar-dmac.c | 57 +++++++++++++++++++++++++++++++++++++++-=
---
>  1 file changed, 52 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 743873c..268407c 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1106,21 +1106,68 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t buf_addr, return desc;
>  }
> =

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
> +	dir =3D DMA_BIDIRECTIONAL;
> +
> +	if (slave->xfer_size) {
> +		dma_unmap_resource(chan->device->dev, slave->slave_addr,
> +				slave->xfer_size, dir, &attrs);

Nitpicking, you can align slave with chan on the previous line.

> +		slave->slave_addr =3D 0;
> +		slave->xfer_size =3D 0;
> +	}
> +
> +	if (size) {
> +		slave->slave_addr =3D dma_map_resource(chan->device->dev, addr,
> +				size, dir, &attrs);
> +
> +		if (dma_mapping_error(chan->device->dev, slave->slave_addr)) {
> +			struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> +
> +			dev_err(chan->device->dev,
> +					"chan%u: failed to map %zx@%pap",
> +					rchan->index, size, &addr);

Indentation looks weird to me.

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
> =

>  	/*
>  	 * We could lock this, but you shouldn't be configuring the
>  	 * channel, while using it...
>  	 */
> -	rchan->src.slave_addr =3D cfg->src_addr;
> -	rchan->dst.slave_addr =3D cfg->dst_addr;
> -	rchan->src.xfer_size =3D cfg->src_addr_width;
> -	rchan->dst.xfer_size =3D cfg->dst_addr_width;
> =

> -	return 0;
> +	ret =3D rcar_dmac_set_slave_addr(chan, &rchan->src, cfg->src_addr,
> +			cfg->src_addr_width);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rcar_dmac_set_slave_addr(chan, &rchan->dst, cfg->dst_addr,
> +			cfg->dst_addr_width);

You could align cfg with chan on the previous line (twice).

With this fixed and the attributes removed as explained by Robin,

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> +	return ret;
>  }
> =

>  static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)

-- =

Regards,

Laurent Pinchart
