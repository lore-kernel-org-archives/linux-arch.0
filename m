From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in
 vgettimeofday
Date: Thu, 19 Mar 2020 16:58:00 +0000
Message-ID: <78109f4e-c9c7-57b6-079b-c911b6090aa0@arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
 <20200317143834.GC632169@arrakis.emea.arm.com>
 <CALCETrVWPNaJMbYoXbnWsALXKrhHMaePOUvY0DmXpvte8Zz9Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:39026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgCSQ5g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 12:57:36 -0400
In-Reply-To: <CALCETrVWPNaJMbYoXbnWsALXKrhHMaePOUvY0DmXpvte8Zz9Zw@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, "open list:MIPS" <linux-mips@vger.kernel.org>, X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.co>

Hi Andy,

On 3/19/20 3:49 PM, Andy Lutomirski wrote:
> On Tue, Mar 17, 2020 at 7:38 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
>>> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
>>> index 54fc1c2ce93f..91138077b073 100644
>>> --- a/arch/arm64/kernel/vdso32/vgettimeofday.c
>>> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
>>> @@ -8,11 +8,14 @@
>>>  #include <linux/time.h>
>>>  #include <linux/types.h>
>>>
>>> +#define VALID_CLOCK_ID(x) \
>>> +     ((x >= 0) && (x < VDSO_BASES))
>>> +
>>>  int __vdso_clock_gettime(clockid_t clock,
>>>                        struct old_timespec32 *ts)
>>>  {
>>>       /* The checks below are required for ABI consistency with arm */
>>> -     if ((u32)ts >= TASK_SIZE_32)
>>> +     if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
>>>               return -EFAULT;
>>>
>>>       return __cvdso_clock_gettime32(clock, ts);
>>
>> I probably miss something but I can't find the TASK_SIZE check in the
>> arch/arm/vdso/vgettimeofday.c code. Is this done elsewhere?
>>
> 
> Can you not just remove the TASK_SIZE_32 check entirely?  If you pass
> a garbage address to the vDSO, you are quite likely to get SIGSEGV.
> Why does this particular type of error need special handling?
> 

In this particular case the system call and the vDSO library as it stands
returns -EFAULT on all the architectures that support the vdso library except on
arm64 compat. The reason why it does not return the correct error code, as I was
discussing with Catalin, it is because arm64 uses USER_DS (addr_limit set
happens in arch/arm64/kernel/entry.S), which is defined as (1 << VA_BITS), as
access_ok() validation even on compat tasks and since arm64 supports up to 52bit
VA, this does not detect the end of the user address space for a 32 bit task.
Hence when we fall back on the system call we get the wrong error code out of it.

According to me to have ABI consistency we need this check, but if we say that
we can make an ABI exception in this case, I am fine with that either if it has
enough consensus.

Please let me know your thoughts.

-- 
Regards,
Vincenzo
