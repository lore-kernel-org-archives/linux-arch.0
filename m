Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:49200 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605AbbBTSkc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Feb 2015 13:40:32 -0500
Date: Fri, 20 Feb 2015 19:33:26 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 14/18] ARM: Add STM32 family machine
In-Reply-To: <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <alpine.DEB.2.02.1502201930040.2739@pmeerw.net>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com> <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150220183326.-YgXViFDp_yXsnyO7logAWiMOPgebFm4Ezo3M9_e9Fs@z>


> STMicrolectronics's STM32 series is a family of Cortex-M
> microcontrollers. It is used in various applications, and
> proposes a wide range of peripherals.

the text describing the STM32 could be a bit more specific :)
some more nitpicking below

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

overlong ===

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

it (lowercase)

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
> +	help
> +	  Support for STMicorelectronics STM32 processors.

STMicroelectronics

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
> +
> +}
> +
> +DT_MACHINE_START(STM32DT, "STM32 (Device Tree Support)")
> +	.init_time = stm32_timer_init,
> +	.dt_compat = stm32_compat,
> +	.restart = armv7m_restart,
> +MACHINE_END
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
