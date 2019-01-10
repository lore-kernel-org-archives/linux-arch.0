Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbfAJKjg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jan 2019 05:39:36 -0500
Subject: Re: [PATCH v3 18/24] arm64: Add vDSO compat support
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-19-vincenzo.frascino@arm.com>
 <483c4226-b56d-69aa-1638-9f495d801273@android.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <da171bd4-06fd-cebe-1f11-b744e87feff6@arm.com>
Date: Thu, 10 Jan 2019 10:39:31 +0000
MIME-Version: 1.0
In-Reply-To: <483c4226-b56d-69aa-1638-9f495d801273@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salyzyn <salyzyn@android.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190110103931.Gen9gVqZmTy_DTxOPeaA8XmQngy1I6iy3kkufjF1dvw@z>

On 17/12/2018 15:26, Mark Salyzyn wrote:
> On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
>> This patch adds vDSO compat support to the arm64 building system.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   arch/arm64/Kconfig         |  1 +
>>   arch/arm64/Makefile        | 21 +++++++++++++++++++--
>>   arch/arm64/kernel/Makefile |  6 +++++-
>>   3 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index aafa18e2e7c4..ed9c36f0ccb9 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -103,6 +103,7 @@ config ARM64
>>   	select GENERIC_STRNLEN_USER
>>   	select GENERIC_TIME_VSYSCALL
>>   	select GENERIC_GETTIMEOFDAY
>> +	select GENERIC_COMPAT_VDSO
>>   	select HANDLE_DOMAIN_IRQ
>>   	select HARDIRQS_SW_RESEND
>>   	select HAVE_ACPI_APEI if (ACPI && EFI)
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 6cb9fc7e9382..814d2b0ac017 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -49,9 +49,23 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>>     endif
>>   endif
>>   
>> -KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
>> +ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>> +  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
>> +
>> +  ifeq ($(CROSS_COMPILE_ARM32),)
>> +    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
>> +  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
>> +    $(error $(CROSS_COMPILE_ARM32)gcc not found, check CROSS_COMPILE_ARM32)
>> +  else
>> +    export CROSS_COMPILE_ARM32
>> +    export CONFIG_COMPAT_VDSO := y
>> +    compat_vdso := -DCONFIG_COMPAT_VDSO=1
>> +  endif
>> +endif
>> +
>> +KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
>>   KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>> -KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>> +KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
>>   
>>   KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>>   KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
> Does not build with clang
> 
> Do not hard-code gcc, use $(cc-name)
> 

$(cc-name) does not seem a supported function: Documentation/kbuild/makefiles.txt

The way of enabling clang seems via CONFIG_CC_IS_CLANG.

> -- Mark
> 

-- 
Regards,
Vincenzo
