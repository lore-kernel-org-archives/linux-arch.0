Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59654 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBWKe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Feb 2019 05:34:59 -0500
Date: Sat, 23 Feb 2019 11:34:51 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
In-Reply-To: <20190222122430.21180-3-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com> <20190222122430.21180-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190223103451.qbvHbcR_LES14DKY5hLtVGk0dcgM8QjWDdpEtYxHF9g@z>

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
> +static notrace int __cvdso_clock_getres(clockid_t clock,
> +					struct __vdso_timespec *res)
> +{
> +	u64 sec, ns;
> +	u32 msk;
> +
> +	/* Check for negative values or invalid clocks */
> +	if (unlikely((u32) clock >= MAX_CLOCKS))
> +		goto fallback;
> +
> +	/*
> +	 * Convert the clockid to a bitmask and use it to check which
> +	 * clocks are handled in the VDSO directly.
> +	 */
> +	msk = 1U << clock;
> +	if (msk & VDSO_HRES) {
> +		/*
> +		 * Preserves the behaviour of posix_get_hrtimer_res().
> +		 */

So much for the theory.

> +		sec = 0;
> +		ns = MONOTONIC_RES_NSEC;

posix_get_hrtimer_res() does:

	sec = 0;
	ns = hrtimer_resolution;

and hrtimer_resolution depends on the enablement of high resolution timers
either compile or run time.

So you need to have a copy of hrtimer_resolution in the vdso data and use
that.

> +	} else if (msk & VDSO_COARSE) {
> +		/*
> +		 * Preserves the behaviour of posix_get_coarse_res().
> +		 */
> +		ns = LOW_RES_NSEC;
> +		sec = __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);

Do we allow CONFIG_HZ = 1?

Thanks,

	tglx
