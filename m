Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41498 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfFDMFq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jun 2019 08:05:46 -0400
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
 <CAK8P3a3EnvkLND2RJdZtEY64PhK5g0sbbuytQro=f0cPur2g9g@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <bb5253b2-623c-c927-27a2-1d3a2990d20f@arm.com>
Date: Tue, 4 Jun 2019 13:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3EnvkLND2RJdZtEY64PhK5g0sbbuytQro=f0cPur2g9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190604120540.buvMC4PRDz7orkkQ8VHJEp1z92eIYStt-1l4-ab0av4@z>

On 31/05/2019 09:16, Arnd Bergmann wrote:
> On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> 
>> + * vdso_data will be accessed by 64 bit and compat code at the same time
>> + * so we should be careful before modifying this structure.
>> + */
>> +struct vdso_data {
>> +       u32                     seq;
>> +
>> +       s32                     clock_mode;
>> +       u64                     cycle_last;
>> +       u64                     mask;
>> +       u32                     mult;
>> +       u32                     shift;
>> +
>> +       struct vdso_timestamp   basetime[VDSO_BASES];
>> +
>> +       s32                     tz_minuteswest;
>> +       s32                     tz_dsttime;
>> +       u32                     hrtimer_res;
>> +};
> 
> The structure contains four padding bytes at the end, which is
> something we try to avoid, at least if this ends up being used as
> an ABI. Maybe add "u32 __unused" at the end?
> 

Agreed, I will fix this in v7.

>      Arnd
> 

-- 
Regards,
Vincenzo
