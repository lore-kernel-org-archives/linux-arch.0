Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266485AbUI0Pl0@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:12267 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266481AbUI0Pl0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Sep 2004 11:41:26 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Date: Mon, 27 Sep 2004 08:41:15 -0700
References: <200409231448.21887.jbarnes@engr.sgi.com> <1096245913.4965.15.camel@gaston>
In-Reply-To: <1096245913.4965.15.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409270841.15883.jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sunday, September 26, 2004 5:45 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2004-09-24 at 04:48, Jesse Barnes wrote:
> >@@ -1727,7 +1727,7 @@
> >        reg = ha->iobase;
> >        /* disable risc and host interrupts */
> >        WRT_REG_WORD(&reg->ictrl, 0);
> >-       RD_REG_WORD(&reg->ictrl);       /* PCI Posted Write flush */
> >+       mmiowb(); /* make sure this write arrives before any others */
> >        ha->flags.ints_enabled = 0;
> > }
>
> This is a typical example of non working sync. You platform might have
> some kind of guarantee vs. ordering of interrupts, but in the general
> case, the above may "leak", that is you may still take an interrupt
> after ha->flags.ints_enabled = 0.

Right, that's what James pointed out.  Jeremy will submit the qla mmiowb bits, 
and has dropped these, since the routine probably shouldn't return until 
interrupts are actually enabled.  (But I see on your platform the sore to 
ins_enabled will probably be issued in parallel to the MMIO store to the 
interrupt register, and so might happen first.)

> First, on some CPUs like evil PPCs, that write to memory may end up
> beeing on a different write queue as I explaines, thouh the mmiowb()
> will help if I implement it as a strong barrier (and the previous
> MMIO read wouldn't have helped). But that isn't my point.
>
> The problem is that interrupts are asynchronous by nature. When the
> above code is reached, the device may already have asserted the
> interrupt line, which may still be in the process of propagating to
> the CPU through the various APICs or within the CPU core. There is
> no way you can guarantee you won't take it (though since it's a PCI
> interrupt, it's, I suppose, a level interrupt, so it will probably
> go away shortly after beeing asserted). It may even be on it's way
> to beeing handled on another CPU in fact. Even synchronize_irq()
> won't help.
>
> I haven't looked at the rest of the driver, but it certainly must be
> prepared to take spurrious interrupts since that can (and so will)
> happen.

Right, afaik all drivers (or at least all PCI drivers) should be able to deal 
with this.  Whether or not they do is a different story (I think qla does).

Jesse
