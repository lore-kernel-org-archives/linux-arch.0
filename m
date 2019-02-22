Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60946 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfBVNe3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 08:34:29 -0500
Date: Fri, 22 Feb 2019 13:34:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Message-ID: <20190222133423.GG42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-3-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222133423.fTCUaeCTgLyb00dqcosBjEhiDlPsKZWND69mn-2kujs@z>

On Fri, Feb 22, 2019 at 12:24:09PM +0000, Vincenzo Frascino wrote:
> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
> 
> Try to unify the gettimeofday vdso implementation introducing
> lib/vdso. The code contained in this library can ideally be
> reused by all the architectures avoiding, where possible, code
> duplication.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/vdso/datapage.h |   1 +
>  include/vdso/helpers.h  |  52 ++++++++++++
>  include/vdso/types.h    |  39 +++++++++
>  lib/Kconfig             |   5 ++
>  lib/vdso/Kconfig        |  37 +++++++++
>  lib/vdso/Makefile       |  22 +++++
>  lib/vdso/gettimeofday.c | 175 ++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 331 insertions(+)
>  create mode 100644 include/vdso/helpers.h
>  create mode 100644 include/vdso/types.h
>  create mode 100644 lib/vdso/Kconfig
>  create mode 100644 lib/vdso/Makefile
>  create mode 100644 lib/vdso/gettimeofday.c
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index da346ad02b03..ff332fcba73c 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -9,6 +9,7 @@
>  #include <linux/bits.h>
>  #include <linux/types.h>
>  #include <linux/time.h>
> +#include <vdso/types.h>
>  
>  #define VDSO_BASES	(CLOCK_TAI + 1)
>  #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
> diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
> new file mode 100644
> index 000000000000..511dea979f6b
> --- /dev/null
> +++ b/include/vdso/helpers.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_HELPERS_H
> +#define __VDSO_HELPERS_H
> +
> +#ifdef __KERNEL__

Nit: __KERNEL__ guards can go.

> +
> +#ifndef __ASSEMBLY__
> +
> +#include <vdso/datapage.h>
> +
> +static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)

Rather than explicitly annotating all functions with notrace, can't we
disable instrumentation for all C files used for the vDSO using compiler
flags?

That would be more robust, and make the code less noisy to read.

> +{
> +	u32 seq;
> +
> +repeat:
> +	seq = READ_ONCE(vd->seq);
> +	if (seq & 1) {
> +		cpu_relax();
> +		goto repeat;
> +	}
> +
> +	smp_rmb();
> +	return seq;
> +}

You could simplify the repeat loop as:

	while ((seq = READ_ONCE(vd->seq)) & 1)
		cpu_relax();

> +
> +static __always_inline notrace u32 vdso_read_retry(const struct vdso_data *vd,
> +						   u32 start)
> +{
> +	u32 seq;
> +
> +	smp_rmb();
> +	seq = READ_ONCE(vd->seq);
> +	return seq != start;
> +}
> +
> +static __always_inline notrace void vdso_write_begin(struct vdso_data *vd)
> +{
> +	++vd->seq;
> +	smp_wmb();
> +}
> +
> +static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
> +{
> +	smp_wmb();
> +	++vd->seq;
> +}

I realise this is what existing vDSO update code does, but I do think
that these should be using WRITE_ONCE() to perform the update, to ensure
that the write is not torn.

e.g. these should be:

static __always_inline notrace void vdso_write_begin(struct vdso_data *vd)
{
	WRITE_ONCE(vd->seq, vd->seq + 1);
	smp_wmb();
}

static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
{
	smp_wmb();
	WRITE_ONCE(vd->seq, vd->seq + 1);
}

Otherwise, the compiler can validly tear updates to vd->seq, and there's
the possibility that a reader sees an inconsistent value for vd->seq,
and consequently uses inconsistent data read from the vdso data page.

[...]

> +#include <linux/types.h>
> +#include <linux/time.h>

Nit: please order headers alphabetically>

> +
> +/*
> + * The definitions below are required to overcome the limitations
> + * of time_t on 32 bit architectures, which overflows in 2038.
> + * The new code should use the replacements based on time64_t and
> + * timespec64.
> + *
> + * The abstraction below will be updated once the migration to
> + * time64_t is complete.
> + */
> +#ifdef CONFIG_GENERIC_VDSO_32
> +#define __vdso_timespec		old_timespec32
> +#define __vdso_timeval		old_timeval32
> +#else
> +#ifdef ENABLE_COMPAT_VDSO
> +#define __vdso_timespec		old_timespec32
> +#define __vdso_timeval		old_timeval32
> +#else
> +#define __vdso_timespec		__kernel_timespec
> +#define __vdso_timeval		__kernel_old_timeval
> +#endif /* CONFIG_COMPAT_VDSO */
> +#endif /* CONFIG_GENERIC_VDSO_32 */

I'm not sure what the comment is trying to say.

For a 64-bit kernel, does this affec the native vDSO, or just the compat
vDSO?

[...]
> +config HAVE_GENERIC_VDSO
> +	bool
> +	default n

IIRC, 'n' is the implicit default.

Thanks,
Mark.
