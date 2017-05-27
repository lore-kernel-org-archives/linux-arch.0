From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v6 3/6] ACPI/IORT: Ignore all errors except EPROBE_DEFER
Date: Sat, 27 May 2017 21:18:39 +0200
Message-ID: <1564836.5iBbgoacpH@aspire.rjw.lan>
References: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
	<1495892865-9506-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1495892865-9506-3-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Saturday, May 27, 2017 07:17:42 PM Sricharan R wrote:
> While deferring the probe of IOMMU masters, xlate and
> add_device callbacks called from iort_iommu_configure
> can pass back error values like -ENODEV, which means
> the IOMMU cannot be connected with that master for real
> reasons. Before the IOMMU probe deferral, all such errors
> were ignored. Now all those errors are propagated back,
> killing the master's probe for such errors. Instead ignore
> all the errors except EPROBE_DEFER, which is the only one
> of concern and let the master work without IOMMU, thus
> restoring the old behavior. Also make explicit that
> acpi_dma_configure handles only -EPROBE_DEFER from
> iort_iommu_configure.
> 
> Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c | 6 ++++++
>  drivers/acpi/scan.c       | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..16e101f 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -782,6 +782,12 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  	if (err)
>  		ops = ERR_PTR(err);
>  
> +	/* Ignore all other errors apart from EPROBE_DEFER */
> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
> +		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
> +		ops = NULL;
> +	}
> +
>  	return ops;
>  }
>  
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e39ec7b..3a10d757 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1371,8 +1371,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>  	iort_set_dma_mask(dev);
>  
>  	iommu = iort_iommu_configure(dev);
> -	if (IS_ERR(iommu))
> -		return PTR_ERR(iommu);
> +	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
>  
>  	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  	/*
> 

ACK for the scan.c change and I'm assuming this to go in via ARM64.

Thanks,
Rafael
