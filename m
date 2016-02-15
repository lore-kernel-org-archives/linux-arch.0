From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ARM: remove asm/gpio.h
Date: Mon, 15 Feb 2016 16:03:06 +0000
Message-ID: <20160215160305.GG10826@n2100.arm.linux.org.uk>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
 <1455551208-2825510-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:53399 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcBOQDW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Feb 2016 11:03:22 -0500
Content-Disposition: inline
In-Reply-To: <1455551208-2825510-5-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Feb 15, 2016 at 04:46:31PM +0100, Arnd Bergmann wrote:
> -#if CONFIG_ARCH_NR_GPIO > 0
> -#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
> -#endif
...
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 40ec1433f05d..2d04b321db13 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -26,8 +26,12 @@
>   */
>  
>  #ifndef ARCH_NR_GPIOS
> +#ifdef CONFIG_ARCH_NR_GPIO
> +#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
> +#else
>  #define ARCH_NR_GPIOS		512
>  #endif
> +#endif

This really isn't the same thing, especially when you look at:

config ARCH_NR_GPIO
        int
        default 1024 if ARCH_BRCMSTB || ARCH_SHMOBILE || ARCH_TEGRA || \
                ARCH_ZYNQ
        default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
                SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
        default 416 if ARCH_SUNXI
        default 392 if ARCH_U8500
        default 352 if ARCH_VT8500
        default 288 if ARCH_ROCKCHIP
        default 264 if MACH_H4700
        default 0

This has the effect of causing anything not mentioned above to end up
with ARCH_NR_GPIOS set to zero.

You really should _not_ be making these kinds of functional changes
when moving code around.  Separate the two changes: either first move
the code, and have a separate patch to make the functional changes, or
make the functional changes first, and then move the code around.

I'd have thought you would've known this by now...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
