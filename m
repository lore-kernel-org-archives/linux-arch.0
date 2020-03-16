From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
Date: Mon, 16 Mar 2020 10:30:04 +0000
Message-ID: <b27428fd-5cd9-ac5b-f11c-894985512f23@arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp> <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316102214.GA5746@lakrids.cambridge.arm.com> <20200316102621.GC3005@mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <20200316102621.GC3005@mbp>
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Will Deacon <will>
List-Id: linux-arch.vger.kernel.org

On 3/16/20 10:26 AM, Catalin Marinas wrote:
> On Mon, Mar 16, 2020 at 10:22:15AM +0000, Mark Rutland wrote:
>> On Mon, Mar 16, 2020 at 09:42:32AM +0000, Vincenzo Frascino wrote:
>>> On 3/15/20 6:30 PM, Catalin Marinas wrote:
>>>> On Fri, Mar 13, 2020 at 03:43:37PM +0000, Vincenzo Frascino wrote:
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/include/asm/vdso/processor.h
>>>>> @@ -0,0 +1,31 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>> +/*
>>>>> + * Copyright (C) 2020 ARM Ltd.
>>>>> + */
>>>>> +#ifndef __ASM_VDSO_PROCESSOR_H
>>>>> +#define __ASM_VDSO_PROCESSOR_H
>>>>> +
>>>>> +#ifndef __ASSEMBLY__
>>>>> +
>>>>> +#include <asm/page-def.h>
>>>>> +
>>>>> +#ifdef CONFIG_COMPAT
>>>>> +#if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
>>>>> +/*
>>>>> + * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
>>>>> + * by the compat vectors page.
>>>>> + */
>>>>> +#define TASK_SIZE_32		UL(0x100000000)
>>>>> +#else
>>>>> +#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
>>>>> +#endif /* CONFIG_ARM64_64K_PAGES */
>>>>> +#endif /* CONFIG_COMPAT */
>>>>
>>>> Just curious, what's TASK_SIZE_32 used for in the vDSO code? You don't
>>>> seem to move TASK_SIZE.
>>>>
>>>
>>> I tried to fine grain the headers as much as I could in order to avoid
>>> unneeded/unwanted inclusions:
>>>  * TASK_SIZE_32 is used to verify ABI consistency on vdso32 (please refer to
>>>    arch/arm64/kernel/vdso32/vgettimeofday.c).
>>>  * TASK_SIZE is not required by the vdso library hence it is not present in
>>>    these headers.
>>
>> It would be worth noting the former point in the commit message, since
>> it can be surprising.
>>
>> I also think it's worth keeping the definitions together if that's easy,
>> as it makes it easier to navigate the codebase, even if TASK_SIZE isn't
>> necessary for the VDSO itself.
> 
> It won't work as TASK_SIZE requires (on arm64) test_thread_flag() which
> can't be made available to the vDSO.
> 

Ups, I did not see this :) luckily I agree ;)

-- 
Regards,
Vincenzo
