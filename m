Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICOuA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 10:50:00 -0400
Subject: Re: [PATCH v2 7/8] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-8-vincenzo.frascino@arm.com>
 <20190903143801.7upetfqe6upouzlh@pburton-laptop>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f783346b-3e33-1bce-f204-f9737ef493e0@arm.com>
Date: Tue, 3 Sep 2019 15:51:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190903143801.7upetfqe6upouzlh@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "salyzyn@android.com" <salyzyn@android.com>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "luto@kernel.org" <luto@kernel.org>
Message-ID: <20190903145132.r_RHaPkrrwKPOD_pvmIWrT9SzJRhqG5iX5ggRIKBcIo@z>

Hi Paul,

On 9/3/19 3:46 PM, Paul Burton wrote:
> Hi Vincenzo,
> 
> On Fri, Aug 30, 2019 at 02:59:01PM +0100, Vincenzo Frascino wrote:
>> VDSO_HAS_32BIT_FALLBACK has been removed from the core since
>> the architectures that support the generic vDSO library have
>> been converted to support the 32 bit fallbacks.
>>
>> Remove unused VDSO_HAS_32BIT_FALLBACK from mips vdso.
>>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Do you want this one in mips-next too, or applied somewhere else along
> with the rest of the series? If the latter:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>
> 

This patch has a dependency on patch n5 hence can not be applied independently.

Thanks,
Vincenzo

> Thanks,
>     Paul
> 
>> ---
>>  arch/mips/include/asm/vdso/gettimeofday.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
>> index e78462e8ca2e..5ad2b086626d 100644
>> --- a/arch/mips/include/asm/vdso/gettimeofday.h
>> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
>> @@ -107,8 +107,6 @@ static __always_inline int clock_getres_fallback(
>>  
>>  #if _MIPS_SIM != _MIPS_SIM_ABI64
>>  
>> -#define VDSO_HAS_32BIT_FALLBACK	1
>> -
>>  static __always_inline long clock_gettime32_fallback(
>>  					clockid_t _clkid,
>>  					struct old_timespec32 *_ts)
>> -- 
>> 2.23.0
>>
