From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V10 04/12] of: dma: Make of_dma_deconfigure() public
Date: Tue, 4 Apr 2017 11:47:17 +0100
Message-ID: <2b2b6268-ad58-4c10-8866-e44a777a4128@arm.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
	<1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
	<1491301105-5274-5-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1491301105-5274-5-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On 04/04/17 11:18, Sricharan R wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> As part of moving DMA initializing to probe time the
> of_dma_deconfigure() function will need to be called from different
> source files. Make it public and move it to drivers/of/device.c where
> the of_dma_configure() function is.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/of/device.c       | 12 ++++++++++++
>  drivers/of/platform.c     |  5 -----
>  include/linux/of_device.h |  3 +++
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 09dedd0..c17c19d 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -136,6 +136,18 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure);
>  
> +/**
> + * of_dma_deconfigure - Clean up DMA configuration
> + * @dev:	Device for which to clean up DMA configuration
> + *
> + * Clean up all configuration performed by of_dma_configure_ops() and free all
> + * resources that have been allocated.
> + */
> +void of_dma_deconfigure(struct device *dev)
> +{
> +	arch_teardown_dma_ops(dev);
> +}
> +
>  int of_device_register(struct platform_device *pdev)
>  {
>  	device_initialize(&pdev->dev);
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 5dfcc96..5344db5 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -158,11 +158,6 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  }
>  EXPORT_SYMBOL(of_device_alloc);
>  
> -static void of_dma_deconfigure(struct device *dev)
> -{
> -	arch_teardown_dma_ops(dev);
> -}
> -
>  /**
>   * of_platform_device_create_pdata - Alloc, initialize and register an of_device
>   * @np: pointer to node to create device for
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index c12dace..af98455 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -56,6 +56,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  }
>  
>  void of_dma_configure(struct device *dev, struct device_node *np);
> +void of_dma_deconfigure(struct device *dev);
>  #else /* CONFIG_OF */
>  
>  static inline int of_driver_match_device(struct device *dev,
> @@ -105,6 +106,8 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  }
>  static inline void of_dma_configure(struct device *dev, struct device_node *np)
>  {}
> +static inline void of_dma_deconfigure(struct device *dev)
> +{}
>  #endif /* CONFIG_OF */
>  
>  #endif /* _LINUX_OF_DEVICE_H */
> 
