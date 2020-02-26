From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 08/11] arm64: traps: Shuffle code to eliminate forward
 declarations
Date: Wed, 26 Feb 2020 13:39:49 -0800
Message-ID: <202002261339.53539BA19@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
 <20200226155714.43937-9-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35471 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgBZVjw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 16:39:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so451906pfa.2
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 13:39:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-9-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudak

On Wed, Feb 26, 2020 at 03:57:11PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Hoist the IT state handling code earlier in traps.c, to avoid
> accumulating forward declarations.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/traps.c | 103 ++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index bc9f4292bfc3..3c07a7074145 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -272,7 +272,55 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  	}
>  }
>  
> -static void advance_itstate(struct pt_regs *regs);
> +#ifdef CONFIG_COMPAT
> +#define PSTATE_IT_1_0_SHIFT	25
> +#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
> +#define PSTATE_IT_7_2_SHIFT	10
> +#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
> +
> +static u32 compat_get_it_state(struct pt_regs *regs)
> +{
> +	u32 it, pstate = regs->pstate;
> +
> +	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
> +	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
> +
> +	return it;
> +}
> +
> +static void compat_set_it_state(struct pt_regs *regs, u32 it)
> +{
> +	u32 pstate_it;
> +
> +	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
> +	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
> +
> +	regs->pstate &= ~PSR_AA32_IT_MASK;
> +	regs->pstate |= pstate_it;
> +}
> +
> +static void advance_itstate(struct pt_regs *regs)
> +{
> +	u32 it;
> +
> +	/* ARM mode */
> +	if (!(regs->pstate & PSR_AA32_T_BIT) ||
> +	    !(regs->pstate & PSR_AA32_IT_MASK))
> +		return;
> +
> +	it  = compat_get_it_state(regs);
> +
> +	/*
> +	 * If this is the last instruction of the block, wipe the IT
> +	 * state. Otherwise advance it.
> +	 */
> +	if (!(it & 7))
> +		it = 0;
> +	else
> +		it = (it & 0xe0) | ((it << 1) & 0x1f);
> +
> +	compat_set_it_state(regs, it);
> +}
>  
>  void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  {
> @@ -285,7 +333,7 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  	if (user_mode(regs))
>  		user_fastforward_single_step(current);
>  
> -	if (regs->pstate & PSR_MODE32_BIT)
> +	if (compat_user_mode(regs))
>  		advance_itstate(regs);
>  }
>  
> @@ -578,34 +626,6 @@ static const struct sys64_hook sys64_hooks[] = {
>  	{},
>  };
>  
> -
> -#ifdef CONFIG_COMPAT
> -#define PSTATE_IT_1_0_SHIFT	25
> -#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
> -#define PSTATE_IT_7_2_SHIFT	10
> -#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
> -
> -static u32 compat_get_it_state(struct pt_regs *regs)
> -{
> -	u32 it, pstate = regs->pstate;
> -
> -	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
> -	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
> -
> -	return it;
> -}
> -
> -static void compat_set_it_state(struct pt_regs *regs, u32 it)
> -{
> -	u32 pstate_it;
> -
> -	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
> -	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
> -
> -	regs->pstate &= ~PSR_AA32_IT_MASK;
> -	regs->pstate |= pstate_it;
> -}
> -
>  static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
>  {
>  	int cond;
> @@ -626,29 +646,6 @@ static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
>  	return aarch32_opcode_cond_checks[cond](regs->pstate);
>  }
>  
> -static void advance_itstate(struct pt_regs *regs)
> -{
> -	u32 it;
> -
> -	/* ARM mode */
> -	if (!(regs->pstate & PSR_AA32_T_BIT) ||
> -	    !(regs->pstate & PSR_AA32_IT_MASK))
> -		return;
> -
> -	it  = compat_get_it_state(regs);
> -
> -	/*
> -	 * If this is the last instruction of the block, wipe the IT
> -	 * state. Otherwise advance it.
> -	 */
> -	if (!(it & 7))
> -		it = 0;
> -	else
> -		it = (it & 0xe0) | ((it << 1) & 0x1f);
> -
> -	compat_set_it_state(regs, it);
> -}
> -
>  static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
>  {
>  	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
> -- 
> 2.20.1
> 

-- 
Kees Cook
