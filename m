Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34441 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJBrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2018 20:47:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so2385864qkg.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Nov 2018 08:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20181109123730.8743-1-vincenzo.frascino@arm.com> <20181109123730.8743-7-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-7-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Nov 2018 17:05:31 +0100
Message-ID: <CAK8P3a3yu_ZOCxDhGvPnff45jEkEMcQ-KuX5Otqfzfi52kd+tA@mail.gmail.com>
Subject: Re: [PATCH 06/27] kernel: Define gettimeofday vdso common code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com, pcc@google.com
Message-ID: <20181109160531.zexGq_C8BIWCeZBS3E_1DX_vQC5yfMd956FuxChykwI@z>

On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> +/*
> + * To avoid performance issues __u_vdso (unsigned vdso type) depends
> + * on the architecture:
> + * 32 bit only __u_vdso is defined as __u32
> + * 64 bit plus compat __u_vdso is defined as __u64
> + */
> +#ifdef CONFIG_GENERIC_VDSO_32
> +typedef __u32 __u_vdso;
> +#else
> +typedef __u64 __u_vdso;
> +#endif /* CONFIG_GENERIC_VDSO_32 */
> +
>  struct vdso_data {
> -       __u64 cs_cycle_last;    /* Timebase at clocksource init */
> -       __u64 raw_time_sec;     /* Raw time */
> +       __u64 cs_cycle_last;            /* Timebase at clocksource init */
> +       __u_vdso raw_time_sec;          /* Raw time */
>         __u64 raw_time_nsec;
> -       __u64 xtime_clock_sec;  /* Kernel time */
> +       __u_vdso xtime_clock_sec;       /* Kernel time */
>         __u64 xtime_clock_nsec;
> -       __u64 xtime_coarse_sec; /* Coarse time */
> +       __u_vdso xtime_coarse_sec;      /* Coarse time */
>         __u64 xtime_coarse_nsec;
> -       __u64 wtm_clock_sec;    /* Wall to monotonic time */
> +       __u_vdso wtm_clock_sec;         /* Wall to monotonic time */

It looks like you change the layout in a way that makes it incompatible between
32-bit and 64-bit user space. Doesn't that break the compat-vdso code
for 32-bit?

It also seems like we need the seconds to be 64-bit wide, at least
for anything that counts in CLOCK_REALTIME or a related format,
otherwise we have to change it back for y2038 support.

      Arnd
