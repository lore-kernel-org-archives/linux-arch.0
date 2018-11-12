Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40400 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKMEPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2018 23:15:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id x2-v6so4697653pfm.7
        for <linux-arch@vger.kernel.org>; Mon, 12 Nov 2018 10:21:15 -0800 (PST)
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C
 implementation
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <20181109.162920.1263908485037438031.davem@davemloft.net>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <1b41ccb3-34dc-e579-f65d-328400cf2b8a@android.com>
Date: Mon, 12 Nov 2018 10:21:12 -0800
MIME-Version: 1.0
In-Reply-To: <20181109.162920.1263908485037438031.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, vincenzo.frascino@arm.com
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, pcc@google.com
Message-ID: <20181112182112.uyMs1pMnnoc85S1FAK0gEMvwt-T2Z0iC8bEDFpikf6s@z>

On 11/09/2018 04:29 PM, David Miller wrote:
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
>
> I say all of this because I want to do something similar on sparc, and
> having a generic implementation of all of the math would make that easier
> for me and other architecture maintainers who might want to do the same.

I saw an _improvement_ in performance for the C implementation (for 
arm64), the optimizer did a better job with the specific processor 
architecture and actually killed a few bugs in the assembler 
implementation. The improvement was in the order of a nano-second or two 
in micro-benchmarks.

I used the bionic benchmarks to measure the performance.

-- Mark
