From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [patch 30/34] tile: Enter idle with preemption disabled
Date: Thu, 28 Mar 2013 21:13:06 +0530
Message-ID: <5154650A.1060406@linux.vnet.ibm.com>
References: <20130321214930.752934102@linutronix.de> <20130321215235.280451779@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130321215235.280451779@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>
List-Id: linux-arch.vger.kernel.org

On 03/22/2013 03:23 AM, Thomas Gleixner wrote:
> cpu_idle() needs to be called with preemption disabled.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  arch/tile/kernel/smpboot.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> Index: linux-2.6/arch/tile/kernel/smpboot.c
> ===================================================================
> --- linux-2.6.orig/arch/tile/kernel/smpboot.c
> +++ linux-2.6/arch/tile/kernel/smpboot.c
> @@ -207,8 +207,6 @@ void __cpuinit online_secondary(void)
>  	/* Set up tile-timer clock-event device on this cpu */
>  	setup_tile_timer();
> 
> -	preempt_enable();
> -

Hmm, so shouldn't we call preempt_disabled() here?

I see that start_secondary() calls preempt_disabled(), but I didn't quite
understand as to which of the *_secondary() functions have to call
it... especially since its the online_secondary() function which calls
cpu_idle().

>  	cpu_idle();
>  }
> 
> 
> 
 
Regards,
Srivatsa S. Bhat
