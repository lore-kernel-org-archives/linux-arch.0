Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262190AbUJZI1r@vger.kernel.org>
Received: from baythorne.infradead.org ([81.187.226.107]:36776 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262189AbUJZI1r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Oct 2004 04:27:47 -0400
Subject: Re: [RFC] Add NO_IRQ to all architectures
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1098757882.17887.35.camel@gaston>
References: <1098756491.17886.18.camel@gaston>
	 <Pine.LNX.4.58.0410251926340.427@ppc970.osdl.org>
	 <1098757882.17887.35.camel@gaston>
Content-Type: text/plain
Message-Id: <1098779093.3872.214.camel@baythorne.infradead.org>
Mime-Version: 1.0
Date: Tue, 26 Oct 2004 09:24:53 +0100
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-10-26 at 12:31 +1000, Benjamin Herrenschmidt wrote:
> Well, the reason I did it that way is that I wasn't sure an arch
> wouldn't want to revert to 0 ... like x86 to be more "backward
> compatible" or to better match what probe_irq_* does ...

Surely that's a reason to put it in include/linux/ and _force_ it to -1,
to prevent them from doing such a thing? We particularly don't want x86
doing this, because most people only test their drivers on x86.

> Note to Willy: In the long run, the irq number should indeed be a
> typedef, it would be nice indeed to hide it in a structure, with some
> ISA_TO_IRQ and IRQ_TO_ISA for drivers who care about legacy numbers
> maybe ?

Sounds like a very good idea. Eventually, perhaps, we can acknowledge
that interrupts are a tree, and that interrupt controllers can be
hot-plugged. :)

-- 
dwmw2
