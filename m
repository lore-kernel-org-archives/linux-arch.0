From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] clocksource: Fix arm_arch_timer clockmode when vDSO
 disabled
Date: Tue, 25 Feb 2020 08:17:09 +0100
Message-ID: <368f9cf7-5d9c-c671-8355-82f0f6e549aa@samsung.com>
References: <CGME20200224151611eucas1p2d5e9492e4497edd18a322fdfc33547bf@eucas1p2.samsung.com>
        <20200224151552.57274-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36855 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgBYHRN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 02:17:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200225071711euoutp02393390631d833d25542a782d0275abc2~2k-yDj4o22728027280euoutp024
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 07:17:11 +0000 (GMT)
In-Reply-To: <20200224151552.57274-1-vincenzo.frascino@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org, maz@kernel.org, Mark.Rutland@arm.com

Hi,

On 24.02.2020 16:15, Vincenzo Frascino wrote:
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
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/clocksource/arm_arch_timer.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> This patch has been rebased and tested on tip/timers/core.
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index ee2420d56f67..d53f4c7ccaae 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -69,7 +69,11 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
>   static bool arch_timer_c3stop;
>   static bool arch_timer_mem_use_virtual;
>   static bool arch_counter_suspend_stop;
> +#ifdef CONFIG_GENERIC_GETTIMEOFDAY
>   static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
> +#else
> +static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
> +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
>   
>   static cpumask_t evtstrm_available = CPU_MASK_NONE;
>   static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
