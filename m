Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262232AbUJZCe3@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40919 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261998AbUJZCeZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2004 22:34:25 -0400
Subject: Re: [RFC] Add NO_IRQ to all architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.58.0410251926340.427@ppc970.osdl.org>
References: <1098756491.17886.18.camel@gaston>
	 <Pine.LNX.4.58.0410251926340.427@ppc970.osdl.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 12:31:22 +1000
Message-Id: <1098757882.17887.35.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-10-25 at 19:27 -0700, Linus Torvalds wrote:
> 
> On Tue, 26 Oct 2004, Benjamin Herrenschmidt wrote:
> > 
> > Here'd a patch adding a definition of NO_IRQ to all archs include/asm-*/irq.h.
> 
> ..and is there any reason to make it arch-specific?
> 
> iow, I really can't imagine it not being ok to just have a global
> 
> 	#define NO_IRQ (-1)
> 
> in one place, rather than in every arch.

Hehe... just after I went through all include/asm-*/... :)

Well, the reason I did it that way is that I wasn't sure an arch
wouldn't want to revert to 0 ... like x86 to be more "backward
compatible" or to better match what probe_irq_* does ...

Note to Willy: In the long run, the irq number should indeed be a
typedef, it would be nice indeed to hide it in a structure, with some
ISA_TO_IRQ and IRQ_TO_ISA for drivers who care about legacy numbers
maybe ?

Ben.
