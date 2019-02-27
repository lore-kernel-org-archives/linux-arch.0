Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfB0OwW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Feb 2019 09:52:22 -0500
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1f9b21cd-81f5-dfa9-70fb-af8228195cb4@arm.com>
Date: Wed, 27 Feb 2019 14:52:17 +0000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190227145217.LhwSK-JMfnatyPnNChy2UVfiUey6PSlNZiRyijzVhsU@z>

Hi Arnd,

thank you for your review.

On 22/02/2019 13:49, Arnd Bergmann wrote:
> On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> 
>> +/*
>> + * The definitions below are required to overcome the limitations
>> + * of time_t on 32 bit architectures, which overflows in 2038.
>> + * The new code should use the replacements based on time64_t and
>> + * timespec64.
>> + *
>> + * The abstraction below will be updated once the migration to
>> + * time64_t is complete.
>> + */
>> +#ifdef CONFIG_GENERIC_VDSO_32
>> +#define __vdso_timespec                old_timespec32
>> +#define __vdso_timeval         old_timeval32
>> +#else
>> +#ifdef ENABLE_COMPAT_VDSO
>> +#define __vdso_timespec                old_timespec32
>> +#define __vdso_timeval         old_timeval32
>> +#else
>> +#define __vdso_timespec                __kernel_timespec
>> +#define __vdso_timeval         __kernel_old_timeval
>> +#endif /* CONFIG_COMPAT_VDSO */
>> +#endif /* CONFIG_GENERIC_VDSO_32 */
> 
> I don't think we need __vdso_timeval at all, just use
> __kernel_old_timeval everywhere. There is no generic
> 64-bit timeval type in the kernel, and there won't be because
> gettimeofday() is deprecated.
> 

Ok, I will update my implementation accordingly in v6.

> For __vdso_timespec, I see how you ended up with this
> redefinition, and it makes the current version of your patches
> easier, but I fear it will in turn make it harder to add the
> __kernel_old_timeval based variant.
> 

What is __kernel_old_timespec (based on you next email)? Why do you think it
will make harder to add the new variants?

-- 
Regards,
Vincenzo

> What I'd prefer to see here is to always use the fixed length
> types everywhere in the code, such as
> 
> static notrace int __cvdso_clock_gettime64(clockid_t clock,
>                                         struct __kernel_timespec *ts)
> {
> ... /* normal clock_gettime using 64-bit times */
> }
> 
> static notrace int __cvdso_clock_gettime32(clockid_t clock,
>                                         struct old_timespec32 *ts32)
> {
>      struct __kernel_timespec ts;
>      int ret = __cvdso_clock_gettime64(clock, &ts);
> 
>      ts32->tv_sec = ts->tv_sec;
>      ts32->tv_nsec = ts->tv_nsec;
> 
>      return ret;
> }
> 
> and then have two different versions for 32-bit and 64-bit
> architectures, calling one or the other function of the
> generic code.
> 
>         Arnd
> 
