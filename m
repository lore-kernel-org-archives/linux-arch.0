Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:39904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750815AbdE3UH0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 May 2017 16:07:26 -0400
Subject: Re: [PATCH v5 26/32] x86, drm, fbdev: Do not specify encrypted memory
 for video mappings
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212056.10190.25468.stgit@tlendack-t1.amdoffice.net>
 <20170516173541.q2rbh5dhkluzsjae@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <766ddfd1-d1fe-213f-1720-5e10356398f0@amd.com>
Date: Tue, 30 May 2017 15:07:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170516173541.q2rbh5dhkluzsjae@pd.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170530200705.I9VzP4YMDNQNv8vbckyNzKVdgwLW5_4ZMMbCFjtnikg@z>

On 5/16/2017 12:35 PM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:20:56PM -0500, Tom Lendacky wrote:
>> Since video memory needs to be accessed decrypted, be sure that the
>> memory encryption mask is not set for the video ranges.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/include/asm/vga.h       |   13 +++++++++++++
>>   arch/x86/mm/pageattr.c           |    2 ++
>>   drivers/gpu/drm/drm_gem.c        |    2 ++
>>   drivers/gpu/drm/drm_vm.c         |    4 ++++
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c  |    7 +++++--
>>   drivers/gpu/drm/udl/udl_fb.c     |    4 ++++
>>   drivers/video/fbdev/core/fbmem.c |   12 ++++++++++++
>>   7 files changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/vga.h b/arch/x86/include/asm/vga.h
>> index c4b9dc2..5c7567a 100644
>> --- a/arch/x86/include/asm/vga.h
>> +++ b/arch/x86/include/asm/vga.h
>> @@ -7,12 +7,25 @@
>>   #ifndef _ASM_X86_VGA_H
>>   #define _ASM_X86_VGA_H
>>   
>> +#include <asm/cacheflush.h>
>> +
>>   /*
>>    *	On the PC, we can just recalculate addresses and then
>>    *	access the videoram directly without any black magic.
>> + *	To support memory encryption however, we need to access
>> + *	the videoram as decrypted memory.
>>    */
>>   
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +#define VGA_MAP_MEM(x, s)					\
>> +({								\
>> +	unsigned long start = (unsigned long)phys_to_virt(x);	\
>> +	set_memory_decrypted(start, (s) >> PAGE_SHIFT);		\
>> +	start;							\
>> +})
>> +#else
>>   #define VGA_MAP_MEM(x, s) (unsigned long)phys_to_virt(x)
>> +#endif
> 
> Can we push the check in and save us the ifdeffery?
> 
> #define VGA_MAP_MEM(x, s)                                       \
> ({                                                              \
>          unsigned long start = (unsigned long)phys_to_virt(x);   \
>                                                                  \
>          if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))                 \
>                  set_memory_decrypted(start, (s) >> PAGE_SHIFT); \
>                                                                  \
>          start;                                                  \
> })
> 
> It does build here. :)
> 

That works for me and it's a lot cleaner.  I'll make the change.

Thanks,
Tom
