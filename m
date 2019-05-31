Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46086 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:32:39 -0400
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-17-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-17-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2019 10:32:22 +0200
Message-ID: <CAK8P3a0gKJX0fAdizNoO3r-UzAoN0Nf=gkMmw++wuryjHy3-8w@mail.gmail.com>
Subject: Re: [PATCH v6 16/19] arm: Add support for generic vDSO
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190531083222.tn8sNoYRuT5cSGmC1Lhhf63Gm3fsHe4TWWuoPdN7elY@z>

On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
> new file mode 100644
> index 000000000000..eeeb319840ba
> --- /dev/null
> +++ b/arch/arm/include/asm/vdso/gettimeofday.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 ARM Limited
> + */
> +#ifndef __ASM_VDSO_GETTIMEOFDAY_H
> +#define __ASM_VDSO_GETTIMEOFDAY_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/barrier.h>
> +#include <asm/cp15.h>
> +#include <asm/unistd.h>
> +#include <uapi/linux/time.h>
> +
> +#ifndef CONFIG_AEABI
> +#error This code depends on AEABI system call conventions
> +#endif

Instead of an #error here, I would use a Kconfig conditional and make it

'select HAVE_GENERIC_VDSO if AEABI'

> diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
> index 89ca89f12d23..05581140fd12 100644
> --- a/arch/arm/vdso/vdso.lds.S
> +++ b/arch/arm/vdso/vdso.lds.S
> @@ -82,6 +82,8 @@ VERSION
>         global:
>                 __vdso_clock_gettime;
>                 __vdso_gettimeofday;
> +               __vdso_clock_getres;
> +               __vdso_clock_gettime64;
>         local: *;
>         };

Why are you adding __vdso_clock_getres here? I would probably
leave the addition of the new entry point(s) for a separate patch
at the end, adding __vdso_clock_gettime64 to all 32-bit ABIs
at once, since while that part is a trivial change, it's also user
visible and deserves its own changelog text.

     Arnd
