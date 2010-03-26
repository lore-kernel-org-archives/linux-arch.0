From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/2] Run interrupt handlers always with interrupts
 disabled
Date: Fri, 26 Mar 2010 10:20:23 +0100
Message-ID: <20100326092023.GH27394@elte.hu>
References: <20100326000325.917127328@linutronix.de>
 <20100326081457.GA23570@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46067 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab0CZJWm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 05:22:42 -0400
Content-Disposition: inline
In-Reply-To: <20100326081457.GA23570@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Nicolas Pitre <nico@fluxnic.net>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew


* Russell King <rmk@arm.linux.org.uk> wrote:

> On Fri, Mar 26, 2010 at 12:06:44AM -0000, Thomas Gleixner wrote:
> > The following patch series removes the IRQF_DISABLED functionality
> > from the core interrupt code and runs all interrupt handlers with
> > interrupts disabled.
> 
> As was covered in previous discussions, what about drivers such as SMC91x 
> which take a long time to retrieve packets from the hardware? Always running 
> handlers with IRQs disabled will kill things such as serial on these 
> platforms.

As long as it's rare (which it is) i dont see a problem: you can enable 
interrupts in the handler by using local_irq_enable(), like the IDE PIO 
drivers do. That way it's documented a bit better as well, because it shows 
the precise source of the latency, with a big comment explaining it, etc.

Thanks,

	Ingo
