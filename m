From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [patch 33/34] x86: Use generic idle loop
Date: Thu, 28 Mar 2013 21:13:22 +0530
Message-ID: <5154651A.6010304@linux.vnet.ibm.com>
References: <20130321214930.752934102@linutronix.de> <20130321215235.486594473@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130321215235.486594473@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On 03/22/2013 03:23 AM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> ---
[...]
> +#define POLL_IDLE	(void*) 0x01
> +

[...]

>  #ifdef CONFIG_APM_MODULE
> @@ -411,20 +376,6 @@ void stop_this_cpu(void *dummy)
>  		halt();
>  }
> 
> -/*
> - * On SMP it's slightly faster (but much more power-consuming!)
> - * to poll the ->work.need_resched flag instead of waiting for the
> - * cross-CPU IPI to arrive. Use this option with caution.
> - */
> -static void poll_idle(void)
> -{
> -	trace_cpu_idle_rcuidle(0, smp_processor_id());
> -	local_irq_enable();
> -	while (!need_resched())
> -		cpu_relax();
> -	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> -}
> -
>  bool amd_e400_c1e_detected;
>  EXPORT_SYMBOL(amd_e400_c1e_detected);
> 
> @@ -489,7 +440,7 @@ static void amd_e400_idle(void)
>  void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
>  {
>  #ifdef CONFIG_SMP
> -	if (x86_idle == poll_idle && smp_num_siblings > 1)
> +	if (x86_idle == POLL_IDLE && smp_num_siblings > 1)
>  		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
>  #endif
>  	if (x86_idle)
> @@ -517,8 +468,9 @@ static int __init idle_setup(char *str)
> 
>  	if (!strcmp(str, "poll")) {
>  		pr_info("using polling idle threads\n");
> -		x86_idle = poll_idle;
> +		x86_idle = POLL_IDLE;
>  		boot_option_idle_override = IDLE_POLL;
> +		cpu_idle_poll_ctrl(true);

Why is that POLL_IDLE needed? Won't cpu_idle_poll_ctrl() suffice?

By the way, booting with idle=poll locks up the kernel during boot with
this patch applied (I verified it). So I think we should just skip the
whole POLL_IDLE thing and leave the job to cpu_idle_poll_ctrl().

 
Regards,
Srivatsa S. Bhat
