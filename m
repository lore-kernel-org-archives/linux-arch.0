Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfBYOKA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Feb 2019 09:10:00 -0500
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <025bc260-85aa-a04e-b29b-b664f50abc3c@arm.com>
Date: Mon, 25 Feb 2019 14:09:55 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190225140955.NzQliMXZoKhdJ1cOYDfu2zHpyiROdxUsuNRLhoQS6fY@z>

Hi Thomas,

thank you for your review.

On 23/02/2019 10:34, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>> +static notrace int __cvdso_clock_getres(clockid_t clock,
>> +					struct __vdso_timespec *res)
>> +{
>> +	u64 sec, ns;
>> +	u32 msk;
>> +
>> +	/* Check for negative values or invalid clocks */
>> +	if (unlikely((u32) clock >= MAX_CLOCKS))
>> +		goto fallback;
>> +
>> +	/*
>> +	 * Convert the clockid to a bitmask and use it to check which
>> +	 * clocks are handled in the VDSO directly.
>> +	 */
>> +	msk = 1U << clock;
>> +	if (msk & VDSO_HRES) {
>> +		/*
>> +		 * Preserves the behaviour of posix_get_hrtimer_res().
>> +		 */
> 
> So much for the theory.
> 
>> +		sec = 0;
>> +		ns = MONOTONIC_RES_NSEC;
> 
> posix_get_hrtimer_res() does:
> 
> 	sec = 0;
> 	ns = hrtimer_resolution;
> 
> and hrtimer_resolution depends on the enablement of high resolution timers
> either compile or run time.
> 
> So you need to have a copy of hrtimer_resolution in the vdso data and use
> that.
> 

I agree, MONOTONIC_RES_NSEC can be HIGH_RES_NSEC or LOW_RES_NSEC depending on
the HIGH_RES_TIMERS configuration option, but does not cover the run time
switch. I will add a copy of hrtimer_resolution in the vdso data in the next
iteration of the patches.

I had a look at the other implementations as well, and it seems that all the
architectures that currently implement getres() make the same wrong assumption I
made. I am going to provide a separate patch set that targets this.

>> +	} else if (msk & VDSO_COARSE) {
>> +		/*
>> +		 * Preserves the behaviour of posix_get_coarse_res().
>> +		 */
>> +		ns = LOW_RES_NSEC;
>> +		sec = __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> 
> Do we allow CONFIG_HZ = 1?
> 

I had a closer look at it today and seems that jiffies.h supports CONFIG_HZ=12
as a minimum case. Hence I think it should be safe to remove __iter_div_u64_rem
and set sec=0 in this case.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
