Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48224 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbbEFRFH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 May 2015 13:05:07 -0400
Date: Wed, 6 May 2015 18:05:03 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
Message-ID: <20150506170503.GF14922@arm.com>
References: <55464BB2.7030401@dawncrow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55464BB2.7030401@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>
Message-ID: <20150506170503.g9vspukYJ4CaNIlGfHpKlXrJIOQIUVERo6hZvPFW0c0@z>

On Sun, May 03, 2015 at 05:24:18PM +0100, André Hentschel wrote:
> From: André Hentschel <nerv@dawncrow.de>
> 
> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeable TLS
> register on ARM is preserved per thread.
> 
> This patch does it analogous to the ARM patch, but for compat mode on ARM64.
> 
> Signed-off-by: André Hentschel <nerv@dawncrow.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonathan Austin <jonathan.austin@arm.com> 
> 
> ---
> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 20e9591..cd7b8c9 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -78,7 +78,7 @@ struct cpu_context {
>  
>  struct thread_struct {
>  	struct cpu_context	cpu_context;	/* cpu context */
> -	unsigned long		tp_value;
> +	unsigned long		tp_value[2];	/* TLS registers */

I think I'd rather have a separate field for the user-writable TLS,
predicated on #ifdef COMPAT. It also removes confusion between the two tls
registers, which are also present on arm64.

>  	struct fpsimd_state	fpsimd_state;
>  	unsigned long		fault_address;	/* fault info */
>  	unsigned long		fault_code;	/* ESR_EL1 value */
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index c6b1f3b..fc7cc6bc 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -218,7 +218,8 @@ static void tls_thread_flush(void)
>  	asm ("msr tpidr_el0, xzr");
>  
>  	if (is_compat_task()) {
> -		current->thread.tp_value = 0;
> +		current->thread.tp_value[0] = 0;
> +		current->thread.tp_value[1] = 0;
>  
>  		/*
>  		 * We need to ensure ordering between the shadow state and the
> @@ -254,7 +255,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  		unsigned long stk_sz, struct task_struct *p)
>  {
>  	struct pt_regs *childregs = task_pt_regs(p);
> -	unsigned long tls = p->thread.tp_value;
> +	unsigned long tls = p->thread.tp_value[0];
>  
>  	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
>  
> @@ -283,6 +284,11 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  		 */
>  		if (clone_flags & CLONE_SETTLS)
>  			tls = childregs->regs[3];
> +		if (is_compat_thread(task_thread_info(p))) {
> +			unsigned long tpuser;
> +			asm("mrs %0, tpidr_el0" : "=r" (tpuser));
> +			p->thread.tp_value[1] = tpuser;
> +		}

Can't this hunk be in the is_compat_thread(...) block slightly earlier
on in the function? In fact, we're reading tpidr_el0 for both the compat and
native cases, so really this all be unconditional.

>  	} else {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childregs->pstate = PSR_MODE_EL1h;
> @@ -291,7 +297,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  	}
>  	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
>  	p->thread.cpu_context.sp = (unsigned long)childregs;
> -	p->thread.tp_value = tls;
> +	p->thread.tp_value[0] = tls;
>  
>  	ptrace_hw_copy_thread(p);
>  
> @@ -302,16 +308,17 @@ static void tls_thread_switch(struct task_struct *next)
>  {
>  	unsigned long tpidr, tpidrro;
>  
> -	if (!is_compat_task()) {
> -		asm("mrs %0, tpidr_el0" : "=r" (tpidr));
> -		current->thread.tp_value = tpidr;
> -	}
> +	asm("mrs %0, tpidr_el0" : "=r" (tpidr));
> +	if (is_compat_task())
> +		current->thread.tp_value[1] = tpidr;
> +	else
> +		current->thread.tp_value[0] = tpidr;

Maybe we could have a macro thread_user_tls(thread) so that we could just
do thread_user_tls(current->thread) = tpidr;

Will
