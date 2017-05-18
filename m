From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH V2 2/3] iommu: of: Ignore all errors except EPROBE_DEFER
Date: Thu, 18 May 2017 13:39:19 +0300
Message-ID: <6863998.WsTHer29ZI@avalon>
References: <1495102030-10548-1-git-send-email-sricharan@codeaurora.org> <1495102030-10548-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1495102030-10548-2-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, magnus.damm@gmail.com, geert@linux-m68k.org, j.neuschaefer@gmx.net, laurent.pinchart+renesas@ideasonboard.com
List-Id: linux-arch.vger.kernel.org

Hi Sricharan,

Thank you for the patch.

On Thursday 18 May 2017 15:37:09 Sricharan R wrote:
> While deferring the probe of IOMMU masters,
> xlate and add_device callback can pass back error values
> like -ENODEV, which means IOMMU cannot be connected
> with that master for real reasons. So rather than
> killing the master's probe for such errors, just
> ignore the errors and let the master work without
> an IOMMU.

I don't think this is a good idea. Why should we allow IOMMU drivers to return 
an error if we're always going to ignore the error value ? That will lead to 
drivers implementing slightly different behaviours, which will be painful the 
day we'll need to start acting based on the error value.

At the very least, if you want to give a specific meaning to -ENODEV, you 
should check for that value specifically and not ignore all errors other than 
-EPROBE_DEFER. You also need to document the meaning of the error value. This 
can be done in the documentation of the of_xlate operation in 
include/linux/iommu.h:

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54adc4a33..6ba553e7384a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -181,7 +181,6 @@ struct iommu_resv_region {
  * @domain_window_disable: Disable a particular window for a domain
  * @domain_set_windows: Set the number of windows for a domain
  * @domain_get_windows: Return the number of windows for a domain
- * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -224,6 +223,11 @@ struct iommu_ops {
 	/* Get the number of windows per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
+	/**
+	 * @of_xlate:
+	 *
+	 * Add OF master IDs to iommu grouping.
+	 */
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 
 	unsigned long pgsize_bitmap;


And add documentation for the error codes there.

If you want to ignore some errors returned from the add_device operation you 
should document it similarly, and in particular document which error check(s) 
need to be performed by of_xlate and which are the responsibility of 
add_device.

> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred
> probing or error")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Magnus Damn <magnus.damn@gmail.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
> [V2] Corrected spelling/case in commit log
> 
>  drivers/iommu/of_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e6e9bec..f0d22c0 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -237,6 +237,12 @@ const struct iommu_ops *of_iommu_configure(struct
> device *dev, ops = ERR_PTR(err);
>  	}
> 
> +	/* Ignore all other errors apart from EPROBE_DEFER */
> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
> +		dev_info(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
> +		ops = NULL;
> +	}
> +
>  	return ops;
>  }

-- 
Regards,

Laurent Pinchart

