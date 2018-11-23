Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387655AbeKWVca (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Nov 2018 16:32:30 -0500
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C
 implementation
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
 <8e306faf-6261-8363-3f18-70e754fa3a9d@arm.com>
 <CAK8P3a0ht6TjXubYiWaLh96hOGy3FH_K=JJVhQrYV3D+z-JqBA@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f283de36-b620-03f0-b97b-fd63900e33ce@arm.com>
Date: Fri, 23 Nov 2018 10:49:28 +0000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0ht6TjXubYiWaLh96hOGy3FH_K=JJVhQrYV3D+z-JqBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181123104928.jRbUQbADXX0i_A4yVxjOBTOXzdcwzh-8Z3BH3ekR44A@z>


On 11/14/18 5:47 PM, Arnd Bergmann wrote:
> On Tue, Nov 13, 2018 at 2:58 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> On 09/11/2018 16:13, Arnd Bergmann wrote:
> 
>>>> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
>>>> index beca249bc2f3..9de0ffc369c5 100644
>>>> --- a/arch/arm64/kernel/vdso/vdso.lds.S
>>>> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
>>>> @@ -88,6 +88,7 @@ VERSION
>>>>                 __kernel_gettimeofday;
>>>>                 __kernel_clock_gettime;
>>>>                 __kernel_clock_getres;
>>>> +               __kernel_time;
>>>>         local: *;
>>>>         };
>>>>  }
>>>
>>> I would  prefer to not add any deprecated interfaces in the VDSO. If we
>>> have the 64-bit version of clock_gettime, we don't need the 32-bit version
>>> of it, and we don't need gettimeofday() or time() either. The C library
>>> can easily implement those by calling into clock_gettime.
>>>
>>
>> I like the idea, this would make the vdso lib code more simple and more maintainable.
>>
>> In this patchset I tried to cover the widest possible scenario making things configurable: each architecture can select and enable exactly what it needs from the vdso common code.
>>
>> Based on what you are proposing, once the C library will implement things in this way, it will be easy to deprecate and remove the unused code.
> 
> Just to clarify: we can never remove interfaces that an older version of the
> C library was using. What I'm asking is that we don't introduce any of the
> unnecessary ones for architectures that don't already have them.
> 

I agree, I realize now I should have worded my answer differently. With
"deprecate and remove the unused code" was referring to redirect gettimeofday
through clock_gettime, not to remove completely gettimeofday interface since
this would cause userspace breakage for old C libraries as you are pointing out
as well.

>> I am not familiar with the development plans of the various C libraries, but looking at
>> bionic libc currently seems using all the vdso exposed functions [1].
>>
>> [1] https://github.com/aosp-mirror/platform_bionic/blob/master/libc/bionic/vdso.cpp
> 
> It looks like this implementation checks for each one of them to be present
> first and then uses a fallback implementation if it does not exist. This would
> clearly let us remove the handlers we don't want to support, but there
> are two possible downsides:
>> - some other libc might be lacking that fallback path
> - the fallback might be much slower, e.g. time() should fallback to
>   the vdso version of clock_gettime(CLOCK_REALTIME_COARSE) for
>   best performance, rather than the time() syscall or CLOCK_REALTIME.
> 
> So I'd argue that if an architecture already has a time() vdso implementation,
> we probably want to keep that entry point but make it point to the best
> generic implementation (i.e. clock_gettime CLOCK_REALTIME_COARSE).

What I was trying to point out here is that if the symbol is present in the vdso
library the C library implementation tends to prefer to use it.

Said that, I agree with what you are saying and in this first iteration I will
make sure that we do not add new symbols for the architectures that did not
support them previously, but I will keep the library the most generic possible,

I would prefer though to introduce the redirection for gettimeofday() and time()
to the best performing clock_gettime() at a later stage (and with a separate
patchset) because it would involve some cleanup in the vdso.c of the
architectures that would use the library (i.e. update_vsyscall_tz() not required
anymore) and because based on what I measured with a quick test the performance
difference seems small with the current implementation of the library.


> 
>       Arnd
> 

-- 
Regards,
Vincenzo
