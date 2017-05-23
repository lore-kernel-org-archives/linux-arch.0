From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V11 08/11] drivers: acpi: Handle IOMMU lookup failure with
	deferred probing or error
Date: Tue, 23 May 2017 14:31:17 +0530
Message-ID: <c6d5c033-a8f9-03e3-9963-cd291ae2d7e1@codeaurora.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
	<1491823266-1209-9-git-send-email-sricharan@codeaurora.org>
	<41668eff-271c-1c4c-7665-3bf0faa74669@codeaurora.org>
	<20170523085241.GA18204@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170523085241.GA18204@red-moon>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Lorenzo,

On 5/23/2017 2:22 PM, Lorenzo Pieralisi wrote:
> On Tue, May 23, 2017 at 02:26:10AM -0400, Nate Watterson wrote:
>> Hi Sricharan,
>>
>> On 4/10/2017 7:21 AM, Sricharan R wrote:
>>> This is an equivalent to the DT's handling of the iommu master's probe
>>> with deferred probing when the corrsponding iommu is not probed yet.
>>> The lack of a registered IOMMU can be caused by the lack of a driver for
>>> the IOMMU, the IOMMU device probe not having been performed yet, having
>>> been deferred, or having failed.
>>>
>>> The first case occurs when the firmware describes the bus master and
>>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>>> or the device driver has not been compiled in. Return NULL, the caller
>>> will configure the device without an IOMMU.
>>>
>>> The second and third cases are handled by deferring the probe of the bus
>>> master device which will eventually get reprobed after the IOMMU.
>>>
>>> The last case is currently handled by deferring the probe of the bus
>>> master device as well. A mechanism to either configure the bus master
>>> device without an IOMMU or to fail the bus master device probe depending
>>> on whether the IOMMU is optional or mandatory would be a good
>>> enhancement.
>>>
>>> Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> [Lorenzo: Added fixes for dma_coherent_mask overflow, acpi_dma_configure
>>>           called multiple times for same device]
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>  drivers/acpi/arm64/iort.c  | 33 ++++++++++++++++++++++++++++++++-
>>>  drivers/acpi/scan.c        | 11 ++++++++---
>>>  drivers/base/dma-mapping.c |  2 +-
>>>  include/acpi/acpi_bus.h    |  2 +-
>>>  include/linux/acpi.h       |  7 +++++--
>>>  5 files changed, 47 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index 3dd9ec3..e323ece 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -543,6 +543,14 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>>>  	const struct iommu_ops *ops = NULL;
>>>  	int ret = -ENODEV;
>>>  	struct fwnode_handle *iort_fwnode;
>>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>> +
>>> +	/*
>>> +	 * If we already translated the fwspec there
>>> +	 * is nothing left to do, return the iommu_ops.
>>> +	 */
>>> +	if (fwspec && fwspec->ops)
>>> +		return fwspec->ops;
>>
>> Is this logic strictly required? It breaks masters with multiple SIDs
>> as only the first SID is actually added to the master's fwspec.
> 
> My bad, that's indeed a silly bug I introduced. Please let me know if the
> patch below fixes it, we will send it upstream shortly.
> 

oops, i think emails crossed. Please let me know if you are ok to add this
to the other fixes.

Regards,
 Sricharan

> Lorenzo
> 
> -- >8 --
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..e326f2a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -666,14 +666,6 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>  	int ret = -ENODEV;
>  	struct fwnode_handle *iort_fwnode;
>  
> -	/*
> -	 * If we already translated the fwspec there
> -	 * is nothing left to do, return the iommu_ops.
> -	 */
> -	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
> -	if (ops)
> -		return ops;
> -
>  	if (node) {
>  		iort_fwnode = iort_get_fwnode(node);
>  		if (!iort_fwnode)
> @@ -735,6 +727,14 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  	u32 streamid = 0;
>  	int err;
>  
> +	/*
> +	 * If we already translated the fwspec there
> +	 * is nothing left to do, return the iommu_ops.
> +	 */
> +	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
> +	if (ops)
> +		return ops;
> +
>  	if (dev_is_pci(dev)) {
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
>  		u32 rid;
> 
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
