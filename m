From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [patch 31/34] tile: Use generic idle loop
Date: Thu, 28 Mar 2013 21:11:36 +0530
Message-ID: <515464B0.8080704@linux.vnet.ibm.com>
References: <20130321214930.752934102@linutronix.de> <20130321215235.348460344@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:33693 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab3C1PoF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 11:44:05 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 28 Mar 2013 21:09:46 +0530
In-Reply-To: <20130321215235.348460344@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>

On 03/22/2013 03:23 AM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  arch/tile/kernel/process.c |   61 ++++-----------------------------------------
>  arch/tile/kernel/smpboot.c |    2 -
>  2 files changed, 7 insertions(+), 56 deletions(-)
> 
> Index: linux-2.6/arch/tile/kernel/process.c
> ===================================================================
> --- linux-2.6.orig/arch/tile/kernel/process.c
> +++ linux-2.6/arch/tile/kernel/process.c
> @@ -40,13 +40,11 @@
>  #include <arch/abi.h>
>  #include <arch/sim_def.h>
> 
> -
>  /*
>   * Use the (x86) "idle=poll" option to prefer low latency when leaving the
>   * idle loop over low power while in the idle loop, e.g. if we have
>   * one thread per core and we want to get threads out of futex waits fast.
>   */
> -static int no_idle_nap;
>  static int __init idle_setup(char *str)
>  {
>  	if (!str)
> @@ -54,64 +52,17 @@ static int __init idle_setup(char *str)
> 
>  	if (!strcmp(str, "poll")) {
>  		pr_info("using polling idle threads.\n");
> -		no_idle_nap = 1;
> +		cpu_idle_poll_ctrl(true);
>  	} else if (!strcmp(str, "halt"))
> -		no_idle_nap = 0;
> -	else
> -		return -1;
> -
> -	return 0;
> +		return 0;
> +	return -1;
>  }
>  early_param("idle", idle_setup);
>

That doesn't look quite right, since it returns -1 (instead of 0) when
str == poll.

Regards,
Srivatsa S. Bhat
