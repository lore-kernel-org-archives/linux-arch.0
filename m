Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56761 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933865AbYBMW4S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2008 17:56:18 -0500
Date: Wed, 13 Feb 2008 22:50:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
Message-ID: <20080213225058.GA20358@flint.arm.linux.org.uk>
References: <200802132330.23817.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200802132330.23817.alessandro.guido@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

On Wed, Feb 13, 2008 at 11:30:23PM +0100, Alessandro Guido wrote:
> Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9619c43..2e21703 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -948,8 +948,6 @@ endmenu
>  
>  if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP || ARCH_IMX || ARCH_PXA)
>  
> -menu "CPU Frequency scaling"
> -
>  source "drivers/cpufreq/Kconfig"
>  
>  config CPU_FREQ_SA1100
> @@ -988,8 +986,6 @@ config CPU_FREQ_PXA
>  	default y
>  	select CPU_FREQ_DEFAULT_GOV_USERSPACE
>  
> -endmenu
> -

Doesn't this cause these CPUFREQ options to appear outside of the CPUFREQ
menu?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
