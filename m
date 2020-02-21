From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] clocksource: Fix arm_arch_timer clockmode when vDSO
 disabled
Date: Fri, 21 Feb 2020 13:34:06 +0000
Message-ID: <a81251e813d54caddd56b9aac4b55e85@kernel.org>
References: <20200221130355.21373-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgBUNeJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 08:34:09 -0500
In-Reply-To: <20200221130355.21373-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, luto@kernel.org, tglx@linutronix.de, m.szyprowski@samsung.com, mark.rutland@arm.com

Vincenzo,

Please include Mark and myself for anything that touches the arch timers
(get_maintainer.pl will tell you who you need to cc).

On 2020-02-21 13:03, Vincenzo Frascino wrote:
> The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
> defined to compile correctly. On arm the vDSO can be disabled and when
> this is the case the compilation ends prematurely with an error:
> 
>  $ make ARCH=arm multi_v7_defconfig
>  $ ./scripts/config -d VDSO
>  $ make
> 
> drivers/clocksource/arm_arch_timer.c:73:44: error:
> ‘VDSO_CLOCKMODE_ARCHTIMER’ undeclared here (not in a function)
>   static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
>                                              ^
> scripts/Makefile.build:267: recipe for target
> 'drivers/clocksource/arm_arch_timer.o' failed
> make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> scripts/Makefile.build:505: recipe for target 'drivers/clocksource' 
> failed
> make[1]: *** [drivers/clocksource] Error 2
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1683: recipe for target 'drivers' failed
> make: *** [drivers] Error 2
> 
> Define VDSO_CLOCKMODE_ARCHTIMER as VDSO_CLOCKMODE_NONE when the vDSOs 
> are
> not enabled to address the issue.
> 
> Fixes: 5e3c6a312a09 ("ARM/arm64: vdso: Use common vdso clock mode 
> storage")
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c
> b/drivers/clocksource/arm_arch_timer.c
> index ee2420d56f67..619839221f94 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -49,6 +49,11 @@
>  #define CNTV_TVAL	0x38
>  #define CNTV_CTL	0x3c
> 
> +#ifndef CONFIG_GENERIC_GETTIMEOFDAY
> +/* The define below is required because on arm the VDSOs can be 
> disabled */
> +#define VDSO_CLOCKMODE_ARCHTIMER	VDSO_CLOCKMODE_NONE
> +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */

This feels pretty clunky.

I'd extect VDSO_ARCH_CLOCKMODES (or some similar architecture-specific
symbol) to be used for vdso_default, and that symbol to be defined as
VDSO_CLOCKMODE_NONE when CONFIG_GENERIC_GETTIMEOFDAY isn't selected.

Otherwise, you'll end-up replicating the same pattern in every
clock-source that gets used by the VDSO.

         M.
-- 
Jazz is not dead. It just smells funny...
