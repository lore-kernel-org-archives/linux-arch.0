Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53482 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbfAOP0y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jan 2019 10:26:54 -0500
Subject: Re: [PATCH v4 01/24] kernel: Standardize vdso_datapage
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <20190115135539.24762-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
Date: Tue, 15 Jan 2019 15:26:50 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190115152650.jyhQjesG8HtENqZfo8ITwyy9cbSnunQBhqC2B9bLy7I@z>

On 15/01/2019 14:57, Thomas Gleixner wrote:
> On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
> 
>> +/*
>> + * There is one vdso_timestamp object in vvar for each vDSO-accelerated
>> + * clock_id. For high-resolution clocks, this encodes the time
>> + * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
>> + * the actual time.
>> + *
>> + * To be noticed that nsec is left-shifted by vdso_data.shift.
> 
> This is only true for highres clocks. For coarse the nsec value is not
> shifted.
>

Agreed, missed part of the comment here. I will fix it in v5.

>> + */
>> +struct vdso_timestamp {
>> +	u64 sec;
>> +	u64 nsec;
>> +};
>> +
>> +/*
>> + * vdso_data will be accessed by 32 and 64 bit code at the same time
>> + * so we should be careful before modifying this structure.
>> + */
>> +struct vdso_data {
>> +	u32 seq;		/* Timebase sequence counter */
>> +
>> +	s32 clock_mode;
>> +	u64 cycle_last;		/* Timebase at clocksource init */
>> +	u64 mask;		/* Clocksource mask (mono = raw) */
> 
> mono = raw? This is broken. The VDSO cannot define time different from the
> regular syscall interfaces.
> 

On v2 of this series I had the masks for mono and raw separate, but based on
your comment (the core timekeeper has them duplicated purely for access pattern
optimization and simplicity). I unified them. Could you please provide more
details on what should be done in this case?

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
