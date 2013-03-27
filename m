From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [patch 13/34] cris: Use generic idle loop
Date: Wed, 27 Mar 2013 16:04:24 +0100
Message-ID: <20130327150421.GV28422@axis.com>
References: <20130321214930.752934102@linutronix.de>
 <20130321215234.148829489@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130321215234.148829489@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-arch.vger.kernel.org


On Thu, Mar 21, 2013 at 09:53:06PM -0000, Thomas Gleixner wrote:
[snip]
> Index: linux-2.6/arch/cris/arch-v32/kernel/process.c
> ===================================================================
> --- linux-2.6.orig/arch/cris/arch-v32/kernel/process.c
> +++ linux-2.6/arch/cris/arch-v32/kernel/process.c
> @@ -23,12 +23,10 @@ extern void stop_watchdog(void);
>  /* We use this if we don't have any better idle routine. */
>  void default_idle(void)
>  {
> -	local_irq_disable();
> -	if (!need_resched()) {
> -		/* Halt until exception. */
> -		__asm__ volatile("ei    \n\t"
> -				 "halt      ");
> -	}
> +	/* Halt until exception. */
> +	__asm__ volatile("ei    \n\t"
> +			 "halt      ");
> +	/* CHECKME: Is this really needed ?? */
>  	local_irq_enable();

No, that local_irq_enable() is redundant since we already enabled interrupts
in the assembler directive above.

>  }

Looks good,

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
