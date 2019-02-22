Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33558 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfBVOkD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 09:40:03 -0500
Date: Fri, 22 Feb 2019 14:39:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 19/23] arm64: Enable compat vDSO support
Message-ID: <20190222143957.GN42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-20-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-20-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222143958.xygu9AzCPkhlhvV-GNHn2SSWJY8SnLKeYx3GvRG1qvg@z>

On Fri, Feb 22, 2019 at 12:24:26PM +0000, Vincenzo Frascino wrote:
> Enable compat vDSO support in the arm64 defconfig.
> 
> Note that the default compiler is set to arm-linux-gnueabihf-.
> For this to take effect and for the compat vDSO to compile correctly, it
> is required that this compiler is in the PATH.

I do not have such a compiler in my path by default.

I hope that we handle that gracefully, rather than causing a build
failure.

Can't we detect the presence of the compat compiler at config time, as
happens for the native compiler?

Thanks,
Mark.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c8432e24207e..3adebe5f3573 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -120,6 +120,7 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=y
>  CONFIG_ACPI_APEI_EINJ=y
>  CONFIG_VIRTUALIZATION=y
>  CONFIG_KVM=y
> +CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"
>  CONFIG_ARM64_CRYPTO=y
>  CONFIG_CRYPTO_SHA1_ARM64_CE=y
>  CONFIG_CRYPTO_SHA2_ARM64_CE=y
> -- 
> 2.20.1
> 
