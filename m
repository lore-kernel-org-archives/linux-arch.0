Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.codeweavers.com ([50.203.203.244]:48330 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUKtM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2019 06:49:12 -0400
Date: Fri, 21 Jun 2019 11:49:02 +0100
From: Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH v7 03/25] kernel: Unify update_vsyscall implementation
Message-ID: <20190621104902.GA6646@merlot.physics.ox.ac.uk>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-4-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>
Message-ID: <20190621104902.zU5kZJenWeJzjfGEe6yuLoe14aiAWT_tORK6r3g_CfU@z>

On Fri, Jun 21, 2019 at 10:52:30AM +0100, Vincenzo Frascino wrote:
> diff --git a/kernel/vdso/vsyscall.c b/kernel/vdso/vsyscall.c
> new file mode 100644
> index 000000000000..d1e8074e3d10
> --- /dev/null
> +++ b/kernel/vdso/vsyscall.c
> +static inline void update_vdso_data(struct vdso_data *vdata,
> +				    struct timekeeper *tk)
> +{
> +	struct vdso_timestamp *vdso_ts;
> +	u64 nsec;
> +
> +	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
> +	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
> +	vdata[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
> +	vdata[CS_HRES_COARSE].shift		= tk->tkr_mono.shift;
> +	vdata[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
> +	vdata[CS_RAW].mask			= tk->tkr_raw.mask;
> +	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
> +	vdata[CS_RAW].shift			= tk->tkr_raw.shift;
> +
> +	/* CLOCK_REALTIME */
> +	vdso_ts		=  &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];

There's an extraneous space after the '='.  Hopefully Thomas can
fix this up if this patchset is otherwise ok.

> +	vdso_ts->sec	= tk->xtime_sec;
> +	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;

Huw.
