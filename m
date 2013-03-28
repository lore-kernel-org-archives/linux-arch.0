Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:51671 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab3C1Pm6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 11:42:58 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 28 Mar 2013 21:08:53 +0530
Message-ID: <5154646E.1090203@linux.vnet.ibm.com>
Date: Thu, 28 Mar 2013 21:10:30 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [patch 17/34] ia64: Use generic idle loop
References: <20130321214930.752934102@linutronix.de> <20130321215234.406851909@linutronix.de>
In-Reply-To: <20130321215234.406851909@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, Tony Luck <tony.luck@intel.com>
Message-ID: <20130328154030._AhBOcAtP3jU6CQk-T3ZQCHxpcH45fcyJXPaAqc66d4@z>

On 03/22/2013 03:23 AM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  arch/ia64/Kconfig          |    1 
>  arch/ia64/kernel/perfmon.c |   13 ++-----
>  arch/ia64/kernel/process.c |   83 +++++++++------------------------------------
>  arch/ia64/kernel/smpboot.c |    2 -
>  4 files changed, 23 insertions(+), 76 deletions(-)
> 
[...]
> -void
> -update_pal_halt_status(int status)
> -{
> -	can_do_pal_halt = pal_halt && status;
> -}
> -
> -/*
> - * We use this if we don't have any better idle routine..
> - */
> -void
> -default_idle (void)
> -{
> -	local_irq_enable();
> -	while (!need_resched()) {
> -		if (can_do_pal_halt) {
> -			local_irq_disable();
> -			if (!need_resched()) {
> -				safe_halt();
> -			}
> -			local_irq_enable();
> -		} else
> -			cpu_relax();
> -	}
> -}
> -
 
We can also get rid of the function prototype declaration of default_idle()
inside arch/ia64/include/asm/processor.h

Regards,
Srivatsa S. Bhat

