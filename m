Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeLKOPm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Dec 2018 09:15:42 -0500
Subject: Re: [PATCH v2 24/28] arm: Add support for generic vDSO
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-25-vincenzo.frascino@arm.com>
 <1f5de1a7-04f0-152f-03ad-e581b0ec1b17@android.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <496b17ae-c6b1-92f4-201b-8420005ad6c6@arm.com>
Date: Tue, 11 Dec 2018 14:15:38 +0000
MIME-Version: 1.0
In-Reply-To: <1f5de1a7-04f0-152f-03ad-e581b0ec1b17@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salyzyn <salyzyn@android.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181211141538.RhYPrEPhM0-NsC6m7fcnbbPsY920QPrFY3ccyB-JX_E@z>

Hi Marc,

thank you very much for testing this set. I really appreciate it.

On 10/12/2018 22:13, Mark Salyzyn wrote:
> On 11/29/2018 09:05 AM, Vincenzo Frascino wrote:
>> The arm vDSO library requires some adaptations to use to take advantage
>> of the newly introduced generic vDSO library.
> Tested-by? Would like to note that this patch series up to 24/28 was 
> back-ported to android-4.9 and worked successfully on a Hikey arm64 device.
> 

I will add you as Tested-by in the next version of the patches. I am going to
re-issue a v3 based on the comments that Arnd and Thomas provided. Would you be
interested in testing it as well? If so I can integrate the support for clang
based on what your are suggesting below to make it more straight forward for
you. Let me know.

> Only significant change was to add back support for clang in 
> arch/arm64/Makefile (pseudo patch):
> 
>   ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>     CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
> 
>     ifeq ($(CROSS_COMPILE_ARM32),)
>       $(error CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO 
> will not be built)
> +   else ifeq ($(cc-name),clang)
> +     export CLANG_TRIPLE_ARM32 ?= $(CROSS_COMPILE_ARM32)
> +     export CLANG_TARGET_ARM32 := --target=$(notdir 
> $(CLANG_TRIPLE_ARM32:%-=%))
> +     export CONFIG_COMPAT_VDSO := y
> +     compat_vdso := -DCONFIG_COMPAT_VDSO=1
> -+   else ifeq ($(shell which $(CROSS_COMPILE_ARM32)$(cc-name) 2> 
> /dev/null),)
> -+     $(error $(CROSS_COMPILE_ARM32)$(cc-name) not found, check 
> CROSS_COMPILE_ARM32)
>     else
>       export CROSS_COMPILE_ARM32
>       export CONFIG_COMPAT_VDSO := y
>       compat_vdso := -DCONFIG_COMPAT_VDSO=1
>     endif
>   endif
> 
> -- Mark
> 

-- 
Regards,
Vincenzo
