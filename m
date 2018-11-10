Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:34128 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJKMZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Nov 2018 05:12:25 -0500
Date: Fri, 09 Nov 2018 16:29:20 -0800 (PST)
Message-ID: <20181109.162920.1263908485037438031.davem@davemloft.net>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C
 implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181109123730.8743-8-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
        <20181109123730.8743-8-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vincenzo.frascino@arm.com
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com
Message-ID: <20181110002920.5F161NLR6ZEcB5gg7on9nn7ZVEZVGB282x9rFhOtuCE@z>

From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Date: Fri,  9 Nov 2018 12:37:10 +0000

> To take advantage of the commonly defined vdso interface for
> gettimeofday the architectural code requires an adaptation.
> 
> This patch re-implements the gettimeofday vdso in C in order to use
> lib/vdso.
> 
> With the new implementation arm64 gains support for CLOCK_BOOTTIME,
> CLOCK_TAI and __kernel_time.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

What is the performance penalty for going to C from ASM like this?

I like the vDSO consolidation, but actually I think it makes a lot of
sense to implement these things in assembler with some C implementation
as guidance or for architectures that haven't optimized into an ASM
version yet.

I'd also like to see if we can somehow make PowerPC's optimizations in
this area usable in more places.

It defines a reciprocal in order to use a multiply instead of a divide
after capturing the time values.

I say all of this because I want to do something similar on sparc, and
having a generic implementation of all of the math would make that easier
for me and other architecture maintainers who might want to do the same.
