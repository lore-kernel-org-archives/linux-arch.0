From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Date: Thu, 29 Nov 2018 23:11:52 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129170530.37789-7-vincenzo.frascino@arm.com>
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

Vinzenco,

On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
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
> +config HAVE_ARCH_TIMER
> +	bool
> +	depends on GENERIC_GETTIMEOFDAY
> +	help
> +	  Select this configuration option if the architecture has an arch
> +	  timer.

Please don't add code which is architecture specific to the generic
implementation. There is really no reason to make ARCH_TIMER special.

> +/*
> + * Returns the clock delta, in nanoseconds left-shifted by the clock
> + * shift.
> + */
> +static __always_inline notrace u64 get_clock_shifted_nsec(u64 cycle_last,
> +							  u64 mult,
> +							  u64 mask)
> +{
> +	u64 res;
> +
> +	/* Read the virtual counter. */

Virtual counter? No. That's again an ARM thingy. This needs to be done in
architecture code.

> +	res = clock_get_virtual_counter();
> +
> +	if (res > cycle_last)
> +		res = res - cycle_last;
> +	/*
> +	 * VDSO Precision Mask: represents the
> +	 * precision bits we can guaranty.
> +	 */
> +	res &= mask;
> +	return res * mult;
> +}
> +
> +#ifdef CONFIG_HAVE_ARCH_TIMER
> +static __always_inline notrace int __do_realtime_or_tai(
> +		const struct vdso_data *vd,
> +		struct __vdso_timespec *ts,
> +		bool is_tai)
> +{
> +	u32 seq, cs_mono_mult, cs_shift;
> +	u64 ns, sec;
> +	u64 cycle_last, cs_mono_mask;
> +
> +	if (vd->use_syscall)
> +		return -1;
> +repeat:
> +	seq = vdso_read_begin(vd);
> +	cycle_last = vd->cs_cycle_last;
> +	cs_mono_mult = vd->cs_mono_mult;
> +	cs_shift = vd->cs_shift;
> +	cs_mono_mask = vd->cs_mono_mask;
> +
> +	if (is_tai)
> +		sec = vd->tai_sec;
> +	else
> +		sec = vd->xtime_clock_sec;
> +	ns = vd->xtime_clock_nsec;
> +
> +	if (unlikely(vdso_read_retry(vd, seq)))
> +		goto repeat;
> +
> +	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult, cs_mono_mask);

This is broken. You cannot read the counter outside the seq count protected
region. Please tell the ARM64 folks that their VDSO asm maze is broken.

Btw, just converting ASM code line by line to C is not really the way to
go.

< SNIP tons of duplicated and horrible code >

Please look at x86/entry/vdso/vclock_gettime.c.  This can be done with a
very limited set of functions.

> +/*
> + * This hook allows the architecture to validate the arguments
> + * passed to the library.
> + */
> +#ifndef __HAVE_VDSO_ARCH_VALIDATE_ARG
> +#define __arch_valid_arg(x)	true
> +#endif

Why would you need that? There is really no point in adding architecture
hooks.

> +static notrace int __cvdso_clock_gettime(clockid_t clock,
> +					 struct __vdso_timespec *ts)
> +{
> +	const struct vdso_data *vd = __arch_get_vdso_data();
> +
> +	if (!__arch_valid_arg(ts))

Especially not for a timespec pointer. It's a user space supplied pointer
and what do you want to validate there? If it's bogus, access will fault,
end of story.

> +		return -EFAULT;
> +
> +	switch (clock) {
> +	case CLOCK_REALTIME:
> +		if (do_realtime(vd, ts))
> +			goto fallback;
> +		break;
> +	case CLOCK_TAI:
> +		if (do_tai(vd, ts))
> +			goto fallback;
> +		break;
> +	case CLOCK_MONOTONIC:
> +		if (do_monotonic(vd, ts))
> +			goto fallback;
> +		break;
> +	case CLOCK_MONOTONIC_RAW:
> +		if (do_monotonic_raw(vd, ts))
> +			goto fallback;
> +		break;
> +	case CLOCK_BOOTTIME:
> +		if (do_boottime(vd, ts))
> +			goto fallback;
> +		break;
> +	case CLOCK_REALTIME_COARSE:
> +		do_realtime_coarse(vd, ts);
> +		break;
> +	case CLOCK_MONOTONIC_COARSE:
> +		do_monotonic_coarse(vd, ts);
> +		break;

See the x86 implementation. It avoids the switch case. The reason why you
want to avoid it is that the compiler will turn that thing above into a
call table, using an indirect branch and then requiring retpoline.

So here is the code which can be made generic:

notrace static int do_hres(clockid_t clk, struct timespec *ts)
{
	struct vgtod_ts *base = &gtod->basetime[clk];
	u64 cycles, last, sec, ns;
	unsigned int seq;

	do {
		seq = gtod_read_begin(gtod);
		cycles = vgetcyc(gtod->vclock_mode);
		ns = base->nsec;
		last = gtod->cycle_last;
		if (unlikely((s64)cycles < 0))
			return vdso_fallback_gettime(clk, ts);
		if (cycles > last)
			ns += (cycles - last) * gtod->mult;
		ns >>= gtod->shift;
		sec = base->sec;
	} while (unlikely(gtod_read_retry(gtod, seq)));

	/*
	 * Do this outside the loop: a race inside the loop could result
	 * in __iter_div_u64_rem() being extremely slow.
	 */
	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
	ts->tv_nsec = ns;

	return 0;
}

notrace static void do_coarse(clockid_t clk, struct timespec *ts)
{
	struct vgtod_ts *base = &gtod->basetime[clk];
	unsigned int seq;

	do {
		seq = gtod_read_begin(gtod);
		ts->tv_sec = base->sec;
		ts->tv_nsec = base->nsec;
	} while (unlikely(gtod_read_retry(gtod, seq)));
}

notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
{
	unsigned int msk;

	/* Sort out negative (CPU/FD) and invalid clocks */
	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
		return vdso_fallback_gettime(clock, ts);

	/*
	 * Convert the clockid to a bitmask and use it to check which
	 * clocks are handled in the VDSO directly.
	 */
	msk = 1U << clock;
	if (likely(msk & VGTOD_HRES)) {
		return do_hres(clock, ts);
	} else if (msk & VGTOD_COARSE) {
		do_coarse(clock, ts);
		return 0;
	}
	return vdso_fallback_gettime(clock, ts);
}

int clock_gettime(clockid_t, struct timespec *)
	__attribute__((weak, alias("__vdso_clock_gettime")));

notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
{
	if (likely(tv != NULL)) {
		struct timespec *ts = (struct timespec *) tv;

		do_hres(CLOCK_REALTIME, ts);
		tv->tv_usec /= 1000;
	}
	if (unlikely(tz != NULL)) {
		tz->tz_minuteswest = gtod->tz_minuteswest;
		tz->tz_dsttime = gtod->tz_dsttime;
	}

	return 0;
}
int gettimeofday(struct timeval *, struct timezone *)
	__attribute__((weak, alias("__vdso_gettimeofday")));

/*
 * This will break when the xtime seconds get inaccurate, but that is
 * unlikely
 */
notrace time_t __vdso_time(time_t *t)
{
	/* This is atomic on x86 so we don't need any locks. */
	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);

	if (t)
		*t = result;
	return result;
}
time_t time(time_t *t)
	__attribute__((weak, alias("__vdso_time")));

The architecture specific part which is needed is:

    vgetcyc()

that's the function which reads the hardware counter or in the x86 case
depending on the mode one of several possible counters.

Note, the above does not support MONOTONIC_RAW, but that's halfways simple
to add.

> +static notrace int __cvdso_clock_getres(clockid_t clock_id,
> +					struct __vdso_timespec *res)
> +{
> +	u64 ns;
> +
> +	if (!__arch_valid_arg(res))
> +		return -EFAULT;
> +
> +	if (clock_id == CLOCK_REALTIME ||
> +	    clock_id == CLOCK_TAI ||
> +	    clock_id == CLOCK_BOOTTIME ||
> +	    clock_id == CLOCK_MONOTONIC ||
> +	    clock_id == CLOCK_MONOTONIC_RAW)
> +		ns = MONOTONIC_RES_NSEC;

This is wrong. You cannot unconditionally set that. See what the syscall
based version does. You always need to verify that the syscall version and
the vdso version return the same information and not something randomly
different.

Thanks,

	tglx
