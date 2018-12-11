Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47040 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeLKNZA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Dec 2018 08:25:00 -0500
Subject: Re: [PATCH v2 04/28] kernel: Add masks support for Raw and NTP time
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-5-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292339240.1657@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fe008742-6af4-35e9-131a-284bf3781dd0@arm.com>
Date: Tue, 11 Dec 2018 13:24:56 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811292339240.1657@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181211132456.xE9iWEcYRy81I3hWRjd8yQ-Q23ufki2E7JhbPv-0zQE@z>

On 29/11/2018 22:41, Thomas Gleixner wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> 
>> Depending on the clocksource selected there can be supported a
>> different resolution hence we require a mask to be applied to the
>> time calculation.
>>
>> This patch exposes the mask in the datapage for Raw and NTP adjusted
>> clock.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  include/vdso/datapage.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
>> index d50a108afaed..0a7bdccf5773 100644
>> --- a/include/vdso/datapage.h
>> +++ b/include/vdso/datapage.h
>> @@ -34,6 +34,8 @@ struct vdso_data {
>>  	__u64 wtm_clock_nsec;
>>  	__u64 btm_nsec;		/* Monotonic to boot time */
>>  	__u64 tai_sec;		/* International Atomic Time */
>> +	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
>> +	__u64 cs_raw_mask;	/* Raw clocksource mask */
> 
> And why would they be different? The core timekeeper has them duplicated
> purely for access pattern optimization and simplicity.
>

As you pointed out I followed the pattern of core timekeeper, but looking at it
after your comment, it seems obvious that one is enough.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
