From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/2] Run interrupt handlers always with interrupts
 disabled
Date: Fri, 26 Mar 2010 11:08:53 +0100
Message-ID: <1269598133.12097.138.camel@laptop>
References: <20100326000325.917127328@linutronix.de>
	 <20100326081457.GA23570@flint.arm.linux.org.uk>
	 <20100326092023.GH27394@elte.hu>
	 <20100326095929.063c5f63@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45574 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab0CZKJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2010 06:09:00 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Nv6TK-0004dj-CW
	for linux-arch@vger.kernel.org; Fri, 26 Mar 2010 10:08:58 +0000
In-Reply-To: <20100326095929.063c5f63@lxorguk.ukuu.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Nicolas Pitre <nico@fluxnic.net>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>, Russell King <rmk@arm.linux.org.uk>

On Fri, 2010-03-26 at 09:59 +0000, Alan Cox wrote:
> > As long as it's rare (which it is) i dont see a problem: you can enable 
> > interrupts in the handler by using local_irq_enable(), like the IDE PIO 
> > drivers do. That way it's documented a bit better as well, because it shows 
> > the precise source of the latency, with a big comment explaining it, etc.
> 
> I don't think it's as rare as you think particularly in embedded, and the
> moment you start explicitly using local_irq_enable() you've simply moved
> the underlying problem back and made it far harder to grep for.

We've got local_irq_enable_in_hardirq() which should be used and can
easily be grep'ed for.

But yes, I would much prefer to simply convert these known slow handlers
to threaded interrupts.
