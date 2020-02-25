From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Date: Tue, 25 Feb 2020 04:09:06 +0100
Message-ID: <20200225030905.GB28329@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgBYDJJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 22:09:09 -0500
Content-Disposition: inline
In-Reply-To: <20200224161318.GG14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>

On Mon, Feb 24, 2020 at 05:13:18PM +0100, Peter Zijlstra wrote:
> Damn, true. That also means I need to fix the arm64 bits, and that's a
> little more tricky.
> 
> Something like so perhaps.. hmm?
> 
> ---
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -32,30 +32,52 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
>  
>  struct nmi_ctx {
>  	u64 hcr;
> +	unsigned int cnt;
>  };
>  
>  DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
>  
> -#define arch_nmi_enter()							\
> -	do {									\
> -		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
> -			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
> -			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
> -			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
> -				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
> -				isb();						\
> -			}							\
> -		}								\
> -	} while (0)
> +#define arch_nmi_enter()						\
> +do {									\
> +	struct nmi_ctx *___ctx;						\
> +	unsigned int ___cnt;						\
> +									\
> +	if (!is_kernel_in_hyp_mode() || in_nmi())			\
> +		break;							\
> +									\
> +	___ctx = this_cpu_ptr(&nmi_contexts);				\
> +	___cnt = ___ctx->cnt;						\
> +	if (!(___cnt & 1) && __cnt) {					\
> +		___ctx->cnt += 2;					\
> +		break;							\
> +	}								\
> +									\
> +	___ctx->cnt |= 1;						\
> +	barrier();							\
> +	nmi_ctx->hcr = read_sysreg(hcr_el2);				\
> +	if (!(nmi_ctx->hcr & HCR_TGE)) {				\
> +		write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);		\
> +		isb();							\
> +	}								\
> +	barrier();							\

Suppose the first NMI is interrupted here. nmi_ctx->hcr has HCR_TGE unset.
The new NMI is going to overwrite nmi_ctx->hcr with HCR_TGE set. Then the
first NMI will not restore the correct value upon arch_nmi_exit().

So perhaps the below, but I bet I overlooked something obvious.

#define arch_nmi_enter()                                             \
do {                                                                 \
     struct nmi_ctx *___ctx;                                         \
     u64 ___hcr;                                                     \
                                                                     \
     if (!is_kernel_in_hyp_mode())                                   \
             break;                                                  \
                                                                     \
     ___ctx = this_cpu_ptr(&nmi_contexts);                           \
     if (___ctx->cnt) {                                              \
             ___ctx->cnt++;                                          \
             break;                                                  \
     }                                                               \
                                                                     \
     ___hcr = read_sysreg(hcr_el2);                                  \
     if (!(___hcr & HCR_TGE)) {                                      \
             write_sysreg(___hcr | HCR_TGE, hcr_el2);                \
             isb();                                                  \
     }                                                               \
     ___ctx->cnt = 1;                                                \
     barrier();                                                      \
     ___ctx->hcr = ___hcr;                                           \
} while (0)

#define arch_nmi_exit()                                         \
do {                                                            \
        struct nmi_ctx *___ctx;                                 \
        u64 ___hcr;                                             \
                                                                \
        if (!is_kernel_in_hyp_mode())                           \
            break;                                              \
                                                                \
        ___ctx = this_cpu_ptr(&nmi_contexts);                   \
	___hcr = nmi_ctx->hcr;                                  \
        barrier();                                              \
        --___ctx->cnt;                                          \
	barrier();                                              \
	if (!___ctx->cnt && !(___hcr & HCR_TGE))                  \
            write_sysreg(___hcr, hcr_el2);                       \
} while (0)
