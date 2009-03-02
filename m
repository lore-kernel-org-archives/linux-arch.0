From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 09:55:53 -0800
Message-ID: <20090302095553.8204d808.akpm@linux-foundation.org>
References: <1235996477.5330.174.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40714 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754140AbZCBR4Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 12:56:25 -0500
In-Reply-To: <1235996477.5330.174.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Mon, 02 Mar 2009 13:21:17 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> 
> People are playing odd games with IRQF_DISABLED, remove it.
> 
> Its not reliable, since shared interrupt lines could disable it for you,
> and its possible and allowed for archs to disable IRQs to limit IRQ nesting.
> 
> Therefore, simply mandate that _ALL_ IRQ handlers are run with IRQs disabled.
> 
> [ This _should_ not break anything, since we've mandated that IRQ handlers
>   _must_ be able to deal with this for a _long_ time ]
> 
> IRQ handlers should be fast, no if buts and any other exceptions. We also have
> plenty instrumentation to find any offending IRQ latency sources.

Changelog is a bit cruddy.  What are these "odd games" and why are they
so serious as to warrant a fairly drastic-looking patch?

Where are these odd games being played, and what are the implications
to those codesites of having their ball taken away?  etc.


wrt the patch itself - it would make life easier if we were to leave
the IRQF_DISABLED definition in place for a while.  I'm counting 47 new
additions of references to IRQF_DISABLED in linux-next/-mm.  It would
grease the wheels a bit were these things (and out-of-tree drivers) to
not instabreak.  One could add a nice runtime warning at request_irq()
time, leave that in place until everything is fixed up.
