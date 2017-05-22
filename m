Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758721AbdEVLGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2017 07:06:00 -0400
Subject: Re: [PATCH V4 3/4] ACPI/IORT: Ignore all errors except EPROBE_DEFER
References: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
 <1495119257-26724-3-git-send-email-sricharan@codeaurora.org>
 <20170522103730.GB7553@red-moon>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <ffb088d6-e40f-7a7d-dafb-e52dc86704fc@codeaurora.org>
Date: Mon, 22 May 2017 16:35:43 +0530
MIME-Version: 1.0
In-Reply-To: <20170522103730.GB7553@red-moon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, laurent.pinchart@ideasonboard.com, j.neuschaefer@gmx.net, geert@linux-m68k.org, magnus.damm@gmail.com
Message-ID: <20170522110543.9Q5J5UExneFz5KUQPo-FUDeFNnjegOUBZ6rC_n5fAWk@z>

Hi Lorenzo,

On 5/22/2017 4:07 PM, Lorenzo Pieralisi wrote:
> Hi Sricharan,
> 
> On Thu, May 18, 2017 at 08:24:16PM +0530, Sricharan R wrote:
>> While deferring the probe of IOMMU masters, xlate and
>> add_device callbacks called from iort_iommu_configure
>> can pass back error values like -ENODEV, which means
>> the IOMMU cannot be connected with that master for real
>> reasons. Before the IOMMU probe deferral, all such errors
>> were ignored. Now all those errors are propagated back,
>> killing the master's probe for such errors. Instead ignore
>> all the errors except EPROBE_DEFER, which is the only one
>> of concern and let the master work without IOMMU, thus
>> restoring the old behavior.
>>
>> Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>> [V4] Added this patch newly.
>>
>>  drivers/acpi/arm64/iort.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index c5fecf9..16e101f 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -782,6 +782,12 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>>  	if (err)
>>  		ops = ERR_PTR(err);
>>  
>> +	/* Ignore all other errors apart from EPROBE_DEFER */
>> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
>> +		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
>> +		ops = NULL;
>> +	}
>> +
>>  	return ops;
>>  }
>>  
> 
> It is getting a bit convoluted. Is not it better to propagate the
> error back and let acpi_dma_configure() make a decision accordingly ?
> 

ok, I was trying to keep it in same way as DT, where of_dma_configure
(here acpi_dma_configure) calls of_iommu_configure(here iort_iommu_configure)
which ends up doing the check. So will have to be changed in both places
for symmetry.

> Something like:
> 
> -- >8 --
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

In case of other errors apart from EPROBE_DEFER,
iommu = NULL should be set, before passing it on to
arch_setup_dma_ops.

Regards,
 Sricharan

>  
>  	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  	/*
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
