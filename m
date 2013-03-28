Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:60024 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab3C1Pmi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 11:42:38 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 28 Mar 2013 21:09:42 +0530
Message-ID: <51546452.3090408@linux.vnet.ibm.com>
Date: Thu, 28 Mar 2013 21:10:02 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [patch 26/34] powerpc: Use generic idle loop
References: <20130321214930.752934102@linutronix.de> <20130321215235.026838003@linutronix.de>
In-Reply-To: <20130321215235.026838003@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Message-ID: <20130328154002.xCRzByRXLc_8_qzPsZng8mG3c48_zExRvuZB2mlLEvI@z>

On 03/22/2013 03:23 AM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
[...]
> Index: linux-2.6/arch/powerpc/kernel/idle.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/idle.c
> +++ linux-2.6/arch/powerpc/kernel/idle.c
> @@ -50,64 +50,30 @@ static int __init powersave_off(char *ar
>  }
>  __setup("powersave=off", powersave_off);
> 
> -/*
> - * The body of the idle task.
> - */
> -void cpu_idle(void)
> +void arch_cpu_idle(void)
>  {
> -	set_thread_flag(TIF_POLLING_NRFLAG);
> -	while (1) {
> -		tick_nohz_idle_enter();
> -		rcu_idle_enter();
> -
> -		while (!need_resched() && !cpu_should_die()) {
> -			ppc64_runlatch_off();
> -
> -			if (ppc_md.power_save) {
> -				clear_thread_flag(TIF_POLLING_NRFLAG);
> -				/*
> -				 * smp_mb is so clearing of TIF_POLLING_NRFLAG
> -				 * is ordered w.r.t. need_resched() test.
> -				 */
> -				smp_mb();
> -				local_irq_disable();
> -
> -				/* Don't trace irqs off for idle */
> -				stop_critical_timings();
> -
> -				/* check again after disabling irqs */
> -				if (!need_resched() && !cpu_should_die())
> -					ppc_md.power_save();
> -
> -				start_critical_timings();
> -
> -				/* Some power_save functions return with
> -				 * interrupts enabled, some don't.
> -				 */
> -				if (irqs_disabled())
> -					local_irq_enable();
> -				set_thread_flag(TIF_POLLING_NRFLAG);
> -
> -			} else {
> -				/*
> -				 * Go into low thread priority and possibly
> -				 * low power mode.
> -				 */
> -				HMT_low();
> -				HMT_very_low();
> -			}
> -		}
> -
> -		HMT_medium();
> -		ppc64_runlatch_on();
> -		rcu_idle_exit();
> -		tick_nohz_idle_exit();
> -		if (cpu_should_die()) {
> -			sched_preempt_enable_no_resched();
> -			cpu_die();
> -		}
> -		schedule_preempt_disabled();
> +	ppc64_runlatch_off();
> +
> +	if (ppc_md.power_save) {
> +		ppc_md.power_save();
> +		/*
> +		 * Some power_save functions return with
> +		 * interrupts enabled, some don't.
> +		 */
> +		if (irqs_disabled())
> +			local_irq_enable();
> +	} else {
> +		local_irq_enable();
> +		/*
> +		 * Go into low thread priority and possibly
> +		 * low power mode.
> +		 */
> +		HMT_low();
> +		HMT_very_low();
>  	}
> +
> +	HMT_medium();
> +	ppc64_runlatch_on();
>  }
> 


The call to cpu_die() seems to be missing. And considering this commit,

commit a7c2bb8279d20d853e43c34584eaf2b039de8026
Author: Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Date:   Wed Aug 4 18:28:33 2010 +0000

    powerpc: Re-enable preemption before cpu_die()

we need to call it with preempt enabled. So how about folding the
following diff with this patch?


diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index b751baa..e434fb9 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -33,11 +33,6 @@
 #include <asm/runlatch.h>
 #include <asm/smp.h>
 
-#ifdef CONFIG_HOTPLUG_CPU
-#define cpu_should_die()	cpu_is_offline(smp_processor_id())
-#else
-#define cpu_should_die()	0
-#endif
 
 unsigned long cpuidle_disable = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(cpuidle_disable);
@@ -50,6 +45,12 @@ static int __init powersave_off(char *arg)
 }
 __setup("powersave=off", powersave_off);
 
+void arch_cpu_idle_dead(void)
+{
+	sched_preempt_enable_no_resched();
+	cpu_die();
+}
+
 void arch_cpu_idle(void)
 {
 	ppc64_runlatch_off();

 
Regards,
Srivatsa S. Bhat

