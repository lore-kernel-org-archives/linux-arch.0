From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH V10 03/12] of: dma: Move range size workaround to
 of_dma_get_range()
Date: Wed, 5 Apr 2017 23:24:19 -0700
Message-ID: <58E5DF13.2020700@gmail.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1491301105-5274-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>, robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-arch.vger.kernel.org

On 04/04/17 03:18, Sricharan R wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Invalid dma-ranges values should be worked around when retrieving the
> DMA range in of_dma_get_range(), not by all callers of the function.
> This isn't much of a problem now that we have a single caller, but that
> situation will change when moving DMA configuration to device probe
> time.

Please drop this patch from the series.  I just now sent Rob an
alternative that reflects other changes that have occurred since
this patch series was first created many, many moons ago
(https://lkml.org/lkml/2017/4/6/53).

Thanks,

Frank

> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/of/address.c | 20 ++++++++++++++++++--
>  drivers/of/device.c  | 15 ---------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 02b2903..6aeb816 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -819,8 +819,8 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
>   *	CPU addr (phys_addr_t)	: pna cells
>   *	size			: nsize cells
>   *
> - * It returns -ENODEV if "dma-ranges" property was not found
> - * for this device in DT.
> + * Return 0 on success, -ENODEV if the "dma-ranges" property was not found for
> + * this device in DT, or -EINVAL if the CPU address or size is invalid.
>   */
>  int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
>  {
> @@ -880,6 +880,22 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>  	*dma_addr = dmaaddr;
>  
>  	*size = of_read_number(ranges + naddr + pna, nsize);
> +	/*
> +	 * DT nodes sometimes incorrectly set the size as a mask. Work around
> +	 * those incorrect DT by computing the size as mask + 1.
> +	 */
> +	if (*size & 1) {
> +		pr_warn("%s: size 0x%llx for dma-range in node(%s) set as mask\n",
> +			__func__, *size, np->full_name);
> +		*size = *size + 1;
> +	}
> +
> +	if (!*size) {
> +		pr_err("%s: invalid size zero for dma-range in node(%s)\n",
> +		       __func__, np->full_name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
>  		 *dma_addr, *paddr, *size);
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index b1e6beb..09dedd0 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -110,21 +110,6 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  		size = dev->coherent_dma_mask + 1;
>  	} else {
>  		offset = PFN_DOWN(paddr - dma_addr);
> -
> -		/*
> -		 * Add a work around to treat the size as mask + 1 in case
> -		 * it is defined in DT as a mask.
> -		 */
> -		if (size & 1) {
> -			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
> -				 size);
> -			size = size + 1;
> -		}
> -
> -		if (!size) {
> -			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
> -			return;
> -		}
>  		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>  	}
>  
> 
