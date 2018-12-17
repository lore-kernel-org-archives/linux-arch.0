Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36700 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeLQP0Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Dec 2018 10:26:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so6539898pfc.3
        for <linux-arch@vger.kernel.org>; Mon, 17 Dec 2018 07:26:24 -0800 (PST)
Subject: Re: [PATCH v3 18/24] arm64: Add vDSO compat support
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-19-vincenzo.frascino@arm.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <483c4226-b56d-69aa-1638-9f495d801273@android.com>
Date: Mon, 17 Dec 2018 07:26:16 -0800
MIME-Version: 1.0
In-Reply-To: <20181213165746.56930-19-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181217152616.xkojU0melH8erxTTP04vtc241OfigMNwokXdu6Y49j8@z>

On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
> This patch adds vDSO compat support to the arm64 building system.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   arch/arm64/Kconfig         |  1 +
>   arch/arm64/Makefile        | 21 +++++++++++++++++++--
>   arch/arm64/kernel/Makefile |  6 +++++-
>   3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aafa18e2e7c4..ed9c36f0ccb9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -103,6 +103,7 @@ config ARM64
>   	select GENERIC_STRNLEN_USER
>   	select GENERIC_TIME_VSYSCALL
>   	select GENERIC_GETTIMEOFDAY
> +	select GENERIC_COMPAT_VDSO
>   	select HANDLE_DOMAIN_IRQ
>   	select HARDIRQS_SW_RESEND
>   	select HAVE_ACPI_APEI if (ACPI && EFI)
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..814d2b0ac017 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -49,9 +49,23 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>     endif
>   endif
>   
> -KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
> +ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
> +  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
> +
> +  ifeq ($(CROSS_COMPILE_ARM32),)
> +    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
> +  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
> +    $(error $(CROSS_COMPILE_ARM32)gcc not found, check CROSS_COMPILE_ARM32)
> +  else
> +    export CROSS_COMPILE_ARM32
> +    export CONFIG_COMPAT_VDSO := y
> +    compat_vdso := -DCONFIG_COMPAT_VDSO=1
> +  endif
> +endif
> +
> +KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
>   KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> -KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
> +KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
>   
>   KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>   KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
Does not build with clang

Do not hard-code gcc, use $(cc-name)

-- Mark
