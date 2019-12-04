Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:56142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDNz6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Dec 2019 08:55:58 -0500
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing
 crash)
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com>
 <20191204135159.GA7210@roeck-us.net>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com>
Date: Wed, 4 Dec 2019 13:58:25 +0000
MIME-Version: 1.0
In-Reply-To: <20191204135159.GA7210@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>
Message-ID: <20191204135825.wZfr5ssKFDwLU1j17Tj-yLyvhWw1PaI_1MBmbfz9On8@z>

Hi Guenter,

On 12/4/19 1:51 PM, Guenter Roeck wrote:
> On Fri, Jun 21, 2019 at 10:52:43AM +0100, Vincenzo Frascino wrote:
>> The arm vDSO library requires some adaptations to use to take advantage
>> of the newly introduced generic vDSO library.
>>
>> Introduce the following changes:
>>  - Modification vdso.c to be compliant with the common vdso datapage
>>  - Use of lib/vdso for gettimeofday
>>  - Implementation of elf note
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> This patch causes a crash with qemu's mcimx6ul-evk emulation while running
> imx_v6_v7_defconfig.
> 

Thank you for reporting this. Could you please provide some details on how I can
reproduce the scenario you are describing?

> [   19.976852] Run /sbin/init as init process
> [   20.044931] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> 
> There is nothing else useful in the log, unfortunately.
> 
> Reverting the following three patches fixes the problem.
> 
> 74d06efb9c2f ARM: 8932/1: Add clock_gettime64 entry point
> 052e76a31b4a ARM: 8931/1: Add clock_getres entry point
> 20e2fc42312f ARM: 8930/1: Add support for generic vDSO
> 
> Guenter
> 

-- 
Regards,
Vincenzo
