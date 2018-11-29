Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3JqJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Nov 2018 04:46:09 -0500
Date: Thu, 29 Nov 2018 23:39:00 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 01/28] kernel: Standardize vdso_datapage
In-Reply-To: <20181129170530.37789-2-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com> <20181129170530.37789-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181129223900.5CpA2rQMkms_YRLz8k0NxdwWrXz2zkTgP38FTrz1hd8@z>

On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> +/*
> + * Copyright (C) 2012 ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.

Please use SPDX identifier for the license and get rid of the boiler plate.

> +#include <linux/types.h>
> +
> +struct vdso_data {
> +	__u64 cs_cycle_last;	/* Timebase at clocksource init */

Why do you want to use the __u* variants? This is not a header exposed to
user space. It's part of the kernel.

> +	__u64 raw_time_sec;	/* Raw time */
> +	__u64 raw_time_nsec;
> +	__u64 xtime_clock_sec;	/* Kernel time */
> +	__u64 xtime_clock_nsec;
> +	__u64 xtime_coarse_sec;	/* Coarse time */
> +	__u64 xtime_coarse_nsec;
> +	__u64 wtm_clock_sec;	/* Wall to monotonic time */
> +	__u64 wtm_clock_nsec;
> +	__u32 tb_seq_count;	/* Timebase sequence counter */
> +	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
> +	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
> +	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
> +	__u32 tz_minuteswest;	/* Whacky timezone stuff */
> +	__u32 tz_dsttime;
> +	__u32 use_syscall;

This struct is also suboptimal cache line and access pattern wise. Aside of
that please look at the x86 variant of this struct. It's optimized and
handles all the clock variants without adding randomly named struct
members.

Thanks,

	tglx
