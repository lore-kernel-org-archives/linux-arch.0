Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:33928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfJKOWE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 10:22:04 -0400
Date: Fri, 11 Oct 2019 15:21:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 11/12] arm64: BTI: Reset BTYPE when skipping emulated
 instructions
Message-ID: <20191011142157.GC33537@lakrids.cambridge.arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-12-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570733080-21015-12-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <richard.henderson@linaro.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191011142158.iz_t-i80Mo6HEpZk50luwn6stMy6xT95onVyQ8BHxPs@z>

On Thu, Oct 10, 2019 at 07:44:39PM +0100, Dave Martin wrote:
> Since normal execution of any non-branch instruction resets the
> PSTATE BTYPE field to 0, so do the same thing when emulating a
> trapped instruction.
> 
> Branches don't trap directly, so we should never need to assign a
> non-zero value to BTYPE here.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kernel/traps.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 3af2768..4d8ce50 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -331,6 +331,8 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  
>  	if (regs->pstate & PSR_MODE32_BIT)
>  		advance_itstate(regs);
> +	else
> +		regs->pstate &= ~(u64)PSR_BTYPE_MASK;

This looks good to me, with one nit below.

We don't (currently) need the u64 cast here, and it's inconsistent with
what we do elsewhere. If the upper 32-bit of pstate get allocated, we'll
need to fix up all the other masking we do:

[mark@lakrids:~/src/linux]% git grep 'pstate &= ~'
arch/arm64/kernel/armv8_deprecated.c:           regs->pstate &= ~PSR_AA32_E_BIT;
arch/arm64/kernel/cpufeature.c:         regs->pstate &= ~PSR_SSBS_BIT;
arch/arm64/kernel/debug-monitors.c:     regs->pstate &= ~DBG_SPSR_SS;
arch/arm64/kernel/insn.c:       pstate &= ~(pstate >> 1);       /* PSR_C_BIT &= ~PSR_Z_BIT */
arch/arm64/kernel/insn.c:       pstate &= ~(pstate >> 1);       /* PSR_C_BIT &= ~PSR_Z_BIT */
arch/arm64/kernel/probes/kprobes.c:     regs->pstate &= ~PSR_D_BIT;
arch/arm64/kernel/probes/kprobes.c:     regs->pstate &= ~DAIF_MASK;
arch/arm64/kernel/ptrace.c:     regs->pstate &= ~SPSR_EL1_AARCH32_RES0_BITS;
arch/arm64/kernel/ptrace.c:                     regs->pstate &= ~PSR_AA32_E_BIT;
arch/arm64/kernel/ptrace.c:     regs->pstate &= ~SPSR_EL1_AARCH64_RES0_BITS;
arch/arm64/kernel/ptrace.c:             regs->pstate &= ~DBG_SPSR_SS;
arch/arm64/kernel/ssbd.c:       task_pt_regs(task)->pstate &= ~val;
arch/arm64/kernel/traps.c:      regs->pstate &= ~PSR_AA32_IT_MASK;

... and at that point I'd suggest we should just ensure the bit
definitions are all defined as unsigned long in the first place since
adding casts to each use is error-prone.

Thanks,
Mark.
