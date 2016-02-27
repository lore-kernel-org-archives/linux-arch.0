From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [patch 01/20] idle: Move x86ism out of generic code
Date: Sat, 27 Feb 2016 15:29:39 -0500
Message-ID: <CAMzpN2j=Nb25x6UQqa6r3UbWgrrhoRb-72U+zOFVA7RrqQ0Z3A@mail.gmail.com>
References: <20160226164321.657646833@linutronix.de>
	<20160226182340.242063758@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35464 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992522AbcB0U3k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Feb 2016 15:29:40 -0500
In-Reply-To: <20160226182340.242063758@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Fri, Feb 26, 2016 at 1:43 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> We have an arch specific callback here already.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/process.c |   12 ++++++++++++
>  kernel/sched/idle.c       |   15 ---------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
>
> Index: b/arch/x86/kernel/process.c
> ===================================================================
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -271,6 +271,18 @@ void exit_idle(void)
>  }
>  #endif
>
> +void arch_cpu_idle_prepare(void)
> +{
> +       /*
> +        * If we're the non-boot CPU, nothing set the stack canary up
> +        * for us. The boot CPU already has it initialized but no harm
> +        * in doing it again. This is a good place for updating it, as
> +        * we wont ever return from this function (so the invalid
> +        * canaries already on the stack wont ever trigger).
> +        */
> +       boot_init_stack_canary();
> +}
> +
>  void arch_cpu_idle_enter(void)
>  {
>         local_touch_nmi();
> Index: b/kernel/sched/idle.c
> ===================================================================
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -275,21 +275,6 @@ static void cpu_idle_loop(void)
>
>  void cpu_startup_entry(enum cpuhp_state state)
>  {
> -       /*
> -        * This #ifdef needs to die, but it's too late in the cycle to
> -        * make this generic (arm and sh have never invoked the canary
> -        * init for the non boot cpus!). Will be fixed in 3.11
> -        */
> -#ifdef CONFIG_X86
> -       /*
> -        * If we're the non-boot CPU, nothing set the stack canary up
> -        * for us. The boot CPU already has it initialized but no harm
> -        * in doing it again. This is a good place for updating it, as
> -        * we wont ever return from this function (so the invalid
> -        * canaries already on the stack wont ever trigger).
> -        */
> -       boot_init_stack_canary();
> -#endif
>         arch_cpu_idle_prepare();
>         cpu_idle_loop();
>  }

Does this actually work with stack protector enabled?
boot_init_stack_canary() is inlined while arch_cpu_idle_prepare() is
not.

--
Brian Gerst
