Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:41060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSJtx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jul 2019 05:49:53 -0400
Subject: Re: [PATCH] arm64: vdso: Cleanup Makefiles.
References: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
 <20190718114121.33024-1-vincenzo.frascino@arm.com>
 <20190719080435.f3nlecyu3ysnsnpv@willie-the-truck>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <867d5696-6784-20ee-79cc-8a2bf39431f9@arm.com>
Date: Fri, 19 Jul 2019 10:49:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190719080435.f3nlecyu3ysnsnpv@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, john.stultz@linaro.org, naohiro.aota@wdc.com, yamada.masahiro@socionext.com
Message-ID: <20190719094948.b9LmOetiz6rzE8JQI9vPdYOi8TBEHSqzmTJx9DXwaSI@z>

Hi Will,

On 19/07/2019 09:04, Will Deacon wrote:
> On Thu, Jul 18, 2019 at 12:41:21PM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
>> index 21009ed5a755..6c4e496309c4 100644
>> --- a/arch/arm64/kernel/vdso32/Makefile
>> +++ b/arch/arm64/kernel/vdso32/Makefile
>> @@ -155,17 +155,17 @@ $(asm-obj-vdso): %.o: %.S FORCE
>>  	$(call if_changed_dep,vdsoas)
>>  
>>  # Actual build commands
>> -quiet_cmd_vdsold_and_vdso_check = LD      $@
>> +quiet_cmd_vdsold_and_vdso_check = VDSOLIB $@
>>        cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)
>>  
>> -quiet_cmd_vdsold = VDSOL   $@
>> +quiet_cmd_vdsold = VDSOLD  $@
> 
> I think we should be more consistent about whether or not we prefix things
> with VDSO, so either go with "VDSOLD, VDSOCC and VDSOAS" or stick to "LD,
> CC and AS" rather than mixing between them.
> 
> I think my suggestion would be something along the lines of CC, LD, AS for
> the native vdso and CC32, LD32, AS32 for the compat vdso.
> 

Sounds good. I will send v2 accordingly.

> Will
> 

-- 
Regards,
Vincenzo
