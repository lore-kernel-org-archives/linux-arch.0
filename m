From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Date: Wed, 19 Feb 2020 17:04:42 +0100
Message-ID: <20200219160442.GE14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
 <20200219155715.GD14946@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSQFC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:05:02 -0500
Content-Disposition: inline
In-Reply-To: <20200219155715.GD14946@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 04:57:15PM +0100, Peter Zijlstra wrote:
> Something like so, I suppose...
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 6ef00eb6fbb9..543de932dc7c 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -350,14 +350,20 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
>  		regs->ip == (unsigned long)native_irq_return_iret)
>  	{
>  		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
> +		unsigned long *dst = &gpregs->ip;
> +		unsigned long *src = (void *)regs->dp;
> +		int i, count = 5;
>  
>  		/*
>  		 * regs->sp points to the failing IRET frame on the
>  		 * ESPFIX64 stack.  Copy it to the entry stack.  This fills
>  		 * in gpregs->ss through gpregs->ip.
> -		 *
>  		 */
> -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> +		for (i = 0; i < count; i++) {
> +			int idx = (dst <= src) ? i : count - i;

That's an off-by-one for going backward; 'count - 1 - i' should work
better, or I should just stop typing for today ;-)

> +			dst[idx] = src[idx];
> +		}
> +
>  		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
>  
>  		/*
