Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46566 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfB1MJ0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Feb 2019 07:09:26 -0500
Subject: Re: [PATCH v5 00/23] Unify vDSOs across more architectures
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <CAK8P3a1Q1uMFLs6eq26Rkv8hQdu0FkPUoq0gDnZPju-Eu1oHgQ@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b02ee1da-e756-f7c7-ad8d-944b9b9e56e0@arm.com>
Date: Thu, 28 Feb 2019 12:09:21 +0000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Q1uMFLs6eq26Rkv8hQdu0FkPUoq0gDnZPju-Eu1oHgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190228120921._e55pJKyKYo96kAd1LwrLZ5F6NTtgOA8muy9083-pvY@z>

Hi Arnd,

thank you for testing my code.

On 28/02/2019 11:40, Arnd Bergmann wrote:
> On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> vDSO (virtual dynamic shared object) is a mechanism that the Linux
>> kernel provides as an alternative to system calls to reduce where
>> possible the costs in terms of cycles.
>> This is possible because certain syscalls like gettimeofday() do
>> not write any data and return one or more values that are stored
>> in the kernel, which makes relatively safe calling them directly
>> as a library function.
> 
> I tried applying the series on top of v5.0-rc7, and got a set of
> build warnings with arm64 defconfig:
> 
> In file included from /git/arm-soc/arch/arm64/include/asm/thread_info.h:30:0,
>                  from /git/arm-soc/include/linux/thread_info.h:38,
>                  from /git/arm-soc/arch/arm64/include/asm/preempt.h:5,
>                  from /git/arm-soc/include/linux/preempt.h:78,
>                  from /git/arm-soc/include/linux/spinlock.h:51,
>                  from /git/arm-soc/include/linux/seqlock.h:36,
>                  from /git/arm-soc/include/linux/time.h:6,
>                  from /git/arm-soc/lib/vdso/gettimeofday.c:7,
>                  from <command-line>:0:
> /git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘kaslr_offset’:
> /git/arm-soc/arch/arm64/include/asm/memory.h:191:2: warning: left
> shift count >= width of type [enabled by default]
>   return kimage_vaddr - KIMAGE_VADDR;
>   ^
> /git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘virt_to_phys’:
> /git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
> shift count >= width of type [enabled by default]
>   return __virt_to_phys((unsigned long)(x));
>   ^
> /git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
> shift count >= width of type [enabled by default]
> /git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘phys_to_virt’:
> /git/arm-soc/arch/arm64/include/asm/memory.h:289:2: warning: left
> shift count >= width of type [enabled by default]
>   return (void *)(__phys_to_virt(x));
>   ^
> In file included from /git/arm-soc/arch/arm64/include/asm/pgtable-hwdef.h:19:0,
>                  from /git/arm-soc/arch/arm64/include/asm/processor.h:46,
>                  from /git/arm-soc/arch/arm64/include/asm/elf.h:129,
>                  from /git/arm-soc/include/linux/elf.h:5,
>                  from /git/arm-soc/include/linux/elfnote.h:62,
>                  from /git/arm-soc/arch/arm64/kernel/vdso32/note.c:11:
> /git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘kaslr_offset’:
> /git/arm-soc/arch/arm64/include/asm/memory.h:191:2: warning: left
> shift count >= width of type [enabled by default]
>   return kimage_vaddr - KIMAGE_VADDR;
>   ^
> /git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘virt_to_phys’:
> /git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
> shift count >= width of type [enabled by default]
>   return __virt_to_phys((unsigned long)(x));
>   ^
> /git/arm-soc/arch/arm64/include/asm/memory.h:283:2: warning: left
> shift count >= width of type [enabled by default]
> /git/arm-soc/arch/arm64/include/asm/memory.h: In function ‘phys_to_virt’:
> /git/arm-soc/arch/arm64/include/asm/memory.h:289:2: warning: left
> shift count >= width of type [enabled by default]
>   return (void *)(__phys_to_virt(x));
>   ^
> 
> I think this is all harmless, but we need to limit the set of header files
> that can be included indirectly when compiling the vdso in arm32 mode.
> 

I agree with you on the principle, but I am unable to replicate the warnings.
Did you make any customization to the default defconfig? What is the top
commit-id you have on your tree?

>        Arnd
> 

-- 
Regards,
Vincenzo
