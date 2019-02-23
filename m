From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Date: Sat, 23 Feb 2019 11:34:51 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190222122430.21180-3-vincenzo.frascino@arm.com>
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
