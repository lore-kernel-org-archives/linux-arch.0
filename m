Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfAJKgQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jan 2019 05:36:16 -0500
Subject: Re: [PATCH v3 02/24] kernel: Define gettimeofday vdso common code
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-3-vincenzo.frascino@arm.com>
 <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e2156e71-a167-ce03-650f-9093d5cd4330@arm.com>
Date: Thu, 10 Jan 2019 10:36:12 +0000
MIME-Version: 1.0
In-Reply-To: <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salyzyn <salyzyn@android.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190110103612.6WcKEKYs41AyxhePC2Md0id9l-9ZHoAwEKHugDFZihg@z>

On 14/12/2018 18:15, Mark Salyzyn wrote:
> On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
>>
>> . . .
>> +}
>> +
>> +#ifdef VDSO_HAS_TIME
>> +static notrace time_t __cvdso_time(time_t *time)
>> +{
>> +	u32 seq;
>> +	time_t t;
>> +	const struct vdso_data *vd = __arch_get_vdso_data();
>> +	struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
> const struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
>

Thanks for this, I will fix in v4.

> -- Mark
> 

-- 
Regards,
Vincenzo
