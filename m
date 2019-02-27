Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0Pts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2019 10:49:48 -0500
Date: Wed, 27 Feb 2019 16:49:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
In-Reply-To: <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
Message-ID: <alpine.DEB.2.21.1902271640260.26197@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com> <20190222122430.21180-3-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de> <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190227154937.7hrXzKDb9Iw-7T_mIno7Zi-c_AuUUZYit38P2viUTBE@z>

Vincenzo,

On Wed, 27 Feb 2019, Vincenzo Frascino wrote:
> 
> The clocksource array has two elements (CLOCKSOURCE_RAW, CLOCKSOURCE_MONO) and
> the situation with my scheme should be the following:

Oops. I misread the patch, but still...

> 	u32		seq:			+    0
> 	s32		clock_mode;		+    4
> 	u64		cycle_last;		+    8
> 	struct vdso_cs	cs[2];			+    16
> 	struct vdso_ts	basetime[VDSO_BASES];	+    48
> 
> which I agree makes still things a bit worse.

> > It's easy enough to benchmark these implementations and without trying I'm
> > pretty sure that you can see the performance drop nicely. Please do so next
> > time and provide the numbers in the changelogs.
> > 
> 
> I did run some benchmarks this morning to quantify the performance impact and
> seems that using vdsotest[1] the difference in between a stock linux kernel
> 5.0.0-rc7 and one that has unified vDSO, running on my x86 machine (Xeon Gold
> 5120T), is below 1%. Please find the results below, I will add them as well to
> the next changelog.

I have some doubts about 1%.
			    	   NEW	STOCK
clock-gettime-monotonic:    vdso:  31	 28    ~ 10% slower
clock-gettime-realtime:     vdso:  32    29    ~ 10% slower

Thanks,

	tglx
