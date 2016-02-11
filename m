From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 2/8] dma-mapping: add {map,unmap}_resource to dma_map_ops
Date: Thu, 11 Feb 2016 02:03:40 +0200
Message-ID: <1751306.gvBkWbovht@avalon>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, vinod.koul@intel.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 February 2016 01:57:52 Niklas S=F6derlund wrote:
> Add methods to handle mapping of device resources from a physical
> address. This is needed for example to map be able to map MMIO FIFO
> registers to a IOMMU.
>=20
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
=2Ese>

Apart from the typo in the commit message that Sergei already pointed o=
ut,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/dma-mapping.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.=
h
> index 75857cd..e3aba4e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -49,6 +49,12 @@ struct dma_map_ops {
>  			 struct scatterlist *sg, int nents,
>  			 enum dma_data_direction dir,
>  			 struct dma_attrs *attrs);
> +	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_add=
r,
> +			       size_t size, enum dma_data_direction dir,
> +			       struct dma_attrs *attrs);
> +	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
> +			   size_t size, enum dma_data_direction dir,
> +			   struct dma_attrs *attrs);
>  	void (*sync_single_for_cpu)(struct device *dev,
>  				    dma_addr_t dma_handle, size_t size,
>  				    enum dma_data_direction dir);

--=20
Regards,

Laurent Pinchart
