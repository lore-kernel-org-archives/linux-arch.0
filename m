Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60259 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWQvP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Feb 2019 11:51:15 -0500
Date: Sat, 23 Feb 2019 17:51:07 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
In-Reply-To: <20190222122430.21180-2-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com> <20190222122430.21180-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190223165107.XXkwi8G39cotgFZemmV19Io7fJN37HBbZexEgG7lmyI@z>

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
> +/*
> + * There is one vdso_clocksource object in vvar for each vDSO clocksource
> + * (mono, raw). This struct is designed to keep vdso_data "cache-line friendly"
> + * and optimal in terms of access pattern.
> + *
> + * Note that mask and shift are the same for mono and raw.
> + */
> +struct vdso_clocksource {
> +	u64 mask;		/* Clocksource mask */
> +	u32 mult;		/* Clocksource multiplier */
> +	u32 shift;		/* Clocksource shift */

Can you please get rid of the tail comments and use proper kerneldoc
format?

> +/*
> + * vdso_data will be accessed by 32 and 64 bit code at the same time
> + * so we should be careful before modifying this structure.
> + */
> +struct vdso_data {
> +	u32 seq;		/* Timebase sequence counter */
> +
> +	s32 clock_mode;
> +	u64 cycle_last;		/* Timebase at clocksource init */
> +
> +	struct vdso_clocksource cs[CLOCKSOURCE_BASES];

Why would you need different clocksource parameters? That really bloats the
data structure and makes the cache access pattern worse. Also the vdso
update needs to copy the same data over and over for no value.

The only clock ID which needs a different mult/shift would be
MONOTONIC_RAW, but if we expose that through the VDSO then we really can be
smarter than this. See incomplete and uncompilable patch below for
reference. You get the idea.

> +	struct vdso_timestamp basetime[VDSO_BASES];
> +
> +	s32 tz_minuteswest;	/* Timezone definitions */
> +	s32 tz_dsttime;

Also please keep the tabular alignment of the members

	u32		foo;
	struct bar	bar;

that's way better to read than

	u32 foo;
	struct bar bar;

Thanks

	tglx

8<-----------------

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -139,9 +139,10 @@ notrace static inline u64 vgetcyc(int mo
 	return U64_MAX;
 }
 
-notrace static int do_hres(clockid_t clk, struct timespec *ts)
+notrace static int do_hres(clockid_t clk, struct timespec *ts,
+			   struct vsyscall_gtod_data *vdata)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
+	struct vgtod_ts *base = &vdata->basetime[clk];
 	u64 cycles, last, sec, ns;
 	unsigned int seq;
 
@@ -168,9 +169,10 @@ notrace static int do_hres(clockid_t clk
 	return 0;
 }
 
-notrace static void do_coarse(clockid_t clk, struct timespec *ts)
+notrace static void do_coarse(clockid_t clk, struct timespec *ts,
+			      struct vsyscall_gtod_data *vdata)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
+	struct vgtod_ts *base = &vdata->basetime[clk];
 	unsigned int seq;
 
 	do {
@@ -194,10 +196,12 @@ notrace int __vdso_clock_gettime(clockid
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VGTOD_HRES)) {
-		return do_hres(clock, ts);
+		return do_hres(clock, ts, &gtod[0]);
 	} else if (msk & VGTOD_COARSE) {
-		do_coarse(clock, ts);
+		do_coarse(clock, ts, &gtod[0]);
 		return 0;
+	} else if (msk & VGTOD_RAW) {
+		return do_hres(clock, ts, &gtod[1]);
 	}
 	return vdso_fallback_gettime(clock, ts);
 }
@@ -210,7 +214,7 @@ notrace int __vdso_gettimeofday(struct t
 	if (likely(tv != NULL)) {
 		struct timespec *ts = (struct timespec *) tv;
 
-		do_hres(CLOCK_REALTIME, ts);
+		do_hres(CLOCK_REALTIME, ts, &gtod[0]);
 		tv->tv_usec /= 1000;
 	}
 	if (unlikely(tz != NULL)) {
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -30,6 +30,7 @@ struct vgtod_ts {
 #define VGTOD_BASES	(CLOCK_TAI + 1)
 #define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
+#define VGTOD_RAW	BIT(CLOCK_MOTONONIC_RAW)
 
 /*
  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
@@ -49,7 +50,8 @@ struct vsyscall_gtod_data {
 	int		tz_minuteswest;
 	int		tz_dsttime;
 };
-extern struct vsyscall_gtod_data vsyscall_gtod_data;
+
+extern struct vsyscall_gtod_data vsyscall_gtod_data[2];
 
 extern int vclocks_used;
 static inline bool vclock_was_used(int vclock)
