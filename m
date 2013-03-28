Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:49079 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab3C1Ppk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 11:45:40 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 28 Mar 2013 21:11:05 +0530
Message-ID: <5154650A.1060406@linux.vnet.ibm.com>
Date: Thu, 28 Mar 2013 21:13:06 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [patch 30/34] tile: Enter idle with preemption disabled
References: <20130321214930.752934102@linutronix.de> <20130321215235.280451779@linutronix.de>
In-Reply-To: <20130321215235.280451779@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>
Message-ID: <20130328154306.Fny9wfj7G4g7P_mK-t6A0mlhyTO6AkJjljB2knQjC7o@z>

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

