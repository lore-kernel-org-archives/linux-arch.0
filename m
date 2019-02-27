Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbfB0Nrg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Feb 2019 08:47:36 -0500
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
Date: Wed, 27 Feb 2019 13:47:31 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190227134731.z39lXVqtu4YxENz5NX-kQ7_73CTCD8eWHsee7FPovdg@z>

Hi Thomas,

On 23/02/2019 17:31, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>> +static notrace int do_hres(const struct vdso_data *vd,
>> +			   clockid_t clk,
>> +			   struct __vdso_timespec *ts)
>> +{
>> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
>> +	u64 cycles, last, sec, ns;
>> +	u32 seq, cs_index = CLOCKSOURCE_MONO;
>> +
>> +	if (clk == CLOCK_MONOTONIC_RAW)
>> +		cs_index = CLOCKSOURCE_RAW;
> 
> Uuurgh. So you create an array with 16 members and then use two. This code
> is really optimized and now you add not only the pointless array, you also
> need the extra index plus another conditional. Not to talk about the cache
> impact which makes things even worse. In the x86 implementation we have:
> 
>        u32 		seq;			 +  0
>        int		mode;			 +  4
>        u64		mask;			 +  8
>        u32		mult;			 + 16
>        u32		shift;			 + 20
>        struct vgtod_ts	basetimer[VGTOD_BASES];  + 24
> 
> Each basetime array member occupies 16 bytes. So
> 
> 	CLOCK_REALTIME		+ 24
> 	CLOCK_MONOTONIC		+ 40
> 	..
> 		cacheline boundary		
> 	..
> 	CLOCK_REALTIME_COARSE	+ 104
> 	CLOCK_MONOTONIC_COARSE	+ 120   <- cacheline boundary
> 	CLOCK_BOOTTIME		+ 136
> 	CLOCK_REALTIME_ALARM	+ 152
> 	CLOCK_BOOTTIME_ALARM	+ 168
>        
> So the most used clocks REALTIME/MONO are in the first cacheline.
> 
> So with your scheme the thing becomes
> 
>        u32 		seq;			 +   0
>        int		mode;			 +   4
>        struct cs	cs[16]			 +   8
>        struct vgtod_ts	basetimer[VGTOD_BASES];  + 264
> 
> and 
> 
> 	CLOCK_REALTIME		+ 264
> 	CLOCK_MONOTONIC		+ 280
>

The clocksource array has two elements (CLOCKSOURCE_RAW, CLOCKSOURCE_MONO) and
the situation with my scheme should be the following:
	u32		seq:			+    0
	s32		clock_mode;		+    4
	u64		cycle_last;		+    8
	struct vdso_cs	cs[2];			+    16
	struct vdso_ts	basetime[VDSO_BASES];	+    48

which I agree makes still things a bit worse.

Assuming L1_CACHE_SHIFT == 6:

	CLOCK_REALTIME			+    48
	...
	cache boundary
	...
	CLOCK_MONOTONIC			+    64
	CLOCK_PROCESS_CPUTIME_ID	+    80
	CLOCK_THREAD_CPUTIME_ID		+    96
	CLOCK_MONOTONIC_RAW		+    112
	...
	cache boundary
	...
	CLOCK_REALTIME_COARSE		+    128
	CLOCK_MONOTONIC_COARSE		+    144
	CLOCK_BOOTTIME			+    160
	CLOCK_REALTIME_ALARM 		+    172
	CLOCK_BOOTTIME_ALARM		+    188
	...

> IOW, the most important clocks touch TWO cachelines now which are not even
> adjacent. No, they are 256 bytes apart, which really sucks for prefetching.
> 
> We're surely not going to sacrify the performance which we carefully tuned
> in that code just to support MONO_RAW. The solution I showed you in the
> other reply does not have these problems at all.
> 
> It's easy enough to benchmark these implementations and without trying I'm
> pretty sure that you can see the performance drop nicely. Please do so next
> time and provide the numbers in the changelogs.
> 

I did run some benchmarks this morning to quantify the performance impact and
seems that using vdsotest[1] the difference in between a stock linux kernel
5.0.0-rc7 and one that has unified vDSO, running on my x86 machine (Xeon Gold
5120T), is below 1%. Please find the results below, I will add them as well to
the next changelog.

[1] https://github.com/nathanlynch/vdsotest

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

8<-----------------

Unified vDSO:
=============

clock-gettime-monotonic: syscall: 351 nsec/call
clock-gettime-monotonic:    libc: 37 nsec/call
clock-gettime-monotonic:    vdso: 31 nsec/call
clock-getres-monotonic: syscall: 271 nsec/call
clock-getres-monotonic:    libc: 269 nsec/call
clock-getres-monotonic:    vdso: 9 nsec/call
clock-gettime-monotonic-coarse: syscall: 280 nsec/call
clock-gettime-monotonic-coarse:    libc: 22 nsec/call
clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
clock-getres-monotonic-coarse: syscall: 274 nsec/call
clock-getres-monotonic-coarse:    libc: 276 nsec/call
clock-getres-monotonic-coarse:    vdso: 10 nsec/call
clock-gettime-monotonic-raw: syscall: 337 nsec/call
clock-gettime-monotonic-raw:    libc: 38 nsec/call
clock-gettime-monotonic-raw:    vdso: 32 nsec/call
clock-getres-monotonic-raw: syscall: 284 nsec/call
clock-getres-monotonic-raw:    libc: 271 nsec/call
clock-getres-monotonic-raw:    vdso: 9 nsec/call
clock-gettime-tai: syscall: 332 nsec/call
clock-gettime-tai:    libc: 37 nsec/call
clock-gettime-tai:    vdso: 31 nsec/call
clock-getres-tai: syscall: 273 nsec/call
clock-getres-tai:    libc: 281 nsec/call
clock-getres-tai:    vdso: 10 nsec/call
clock-gettime-boottime: syscall: 338 nsec/call
clock-gettime-boottime:    libc: 37 nsec/call
clock-gettime-boottime:    vdso: 32 nsec/call
clock-getres-boottime: syscall: 283 nsec/call
clock-getres-boottime:    libc: 278 nsec/call
clock-getres-boottime:    vdso: 9 nsec/call
clock-gettime-realtime: syscall: 338 nsec/call
clock-gettime-realtime:    libc: 39 nsec/call
clock-gettime-realtime:    vdso: 32 nsec/call
clock-getres-realtime: syscall: 281 nsec/call
clock-getres-realtime:    libc: 277 nsec/call
clock-getres-realtime:    vdso: 10 nsec/call
clock-gettime-realtime-coarse: syscall: 286 nsec/call
clock-gettime-realtime-coarse:    libc: 21 nsec/call
clock-gettime-realtime-coarse:    vdso: 12 nsec/call
clock-getres-realtime-coarse: syscall: 285 nsec/call
clock-getres-realtime-coarse:    libc: 283 nsec/call
clock-getres-realtime-coarse:    vdso: 11 nsec/call
getcpu: syscall: 234 nsec/call
getcpu:    libc: 31 nsec/call
getcpu:    vdso: 20 nsec/call
gettimeofday: syscall: 293 nsec/call
gettimeofday:    libc: 32 nsec/call
gettimeofday:    vdso: 31 nsec/call

Stock Kernel:
=============

clock-gettime-monotonic: syscall: 349 nsec/call
clock-gettime-monotonic:    libc: 37 nsec/call
clock-gettime-monotonic:    vdso: 28 nsec/call
clock-getres-monotonic: syscall: 296 nsec/call
clock-getres-monotonic:    libc: 295 nsec/call
clock-getres-monotonic:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-monotonic-coarse: syscall: 296 nsec/call
clock-gettime-monotonic-coarse:    libc: 21 nsec/call
clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
clock-getres-monotonic-coarse: syscall: 287 nsec/call
clock-getres-monotonic-coarse:    libc: 288 nsec/call
clock-getres-monotonic-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-monotonic-raw: syscall: 353 nsec/call
clock-gettime-monotonic-raw:    libc: 360 nsec/call
clock-gettime-monotonic-raw:    vdso: 352 nsec/call
clock-getres-monotonic-raw: syscall: 282 nsec/call
clock-getres-monotonic-raw:    libc: 286 nsec/call
clock-getres-monotonic-raw:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-tai: syscall: 351 nsec/call
clock-gettime-tai:    libc: 364 nsec/call
clock-gettime-tai:    vdso: 365 nsec/call
clock-getres-tai: syscall: 287 nsec/call
clock-getres-tai:    libc: 287 nsec/call
clock-getres-tai:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-boottime: syscall: 347 nsec/call
clock-gettime-boottime:    libc: 364 nsec/call
clock-gettime-boottime:    vdso: 355 nsec/call
clock-getres-boottime: syscall: 287 nsec/call
clock-getres-boottime:    libc: 287 nsec/call
clock-getres-boottime:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-realtime: syscall: 346 nsec/call
clock-gettime-realtime:    libc: 36 nsec/call
clock-gettime-realtime:    vdso: 29 nsec/call
clock-getres-realtime: syscall: 285 nsec/call
clock-getres-realtime:    libc: 287 nsec/call
clock-getres-realtime:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-realtime-coarse: syscall: 296 nsec/call
clock-gettime-realtime-coarse:    libc: 20 nsec/call
clock-gettime-realtime-coarse:    vdso: 11 nsec/call
clock-getres-realtime-coarse: syscall: 301 nsec/call
clock-getres-realtime-coarse:    libc: 297 nsec/call
clock-getres-realtime-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
getcpu: syscall: 255 nsec/call
getcpu:    libc: 32 nsec/call
getcpu:    vdso: 21 nsec/call
gettimeofday: syscall: 339 nsec/call
gettimeofday:    libc: 31 nsec/call
gettimeofday:    vdso: 30 nsec/call
