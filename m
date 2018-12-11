From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 01/28] kernel: Standardize vdso_datapage
Date: Tue, 11 Dec 2018 13:22:38 +0000
Message-ID: <b9ac0054-4246-35fc-918e-47f67b11a44f@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
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
