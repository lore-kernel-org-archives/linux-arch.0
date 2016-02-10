Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45949 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414AbcBJKZM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Feb 2016 05:25:12 -0500
Subject: Re: [PATCH v3 3/8] dma-mapping: add dma_{map,unmap}_resource
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56BB1003.8020409@arm.com>
Date: Wed, 10 Feb 2016 10:25:07 +0000
MIME-Version: 1.0
In-Reply-To: <1455065878-11906-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, geert+renesas@glider.be, vinod.koul@intel.com, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com
Message-ID: <20160210102507.7h40AUfi5nfGd9DzeoUBHzrvjd5mCJnX0bptoWdPq58@z>

Hi Niklas,

Thanks for doing this, it looks good. Just a couple of minor comments on 
this and the next patch...

On 10/02/16 00:57, Niklas Söderlund wrote:
> Map/Unmap a device resource from a physical address. If no dma_map_ops
> method is available the operation is a no-op.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>   include/linux/dma-mapping.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e3aba4e..21bf986 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -216,6 +216,33 @@ static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
>   	debug_dma_unmap_page(dev, addr, size, dir, false);
>   }
>
> +static inline dma_addr_t dma_map_resource(struct device *dev,
> +					  phys_addr_t phys_addr,
> +					  size_t size,
> +					  enum dma_data_direction dir,
> +					  struct dma_attrs *attrs)
> +{
> +	struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	BUG_ON(!valid_dma_direction(dir));

I think it would be worth also having the same inverse pfn_valid() check 
as ioremap() here, to make sure this is similarly hard to misuse.

Robin.

> +	if (ops->map_resource)
> +		return ops->map_resource(dev, phys_addr, size, dir, attrs);
> +
> +	return phys_addr;
> +}
> +
> +static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
> +				      size_t size, enum dma_data_direction dir,
> +				      struct dma_attrs *attrs)
> +{
> +	struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +	if (ops->unmap_resource)
> +		ops->unmap_resource(dev, addr, size, dir, attrs);
> +
> +}
> +
>   static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
>   					   size_t size,
>   					   enum dma_data_direction dir)
>

