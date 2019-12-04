From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing
 crash)
Date: Wed, 4 Dec 2019 05:51:59 -0800
Message-ID: <20191204135159.GA7210@roeck-us.net>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-17-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 21, 2019 at 10:52:43AM +0100, Vincenzo Frascino wrote:
> The arm vDSO library requires some adaptations to use to take advantage
> of the newly introduced generic vDSO library.
> 
> Introduce the following changes:
>  - Modification vdso.c to be compliant with the common vdso datapage
>  - Use of lib/vdso for gettimeofday
>  - Implementation of elf note
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This patch causes a crash with qemu's mcimx6ul-evk emulation while running
imx_v6_v7_defconfig.

[   19.976852] Run /sbin/init as init process
[   20.044931] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

There is nothing else useful in the log, unfortunately.

Reverting the following three patches fixes the problem.

74d06efb9c2f ARM: 8932/1: Add clock_gettime64 entry point
052e76a31b4a ARM: 8931/1: Add clock_getres entry point
20e2fc42312f ARM: 8930/1: Add support for generic vDSO

Guenter
