Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbeKMUS6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Nov 2018 15:18:58 -0500
Subject: Re: [PATCH 06/27] kernel: Define gettimeofday vdso common code
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-7-vincenzo.frascino@arm.com>
 <CAK8P3a3yu_ZOCxDhGvPnff45jEkEMcQ-KuX5Otqfzfi52kd+tA@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c75dc535-7910-f3cb-4c63-802f18f70208@arm.com>
Date: Tue, 13 Nov 2018 10:21:28 +0000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3yu_ZOCxDhGvPnff45jEkEMcQ-KuX5Otqfzfi52kd+tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com, pcc@google.com
Message-ID: <20181113102128.CwFssZ-0JO_i7y7TAgHWMTVy1-iYmmEtjSSwVeYO02o@z>

Hi Arnd,

thank you for reviewing my patches.

On 09/11/2018 16:05, Arnd Bergmann wrote:
> On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> +/*
>> + * To avoid performance issues __u_vdso (unsigned vdso type) depends
>> + * on the architecture:
>> + * 32 bit only __u_vdso is defined as __u32
>> + * 64 bit plus compat __u_vdso is defined as __u64
>> + */
>> +#ifdef CONFIG_GENERIC_VDSO_32
>> +typedef __u32 __u_vdso;
>> +#else
>> +typedef __u64 __u_vdso;
>> +#endif /* CONFIG_GENERIC_VDSO_32 */
>> +
>>  struct vdso_data {
>> -       __u64 cs_cycle_last;    /* Timebase at clocksource init */
>> -       __u64 raw_time_sec;     /* Raw time */
>> +       __u64 cs_cycle_last;            /* Timebase at clocksource init */
>> +       __u_vdso raw_time_sec;          /* Raw time */
>>         __u64 raw_time_nsec;
>> -       __u64 xtime_clock_sec;  /* Kernel time */
>> +       __u_vdso xtime_clock_sec;       /* Kernel time */
>>         __u64 xtime_clock_nsec;
>> -       __u64 xtime_coarse_sec; /* Coarse time */
>> +       __u_vdso xtime_coarse_sec;      /* Coarse time */
>>         __u64 xtime_coarse_nsec;
>> -       __u64 wtm_clock_sec;    /* Wall to monotonic time */
>> +       __u_vdso wtm_clock_sec;         /* Wall to monotonic time */
> 
> It looks like you change the layout in a way that makes it incompatible between
> 32-bit and 64-bit user space. Doesn't that break the compat-vdso code
> for 32-bit?
> 

No, it does not since vdso_data structure is not part of the ABI and the userspace can access the vdso library only via function symbols. There was a proposal some time ago to introduce ABI data structures in the vdso data page but it was rejected [1] and [2].

CONFIG_GENERIC_VDSO_32 is meant to be used in 32 bit only platforms and the rationale behind it is to preserve performances were possible.

[1] https://lkml.org/lkml/2015/9/2/460
[2] https://lkml.org/lkml/2015/9/2/534

> It also seems like we need the seconds to be 64-bit wide, at least
> for anything that counts in CLOCK_REALTIME or a related format,
> otherwise we have to change it back for y2038 support.
> 

I agree with you, we should address the y2038 support here, even if there are some architectures that currently use u32 for CLOCK_REALTIME sec.

>       Arnd
> 

-- 
Regards,
Vincenzo
