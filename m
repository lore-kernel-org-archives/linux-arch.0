Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:49274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfFXMvC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 08:51:02 -0400
Date: Mon, 24 Jun 2019 13:50:55 +0100
From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Message-ID: <20190624135055.7020fc2a@donnerap.cambridge.arm.com>
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>
Message-ID: <20190624125055.0sjcT7z-l99OwFmnNQzDwtEy-DC2rScdeVI_S9L5BUU@z>

On Fri, 21 Jun 2019 10:52:27 +0100
Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:

Hi,

> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
[ ... ]

Some numbers for the ARM(32) part:

I booted my trusted old Calxeda Midway server (Cortex A-15 cores) and ran
the vdsotest benchmark on it. The results are:
(vdso: times, in nsec/call; n/t: "not tested" (=not implemented))
call				5.2-rc3	5.2-rc3-vdso
clock-gettime-monotonic:        147     142
clock-getres-monotonic:         n/t     34
clock-gettime-monotonic-coarse: 90      96
clock-getres-monotonic-coarse:  n/t     36
clock-gettime-monotonic-raw:    431     142
clock-getres-monotonic-raw:     n/t     35
clock-gettime-tai:              598     150
clock-getres-tai:               n/t     34
clock-gettime-boottime:         592     142
clock-getres-boottime:          n/t     34
clock-gettime-realtime:         149     142
clock-getres-realtime:          n/t     34
clock-gettime-realtime-coarse:  86      96
clock-getres-realtime-coarse:   n/t     36
getcpu:                         n/t     n/t
gettimeofday:                   133     110

So there are some minor improvements, two minor regressions, some
significant improvements (factor 3-4), and some dramatic improvements
(where we actually gained VDSO support).
Overall a pretty impressive outcome for an "Odd fixes" architecture,
especially as it should reduce the future maintenance burden.

Cheers,
Andre.
