Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56456 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1753917AbWKFXRp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2006 18:17:45 -0500
Subject: Re: [matthew@wil.cx: Re: Which architectures need 64-bit
	resources?]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20061106222935.GQ27140@parisc-linux.org>
References: <20061106222935.GQ27140@parisc-linux.org>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 10:17:43 +1100
Message-Id: <1162855063.28571.365.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


> Here's a proposed patch (which needs buy-in from the ARM, MIPS and
> PowerPC guys, plus anyone who knows about x86-32 machines with 64-bit
> IO).  Grepping the arch/*/configs/* doesn't show anyone else using it by
> default.

For the ppc bits:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> I got the info for ARM from Vince Sanders, and made my best guess for
> MIPS & PPC.  This patch is entirely untested.
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index adb05de..d73cf59 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -241,6 +241,7 @@ config ARCH_IXP23XX
>   	bool "IXP23XX-based"
>  	depends on MMU
>   	select PCI
> +	select RESOURCES_64BIT
>  	help
>  	  Support for Intel's IXP23xx (XScale) family of processors.
>  
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 8a49884..f0205e0 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1556,6 +1556,7 @@ config SB1_PASS_2_1_WORKAROUNDS
>  config 64BIT_PHYS_ADDR
>  	bool "Support for 64-bit physical address space"
>  	depends on (CPU_R4X00 || CPU_R5000 || CPU_RM7000 || CPU_RM9000 || CPU_R10000 || CPU_SB1 || CPU_MIPS32 || CPU_MIPS64) && 32BIT
> +	select RESOURCES_64BIT
>  
>  config CPU_HAS_LLSC
>  	bool
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8b69104..29ab1e0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -227,10 +227,11 @@ config PTE_64BIT
>  config PHYS_64BIT
>  	bool 'Large physical address support' if E500
>  	depends on 44x || E500
> +	select RESOURCES_64BIT
>  	default y if 44x
>  	---help---
>  	  This option enables kernel support for larger than 32-bit physical
> -	  addresses.  This features is not be available on all e500 cores.
> +	  addresses.  This features is not available on all e500 cores.
>  
>  	  If in doubt, say N here.
>  
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 734ce95..613942d 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -92,9 +92,14 @@ config TEXTSEARCH_FSM
>  	tristate
>  
>  #
> -# plist support is select#ed if needed
> +# plist support is selected if needed
>  #
>  config PLIST
>  	boolean
>  
> +# 64-bit resources are selected by individual architectures
> +config RESOURCES_64BIT
> +	bool
> +	default 64BIT
> +
>  endmenu
> diff --git a/mm/Kconfig b/mm/Kconfig
> index db7c55d..089513f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -151,9 +151,3 @@ config MIGRATION
>  	  while the virtual addresses are not changed. This is useful for
>  	  example on NUMA systems to put pages nearer to the processors accessing
>  	  the page.
> -
> -config RESOURCES_64BIT
> -	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
> -	default 64BIT
> -	help
> -	  This option allows memory and IO resources to be 64 bit.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ----- End forwarded message -----

