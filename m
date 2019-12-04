From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing
 crash)
Date: Wed, 4 Dec 2019 08:16:41 -0800
Message-ID: <20191204161641.GA28130@roeck-us.net>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com>
 <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 04, 2019 at 01:58:25PM +0000, Vincenzo Frascino wrote:
> Hi Guenter,
> 
> On 12/4/19 1:51 PM, Guenter Roeck wrote:
> > On Fri, Jun 21, 2019 at 10:52:43AM +0100, Vincenzo Frascino wrote:
> >> The arm vDSO library requires some adaptations to use to take advantage
> >> of the newly introduced generic vDSO library.
> >>
> >> Introduce the following changes:
> >>  - Modification vdso.c to be compliant with the common vdso datapage
> >>  - Use of lib/vdso for gettimeofday
> >>  - Implementation of elf note
> >>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > 
> > This patch causes a crash with qemu's mcimx6ul-evk emulation while running
> > imx_v6_v7_defconfig.
> > 
> 
> Thank you for reporting this. Could you please provide some details on how I can
> reproduce the scenario you are describing?
> 
- Build imx_v6_v7_defconfig
- Get root file system or initrd, for example from
  https://github.com/groeck/linux-build-test/tree/master/rootfs/arm
- Run image. Example, with initrd:
	qemu-system-arm -M mcimx6ul-evk -kernel arch/arm/boot/zImage \
		-no-reboot -initrd rootfs-armv7a.cpio \
		-m 256 -display none -serial null \
		--append 'rdinit=/sbin/init earlycon=ec_imx6q,mmio,0x21e8000,115200n8 console=ttymxc1,115200'
		-dtb arch/arm/boot/dts/imx6ul-14x14-evk.dtb \
		-nographic -monitor null -serial stdio

qemu has to be v3.1 or later to support the machine.

Hope this helps,
Guenter
