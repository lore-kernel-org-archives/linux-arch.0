Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:44024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFYRCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 13:02:21 -0400
Date: Tue, 25 Jun 2019 19:02:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] lib/vdso: Delay mask application in do_hres()
In-Reply-To: <20190625161804.38713-1-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1906251851350.32342@nanos.tec.linutronix.de>
References: <20190624133607.GI29497@fuggles.cambridge.arm.com> <20190625161804.38713-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux@armlinux.org.uk, Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com, Daniel Lezcano <daniel.lezcano@linaro.org>, salyzyn@android.com, pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, Andy Lutomirski <luto@kernel.org>
Message-ID: <20190625170213.DNvGvRfi2n4z0s0sp34EsqHDZnfsjcT620R7rmZCNcE@z>

On Tue, 25 Jun 2019, Vincenzo Frascino wrote:

CC+ Andy

> do_hres() in the vDSO generic library masks the hw counter value
> immediately after reading it.
> 
> Postpone the mask application after checking if the syscall fallback is
> enabled, in order to be able to detect a possible fallback for the
> architectures that have masks smaller than ULLONG_MAX.

Right. This only worked on x86 because the mask is there ULLONG_MAX for all
VDSO capable clocksources, i.e. that ever worked just by chance.

As we talked about that already yesterday, I tested this on a couple of
machines and as expected the outcome is uarch dependent. Minimal deviations
to both sides and some machines do not show any change at all. I doubt it's
possible to come up with a solution which makes all uarchs go faster
magically.

Though, thinking about it, we could remove the mask operation completely on
X86. /me runs tests

Thanks,

	tglx


> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  lib/vdso/gettimeofday.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index ef28cc5d7bff..ee1221ba1d32 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -35,12 +35,12 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
>  
>  	do {
>  		seq = vdso_read_begin(vd);
> -		cycles = __arch_get_hw_counter(vd->clock_mode) &
> -			vd->mask;
> +		cycles = __arch_get_hw_counter(vd->clock_mode);
>  		ns = vdso_ts->nsec;
>  		last = vd->cycle_last;
>  		if (unlikely((s64)cycles < 0))
>  			return clock_gettime_fallback(clk, ts);
> +		cycles &= vd->mask;
>  		if (cycles > last)
>  			ns += (cycles - last) * vd->mult;
>  		ns >>= vd->shift;
> -- 
> 2.22.0
> 
> 
