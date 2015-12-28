From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
Date: Mon, 28 Dec 2015 12:38:01 +0100
Message-ID: <2456668.ZPsJrdbq6k@wuerfel>
References: <1451146000-5646-1-git-send-email-ynorov@caviumnetworks.com> <1451146000-5646-3-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62144 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbL1LiN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Dec 2015 06:38:13 -0500
In-Reply-To: <1451146000-5646-3-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, klimov.linux@gmail.com

On Saturday 26 December 2015 19:06:40 Yury Norov wrote:
> All new 32-bit architectures should have 64-bit off_t type, but existing
> architectures has 32-bit ones.

It's worth mentioning here that ever the architectures that only have
64-bit off_t in the kernel ( arc, c6x, h8300, hexagon, metag, nios2, opernrisc,
tile32 and unicore32) may use a libc with 32-bit off_t in their libc,
and therefore want to limit the file size to 4GB unless specified differently
in the open flags.

> To handle it, new config option is added to arch/Kconfig that defaults
> ARCH_32BIT_OFF_T to be disabled by default. All existing 32-bit architectures
> enable it explicitly here.
> 
> New option affects force_o_largefile() behaviour. Namely, if off_t is
> 64-bits long, we have no reason to reject user to open big files.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

The patch looks mostly right, just a few stylistic comments:


> diff --git a/arch/Kconfig b/arch/Kconfig
> index 4e949e5..1e5e6c8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -233,6 +233,10 @@ config ARCH_THREAD_INFO_ALLOCATOR
>  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	bool
>  
> +config ARCH_32BIT_OFF_T
> +	def_bool n
> +	depends on !64BIT

'bool' is the same as 'def_bool n', and the former is more common, so please
use that.

> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -11,6 +11,7 @@ menu "Processor type and features"
>  
>  config IA64
>  	bool
> +	select ARCH_32BIT_OFF_T if !64BIT
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
>  	select PCI if (!IA64_HP_SIM)

No need to patch IA64, we don't support 32-bit kernels on that architecture

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index db49e0d..2026a9e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -7,6 +7,7 @@ config PPC32
>  config 32BIT
>  	bool
>  	default y if PPC32
> +	select ARCH_32BIT_OFF_T
>  
>  config 64BIT
>  	bool

It seems the preferred way of writing this in powerpc is to put

	select ARCH_32BIT_OFF_T if PPC32

under config PPC

> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3a55f49..d05a143 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -64,6 +64,7 @@ config ARCH_SUPPORTS_UPROBES
>  
>  config S390
>  	def_bool y
> +	select ARCH_32BIT_OFF_T if !64BIT
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>  	select ARCH_HAS_ELF_RANDOMIZE

32-bit s390 support was removed some time ago, so this is no longer
needed.

> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 76ce329..2e27443 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -5,7 +5,8 @@
>  
>  
>  #ifndef force_o_largefile
> -#define force_o_largefile() (BITS_PER_LONG != 32)
> +#define force_o_largefile() ((BITS_PER_LONG != 32)			\
> +				|| !IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
>  #endif
>  
>  #if BITS_PER_LONG == 32

I just realized that while I suggested the expression you wrote here, the
BITS_PER_LONG check isn't actually needed, we can just make it

#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))

	Arnd
