From: Juergen Gross <jgross@suse.com>
Subject: Re: [Patch V6 12/16] mm: provide early_memremap_ro to establish
 read-only mapping
Date: Wed, 29 Jul 2015 11:20:13 +0200
Message-ID: <55B89ACD.2070903@suse.com>
References: <1437108697-4115-1-git-send-email-jgross@suse.com>
 <1437108697-4115-13-git-send-email-jgross@suse.com>
 <55ADCF40.6010903@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33935 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbbG2JUS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Jul 2015 05:20:18 -0400
In-Reply-To: <55ADCF40.6010903@suse.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com

On 07/21/2015 06:49 AM, Juergen Gross wrote:
> Hi MM maintainers,
>
> this patch is the last requiring an ack for the series to go in.
> Could you please comment?

PING?

>
>
> Juergen
>
> On 07/17/2015 06:51 AM, Juergen Gross wrote:
>> During early boot as Xen pv domain the kernel needs to map some page
>> tables supplied by the hypervisor read only. This is needed to be
>> able to relocate some data structures conflicting with the physical
>> memory map especially on systems with huge RAM (above 512GB).
>>
>> Provide the function early_memremap_ro() to provide this read only
>> mapping.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> Acked-by: Konrad Rzeszutek Wilk <Konrad.wilk@oracle.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-mm@kvack.org
>> Cc: linux-arch@vger.kernel.org
>> ---
>>   include/asm-generic/early_ioremap.h |  2 ++
>>   include/asm-generic/fixmap.h        |  3 +++
>>   mm/early_ioremap.c                  | 12 ++++++++++++
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/include/asm-generic/early_ioremap.h
>> b/include/asm-generic/early_ioremap.h
>> index a5de55c..316bd04 100644
>> --- a/include/asm-generic/early_ioremap.h
>> +++ b/include/asm-generic/early_ioremap.h
>> @@ -11,6 +11,8 @@ extern void __iomem *early_ioremap(resource_size_t
>> phys_addr,
>>                      unsigned long size);
>>   extern void *early_memremap(resource_size_t phys_addr,
>>                   unsigned long size);
>> +extern void *early_memremap_ro(resource_size_t phys_addr,
>> +                   unsigned long size);
>>   extern void early_iounmap(void __iomem *addr, unsigned long size);
>>   extern void early_memunmap(void *addr, unsigned long size);
>>
>> diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
>> index f23174f..1cbb833 100644
>> --- a/include/asm-generic/fixmap.h
>> +++ b/include/asm-generic/fixmap.h
>> @@ -46,6 +46,9 @@ static inline unsigned long virt_to_fix(const
>> unsigned long vaddr)
>>   #ifndef FIXMAP_PAGE_NORMAL
>>   #define FIXMAP_PAGE_NORMAL PAGE_KERNEL
>>   #endif
>> +#if !defined(FIXMAP_PAGE_RO) && defined(PAGE_KERNEL_RO)
>> +#define FIXMAP_PAGE_RO PAGE_KERNEL_RO
>> +#endif
>>   #ifndef FIXMAP_PAGE_NOCACHE
>>   #define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
>>   #endif
>> diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
>> index e10ccd2..0cfadaf 100644
>> --- a/mm/early_ioremap.c
>> +++ b/mm/early_ioremap.c
>> @@ -217,6 +217,13 @@ early_memremap(resource_size_t phys_addr,
>> unsigned long size)
>>       return (__force void *)__early_ioremap(phys_addr, size,
>>                              FIXMAP_PAGE_NORMAL);
>>   }
>> +#ifdef FIXMAP_PAGE_RO
>> +void __init *
>> +early_memremap_ro(resource_size_t phys_addr, unsigned long size)
>> +{
>> +    return (__force void *)__early_ioremap(phys_addr, size,
>> FIXMAP_PAGE_RO);
>> +}
>> +#endif
>>   #else /* CONFIG_MMU */
>>
>>   void __init __iomem *
>> @@ -231,6 +238,11 @@ early_memremap(resource_size_t phys_addr,
>> unsigned long size)
>>   {
>>       return (void *)phys_addr;
>>   }
>> +void __init *
>> +early_memremap_ro(resource_size_t phys_addr, unsigned long size)
>> +{
>> +    return (void *)phys_addr;
>> +}
>>
>>   void __init early_iounmap(void __iomem *addr, unsigned long size)
>>   {
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
