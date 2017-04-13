From: Julien Grall <julien.grall@arm.com>
Subject: Re: "Consolidate get_dma_ops" breaks Xen on ARM
Date: Thu, 13 Apr 2017 15:04:19 +0100
Message-ID: <47808787-8067-ccc0-0ec6-de5e0d7597c8@arm.com>
References: <alpine.DEB.2.10.1704101713080.2759@sstabellini-ThinkPad-X260>
 <CY1PR0401MB1536C1FF3C069BC88D1DB14581000@CY1PR0401MB1536.namprd04.prod.outlook.com>
 <a758dfc6-2b00-e279-303c-ba1e27380e35@arm.com>
 <20170411133649.GB27857@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.10.1704111411350.2759@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.10.1704111411350.2759@sstabellini-ThinkPad-X260>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefano Stabellini <sstabellini@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "jgross@suse.com" <jgross@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "x86@kernel.org" <x86@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, Bart Van Assche <Bart.VanAssche@sandisk.com>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Stefano,

Sorry for the late answer.

On 12/04/17 00:39, Stefano Stabellini wrote:
> On Tue, 11 Apr 2017, Catalin Marinas wrote:
>> On Tue, Apr 11, 2017 at 01:43:28PM +0100, Julien Grall wrote:
>>> On 11/04/17 02:14, Bart Van Assche wrote:
>>>> On 04/10/17 17:31, Stefano Stabellini wrote:
>>>>> I think the reason is that, as you can see, if (dev && dev->dma_ops),
>>>>> dev->dma_ops is returned, while before this changes, xen_dma_ops was
>>>>> returned on Xen on ARM.
>>>>>
>>>>> Unfortunately DMA cannot work properly without using the appropriate
>>>>> xen_dma_ops. See drivers/xen/swiotlb-xen.c and arch/arm/xen/mm.c for
>>>>> more details. (The problem is easy to spot, but I wasn't CC'ed on the
>>>>> patch.)
>>>>>
>>>>> I don't know how to solve this problem without introducing some sort of
>>>>> if (xen()) in include/linux/dma-mapping.h.
>>>>
>>>> Sorry but I don't have access to an ARM development system. Does your
>>>> comment apply to dev == NULL only, dev != NULL only or perhaps to both?
>>>> If your comment applies to dev != NULL only, can you check whether
>>>> adding something like set_dma_ops(dev, get_arch_dma_ops(NULL)) to the
>>>> appropriate ARM arch_setup_dma_ops() function is sufficient?
>>>
>>> If I understand correctly, set_dma_ops will replace dev->dma_ops with
>>> Xen DMA ops.
>>>
>>> However, Xen DMA ops will need in some places to call the device
>>> specific DMA ops (see __generic_dma_ops(...)). So I think replacing
>>> dev->dma_ops is not a solution here.
>>>
>>> The hackish patch below is fixing the problem for both ARM64 and ARM32.
>>>
>>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>>> index 0977317c6835..43a73ddeec7a 100644
>>> --- a/include/linux/dma-mapping.h
>>> +++ b/include/linux/dma-mapping.h
>>> @@ -174,6 +174,8 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
>>>  #include <asm/dma-mapping.h>
>>>  static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
>>>  {
>>> +       if (xen_initial_domain())
>>> +              return xen_dma_ops;
>>>         if (dev && dev->dma_ops)
>>>                 return dev->dma_ops;
>>>         return get_arch_dma_ops(dev ? dev->bus : NULL);
>>
>> If we do this, I guess there is no need to check for
>> xen_initial_domain() in the get_arch_dma_ops() function. Anyway, this
>> hunk would break the other architectures since xen_dma_ops is only
>> defined for arm and arm64.
>>
>>> It is not nice as this is common code, but I can't find a better solution
>>> so far. Any opinions?
>>
>> A different hack would be to avoid the generic get_dma_ops
>> implementation on arm with some #ifdef hacks above.
>>
>> Yet another way would be for dom0 to always set dev->dma_ops to
>> xen_dma_ops and preserve the real dma_ops somewhere under dev->archdata.
>> You could intercept the arch_setup_dma_ops() function for this or use
>> bus_register_notifier() (though I think the former is easier). The Xen
>> code making use of the real dma_ops would have to dig them out from
>> dev->archdata.
>
> This is a good suggestion, Catalin. Thank you. See below. Is that what
> you have in mind? Julien could you test it, please? If it is the right
> approach, I'll submit the patch properly and rename __generic_dma_ops to
> xen_generic_dma_ops or something.

This patch is fixing the bug I encountered.

Cheers,

-- 
Julien Grall
