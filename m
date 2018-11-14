Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbeKNUZe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Nov 2018 15:25:34 -0500
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C
 implementation
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <20181109.162920.1263908485037438031.davem@davemloft.net>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b455064b-4ffe-3ed3-6fa1-ee65e78f054b@arm.com>
Date: Wed, 14 Nov 2018 10:22:52 +0000
MIME-Version: 1.0
In-Reply-To: <20181109.162920.1263908485037438031.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com
Message-ID: <20181114102252.9YOGVQe5dqrpvm9UnAqp7xdEfi3IGSYvkWpUetA8gEI@z>

Hi David,

thank you for reviewing my code.

On 10/11/2018 00:29, David Miller wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Date: Fri,  9 Nov 2018 12:37:10 +0000
> 
>> To take advantage of the commonly defined vdso interface for
>> gettimeofday the architectural code requires an adaptation.
>>
>> This patch re-implements the gettimeofday vdso in C in order to use
>> lib/vdso.
>>
>> With the new implementation arm64 gains support for CLOCK_BOOTTIME,
>> CLOCK_TAI and __kernel_time.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> What is the performance penalty for going to C from ASM like this?
> 
> I like the vDSO consolidation, but actually I think it makes a lot of
> sense to implement these things in assembler with some C implementation
> as guidance or for architectures that haven't optimized into an ASM
> version yet.
> 
> I'd also like to see if we can somehow make PowerPC's optimizations in
> this area usable in more places.
> 
> It defines a reciprocal in order to use a multiply instead of a divide
> after capturing the time values.
> > I say all of this because I want to do something similar on sparc, and
> having a generic implementation of all of the math would make that easier
> for me and other architecture maintainers who might want to do the same.
> 

I did run some benchmarks on arm64 with both vdsotest-bench (I added a
script to the vdsotest implementation that can be used to replicate the
results) and an ad-hoc test that stresses the vdso library and the
differences in terms of performance penalty are very little (~1%) to
none in some cases.  

-- 
Regards,
Vincenzo
