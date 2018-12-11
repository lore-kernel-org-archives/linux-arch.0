From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Date: Tue, 11 Dec 2018 13:54:07 +0000
Message-ID: <97be4423-fb05-69a5-cd01-245e0ff29479@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 29/11/2018 22:11, Thomas Gleixner wrote:
> Vinzenco,
> 
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:

[...]

>> +/*
>> + * Returns the clock delta, in nanoseconds left-shifted by the clock
>> + * shift.
>> + */
>> +static __always_inline notrace u64 get_clock_shifted_nsec(u64 cycle_last,
>> +							  u64 mult,
>> +							  u64 mask)
>> +{
>> +	u64 res;
>> +
>> +	/* Read the virtual counter. */
> 
> Virtual counter? No. That's again an ARM thingy. This needs to be done in
> architecture code.
>

I agree, the name choice is unfortunate here. And I should have removed the
comment as well. What this function does is getting the hardware counter, which
seems not ARM specific.

>> +/*
>> + * This hook allows the architecture to validate the arguments
>> + * passed to the library.
>> + */
>> +#ifndef __HAVE_VDSO_ARCH_VALIDATE_ARG
>> +#define __arch_valid_arg(x)	true
>> +#endif
> 
> Why would you need that? There is really no point in adding architecture
> hooks.
>

It is for the bogus. BTW I agree with your comment below. Will remove it in v3.

>> +static notrace int __cvdso_clock_gettime(clockid_t clock,
>> +					 struct __vdso_timespec *ts)
>> +{
>> +	const struct vdso_data *vd = __arch_get_vdso_data();
>> +
>> +	if (!__arch_valid_arg(ts))
> 
> Especially not for a timespec pointer. It's a user space supplied pointer
> and what do you want to validate there? If it's bogus, access will fault,
> end of story.
>>> +		return -EFAULT;
>> +
>> +	switch (clock) {
>> +	case CLOCK_REALTIME:
>> +		if (do_realtime(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_TAI:
>> +		if (do_tai(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_MONOTONIC:
>> +		if (do_monotonic(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_MONOTONIC_RAW:
>> +		if (do_monotonic_raw(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_BOOTTIME:
>> +		if (do_boottime(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_REALTIME_COARSE:
>> +		do_realtime_coarse(vd, ts);
>> +		break;
>> +	case CLOCK_MONOTONIC_COARSE:
>> +		do_monotonic_coarse(vd, ts);
>> +		break;
> 
> See the x86 implementation. It avoids the switch case. The reason why you
> want to avoid it is that the compiler will turn that thing above into a
> call table, using an indirect branch and then requiring retpoline.
>

Thanks for providing the rationale here. Going forward I will generalize that
implementation and make sure it works on all the architectures.

[...]

>> +static notrace int __cvdso_clock_getres(clockid_t clock_id,
>> +					struct __vdso_timespec *res)
>> +{
>> +	u64 ns;
>> +
>> +	if (!__arch_valid_arg(res))
>> +		return -EFAULT;
>> +
>> +	if (clock_id == CLOCK_REALTIME ||
>> +	    clock_id == CLOCK_TAI ||
>> +	    clock_id == CLOCK_BOOTTIME ||
>> +	    clock_id == CLOCK_MONOTONIC ||
>> +	    clock_id == CLOCK_MONOTONIC_RAW)
>> +		ns = MONOTONIC_RES_NSEC;
> 
> This is wrong. You cannot unconditionally set that. See what the syscall
> based version does. You always need to verify that the syscall version and
> the vdso version return the same information and not something randomly
> different.
>

Agreed, I will fix it in v3.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
