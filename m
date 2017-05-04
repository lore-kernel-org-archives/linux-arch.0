Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0083.outbound.protection.outlook.com ([104.47.32.83]:50832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754981AbdEDOeP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 May 2017 10:34:15 -0400
Subject: Re: [PATCH v5 09/32] x86/mm: Provide general kernel support for
 memory encryption
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211754.10190.25082.stgit@tlendack-t1.amdoffice.net>
 <20170427161227.c57dkvghz63pvmu2@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0b6e4055-8e07-3a71-3d52-12b0395c8f04@amd.com>
Date: Thu, 4 May 2017 09:34:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170427161227.c57dkvghz63pvmu2@pd.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170504143409.UqoGaz0QMacrIdeSuPLRf1OuR_3sWLIXqgx1TQMf5qM@z>



On 4/27/2017 11:12 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:17:54PM -0500, Tom Lendacky wrote:
>> Changes to the existing page table macros will allow the SME support to
>> be enabled in a simple fashion with minimal changes to files that use these
>> macros.  Since the memory encryption mask will now be part of the regular
>> pagetable macros, we introduce two new macros (_PAGE_TABLE_NOENC and
>> _KERNPG_TABLE_NOENC) to allow for early pagetable creation/initialization
>> without the encryption mask before SME becomes active.  Two new pgprot()
>> macros are defined to allow setting or clearing the page encryption mask.
>
> ...
>
>> @@ -55,7 +57,7 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
>>  	__phys_addr_symbol(__phys_reloc_hide((unsigned long)(x)))
>>
>>  #ifndef __va
>> -#define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
>> +#define __va(x)			((void *)(__sme_clr(x) + PAGE_OFFSET))
>>  #endif
>>
>>  #define __boot_va(x)		__va(x)
>> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
>> index 7bd0099..fead0a5 100644
>> --- a/arch/x86/include/asm/page_types.h
>> +++ b/arch/x86/include/asm/page_types.h
>> @@ -15,7 +15,7 @@
>>  #define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
>>  #define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
>>
>> -#define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
>> +#define __PHYSICAL_MASK		((phys_addr_t)(__sme_clr((1ULL << __PHYSICAL_MASK_SHIFT) - 1)))
>
> That looks strange: poking SME mask hole into a mask...?

I masked it out here based on a previous comment from Dave Hansen:

   http://marc.info/?l=linux-kernel&m=148778719826905&w=2

I could move the __sme_clr into the individual defines of:

PHYSICAL_PAGE_MASK, PHYSICAL_PMD_PAGE_MASK and PHYSICAL_PUD_PAGE_MASK

Either way works for me.

Thanks,
Tom

>
>>  #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
>>
>>  /* Cast *PAGE_MASK to a signed type so that it is sign-extended if
>
