Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbfDBJA3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 05:00:29 -0400
Subject: Re: [PATCH 2/5] powerpc: Fix vDSO clock_getres()
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-3-vincenzo.frascino@arm.com>
 <f54a24fe-f893-10c9-9177-4985bad2e745@c-s.fr>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f4919c8a-e0dd-ab78-d6a3-b792fa388aa9@arm.com>
Date: Tue, 2 Apr 2019 10:00:25 +0100
MIME-Version: 1.0
In-Reply-To: <f54a24fe-f893-10c9-9177-4985bad2e745@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>
Message-ID: <20190402090025.rDGKpoQzC7K4sKSo-1Hu_C980w2e4YYkPm1knNKmxcI@z>

Hi Christophe,

thank you for your review.

On 02/04/2019 06:54, Christophe Leroy wrote:
> 
> 
> On 04/01/2019 11:51 AM, Vincenzo Frascino wrote:
>> clock_getres in the vDSO library has to preserve the same behaviour
>> of posix_get_hrtimer_res().
>>
>> In particular, posix_get_hrtimer_res() does:
>>      sec = 0;
>>      ns = hrtimer_resolution;
>> and hrtimer_resolution depends on the enablement of the high
>> resolution timers that can happen either at compile or at run time.
>>
>> Fix the powerpc vdso implementation of clock_getres keeping a copy of
>> hrtimer_resolution in vdso data and using that directly.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   arch/powerpc/include/asm/vdso_datapage.h  |  2 ++
> 
> Conflicts with commit b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC 
> inconsistencies across Y2038")
> 

Thanks for pointing this out, I will rebase my code on top of the latest version
before reissuing v2.

...

-- 
Regards,
Vincenzo
