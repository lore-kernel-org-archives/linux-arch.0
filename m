Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33058 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbbBTUBN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Feb 2015 15:01:13 -0500
Date: Fri, 20 Feb 2015 21:00:19 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 14/18] ARM: Add STM32 family machine
Message-ID: <20150220200019.GU19388@pengutronix.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150220200019.b3jQv2XlxhyVTjYHPnEAOyQMPWFbNJqTQyjK6-Ni7UM@z>

Hello,

On Fri, Feb 20, 2015 at 07:01:13PM +0100, Maxime Coquelin wrote:
> STMicrolectronics's STM32 series is a family of Cortex-M
> microcontrollers. It is used in various applications, and
> proposes a wide range of peripherals.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  Documentation/arm/stm32/overview.txt           | 32 ++++++++++++++++++++++++++
>  Documentation/arm/stm32/stm32f429-overview.txt | 22 ++++++++++++++++++
>  arch/arm/Kconfig                               | 22 ++++++++++++++++++
>  arch/arm/Makefile                              |  1 +
>  arch/arm/mach-stm32/Makefile                   |  1 +
>  arch/arm/mach-stm32/Makefile.boot              |  0
>  arch/arm/mach-stm32/board-dt.c                 | 31 +++++++++++++++++++++++++
>  7 files changed, 109 insertions(+)
>  create mode 100644 Documentation/arm/stm32/overview.txt
>  create mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
>  create mode 100644 arch/arm/mach-stm32/Makefile
>  create mode 100644 arch/arm/mach-stm32/Makefile.boot
>  create mode 100644 arch/arm/mach-stm32/board-dt.c
> 
> diff --git a/Documentation/arm/stm32/overview.txt b/Documentation/arm/stm32/overview.txt
> new file mode 100644
> index 0000000..d8bf6bb
> --- /dev/null
> +++ b/Documentation/arm/stm32/overview.txt
> @@ -0,0 +1,32 @@
> +			STM32 ARM Linux Overview
> +			==========================
> +
> +Introduction
> +------------
> +
> +  The STMicroelectronics family of Cortex-M based MCUs are supported by the
> +  'STM32' platform of ARM Linux. Currently only the STM32F429 is supported.
> +
> +
> +Configuration
> +-------------
> +
> +  A generic configuration is provided for STM32 family, and can be used as the
> +  default by
> +	make stm32_defconfig
> +
> +Layout
> +------
> +
> +  All the files for multiple machine families are located in the platform code
> +  contained in arch/arm/mach-stm32
> +
> +  There is a generic board board-dt.c in the mach folder which support
> +  Flattened Device Tree, which means, It works with any compatible board with
> +  Device Trees.
> +
> +
> +Document Author
> +---------------
> +
> +  Maxime Coquelin <mcoquelin.stm32@gmail.com>
> diff --git a/Documentation/arm/stm32/stm32f429-overview.txt b/Documentation/arm/stm32/stm32f429-overview.txt
> new file mode 100644
> index 0000000..5206822
> --- /dev/null
> +++ b/Documentation/arm/stm32/stm32f429-overview.txt
> @@ -0,0 +1,22 @@
> +			STM32F429 Overview
> +			==================
> +
> +  Introduction
> +  ------------
> +	The STM32F429 is a Cortex-M4 MCU aimed at various applications.
> +	It features:
> +	- ARM Cortex-M4 up to 180MHz with FPU
> +	- 2MB internal Flash Memory
> +	- External memory support through FMC controller (PSRAM, SDRAM, NOR, NAND)
> +	- I2C, SPI, SAI, CAN, USB OTG, Ethernet controllers
> +	- LCD controller & Camera interface
> +	- Cryptographic processor
> +
> +  Resources
> +  ---------
> +	Datasheet and reference manual are publicly available on ST website:
> +	- http://www.st.com/web/en/catalog/mmc/FM141/SC1169/SS1577/LN1806?ecmp=stm32f429-439_pron_pr-ces2014_nov2013
> +
> +  Document Author
> +  ---------------
> +	Maxime Coquelin <mcoquelin.stm32@gmail.com>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 97d07ed..cfd9532 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -774,6 +774,28 @@ config ARCH_OMAP1
>  	help
>  	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
>  
> +config ARCH_STM32
> +	bool "STMicrolectronics STM32"
> +	depends on !MMU
> +	select ARCH_REQUIRE_GPIOLIB
> +	select ARM_NVIC
> +	select AUTO_ZRELADDR
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select RESET_CONTROLLER
> +	select PINCTRL
> +	select PINCTRL_STM32
> +	select CLKSRC_OF
> +	select ARMV7M_SYSTICK
> +	select COMMON_CLK
> +	select CPU_V7M
> +	select GENERIC_CLOCKEVENTS
> +	select NO_DMA
> +	select NO_IOPORT_MAP
> +	select SPARSE_IRQ
> +	select USE_OF
Please sort this list alphabetically.

> +	help
> +	  Support for STMicorelectronics STM32 processors.
> +
>  endchoice
>  
>  menu "Multiple platform selection"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c1785ee..7d00659 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -196,6 +196,7 @@ machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
>  machine-$(CONFIG_ARCH_SIRF)		+= prima2
>  machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
>  machine-$(CONFIG_ARCH_STI)		+= sti
> +machine-$(CONFIG_ARCH_STM32)		+= stm32
>  machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
>  machine-$(CONFIG_ARCH_TEGRA)		+= tegra
>  machine-$(CONFIG_ARCH_U300)		+= u300
> diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
> new file mode 100644
> index 0000000..bd0b7b5
> --- /dev/null
> +++ b/arch/arm/mach-stm32/Makefile
> @@ -0,0 +1 @@
> +obj-y += board-dt.o
> diff --git a/arch/arm/mach-stm32/Makefile.boot b/arch/arm/mach-stm32/Makefile.boot
> new file mode 100644
> index 0000000..e69de29
Maybe note there why this file exists and can be empty. Feel free to
copy the content of efm32's Makefile.boot.

> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> new file mode 100644
> index 0000000..1d681b3
> --- /dev/null
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (C) Maxime Coquelin 2015
> + * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
> +#include <linux/reset-controller.h>
> +#include <asm/v7m.h>
> +#include <asm/mach/arch.h>
> +
> +static const char *const stm32_compat[] __initconst = {
> +	"st,stm32f429",
> +	NULL
> +};
> +
> +static void __init stm32_timer_init(void)
> +{
> +	of_clk_init(NULL);
> +	reset_controller_of_init();
> +	clocksource_of_init();
Hmm, if reset_controller_of_init was called automatically you wouldn't
need that, right? Maybe arange for that instead?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
