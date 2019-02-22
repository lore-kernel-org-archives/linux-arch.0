Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfBVOWK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 09:22:10 -0500
Date: Fri, 22 Feb 2019 14:22:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 11/23] arm64: compat: Generate asm offsets for signals
Message-ID: <20190222142204.GK42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-12-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-12-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222142205.yZXRsXixH1rt5I3OH1WfmM_injIfrkAhmK6-PaekdZE@z>

On Fri, Feb 22, 2019 at 12:24:18PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
> index 1f05268f4c6d..a6fd7be1b22a 100644
> --- a/arch/arm64/include/asm/signal32.h
> +++ b/arch/arm64/include/asm/signal32.h
> @@ -52,7 +52,7 @@ struct compat_ucontext {
>  	compat_stack_t			uc_stack;
>  	struct compat_sigcontext	uc_mcontext;
>  	compat_sigset_t			uc_sigmask;
> -	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
> +	int				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];

Spurious whitespace change?

> +/* Macros for asm-offsets.c */
> +#define OFFSET_OF_COMPAT_SIGFRAME_REGS (				\
> +			offsetof(struct compat_sigframe, uc) +		\
> +			offsetof(struct compat_ucontext, uc_mcontext) +	\
> +			offsetof(struct compat_sigcontext, arm_r0))
> +
> +#define OFFSET_OF_COMPAT_RT_SIGFRAME_REGS (				\
> +			offsetof(struct compat_rt_sigframe, sig) +	\
> +			offsetof(struct compat_sigframe, uc) +		\
> +			offsetof(struct compat_ucontext, uc_mcontext) +	\
> +			offsetof(struct compat_sigcontext, arm_r0))
> +
>  int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
>  		       struct pt_regs *regs);
>  int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 4adb52190a90..afd28ccda174 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -30,6 +30,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
> +#include <asm/signal32.h>
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  #include <linux/kbuild.h>
> @@ -84,6 +85,11 @@ int main(void)
>    DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
>    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
>    BLANK();
> +#ifdef CONFIG_COMPAT
> +  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		OFFSET_OF_COMPAT_SIGFRAME_REGS);
> +  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	OFFSET_OF_COMPAT_RT_SIGFRAME_REGS);

Can't we do:

DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_sigframe, uc.us_mcontext.arm_r0)
DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_rt_sigframe, sig.uc.us_mcontext.arm_r0)

... and avoid the OFFSET_OF_* macros entirely?

Thanks,
Mark.
