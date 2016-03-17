From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v5 6/9] dmaengine: rcar-dmac: group slave configuration
Date: Thu, 17 Mar 2016 13:28:50 +0200
Message-ID: <5083144.aEzMy68lFX@avalon>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<1457404974-1800-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1457404974-1800-7-git-send-email-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
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

On Tuesday 08 March 2016 03:42:51 Niklas S=F6derlund wrote:
> Group slave address and transfer size in own structs for source and
> destination. This is in preparation for hooking up the dma-mapping API
> to the slave addresses.
> =

> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/dma/sh/rcar-dmac.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> =

> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 01cf82f..b3911fe 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -118,14 +118,22 @@ struct rcar_dmac_desc_page {
>  	sizeof(struct rcar_dmac_xfer_chunk))
> =

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
> - * @src_xfer_size: size (in bytes) of hardware transfers on the source s=
ide
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
> =

> -	unsigned int src_xfer_size;
> -	unsigned int dst_xfer_size;
> -	phys_addr_t src_slave_addr;
> -	phys_addr_t dst_slave_addr;
> +	struct rcar_dmac_chan_slave src;
> +	struct rcar_dmac_chan_slave dst;
>  	int mid_rid;
> =

>  	spinlock_t lock;
> @@ -793,13 +799,13 @@ static void rcar_dmac_chan_configure_desc(struct
> rcar_dmac_chan *chan, case DMA_DEV_TO_MEM:
>  		chcr =3D RCAR_DMACHCR_DM_INC | RCAR_DMACHCR_SM_FIXED
> =

>  		     | RCAR_DMACHCR_RS_DMARS;
> =

> -		xfer_size =3D chan->src_xfer_size;
> +		xfer_size =3D chan->src.xfer_size;
>  		break;
> =

>  	case DMA_MEM_TO_DEV:
>  		chcr =3D RCAR_DMACHCR_DM_FIXED | RCAR_DMACHCR_SM_INC
> =

>  		     | RCAR_DMACHCR_RS_DMARS;
> =

> -		xfer_size =3D chan->dst_xfer_size;
> +		xfer_size =3D chan->dst.xfer_size;
>  		break;
> =

>  	case DMA_MEM_TO_MEM:
> @@ -1038,7 +1044,7 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, stru=
ct
> scatterlist *sgl, }
> =

>  	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
> -		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
> +		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
>  	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
>  				      dir, flags, false);
>  }
> @@ -1093,7 +1099,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t buf_addr, }
> =

>  	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
> -		 ? rchan->src_slave_addr : rchan->dst_slave_addr;
> +		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
>  	desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
>  				      dir, flags, true);
> =

> @@ -1110,10 +1116,10 @@ static int rcar_dmac_device_config(struct dma_chan
> *chan, * We could lock this, but you shouldn't be configuring the
>  	 * channel, while using it...
>  	 */
> -	rchan->src_slave_addr =3D cfg->src_addr;
> -	rchan->dst_slave_addr =3D cfg->dst_addr;
> -	rchan->src_xfer_size =3D cfg->src_addr_width;
> -	rchan->dst_xfer_size =3D cfg->dst_addr_width;
> +	rchan->src.slave_addr =3D cfg->src_addr;
> +	rchan->dst.slave_addr =3D cfg->dst_addr;
> +	rchan->src.xfer_size =3D cfg->src_addr_width;
> +	rchan->dst.xfer_size =3D cfg->dst_addr_width;
> =

>  	return 0;
>  }

-- =

Regards,

Laurent Pinchart
