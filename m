From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V10 06/12] of: device: Fix overflow of coherent_dma_mask
Date: Thu, 6 Apr 2017 08:56:33 -0500
Message-ID: <CAL_JsqLsE378hfs=xNvSdPV2r+7H81cAFzOwtda2W+mFVoohuA@mail.gmail.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
	<1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
	<1491301105-5274-7-git-send-email-sricharan@codeaurora.org>
	<58E5E7B7.1050400@gmail.com>
	<b081f333-084d-ffa5-635f-f7f1c0232ac3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b081f333-084d-ffa5-635f-f7f1c0232ac3-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sudeep Holla <sudeep.holla>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 6, 2017 at 5:24 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 06/04/17 08:01, Frank Rowand wrote:
>> On 04/04/17 03:18, Sricharan R wrote:
>>> Size of the dma-range is calculated as coherent_dma_mask + 1
>>> and passed to arch_setup_dma_ops further. It overflows when
>>> the coherent_dma_mask is set for full 64 bits 0xFFFFFFFFFFFFFFFF,
>>> resulting in size getting passed as 0 wrongly. Fix this by
>>> passsing in max(mask, mask + 1). Note that in this case
>>> when the mask is set to full 64bits, we will be passing the mask
>>> itself to arch_setup_dma_ops instead of the size. The real fix
>>> for this should be to make arch_setup_dma_ops receive the
>>> mask and handle it, to be done in the future.
>>>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>  drivers/of/device.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index c17c19d..c2ae6bb 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>>      ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>>      if (ret < 0) {
>>>              dma_addr = offset = 0;
>>> -            size = dev->coherent_dma_mask + 1;
>>> +            size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>>>      } else {
>>>              offset = PFN_DOWN(paddr - dma_addr);
>>>              dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>>
>>
>> NACK.
>>
>> Passing an invalid size to arch_setup_dma_ops() is only part of the problem.
>> size is also used in of_dma_configure() before calling arch_setup_dma_ops():
>>
>>         dev->coherent_dma_mask = min(dev->coherent_dma_mask,
>>                                      DMA_BIT_MASK(ilog2(dma_addr + size)));
>>         *dev->dma_mask = min((*dev->dma_mask),
>>                              DMA_BIT_MASK(ilog2(dma_addr + size)));
>>
>> which would be incorrect for size == 0xffffffffffffffffULL when
>> dma_addr != 0.  So the proposed fix really is not papering over
>> the base problem very well.
>
> I'm not sure I agree there. Granted, there exist many more problematic
> aspects than are dealt with here (I've got more patches cooking to sort
> out some of the other issues we have with dma-ranges), but considering
> size specifically:
>
> - It is not possible to explicitly specify a range with a size of 2^64
> in DT. If someone does specify a size of 0, they've done a silly thing
> and should not be surprised that it ends badly.

And because of this, we allow ~0 (both 32 and 64 bit) in DT dma-ranges
and fix these up as 2^32 and 2^64 sizes.

Rob
