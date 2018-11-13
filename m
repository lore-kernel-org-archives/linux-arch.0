Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51388 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbeKMUVw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Nov 2018 15:21:52 -0500
Subject: Re: [PATCH 06/27] kernel: Define gettimeofday vdso common code
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-7-vincenzo.frascino@arm.com>
 <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <61f77f06-396e-9293-c8cc-28fe7ea32af5@arm.com>
Date: Tue, 13 Nov 2018 10:24:22 +0000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181113102422.Pz0ZawzYjREYtxN4CVg7UPAdbpLoQys9Yj1FHCK3Ung@z>


On 10/11/2018 16:18, Arnd Bergmann wrote:
> On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
>>
>> This patch tries to unify the gettimeofday vdso implementation
>> introducing lib/vdso. The code contained in this library can
>> ideally be reused by all the architectures avoiding, where
>> possible, code duplication.
>>
>> In doing so, tries to maintain the performances using inlining as much
>> as possible and consequently reduces the surface for ROP type of attacks.
>>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> I just noticed that this new version misses some of the cleanups
> that Thomas recently did in the x86 version, e.g. f3e839384164
> ("x86/vdso: Replace the clockid switch case").
> 
> I haven't looked at all the details, but I'd suggest using the latest
> x86 code as a base.
> 

Ok, I will have a look at Thomas' work. Thanks for pointing this out. 

>         Arnd
> 

-- 
Regards,
Vincenzo
