From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/2] Run interrupt handlers always with interrupts
 disabled
Date: Fri, 26 Mar 2010 11:53:58 +0100
Message-ID: <20100326105358.GA4424@elte.hu>
References: <20100326000325.917127328@linutronix.de>
 <20100326081457.GA23570@flint.arm.linux.org.uk>
 <20100326092023.GH27394@elte.hu>
 <20100326095929.063c5f63@lxorguk.ukuu.org.uk>
 <1269598133.12097.138.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51802 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753760Ab0CZKyl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 06:54:41 -0400
Content-Disposition: inline
In-Reply-To: <1269598133.12097.138.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Nicolas Pitre <nico@fluxnic.net>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>, Russell King <rmk@arm.linux.org.uk>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2010-03-26 at 09:59 +0000, Alan Cox wrote:
> > > As long as it's rare (which it is) i dont see a problem: you can enable 
> > > interrupts in the handler by using local_irq_enable(), like the IDE PIO 
> > > drivers do. That way it's documented a bit better as well, because it shows 
> > > the precise source of the latency, with a big comment explaining it, etc.
> > 
> > I don't think it's as rare as you think particularly in embedded, and the 
> > moment you start explicitly using local_irq_enable() you've simply moved 
> > the underlying problem back and made it far harder to grep for.
> 
> We've got local_irq_enable_in_hardirq() which should be used and can easily 
> be grep'ed for.
> 
> But yes, I would much prefer to simply convert these known slow handlers to 
> threaded interrupts.

Yeah, agreed. So there's multiple solutions:

 - On old hw with a driver that nobody is willing to convert to threaded IRQs: 
   use the existing local_irq_enable_in_hardirq() API. This preserves the 
   status quo.

 - On new hw with new drivers where there's such a level of IRQ parallelism 
   that enabling IRQs in hardirqs is not an option, use threaded IRQ handlers.

Thanks,

	Ingo
