From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [patch 05/34] idle: Implement generic idle function
Date: Mon, 18 Nov 2013 11:35:26 +0530
Message-ID: <CAOh2x=nefF3QqHy2C8jRFeXj_JxyeUus+4D1OD96qj8BkYY-JA@mail.gmail.com>
References: <20130321214930.752934102@linutronix.de>
	<20130321215233.646635455@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:42081 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab3KRGF1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2013 01:05:27 -0500
In-Reply-To: <20130321215233.646635455@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, badarkhe.manish@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Mar 22, 2013 at 3:23 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> --- linux-2.6.orig/kernel/cpu/idle.c
> +++ linux-2.6/kernel/cpu/idle.c

> +void cpu_startup_entry(enum cpuhp_state state)
> +{
> +       current_set_polling();
> +       arch_cpu_idle_prepare();
> +       cpu_idle_loop();
> +}
> +#endif

Hi Thomas..

Manish (cc'd) recently asked me purpose of _state_ argument in this
routine, As this is unused here..

Was this reserved for future use?
