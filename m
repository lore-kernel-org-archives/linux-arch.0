From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/31] nds32: VDSO support
Date: Wed, 8 Nov 2017 10:37:52 +0100
Message-ID: <CAK8P3a2BDfCLg6J5qmAFD86ZoxzXLNrXO8UTfkvScws=R-T5jw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <0911917e908c7648d25b33663afc88f5aca6bb4d.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:54794 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdKHJhx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 04:37:53 -0500
In-Reply-To: <0911917e908c7648d25b33663afc88f5aca6bb4d.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Palmer Dabbelt <palmer@dabbelt.com>, Deepa Dinamani <deepa.kernel@gmail.com>

On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:

> --- /dev/null
> +++ b/arch/nds32/include/asm/vdso_datapage.h
> @@ -0,0 +1,51 @@

> +#ifndef __ASM_VDSO_DATAPAGE_H
> +#define __ASM_VDSO_DATAPAGE_H
> +
> +#ifdef __KERNEL__
> +
> +#ifndef __ASSEMBLY__
> +
> +struct vdso_data {
> +       bool cycle_count_down;  /* timer cyclye counter is decrease with time */
> +       u32 cycle_count_offset; /* offset of timer cycle counter register */
> +       u32 seq_count;          /* sequence count - odd during updates */
> +       u32 xtime_coarse_sec;   /* coarse time */
> +       u32 xtime_coarse_nsec;
> +
> +       u32 wtm_clock_sec;      /* wall to monotonic offset */
> +       u32 wtm_clock_nsec;
> +       u32 xtime_clock_sec;    /* CLOCK_REALTIME - seconds */
> +       u32 cs_mult;            /* clocksource multiplier */
> +       u32 cs_shift;           /* Cycle to nanosecond divisor (power of two) */
> +
> +       u64 cs_cycle_last;      /* last cycle value */
> +       u64 cs_mask;            /* clocksource mask */
> +
> +       u64 xtime_clock_nsec;   /* CLOCK_REALTIME sub-ns base */
> +       u32 tz_minuteswest;     /* timezone info for gettimeofday(2) */
> +       u32 tz_dsttime;
> +};

I need some insight from Deepa and Palmer here: to prepare for 64-bit
time_t in the
future, would it make sense to define the vdso to use 64-bit seconds numbers
consistently, and provide vdso symbols that return 64-bit times, having the
glibc convert that to normal timespec values, or should we leave it for now?

For the normal syscalls I think we are better off keeping things consistent
between architectures, but the vdso is architecture specific by definition, so
we may as well use 64-bit times there now (same for risc-v, which still
has time to modify this before the 4.15 release and glibc merge).

> +/*
> + * This controls what symbols we export from the DSO.
> + */
> +VERSION
> +{
> +       LINUX_2.6 {
> +       global:
> +               __kernel_rt_sigreturn;
> +               __vdso_gettimeofday;
> +               __vdso_clock_getres;
> +               __vdso_clock_gettime;
> +       local: *;
> +       };
> +}

I still struggle to understand how symbol versioning is supposed to work
in a vdso (as opposed to a library you compile against), but I think this should
use the version from the kernel that you plan to merge into, i.e. LINUX_4
or LINUX_4_16.

       Arnd
