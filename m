Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40982 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEJmw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 04:42:52 -0500
MIME-Version: 1.0
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com> <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com> <20191204161641.GA28130@roeck-us.net>
 <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com>
In-Reply-To: <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 5 Dec 2019 10:42:40 +0100
Message-ID: <CAAdtpL71ED3zbkHMqtd1XFQwToOctWJpy2WPqahxHR81fKdTkg@mail.gmail.com>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing crash)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, open list <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>
Message-ID: <20191205094240.RD3QTtsYbT3H88OLBeIQpL5fK0fEUP19yKR6EtvadPo@z>

On Wed, Dec 4, 2019 at 6:23 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 12/4/19 4:16 PM, Guenter Roeck wrote:
[...]
> --->8---
>
> Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Date:   Wed Dec 4 16:58:55 2019 +0000
>
>     arm: Fix __arch_get_hw_counter() access to CNTVCT
>
>     __arch_get_hw_counter() should check clock_mode to see if it can access
>     CNTVCT. With the conversion to unified vDSO this check has been left out.
>
>     This causes on imx v6 and v7 (imx_v6_v7_defconfig) and other platforms to
>     hang at boot during the execution of the init process as per below:
>
>     [   19.976852] Run /sbin/init as init process
>     [   20.044931] Kernel panic - not syncing: Attempted to kill init!
>     exitcode=0x00000004
>
>     Fix the problem verifying that clock_mode is set coherently before
>     accessing CNTVCT.
>
>     Cc: Russell King <linux@armlinux.org.uk>
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>     Investigated-by: Arnd Bergmann <arnd@arndb.de>

There are only 2 "Investigated-by" vs 7k+ "Suggested-by"... Is there a
real difference?

>     Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> diff --git a/arch/arm/include/asm/vdso/gettimeofday.h
> b/arch/arm/include/asm/vdso/gettimeofday.h
> index 5b879ae7afc1..0ad2429c324f 100644
> --- a/arch/arm/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm/include/asm/vdso/gettimeofday.h
> @@ -75,6 +75,9 @@ static __always_inline u64 __arch_get_hw_counter(int clock_mode)
>  #ifdef CONFIG_ARM_ARCH_TIMER
>         u64 cycle_now;
>
> +       if (!clock_mode)
> +               return -EINVAL;
> +

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>         isb();
>         cycle_now = read_sysreg(CNTVCT);
>
>
