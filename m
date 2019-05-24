From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/8] arm64: Basic Branch Target Identification support
Date: Fri, 24 May 2019 14:02:17 +0100
Message-ID: <20190524130217.GA15566@lakrids.cambridge.arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
 <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>, "H.J. Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, Andrew Jones <drjones@redhat.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Sudakshina Das <sudi.das@arm.com>, Paul Elliott <paul.elliott@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi Dave,

This generally looks good, but I have a few comments below.

On Fri, May 24, 2019 at 11:25:29AM +0100, Dave Martin wrote:
> +#define arch_calc_vm_prot_bits(prot, pkey) arm64_calc_vm_prot_bits(prot)
> +static inline unsigned long arm64_calc_vm_prot_bits(unsigned long prot)
> +{
> +	if (system_supports_bti() && (prot & PROT_BTI_GUARDED))
> +		return VM_ARM64_GP;
> +
> +	return 0;
> +}
> +
> +#define arch_vm_get_page_prot(vm_flags) arm64_vm_get_page_prot(vm_flags)
> +static inline pgprot_t arm64_vm_get_page_prot(unsigned long vm_flags)
> +{
> +	return (vm_flags & VM_ARM64_GP) ? __pgprot(PTE_GP) : __pgprot(0);
> +}

While the architectural name for the PTE bit is GP, it might make more
sense to call the vm flag VM_ARM64_BTI, since people are more likely to
recognise BTI than GP as a mnemonic.

Not a big deal either way, though.

[...]

> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index b2de329..b868ef11 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -41,6 +41,7 @@
>  
>  /* Additional SPSR bits not exposed in the UABI */
>  #define PSR_IL_BIT		(1 << 20)
> +#define PSR_BTYPE_CALL		(2 << 10)

I thought BTYPE was a 2-bit field, so isn't there at leat one other
value to have a mnemonic for?

Is it an enumeration or a bitmask?

>  #endif /* _UAPI__ASM_HWCAP_H */
> diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
> new file mode 100644
> index 0000000..4776b43
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/mman.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI__ASM_MMAN_H
> +#define _UAPI__ASM_MMAN_H
> +
> +#include <asm-generic/mman.h>
> +
> +#define PROT_BTI_GUARDED	0x10		/* BTI guarded page */

From prior discussions, I thought this would be PROT_BTI, without the
_GUARDED suffix. Do we really need that?

AFAICT, all other PROT_* definitions only have a single underscore, and
the existing arch-specific flags are PROT_ADI on sparc, and PROT_SAO on
powerpc.

[...]

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index b82e0a9..3717b06 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1860,7 +1860,7 @@ void syscall_trace_exit(struct pt_regs *regs)
>   */
>  #define SPSR_EL1_AARCH64_RES0_BITS \
>  	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
> -	 GENMASK_ULL(20, 13) | GENMASK_ULL(11, 10) | GENMASK_ULL(5, 5))
> +	 GENMASK_ULL(20, 13) | GENMASK_ULL(5, 5))
>  #define SPSR_EL1_AARCH32_RES0_BITS \
>  	(GENMASK_ULL(63, 32) | GENMASK_ULL(22, 22) | GENMASK_ULL(20, 20))

Phew; I was worried this would be missed!

[...]

> @@ -741,6 +741,11 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
>  	regs->pc = (unsigned long)ka->sa.sa_handler;
>  
> +	if (system_supports_bti()) {
> +		regs->pstate &= ~(regs->pstate & PSR_BTYPE_MASK);

Nit: that can be:

		regs->pstate &= ~PSR_BTYPE_MASK;

> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 5610ac0..85b456b 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -66,6 +66,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  	unsigned long flags = current_thread_info()->flags;
>  
>  	regs->orig_x0 = regs->regs[0];
> +	regs->pstate &= ~(regs->pstate & PSR_BTYPE_MASK);

Likewise:

	regs->pstate &= ~PSR_BTYPE_MASK;

... though I don't understand why that would matter to syscalls, nor how
those bits could ever be set given we had to execute an SVC to get here.

What am I missing?

Thanks,
Mark.
