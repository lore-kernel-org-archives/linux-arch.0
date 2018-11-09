Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42648 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeKJBzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2018 20:55:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id m5so2435251qka.9
        for <linux-arch@vger.kernel.org>; Fri, 09 Nov 2018 08:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20181109123730.8743-1-vincenzo.frascino@arm.com> <20181109123730.8743-8-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-8-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Nov 2018 17:13:29 +0100
Message-ID: <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com, pcc@google.com
Message-ID: <20181109161329.fLoT3wJXRJEt1Yyv4NFuMvLdsVdM0O6OGtSVpjTm3Vc@z>

> +
> +extern struct vdso_data _vdso_data;
> +
> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
> +                                                        struct timezone *_tz)

I'm trying to get rid of the last users of 'struct timeval' in the kernel so
we can remove the definition (it will clash with future glibc implementations
in the uapi headers). Could you change this to use __kernel_old_timeval
instead?

> +static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
> +                                                          struct timespec *_ts)

And this should be __kernel_timespec respectively on the kernel-user interface,
at least for 64-bit architectures.

On 32-bit, the corresponding type is 'struct old_timespec32'.

> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index beca249bc2f3..9de0ffc369c5 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -88,6 +88,7 @@ VERSION
>                 __kernel_gettimeofday;
>                 __kernel_clock_gettime;
>                 __kernel_clock_getres;
> +               __kernel_time;
>         local: *;
>         };
>  }

I would  prefer to not add any deprecated interfaces in the VDSO. If we
have the 64-bit version of clock_gettime, we don't need the 32-bit version
of it, and we don't need gettimeofday() or time() either. The C library
can easily implement those by calling into clock_gettime.

> +notrace int __kernel_clock_gettime(clockid_t clock, struct timespec *ts)
> +{
> +       return __cvdso_clock_gettime(clock, ts);
> +}
> +
> +notrace int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz)
> +{
> +       return __cvdso_gettimeofday(tv, tz);
> +}
> +
> +notrace time_t __kernel_time(time_t *time)
> +{
> +       return __cvdso_time(time);
> +}
> +
> +notrace int __kernel_clock_getres(clockid_t clock_id, struct timespec *res)
> +{
> +       return __cvdso_clock_getres(clock_id, res);
> +}
> +

These should use __kernel_old_timeval and __kernel_timespec again.

        Arnd
