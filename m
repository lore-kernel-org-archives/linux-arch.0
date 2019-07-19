From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH] arm64: vdso: Cleanup Makefiles.
Date: Fri, 19 Jul 2019 10:49:48 +0100
Message-ID: <867d5696-6784-20ee-79cc-8a2bf39431f9@arm.com>
References: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
 <20190718114121.33024-1-vincenzo.frascino@arm.com>
 <20190719080435.f3nlecyu3ysnsnpv@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719080435.f3nlecyu3ysnsnpv@willie-the-truck>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, john.stultz@linaro.org, naohiro.aota@wdc.com, yamada.masahiro@socionext.com
List-Id: linux-arch.vger.kernel.org

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
