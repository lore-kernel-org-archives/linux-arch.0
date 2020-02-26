From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Date: Wed, 26 Feb 2020 14:16:06 +0100
Message-ID: <20200226131606.GL14946@hirez.programming.kicks-ass.net>
References: <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
 <20200221202246.GA14897@hirez.programming.kicks-ass.net>
 <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
 <20200224112708.4f307ba3@gandalf.local.home>
 <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
 <20200224114754.0fb798c1@gandalf.local.home>
 <20200224213139.GO11457@worktop.programming.kicks-ass.net>
 <20200224170231.3807931d@gandalf.local.home>
 <20200226102509.GU18400@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39704 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgBZNQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 08:16:53 -0500
Content-Disposition: inline
In-Reply-To: <20200226102509.GU18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Wed, Feb 26, 2020 at 11:25:09AM +0100, Peter Zijlstra wrote:
> Subject: sh/ftrace: Move arch_ftrace_nmi_{enter,exit} into nmi exception
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Feb 24 22:26:21 CET 2020
> 
> SuperH is the last remaining user of arch_ftrace_nmi_{enter,exit}(),
> remove it from the generic code and into the SuperH code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
> @@ -170,11 +170,21 @@ BUILD_TRAP_HANDLER(bug)
>  	force_sig(SIGTRAP);
>  }
>  
> +#ifdef CONFIG_HAVE_DYNAMIC_FTRACE

build robot just informed me that this ought to s/HAVE_//

> +extern void arch_ftrace_nmi_enter(void);
> +extern void arch_ftrace_nmi_exit(void);
> +#else
> +static inline void arch_ftrace_nmi_enter(void) { }
> +static inline void arch_ftrace_nmi_exit(void) { }
> +#endif
