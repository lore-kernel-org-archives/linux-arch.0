Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbfB0OXH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Feb 2019 09:23:07 -0500
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3f7238b5-3357-3635-38f4-9eaa14e400c9@arm.com>
Date: Wed, 27 Feb 2019 14:23:02 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190227142302.OH5ezCD5HxJSFKhwm-ZnoKfYIOW1fxQnUsS7BvRZYbg@z>

On 23/02/2019 16:51, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>> +/*
>> + * There is one vdso_clocksource object in vvar for each vDSO clocksource
>> + * (mono, raw). This struct is designed to keep vdso_data "cache-line friendly"
>> + * and optimal in terms of access pattern.
>> + *
>> + * Note that mask and shift are the same for mono and raw.
>> + */
>> +struct vdso_clocksource {
>> +	u64 mask;		/* Clocksource mask */
>> +	u32 mult;		/* Clocksource multiplier */
>> +	u32 shift;		/* Clocksource shift */
> 
> Can you please get rid of the tail comments and use proper kerneldoc
> format?
>

I will fix it in v6, thanks.

>> +/*
>> + * vdso_data will be accessed by 32 and 64 bit code at the same time
>> + * so we should be careful before modifying this structure.
>> + */
>> +struct vdso_data {
>> +	u32 seq;		/* Timebase sequence counter */
>> +
>> +	s32 clock_mode;
>> +	u64 cycle_last;		/* Timebase at clocksource init */
>> +
>> +	struct vdso_clocksource cs[CLOCKSOURCE_BASES];
> 
> Why would you need different clocksource parameters? That really bloats the
> data structure and makes the cache access pattern worse. Also the vdso
> update needs to copy the same data over and over for no value.
> 
> The only clock ID which needs a different mult/shift would be
> MONOTONIC_RAW, but if we expose that through the VDSO then we really can be
> smarter than this. See incomplete and uncompilable patch below for
> reference. You get the idea.
> 

Ok, thank you for providing the reference code. I will update my patches in v6
accordingly.

...

-- 
Regards,
Vincenzo
