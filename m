From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
Date: Thu, 30 Aug 2018 14:35:59 +0200
Message-ID: <20180830123559.GF20005@nazgul.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 08:42:49PM +0800, Pu Wen wrote:
> Add x86 architecture support for new processor Hygon Dhyana Family 18h.
> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
> AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU. In
> this way we can remove old AMD architecture support codes from Hygon
> code path and generate a clear initialization flow for Hygon processors.
> It also reduce long-term maintenance effort.
> Also add Maintainer information for hygon.c in accordance.
> 
> To identify Hygon processors, add a new vendor type X86_VENDOR_HYGON(9)
> for system recognition.
> 
> To enable Hygon processor config, add a separated Kconfig entry
> (CPU_SUP_HYGON) for Dhyana CPU in kernel config setup.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  MAINTAINERS                      |   6 +
>  arch/x86/Kconfig.cpu             |  13 ++
>  arch/x86/include/asm/processor.h |   3 +-
>  arch/x86/kernel/cpu/Makefile     |   1 +
>  arch/x86/kernel/cpu/hygon.c      | 408 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 430 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/cpu/hygon.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b..9c1d920 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6759,6 +6759,12 @@ S:	Maintained
>  F:	mm/memory-failure.c
>  F:	mm/hwpoison-inject.c
>  
> +HYGON PROCESSOR SUPPORT
> +M:	Pu Wen <puwen@hygon.cn>
> +L:	linux-arch@vger.kernel.org

This is probably the wrong ML. You either have your own or use lkml, I'd
say.

> +S:	Supported
> +F:	arch/x86/kernel/cpu/hygon.c
> +
>  Hyper-V CORE AND DRIVERS
>  M:	"K. Y. Srinivasan" <kys@microsoft.com>
>  M:	Haiyang Zhang <haiyangz@microsoft.com>
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 638411f..2e92267 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -426,6 +426,19 @@ config CPU_SUP_AMD
>  
>  	  If unsure, say N.
>  
> +config CPU_SUP_HYGON
> +	default y
> +	bool "Support Hygon processors" if PROCESSOR_SELECT
> +	help
> +	  This enables detection, tunings and quirks for Hygon processors
> +
> +	  You need this enabled if you want your kernel to run on an
> +	  Hygon CPU. Disabling this option on other types of CPUs
> +	  makes the kernel a tiny bit smaller. Disabling it on an Hygon
> +	  CPU might render the kernel unbootable.
> +
> +	  If unsure, say N.
> +
>  config CPU_SUP_CENTAUR
>  	default y
>  	bool "Support Centaur processors" if PROCESSOR_SELECT
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index c242972..9f18cdb 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -153,7 +153,8 @@ enum cpuid_regs_idx {
>  #define X86_VENDOR_CENTAUR	5
>  #define X86_VENDOR_TRANSMETA	7
>  #define X86_VENDOR_NSC		8
> -#define X86_VENDOR_NUM		9
> +#define X86_VENDOR_HYGON	9
> +#define X86_VENDOR_NUM		10
>  
>  #define X86_VENDOR_UNKNOWN	0xff
>  
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index 347137e..1f5d229 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
>  
>  obj-$(CONFIG_CPU_SUP_INTEL)		+= intel.o intel_pconfig.o
>  obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
> +obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
>  obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
>  obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
>  obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
> new file mode 100644
> index 0000000..ae90d1f
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/hygon.c
> @@ -0,0 +1,408 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hygon Processor Support for Linux
> + *
> + * Copyright (c) Chengdu Haiguang IC Design Co., Ltd.
> + *
> + * Author: 2018 Pu Wen <puwen@hygon.cn>

Year goes with the copyright.

Otherwise looks ok.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
