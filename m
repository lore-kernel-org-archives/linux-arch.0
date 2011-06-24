From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/8] ARM: dma-mapping: use asm-generic/dma-mapping-common.h
Date: Fri, 24 Jun 2011 17:36:43 +0200
Message-ID: <201106241736.43576.arnd@arndb.de>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Monday 20 June 2011, Marek Szyprowski wrote:
> This patch modifies dma-mapping implementation on ARM architecture to
> use common dma_map_ops structure and asm-generic/dma-mapping-common.h
> helpers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

This is a good idea in general, but I have a few concerns about details:

First of all, should we only allow using dma_map_ops on ARM, or do we
also want to support a case where these are all inlined as before?

I suppose for the majority of the cases, the overhead of the indirect
function call is near-zero, compared to the overhead of the cache
management operation, so it would only make a difference for coherent
systems without an IOMMU. Do we care about micro-optimizing those?

> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 799669d..f4e4968 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -10,6 +10,27 @@
>  #include <asm-generic/dma-coherent.h>
>  #include <asm/memory.h>
>  
> +extern struct dma_map_ops dma_ops;
> +
> +static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> +{
> +	if (dev->archdata.dma_ops)
> +		return dev->archdata.dma_ops;
> +	return &dma_ops;
> +}

I would not name the global structure just 'dma_ops', the identifier could
too easily conflict with a local variable in some driver. How about
arm_dma_ops or linear_dma_ops instead?

>  /*
>   * The scatter list versions of the above methods.
>   */
> -extern int dma_map_sg(struct device *, struct scatterlist *, int,
> -		enum dma_data_direction);
> -extern void dma_unmap_sg(struct device *, struct scatterlist *, int,
> +extern int arm_dma_map_sg(struct device *, struct scatterlist *, int,
> +		enum dma_data_direction, struct dma_attrs *attrs);
> +extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, int,
> +		enum dma_data_direction, struct dma_attrs *attrs);
> +extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
>  		enum dma_data_direction);
> -extern void dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
> +extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
>  		enum dma_data_direction);
> -extern void dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
> -		enum dma_data_direction);
> -

You should not need to make these symbols visible in the header file any
more unless they are used outside of the main file later.

	Arnd
