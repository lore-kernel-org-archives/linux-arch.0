Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34676 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLABjO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Nov 2018 20:39:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so6102032qtp.1
        for <linux-arch@vger.kernel.org>; Fri, 30 Nov 2018 06:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 30 Nov 2018 15:29:25 +0100
Message-ID: <CAK8P3a1hmsf2CKWfQ60aUQMoC1YxWhkRKY3GBRusGnQ2cDCJpQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181130142925.8kEF0sSjFenZ_DFkkzjNfy1hlT7NDUY-2rbvipW38VA@z>

On Thu, Nov 29, 2018 at 11:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> > +if HAVE_GENERIC_VDSO
> > +
> > +config GENERIC_GETTIMEOFDAY
> > +     bool
> > +     help
> > +       This is a generic implementation of gettimeofday vdso.
> > +       Each architecture that enables this feature has to
> > +       provide the fallback implementation.
> > +
> > +config GENERIC_VDSO_32
> > +     bool
> > +     depends on GENERIC_GETTIMEOFDAY && !64BIT
> > +     help
> > +       This config option helps to avoid possible performance issues
> > +       in 32 bit only architectures.
> > +
> > +config HAVE_ARCH_TIMER
> > +     bool
> > +     depends on GENERIC_GETTIMEOFDAY
> > +     help
> > +       Select this configuration option if the architecture has an arch
> > +       timer.
>
> Please don't add code which is architecture specific to the generic
> implementation. There is really no reason to make ARCH_TIMER special.

I think it's just unfortunate naming based on what arm64 had, but
conceptually it does the right thing, and just disable the clock_gettime
fastpath on kernel builds that never have access to a clocksource
from user space.

> > +static notrace int __cvdso_clock_getres(clockid_t clock_id,
> > +                                     struct __vdso_timespec *res)
> > +{
> > +     u64 ns;
> > +
> > +     if (!__arch_valid_arg(res))
> > +             return -EFAULT;
> > +
> > +     if (clock_id == CLOCK_REALTIME ||
> > +         clock_id == CLOCK_TAI ||
> > +         clock_id == CLOCK_BOOTTIME ||
> > +         clock_id == CLOCK_MONOTONIC ||
> > +         clock_id == CLOCK_MONOTONIC_RAW)
> > +             ns = MONOTONIC_RES_NSEC;
>
> This is wrong. You cannot unconditionally set that. See what the syscall
> based version does. You always need to verify that the syscall version and
> the vdso version return the same information and not something randomly
> different.

Do you think we actually need the fastpath here? If not, the
easy way to do it would be to always fall back to calling
the syscall based version. Or was this originally added
to deal with the syscall and vdso clock_gettime having
different resolutions (which would sound like a bad idea, but
might have to stay for compatibility)?

      Arnd
