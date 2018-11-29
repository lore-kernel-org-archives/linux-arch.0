Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37116 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeK3Htf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Nov 2018 02:49:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so1912024qkd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 Nov 2018 12:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20181129170530.37789-1-vincenzo.frascino@arm.com> <20181129170530.37789-7-vincenzo.frascino@arm.com>
In-Reply-To: <20181129170530.37789-7-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Nov 2018 21:42:35 +0100
Message-ID: <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181129204235.vJycSnvpr2f2aoiuianUhcKEj9xp01iFIDBMXqu5l5w@z>

On Thu, Nov 29, 2018 at 6:06 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +/*
> + * The definitions below are required to overcome the limitations
> + * of time_t on 32 bit architectures, which overflows in 2038.
> + * The new code should use the replacements based on time64_t and
> + * timespec64.
> + *
> + * The abstraction below will be updated once the migration to
> + * time64_t is complete.
> + */
> +#ifdef CONFIG_GENERIC_VDSO_32
> +#define __vdso_timespec                old_timespec32
> +#define __vdso_timeval         old_timeval32
> +#else
> +#ifdef ENABLE_COMPAT_VDSO
> +#define __vdso_timespec                old_timespec32
> +#define __vdso_timeval         old_timeval32
> +#else
> +#define __vdso_timespec                __kernel_timespec
> +#define __vdso_timeval         __kernel_old_timeval
> +#endif /* CONFIG_COMPAT_VDSO */
> +#endif /* CONFIG_GENERIC_VDSO_32 */
>

Have you considered doing this in the reverse way, by including
the common parts from multiple implementations (32 and 64
bit), instead of compiling the same source file multiple
times with different macros set? I think that would make it
easier to understand.

> +
> +#ifdef CONFIG_HAVE_ARCH_TIMER
> +static __always_inline notrace int __do_realtime_or_tai(
> +               const struct vdso_data *vd,
> +               struct __vdso_timespec *ts,
> +               bool is_tai)
> +{
> +       u32 seq, cs_mono_mult, cs_shift;
> +       u64 ns, sec;
> +       u64 cycle_last, cs_mono_mask;
> +
> +       if (vd->use_syscall)
> +               return -1;
> +repeat:

Maybe instead of the #ifdef, do it like

     if (!IS_ENABLED(CONFIG_HAVE_ARCH_TIMER) ||
         vd->use_syscall)
                return -1;

> +static notrace int __cvdso_clock_gettime(clockid_t clock,
> +                                        struct __vdso_timespec *ts)
> +{
> +       const struct vdso_data *vd = __arch_get_vdso_data();
> +
> +       if (!__arch_valid_arg(ts))
> +               return -EFAULT;
> +
> +       switch (clock) {
> +       case CLOCK_REALTIME:
> +               if (do_realtime(vd, ts))
> +                       goto fallback;
> +               break;
> +       case CLOCK_TAI:
> +               if (do_tai(vd, ts))
> +                       goto fallback;
> +               break;
> +       case CLOCK_MONOTONIC:
> +               if (do_monotonic(vd, ts))
> +                       goto fallback;
> +               break;
> +       case CLOCK_MONOTONIC_RAW:
> +               if (do_monotonic_raw(vd, ts))
> +                       goto fallback;
> +               break;

Please sync this up with the latest x86 version in
arch/x86/entry/vdso/vclock_gettime.c, that version has
seen a lot of improvements recently, so I'd recommend
using a copy of that file as the base, and then
modifying it as needed to make it work on the other
architectures.

      Arnd
