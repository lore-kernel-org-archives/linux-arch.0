Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S265222AbUI0Aqz@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:26505 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265211AbUI0Aqz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 26 Sep 2004 20:46:55 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200409231448.21887.jbarnes@engr.sgi.com>
References: <200409231448.21887.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1096245913.4965.15.camel@gaston>
Mime-Version: 1.0
Date: Mon, 27 Sep 2004 10:45:13 +1000
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-09-24 at 04:48, Jesse Barnes wrote:

>@@ -1727,7 +1727,7 @@
>        reg = ha->iobase;
>        /* disable risc and host interrupts */
>        WRT_REG_WORD(&reg->ictrl, 0);
>-       RD_REG_WORD(&reg->ictrl);       /* PCI Posted Write flush */
>+       mmiowb(); /* make sure this write arrives before any others */
>        ha->flags.ints_enabled = 0;
> }

This is a typical example of non working sync. You platform might have
some kind of guarantee vs. ordering of interrupts, but in the general
case, the above may "leak", that is you may still take an interrupt
after ha->flags.ints_enabled = 0.

First, on some CPUs like evil PPCs, that write to memory may end up
beeing on a different write queue as I explaines, thouh the mmiowb()
will help if I implement it as a strong barrier (and the previous
MMIO read wouldn't have helped). But that isn't my point.

The problem is that interrupts are asynchronous by nature. When the
above code is reached, the device may already have asserted the
interrupt line, which may still be in the process of propagating to
the CPU through the various APICs or within the CPU core. There is
no way you can guarantee you won't take it (though since it's a PCI
interrupt, it's, I suppose, a level interrupt, so it will probably
go away shortly after beeing asserted). It may even be on it's way
to beeing handled on another CPU in fact. Even synchronize_irq()
won't help.

I haven't looked at the rest of the driver, but it certainly must be
prepared to take spurrious interrupts since that can (and so will)
happen.

Ben.
