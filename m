Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60310 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBWRbi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Feb 2019 12:31:38 -0500
Date: Sat, 23 Feb 2019 18:31:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
In-Reply-To: <20190222122430.21180-3-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com> <20190222122430.21180-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190223173132.BaLVeOdVpsNJ8v8Prq09JJbCuH2Z1ZeIxfBzzaGsf_k@z>

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
> +static notrace int do_hres(const struct vdso_data *vd,
> +			   clockid_t clk,
> +			   struct __vdso_timespec *ts)
> +{
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
> +	u64 cycles, last, sec, ns;
> +	u32 seq, cs_index = CLOCKSOURCE_MONO;
> +
> +	if (clk == CLOCK_MONOTONIC_RAW)
> +		cs_index = CLOCKSOURCE_RAW;

Uuurgh. So you create an array with 16 members and then use two. This code
is really optimized and now you add not only the pointless array, you also
need the extra index plus another conditional. Not to talk about the cache
impact which makes things even worse. In the x86 implementation we have:

       u32 		seq;			 +  0
       int		mode;			 +  4
       u64		mask;			 +  8
       u32		mult;			 + 16
       u32		shift;			 + 20
       struct vgtod_ts	basetimer[VGTOD_BASES];  + 24

Each basetime array member occupies 16 bytes. So

	CLOCK_REALTIME		+ 24
	CLOCK_MONOTONIC		+ 40
	..
		cacheline boundary		
	..
	CLOCK_REALTIME_COARSE	+ 104
	CLOCK_MONOTONIC_COARSE	+ 120   <- cacheline boundary
	CLOCK_BOOTTIME		+ 136
	CLOCK_REALTIME_ALARM	+ 152
	CLOCK_BOOTTIME_ALARM	+ 168
       
So the most used clocks REALTIME/MONO are in the first cacheline.

So with your scheme the thing becomes

       u32 		seq;			 +   0
       int		mode;			 +   4
       struct cs	cs[16]			 +   8
       struct vgtod_ts	basetimer[VGTOD_BASES];  + 264

and 

	CLOCK_REALTIME		+ 264
	CLOCK_MONOTONIC		+ 280

IOW, the most important clocks touch TWO cachelines now which are not even
adjacent. No, they are 256 bytes apart, which really sucks for prefetching.

We're surely not going to sacrify the performance which we carefully tuned
in that code just to support MONO_RAW. The solution I showed you in the
other reply does not have these problems at all.

It's easy enough to benchmark these implementations and without trying I'm
pretty sure that you can see the performance drop nicely. Please do so next
time and provide the numbers in the changelogs.

Thanks,

	tglx
