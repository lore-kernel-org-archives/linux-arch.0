Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKNWm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Dec 2018 08:22:42 -0500
Subject: Re: [PATCH v2 01/28] kernel: Standardize vdso_datapage
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b9ac0054-4246-35fc-918e-47f67b11a44f@arm.com>
Date: Tue, 11 Dec 2018 13:22:38 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181211132238.HPFawhjW3vnDIfeF_oU1sKAK3ZhMxURn_MQ72XHHFHQ@z>

Hi Thomas,

thank you for reviewing my patches.

On 29/11/2018 22:39, Thomas Gleixner wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
>> +/*
>> + * Copyright (C) 2012 ARM Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> 
> Please use SPDX identifier for the license and get rid of the boiler plate.
> 

Agreed, I will fix it in the next iteration.

>> +#include <linux/types.h>
>> +
>> +struct vdso_data {
>> +	__u64 cs_cycle_last;	/* Timebase at clocksource init */
> 
> Why do you want to use the __u* variants? This is not a header exposed to
> user space. It's part of the kernel.
> 

This patch contains the same datatypes of the file from which is copied. Said
that, I agree with you and I will fix this in v3.

>> +	__u64 raw_time_sec;	/* Raw time */
>> +	__u64 raw_time_nsec;
>> +	__u64 xtime_clock_sec;	/* Kernel time */
>> +	__u64 xtime_clock_nsec;
>> +	__u64 xtime_coarse_sec;	/* Coarse time */
>> +	__u64 xtime_coarse_nsec;
>> +	__u64 wtm_clock_sec;	/* Wall to monotonic time */
>> +	__u64 wtm_clock_nsec;
>> +	__u32 tb_seq_count;	/* Timebase sequence counter */
>> +	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
>> +	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
>> +	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
>> +	__u32 tz_minuteswest;	/* Whacky timezone stuff */
>> +	__u32 tz_dsttime;
>> +	__u32 use_syscall;
> 
> This struct is also suboptimal cache line and access pattern wise. Aside of
> that please look at the x86 variant of this struct. It's optimized and
> handles all the clock variants without adding randomly named struct
> members.
> 

I had a look at the x86 implementation and I agree with you and Arnd that it is
better than what I am proposing here. Therefore, in my v3, I will follow that
model for the vdso unification. Thanks to both for pointing that out and for
providing the rationale behind it.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
