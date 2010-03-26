From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/2] Run interrupt handlers always with interrupts
 disabled
Date: Fri, 26 Mar 2010 10:28:12 +0100
Message-ID: <1269595692.12097.128.camel@laptop>
References: <20100326000325.917127328@linutronix.de>
	 <20100326081457.GA23570@flint.arm.linux.org.uk>
	 <20100326092023.GH27394@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41793 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab0CZJ2V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2010 05:28:21 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Nv5pz-0003wO-4l
	for linux-arch@vger.kernel.org; Fri, 26 Mar 2010 09:28:19 +0000
In-Reply-To: <20100326092023.GH27394@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Nicolas Pitre <nico@fluxnic.net>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <andi@firstfloor.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>, Russell King <rmk@arm.linux.org.uk>

On Fri, 2010-03-26 at 10:20 +0100, Ingo Molnar wrote:
> * Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > On Fri, Mar 26, 2010 at 12:06:44AM -0000, Thomas Gleixner wrote:
> > > The following patch series removes the IRQF_DISABLED functionality
> > > from the core interrupt code and runs all interrupt handlers with
> > > interrupts disabled.
> > 
> > As was covered in previous discussions, what about drivers such as SMC91x 
> > which take a long time to retrieve packets from the hardware? Always running 
> > handlers with IRQs disabled will kill things such as serial on these 
> > platforms.
> 
> As long as it's rare (which it is) i dont see a problem: you can enable 
> interrupts in the handler by using local_irq_enable(), like the IDE PIO 
> drivers do. That way it's documented a bit better as well, because it shows 
> the precise source of the latency, with a big comment explaining it, etc.

Or alternatively, use threaded interrupts for such slow hardware.
