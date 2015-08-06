From: Juergen Gross <jgross@suse.com>
Subject: Re: [Patch V6 12/16] mm: provide early_memremap_ro to establish
 read-only mapping
Date: Thu, 6 Aug 2015 15:02:09 +0200
Message-ID: <55C35AD1.7010101@suse.com>
References: <1437108697-4115-1-git-send-email-jgross@suse.com>
 <1437108697-4115-13-git-send-email-jgross@suse.com>
 <55C3573B.6020509@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42098 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbHFNCM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Aug 2015 09:02:12 -0400
In-Reply-To: <55C3573B.6020509@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-arch@vger.kernel.org

On 08/06/2015 02:46 PM, Vlastimil Babka wrote:
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
>
> So the function is declared unconditionally...
>
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
>
> ... here we provide a implementation when both CONFIG_MMU and
> FIXMAP_PAGE_RO are defined...
>
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
>
> ... and here for !CONFIG_MMU.
>
> So, what about CONFIG_MMU && !FIXMAP_PAGE_RO combinations? Which
> translates to CONFIG_MMU && !PAGE_KERNEL_RO. Maybe they don't exist, but
> then it's still awkward to see the combination in the code left
> unimplemented.

At least there are some architectures without #define PAGE_KERNEL_RO but
testing CONFIG_MMU (arm, m68k, xtensa).

> Would it be perhaps simpler to assume the same thing as in
> drivers/base/firmware_class.c ?
>
> /* Some architectures don't have PAGE_KERNEL_RO */
> #ifndef PAGE_KERNEL_RO
> #define PAGE_KERNEL_RO PAGE_KERNEL
> #endif
>
> Or would it be dangerous here to silently lose the read-only protection?

The only reason to use this function instead of early_memremap() is the
mandatory read-only mapping. My intention was to let the build fail in
case it is being used but not implemented. An architecture requiring the
function but having no PAGE_KERNEL_RO still can define FIXMAP_PAGE_RO.


Juergen
