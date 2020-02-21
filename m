From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] clocksource: Fix arm_arch_timer clockmode when vDSO
 disabled
Date: Fri, 21 Feb 2020 14:15:34 +0100
Message-ID: <c2ee91f1-2951-1fc4-d549-106d7b1798e7@samsung.com>
References: <CGME20200221130455eucas1p2aa4312aad606b53add889811d8e9fbc7@eucas1p2.samsung.com>
        <20200221130355.21373-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58076 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgBUNPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:15:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200221131536euoutp0190cff42d53bec9f4969628354d1797be~1bTkjxqN_1773117731euoutp019
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 13:15:36 +0000 (GMT)
In-Reply-To: <20200221130355.21373-1-vincenzo.frascino@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org

Hi,

On 21.02.2020 14:03, Vincenzo Frascino wrote:
> The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
> defined to compile correctly. On arm the vDSO can be disabled and when
> this is the case the compilation ends prematurely with an error:
>
>   $ make ARCH=arm multi_v7_defconfig
>   $ ./scripts/config -d VDSO
>   $ make
>
> drivers/clocksource/arm_arch_timer.c:73:44: error:
> ‘VDSO_CLOCKMODE_ARCHTIMER’ undeclared here (not in a function)
>    static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
>                                               ^
> scripts/Makefile.build:267: recipe for target
> 'drivers/clocksource/arm_arch_timer.o' failed
> make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> scripts/Makefile.build:505: recipe for target 'drivers/clocksource' failed
> make[1]: *** [drivers/clocksource] Error 2
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1683: recipe for target 'drivers' failed
> make: *** [drivers] Error 2
>
> Define VDSO_CLOCKMODE_ARCHTIMER as VDSO_CLOCKMODE_NONE when the vDSOs are
> not enabled to address the issue.
>
> Fixes: 5e3c6a312a09 ("ARM/arm64: vdso: Use common vdso clock mode storage")
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks, this fixes the issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/clocksource/arm_arch_timer.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index ee2420d56f67..619839221f94 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -49,6 +49,11 @@
>   #define CNTV_TVAL	0x38
>   #define CNTV_CTL	0x3c
>   
> +#ifndef CONFIG_GENERIC_GETTIMEOFDAY
> +/* The define below is required because on arm the VDSOs can be disabled */
> +#define VDSO_CLOCKMODE_ARCHTIMER	VDSO_CLOCKMODE_NONE
> +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
> +
>   static unsigned arch_timers_present __initdata;
>   
>   static void __iomem *arch_counter_base;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
