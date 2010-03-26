From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 0/2] Run interrupt handlers always with interrupts
 disabled
Date: Fri, 26 Mar 2010 09:59:29 +0000
Message-ID: <20100326095929.063c5f63@lxorguk.ukuu.org.uk>
References: <20100326000325.917127328@linutronix.de>
	<20100326081457.GA23570@flint.arm.linux.org.uk>
	<20100326092023.GH27394@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54008 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752622Ab0CZJ4w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2010 05:56:52 -0400
In-Reply-To: <20100326092023.GH27394@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Nicolas Pitre <nico@fluxnic.net>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>, Russell King <rmk@arm.linux.org.uk>

> As long as it's rare (which it is) i dont see a problem: you can enable 
> interrupts in the handler by using local_irq_enable(), like the IDE PIO 
> drivers do. That way it's documented a bit better as well, because it shows 
> the precise source of the latency, with a big comment explaining it, etc.

I don't think it's as rare as you think particularly in embedded, and the
moment you start explicitly using local_irq_enable() you've simply moved
the underlying problem back and made it far harder to grep for.

Alan
