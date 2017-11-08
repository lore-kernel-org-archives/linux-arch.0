From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 16/31] nds32: VDSO support
Date: Wed, 8 Nov 2017 12:00:35 -0800
Message-ID: <CABeXuvoJyQxXaCGyu-9fw-E32hHMgpZ0x1njbM1O5znCr1audA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <0911917e908c7648d25b33663afc88f5aca6bb4d.1510118606.git.green.hu@gmail.com>
 <CAK8P3a2BDfCLg6J5qmAFD86ZoxzXLNrXO8UTfkvScws=R-T5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:50247 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdKHUAh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 15:00:37 -0500
In-Reply-To: <CAK8P3a2BDfCLg6J5qmAFD86ZoxzXLNrXO8UTfkvScws=R-T5jw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Palmer Dabbelt <palmer@dabbelt.com>

On Wed, Nov 8, 2017 at 1:37 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> --- /dev/null
>> +++ b/arch/nds32/include/asm/vdso_datapage.h
>> @@ -0,0 +1,51 @@
>
>> +#ifndef __ASM_VDSO_DATAPAGE_H
>> +#define __ASM_VDSO_DATAPAGE_H
>> +
>> +#ifdef __KERNEL__
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +struct vdso_data {
>> +       bool cycle_count_down;  /* timer cyclye counter is decrease with time */
>> +       u32 cycle_count_offset; /* offset of timer cycle counter register */
>> +       u32 seq_count;          /* sequence count - odd during updates */
>> +       u32 xtime_coarse_sec;   /* coarse time */
>> +       u32 xtime_coarse_nsec;
>> +
>> +       u32 wtm_clock_sec;      /* wall to monotonic offset */
>> +       u32 wtm_clock_nsec;
>> +       u32 xtime_clock_sec;    /* CLOCK_REALTIME - seconds */
>> +       u32 cs_mult;            /* clocksource multiplier */
>> +       u32 cs_shift;           /* Cycle to nanosecond divisor (power of two) */
>> +
>> +       u64 cs_cycle_last;      /* last cycle value */
>> +       u64 cs_mask;            /* clocksource mask */
>> +
>> +       u64 xtime_clock_nsec;   /* CLOCK_REALTIME sub-ns base */
>> +       u32 tz_minuteswest;     /* timezone info for gettimeofday(2) */
>> +       u32 tz_dsttime;
>> +};
>
> I need some insight from Deepa and Palmer here: to prepare for 64-bit
> time_t in the
> future, would it make sense to define the vdso to use 64-bit seconds numbers
> consistently, and provide vdso symbols that return 64-bit times, having the
> glibc convert that to normal timespec values, or should we leave it for now?

Other architectures also have a similar way of defining these as u32
(eg: x86) I think for performance reasons on 32 bit systems.
u32 still works until 2106 as the timekeeping structures are s64. I
was planning to leave it that way for x86.
If this architecture can live with u64, then it will be better to use it here.

> For the normal syscalls I think we are better off keeping things consistent
> between architectures, but the vdso is architecture specific by definition, so
> we may as well use 64-bit times there now (same for risc-v, which still
> has time to modify this before the 4.15 release and glibc merge).

But, I don't think this vdso can return 64 bit times without syscalls
for the architecture also supporting that. The problem is that all
fallback paths depend on syscalls directly.
Also I couldn't find any arch specific handling of vdso interfaces in
glibc. I think they expect the vdso wrappers in the kernel to handle
this part.

-Deepa
