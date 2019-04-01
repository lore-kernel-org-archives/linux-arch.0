Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfDAOtC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 10:49:02 -0400
Date: Mon, 1 Apr 2019 15:48:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/4] arm64: compat: Add KUSER_HELPERS config option
Message-ID: <20190401144855.GJ14874@arrakis.emea.arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401112025.40807-5-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190401144856._IozsBNPL3P0XWJruhUZSuhUIMcH1imubiZWRucgk84@z>

On Mon, Apr 01, 2019 at 12:20:25PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e34b9eba5de..35c98e91bfeb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1494,6 +1494,36 @@ config COMPAT
>  
>  	  If you want to execute 32-bit userspace applications, say Y.
>  
> +config KUSER_HELPERS
> +	bool "Enable kuser helpers page for compatibility with 32 bit applications."

I'd say only "Enable kuser helpers page for 32-bit applications" (my
first reading of this sounded like it would be enabled for 64-bit apps
to be on par with 32-bit ones).

> +	depends on COMPAT
> +	default y
> +	help
> +	  Warning: disabling this option may break user programs.

"may break 32-bit user programs."

> +
> +	  Provide kuser helpers to compat tasks. The kernel provides
> +	  helper code to userspace in read only form at a fixed location
> +	  to allow userspace to be independent of the CPU type fitted to
> +	  the system. This permits binaries to be run on ARMv4 through
> +	  to ARMv8 without modification.
> +
> +	  See Documentation/arm/kernel_user_helpers.txt for details.
> +
> +	  However, the fixed address nature of these helpers can be used
> +	  by ROP (return orientated programming) authors when creating
> +	  exploits.
> +
> +	  If all of the binaries and libraries which run on your platform
> +	  are built specifically for your platform, and make no use of
> +	  these helpers, then you can turn this option off to hinder
> +	  such exploits. However, in that case, if a binary or library
> +	  relying on those helpers is run, it will not function correctly.
> +
> +	  Note: kuser helpers is disabled by default with 64K pages.

Is it?

> +
> +	  Say N here only if you are absolutely certain that you do not
> +	  need these helpers; otherwise, the safe option is to say Y.
> +

-- 
Catalin
