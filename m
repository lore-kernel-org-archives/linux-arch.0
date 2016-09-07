Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:52800
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751081AbcIGOLo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Sep 2016 10:11:44 -0400
Subject: Re: [RFC PATCH v2 07/20] x86: Provide general kernel support for
 memory encryption
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223646.29880.28794.stgit@tlendack-t1.amdoffice.net>
 <20160902181447.GA25328@nazgul.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <616644bb-6a38-e480-3375-bd39a8487b7d@amd.com>
Date: Wed, 7 Sep 2016 09:11:35 -0500
MIME-Version: 1.0
In-Reply-To: <20160902181447.GA25328@nazgul.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160907141135.ny-DHArUJqnCvSuH6MGGaglHTgHLUeYZv0gYeXUTYb0@z>

On 09/02/2016 01:14 PM, Borislav Petkov wrote:
> On Mon, Aug 22, 2016 at 05:36:46PM -0500, Tom Lendacky wrote:
>> Adding general kernel support for memory encryption includes:
>> - Modify and create some page table macros to include the Secure Memory
>>   Encryption (SME) memory encryption mask
>> - Update kernel boot support to call an SME routine that checks for and
>>   sets the SME capability (the SME routine will grow later and for now
>>   is just a stub routine)
>> - Update kernel boot support to call an SME routine that encrypts the
>>   kernel (the SME routine will grow later and for now is just a stub
>>   routine)
>> - Provide an SME initialization routine to update the protection map with
>>   the memory encryption mask so that it is used by default
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
> 
> ...
> 
>> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
>> index 747fc52..9f3e762 100644
>> --- a/arch/x86/include/asm/mem_encrypt.h
>> +++ b/arch/x86/include/asm/mem_encrypt.h
>> @@ -15,12 +15,21 @@
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> +#include <linux/init.h>
>> +
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>  
>>  extern unsigned long sme_me_mask;
>>  
>>  u8 sme_get_me_loss(void);
>>  
>> +void __init sme_early_init(void);
>> +
>> +#define __sme_pa(x)		(__pa((x)) | sme_me_mask)
>> +#define __sme_pa_nodebug(x)	(__pa_nodebug((x)) | sme_me_mask)
>> +
>> +#define __sme_va(x)		(__va((x) & ~sme_me_mask))
> 
> So I'm wondering: why not push the masking off of the SME mask into the
> __va() macro instead of defining a specific __sme_va() one?
> 
> I mean, do you even see cases where __va() would need to have to
> sme_mask left in the virtual address?
> 
> Because if not, you could mask it out in __va() so that all __va() users
> get the "clean" va, without the enc bits.

That's a good point, yes, it could go in __va().  I'll make that change.

> 
> Hmmm.
> 
> Btw, this patch is huuuge. It would be nice if you could split it, if
> possible...

Ok, I'll look at how to make this a bit more manageable.

Thanks,
Tom

> 
> Thanks.
> 
