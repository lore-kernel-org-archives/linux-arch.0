Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:47646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfFTQ15 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 12:27:57 -0400
Date: Thu, 20 Jun 2019 17:27:46 +0100
From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
Message-ID: <20190620172746.7f92cb14@donnerap.cambridge.arm.com>
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huw Davies <huw@codeweavers.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190620162746.j70VIB0J8lHow66s1orFAAymjVlsGR17w1Cj2DCIfnM@z>

On Thu, 30 May 2019 15:15:12 +0100
Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:

Hi,

> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
> [ ... ]
> The porting has been benchmarked and the performance results are
> provided as part of this cover letter.

I can't reveal the absolute numbers here, but vdsotest-bench gives me
quite some performance gain on my board here ("time needed on v6" divided
by "time needed on 5.2-rc1", so smaller percentages are better):
clock-gettime-monotonic:	23 %
clock-gettime-monotonic-raw:	30 %
clock-gettime-tai:		 5 %
clock-getres-tai:		 5 %
clock-gettime-boottime:		 5 %
clock-getres-boottime:		 5 %
clock-gettime-realtime:		25 %
gettimeofday:			26 % 
The other numbers stayed the same or differed by just 1 ns, which seems to
be within the margin of error, as repeated runs on the same kernel suggest.
The 5% numbers are of course those were we went from a syscall-only to the
newly added arm64 VDSO implementation, but even the other calls improved
by a factor of 3 or more.

Sounds like a strong indicator that this is a good thing to have.

Not sure if "running some benchmark a couple of times on a single machine"
qualifies for this, but I guess it means:

Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.
