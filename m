Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDAL1u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 07:27:50 -0400
Subject: Re: [PATCH] arm64: compat: Reduce address limit
References: <20190401103201.9268-1-vincenzo.frascino@arm.com>
 <20190401105913.GC14874@arrakis.emea.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <5b732920-b067-219c-ffd7-3ce99f1b4446@arm.com>
Date: Mon, 1 Apr 2019 12:27:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190401105913.GC14874@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>
Message-ID: <20190401112746.2CiualnaCQeg5KRutPSySF___6bZrR8HlcRE7VjkMWo@z>

On 01/04/2019 11:59, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 11:32:01AM +0100, Vincenzo Frascino wrote:
>> Currently, compat tasks running on arm64 can allocate memory up to
>> TASK_SIZE_32 (UL(0x100000000)).
>>
>> This means that mmap() allocations, if we treat them as returning an
>> array, are not compliant with the sections 6.5.8 of the C standard
>> (C99) which states that: "If the expression P points to an element of
>> an array object and the expression Q points to the last element of the
>> same array object, the pointer expression Q+1 compares greater than P".
>>
>> Redefine TASK_SIZE_32 to address the issue.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Jann Horn <jannh@google.com>
>> Reported-by: Jann Horn <jannh@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/processor.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 5d9ce62bdebd..f8235f7df29b 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -57,7 +57,11 @@
>>  #define TASK_SIZE_64		(UL(1) << vabits_user)
>>  
>>  #ifdef CONFIG_COMPAT
>> +#ifdef CONFIG_ARM64_64K_PAGES
>>  #define TASK_SIZE_32		UL(0x100000000)
>> +#else
>> +#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
>> +#endif /* CONFIG_ARM64_64K_PAGES */
> 
> I'd add a comment above stating that with the 64K page configuration,
> the last page is occupied by the compat vectors page.
> 

Ok, I will post v2 shortly.

-- 
Regards,
Vincenzo
