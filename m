From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V10 03/12] of: dma: Move range size workaround to
	of_dma_get_range()
Date: Thu, 6 Apr 2017 11:03:02 +0100
Message-ID: <4d6206a4-fa5d-00b8-b536-fd9fe68fb168@arm.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
	<1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
	<1491301105-5274-4-git-send-email-sricharan@codeaurora.org>
	<58E5DF13.2020700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <58E5DF13.2020700-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Frank,

On 06/04/17 07:24, Frank Rowand wrote:
> On 04/04/17 03:18, Sricharan R wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>
>> Invalid dma-ranges values should be worked around when retrieving the
>> DMA range in of_dma_get_range(), not by all callers of the function.
>> This isn't much of a problem now that we have a single caller, but that
>> situation will change when moving DMA configuration to device probe
>> time.
> 
> Please drop this patch from the series.  I just now sent Rob an
> alternative that reflects other changes that have occurred since
> this patch series was first created many, many moons ago
> (https://lkml.org/lkml/2017/4/6/53).

Fine by me too - if we can get rid of that dubious fixup altogether, all
the better. Feel free to transfer my Reviewed-by to your patch if you like.

Thanks,
Robin.

> Thanks,
> 
> Frank
> 
>>
>> Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>> ---
>>  drivers/of/address.c | 20 ++++++++++++++++++--
>>  drivers/of/device.c  | 15 ---------------
>>  2 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 02b2903..6aeb816 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -819,8 +819,8 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
>>   *	CPU addr (phys_addr_t)	: pna cells
>>   *	size			: nsize cells
>>   *
>> - * It returns -ENODEV if "dma-ranges" property was not found
>> - * for this device in DT.
>> + * Return 0 on success, -ENODEV if the "dma-ranges" property was not found for
>> + * this device in DT, or -EINVAL if the CPU address or size is invalid.
>>   */
>>  int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
>>  {
>> @@ -880,6 +880,22 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>>  	*dma_addr = dmaaddr;
>>  
>>  	*size = of_read_number(ranges + naddr + pna, nsize);
>> +	/*
>> +	 * DT nodes sometimes incorrectly set the size as a mask. Work around
>> +	 * those incorrect DT by computing the size as mask + 1.
>> +	 */
>> +	if (*size & 1) {
>> +		pr_warn("%s: size 0x%llx for dma-range in node(%s) set as mask\n",
>> +			__func__, *size, np->full_name);
>> +		*size = *size + 1;
>> +	}
>> +
>> +	if (!*size) {
>> +		pr_err("%s: invalid size zero for dma-range in node(%s)\n",
>> +		       __func__, np->full_name);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>>  
>>  	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
>>  		 *dma_addr, *paddr, *size);
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index b1e6beb..09dedd0 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -110,21 +110,6 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>  		size = dev->coherent_dma_mask + 1;
>>  	} else {
>>  		offset = PFN_DOWN(paddr - dma_addr);
>> -
>> -		/*
>> -		 * Add a work around to treat the size as mask + 1 in case
>> -		 * it is defined in DT as a mask.
>> -		 */
>> -		if (size & 1) {
>> -			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
>> -				 size);
>> -			size = size + 1;
>> -		}
>> -
>> -		if (!size) {
>> -			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
>> -			return;
>> -		}
>>  		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>  	}
>>  
>>
