From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu: of: Fix check for returning EPROBE_DEFER
Date: Thu, 18 May 2017 14:33:57 +0530
Message-ID: <1c306cf1-f7fb-87b1-1fef-3b08aea04560@codeaurora.org>
References: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
	<20170517170430.GD31462@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170517170430.GD31462-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
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
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Bjorn,

On 5/17/2017 10:34 PM, Bjorn Helgaas wrote:
> On Wed, May 17, 2017 at 05:00:07PM +0530, Sricharan R wrote:
>> Now with iommu probe deferral, we return -EPROBE_DEFER
>> for master's that are connected to an iommu which is not
> 
> s/master's/masters/
> 
> s/iommu/IOMMU/ in your English text (changelogs and comments).  That seems
> to be the convention, based on "git log drivers/iommu/of_iommu.c"
> 

ok, will correct those.

Regards,
 Sricharan


>> probed yet, but going to get probed, so that we can attach
>> the correct dma_ops. So while trying to defer the probe of
>> the master, check if the of_iommu node that it is connected
>> to is marked in DT as 'status=disabled', then the iommu is never
>> is going to get probed. So simply return NULL and let the master
>> work without an iommu.
>>
>> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>> Tested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Tested-by: Magnus Damn <magnus.damn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/iommu/of_iommu.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 9f44ee8..e6e9bec 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node *np)
>>  
>>  	ops = iommu_ops_from_fwnode(fwnode);
>>  	if ((ops && !ops->of_xlate) ||
>> +	    !of_device_is_available(iommu_spec->np) ||
>>  	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
>>  		return NULL;
>>  
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
