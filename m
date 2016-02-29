From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 01/20] idle: Move x86ism out of generic code
Date: Mon, 29 Feb 2016 20:35:41 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602292026050.3638@nanos>
References: <20160226164321.657646833@linutronix.de> <20160226182340.242063758@linutronix.de> <CAMzpN2j=Nb25x6UQqa6r3UbWgrrhoRb-72U+zOFVA7RrqQ0Z3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42325 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcB2ThR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 14:37:17 -0500
In-Reply-To: <CAMzpN2j=Nb25x6UQqa6r3UbWgrrhoRb-72U+zOFVA7RrqQ0Z3A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Sat, 27 Feb 2016, Brian Gerst wrote:
> >         arch_cpu_idle_prepare();
> >         cpu_idle_loop();
> >  }
> 
> Does this actually work with stack protector enabled?
> boot_init_stack_canary() is inlined while arch_cpu_idle_prepare() is
> not.

Stupid me. No it does of course not. I could have sworn that I tested that,
but obvioulsy not.

I drop that patch, but actually the real question is whether we can drop that
'#ifdef x86' around that boot_init_stack_canary() invocation.

AFAICT, neither arm, arm64 nor mips and sh call it on anything else than the
boot cpu. I can't see why that would be an issue on those architectures and
why it would be a problem if the boot cpu calls it again here.

CC'ed the relevant maintainers. Is there any issue with the patch below?

Thanks,

	tglx

8<------------------

--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -276,12 +276,6 @@ static void cpu_idle_loop(void)
 void cpu_startup_entry(enum cpuhp_state state)
 {
 	/*
-	 * This #ifdef needs to die, but it's too late in the cycle to
-	 * make this generic (arm and sh have never invoked the canary
-	 * init for the non boot cpus!). Will be fixed in 3.11
-	 */
-#ifdef CONFIG_X86
-	/*
 	 * If we're the non-boot CPU, nothing set the stack canary up
 	 * for us. The boot CPU already has it initialized but no harm
 	 * in doing it again. This is a good place for updating it, as
@@ -289,7 +283,7 @@ void cpu_startup_entry(enum cpuhp_state
 	 * canaries already on the stack wont ever trigger).
 	 */
 	boot_init_stack_canary();
-#endif
+
 	arch_cpu_idle_prepare();
 	cpu_idle_loop();
 }
