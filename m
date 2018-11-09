Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42237 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeKJDFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2018 22:05:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so1220772plo.9
        for <linux-arch@vger.kernel.org>; Fri, 09 Nov 2018 09:23:39 -0800 (PST)
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C
 implementation
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <ef94c2cb-4573-211d-f69e-57bf90a80e6a@android.com>
Date: Fri, 9 Nov 2018 09:23:37 -0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, pcc@google.com
Message-ID: <20181109172337.EvE_X1WtFs4Oo4BYL3YpHnqMH4bBy5RnsjxyDO-gBfY@z>

On 11/09/2018 08:13 AM, Arnd Bergmann wrote:
>> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
>> index beca249bc2f3..9de0ffc369c5 100644
>> --- a/arch/arm64/kernel/vdso/vdso.lds.S
>> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
>> @@ -88,6 +88,7 @@ VERSION
>>                  __kernel_gettimeofday;
>>                  __kernel_clock_gettime;
>>                  __kernel_clock_getres;
>> +               __kernel_time;
>>          local: *;
>>          };
>>   }
> I would  prefer to not add any deprecated interfaces in the VDSO. If we
> have the 64-bit version of clock_gettime, we don't need the 32-bit version
> of it, and we don't need gettimeofday() or time() either. The C library
> can easily implement those by calling into clock_gettime.
Alas time() calls are simple and in the order of get_res, the cost of 
which is a five fold
improvement over the alternate higher resolution calls (clock_gettime or 
up to 100 fold
on some architectures over gettimeofday). We could measure a small 
improvement in
cpu utilization (and thus battery life by extension) attributed to arm64 
Android by
calling __kernel_time over __kernel_clock_gettime with coarse 
resolution. A game of
inches admittedly, but super KISS to add, and it is not as-if 
__kernel_time existence
will cause an issue with deprecation of a system call entry point.

-- Mark
