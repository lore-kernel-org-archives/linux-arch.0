From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 07/34] alpha: Use generic idle loop
Date: Fri, 29 Mar 2013 12:22:54 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303291210250.22263@ionos>
References: <20130321214930.752934102@linutronix.de> <20130321215233.766017538@linutronix.de> <515463D4.60501@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44976 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307Ab3C2LXC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2013 07:23:02 -0400
In-Reply-To: <515463D4.60501@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>

On Thu, 28 Mar 2013, Srivatsa S. Bhat wrote:
> (In all my replies, I'm referring to the code in your v2 on your git
> tree, but replying to the corresponding patches in your v1).
> 
> So, in alpha, we poll in cpu idle. In the generic implementation in
> kernel/cpu/idle.c, arch_cpu_idle() is defined as:
> 
> void __weak arch_cpu_idle(void)
> {
>         cpu_idle_poll();
> }
> 
> Should it not have been:
> 
> void __weak arch_cpu_idle(void)
> {
> 	current_set_polling();
>         cpu_idle_poll();
> 	current_clr_polling();
> }
> 
> instead?

Hmm, we should not clear it at all, because we are always polling and
never leave polling mode. So instead of calling cpu_idle_poll from the
weak arch_cpu_idle() we should set cpu_idle_force_poll so we drop into

	if (cpu_idle_force_poll) {
		cpu_idle_poll();
	} else ...

which keeps the polling flag set.

Thanks,

	tglx
