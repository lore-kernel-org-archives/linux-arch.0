From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 02/24] kernel: Define gettimeofday vdso common code
Date: Tue, 15 Jan 2019 16:27:27 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1901151558140.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <20190115135539.24762-3-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190115135539.24762-3-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:

> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
> 
> This patch tries to unify the gettimeofday vdso implementation

# git grep 'This patch' Documentation/process

> +/*
> + * To improve performances, in this file, __always_inline it is used

performances?

> + * for the functions called multiple times.
> + */
> +static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)
> +{
> +	u32 seq;
> +
> +repeat:
> +	/* Trying to access concurrent shared memory */

I think I know what you try to say, but the comment does not make sense.

> +	seq = READ_ONCE(vd->seq);
> +	if (seq & 1) {
> +		cpu_relax();
> +		goto repeat;
> +	}
> +
> +	smp_rmb();
> +	return seq;
> +}
> +
> +static __always_inline notrace u32 vdso_read_retry(const struct vdso_data *vd,
> +						   u32 start)
> +{
> +	u32 seq;
> +
> +	smp_rmb();
> +	/* Trying to access concurrent shared memory */

This one even less.

> +	seq = READ_ONCE(vd->seq);
> +	return seq != start;
> +}
> +if HAVE_GENERIC_VDSO
> +
> +config GENERIC_GETTIMEOFDAY
> +	bool
> +	help
> +	  This is a generic implementation of gettimeofday vdso.
> +	  Each architecture that enables this feature has to
> +	  provide the fallback implementation.
> +
> +config GENERIC_VDSO_32
> +	bool
> +	depends on GENERIC_GETTIMEOFDAY && !64BIT
> +	help
> +	  This config option helps to avoid possible performance issues
> +	  in 32 bit only architectures.
> +
> +config HAVE_HW_COUNTER
> +	bool
> +	depends on GENERIC_GETTIMEOFDAY
> +	help
> +	  Select this configuration option if the architecture has an arch
> +	  timer.

What? If the architecture does not have a timer which is VDSO capable in
the first place then why would it ever enable VDSO? Get rid of these
pointless extras please.

> +config CROSS_COMPILE_COMPAT_VDSO
> +	string "32 bit Toolchain prefix for compat vDSO"
> +	depends on GENERIC_COMPAT_VDSO
> +	help
> +	  Defines the cross-compiler prefix for compiling compat vDSO.

Really? Why would every architecture see this Kconfig entry even if it's
not needed?

x8664 compilers can compile the VDSO for 32bit just fine and all they need
are the proper compiler flags.

> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> new file mode 100644
> index 000000000000..f008795f454a
> --- /dev/null
> +++ b/lib/vdso/gettimeofday.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic userspace implementations of gettimeofday() and similar.
> + *
> + * Copyright (C) 2018 ARM Limited
> + * Copyright (C) 2017 Cavium, Inc.
> + * Copyright (C) 2015 Mentor Graphics Corporation

Interesting. Most of that code comes from x86 but everyone and his dog has
it's copyright on it.

> +/*
> + * The generic vDSO implementation requires that gettimeofday.h
> + * provides:
> + * - __arch_get_vdso_data(): to get the vdso datapage.
> + * - __arch_get_hw_counter(): to get the hw counter based on the
> + *   clock_mode.
> + * - __arch_get_realtime_res(): to get the correct realtime res.
> + * - __arch_get_coarse_res(): to get the correct coarse res.
> + * - gettimeofday_fallback(): fallback for gettimeofday.
> + * - clock_gettime_fallback(): fallback for clock_gettime.
> + * - clock_getres_fallback(): fallback for clock_getres.
> + */
> +#include <asm/vdso/gettimeofday.h>
> +
> +#ifdef CONFIG_HAVE_HW_COUNTER

What the heck is this for?

> +static notrace int do_hres(const struct vdso_data *vd,
> +			   clockid_t clk,
> +			   struct __vdso_timespec *ts)
> +{
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
> +	u64 cycles, last, sec, ns;
> +	u32 seq;
> +
> +	if (vd->use_syscall)
> +		return -1;

No. We optimize for the VDSO case and this extra conditional is really
pointless. If your platform does not support VDSO then why are you exposing
the VDSO at all?

> +	do {
> +		seq = vdso_read_begin(vd);
> +		cycles = __arch_get_hw_counter(vd->clock_mode) & vd->mask;
> +		ns = vdso_ts->nsec;
> +		last = vd->cycle_last;
> +		if (unlikely((s64)cycles < 0))
> +			return clock_gettime_fallback(clk, ts);
> +		if (cycles > last)
> +			ns += (cycles - last) * vd->mult;
> +		ns >>= vd->shift;
> +		sec = vdso_ts->sec;
> +	} while (unlikely(vdso_read_retry(vd, seq)));
> +
> +	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> +	ts->tv_nsec = ns;
> +
> +	return 0;
> +}
> +#else
> +static notrace int do_hres(const struct vdso_data *vd,
> +			   clockid_t clk,
> +			   struct __vdso_timespec *ts)
> +{
> +	return -1;

This is not only pointless, it's broken. You just return -1 to the
caller. What is the caller supposed to do with that information? If the
VDSO is there and there is no suitable clocksource then it has to fall back
to the syscall automatically.

> +#ifdef VDSO_HAS_TIME

Why do we need yet another conditional. If we standartize on a single
implementation then why don't we export all the same functionality?

> +static notrace time_t __cvdso_time(time_t *time)
> +{
> +	u32 seq;
> +	time_t t;
> +	const struct vdso_data *vd = __arch_get_vdso_data();
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
> +
> +repeat:
> +	seq = vdso_read_begin(vd);
> +
> +	t = vdso_ts->sec;
> +
> +	if (unlikely(vdso_read_retry(vd, seq)))
> +		goto repeat;
> +
> +	if (unlikely(time != NULL))
> +		*time = t;
> +
> +	return t;

Uurgh. This is horrible code, really. Also why is the sequence count
required in the first place? Is there any 64bit architecture where the
access to vd->basetime[...].sec is not atomic?

> +}
> +#endif /* VDSO_HAS_TIME */
> +
> +static notrace int __cvdso_clock_getres(clockid_t clock,
> +					struct __vdso_timespec *res)
> +{

What's the point of exposing clock_getres() via the VDSO? It's not a
hotpath function in any way.

> +	u64 ns;
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
> +	if (msk & VDSO_HRES)
> +		ns = __arch_get_realtime_res(clock);

And if at all, then why is this an arch function? The resolution
information is generic and in no way architecture specific.

Thanks,

	tglx
