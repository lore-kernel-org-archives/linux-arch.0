Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55420 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1Nms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Feb 2019 08:42:48 -0500
Date: Thu, 28 Feb 2019 14:42:41 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] vdso: use fixed-size time types
In-Reply-To: <20190228115855.610027-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1902281440340.1821@nanos.tec.linutronix.de>
References: <CAK8P3a2D44CDXbcKB-WtphYY9E74ovFPs+e4Ti3fUqRL77AYhw@mail.gmail.com> <20190228115855.610027-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190228134241.6Kly3YmFyxsoXZz6gaW6pohp2U_--iDJw0dBX7xMADM@z>

On Thu, 28 Feb 2019, Arnd Bergmann wrote:

> Hi Vincento,
> 
> I've implemented now what I tried to explain earlier.  This moves the
> implementation of clock_gettime() and clock_getres() over to 64-bit
> __kernel_timespec, with a conversion in the end for architectures that
> actually use the 32-bit calls.
> 
> The vdso/types.h file is now obsolete, but we do need to duplicate
> a few functions on mips32 and x86-32. It may be possible to fold those
> into the generic lib/vdso/gettimeofday.c file as another step.
> 
> If there are no objections, please fold these changes into your
> series.

Please write the new generic code in that way and apply the architecture
changes when converting them over.

Thanks,

	tglx
