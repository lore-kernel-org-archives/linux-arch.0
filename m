From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Date: Mon, 25 Feb 2019 14:09:55 +0000
Message-ID: <025bc260-85aa-a04e-b29b-b664f50abc3c@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
