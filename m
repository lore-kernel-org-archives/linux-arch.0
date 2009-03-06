From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Fri, 06 Mar 2009 20:59:03 +1100
Message-ID: <1236333543.7260.138.camel@pasglop>
References: <1235996477.5330.174.camel@laptop>
	 <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
	 <1236329922.7260.127.camel@pasglop>  <1236330733.6326.15.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49287 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZCFJ7b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Mar 2009 04:59:31 -0500
In-Reply-To: <1236330733.6326.15.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>


> If you have distinct interrupt priorities, you can
> 
> 1) provide an interrupt stack for each priority
> 2) mask all lower priorities when handling one
> 
> Would that not work?

The PIC does that already. IE. it will only interrupt again before
->eoi() for an interrupt of a higher priority. But by using
IRQF_DISABLED, you mask interrupts in the core, and thus effectively
completely prevents the whole thing.

> The problems with enabling irqs in hardirq handlers are that you get
> unlimited irq nesting, which is bad for your stack, furthermore, somehow
> people thing it makes things 'faster' because the irq-off latency goes
> down.

No, you don't get unlimited IRQ nesting, at least not on sane archs with
a decent PIC that does things like what I described above :-)

> The latter just isn't true, as you still have preemption disabled, so
> everything but irqs still suffers.
> 
> The only way to make things low-latency is to pull work out of
> non-preemptable context. Using threaded IRQs is one way to do that.

Cheers,
Ben.
