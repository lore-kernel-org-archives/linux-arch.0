Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268228AbUIQFrC@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57000 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268206AbUIQFrC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Sep 2004 01:47:02 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.58.0409161229310.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
	 <1095287935.1688.4.camel@mulgrave>
	 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
	 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org>
	 <4149E5C2.7010008@pobox.com>
	 <Pine.LNX.4.58.0409161229310.2333@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1095399875.5109.67.camel@gaston>
Mime-Version: 1.0
Date: Fri, 17 Sep 2004 15:44:35 +1000
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>


> So the only remaining source of issues would be synchronization between
> devices (which we haven't really supported anyway, and which nobody really
> tends to care about), and synchronization with "side-band signals". And
> there are really only two side-band signals that I can think of: DMA and
> IRQ's.

DMA isn't really "side band", and reads only synchronize with DMA on the
same bus path anyways.

Interrupts are never properly synchronized (and I've seen many bugs
because of that, we can _NEVER_ assume we are properly synchronized with
an interrupt, it can be buffered a totally random amount of time in the
path to the CPU and even inside of the CPU before reaching the core,
whatever the driver did to mask it on the device, drivers writers must
be aware of that, they aren't most of the time, calling sychronize_irq()
after masking on-device will _NOT_ guarantee you won't get a stale one).

> I would argue that we likely don't normally care about strict
> synchronization with those side-band signals, because most of the
> serialization that a driver would rely on would be strictly causal (and
> thus happen regardless of what interface we make up:  I seriously doubt we
> could come up with a non-causal interface, but some physicists might be
> very interested indeed ;).

Nope,  we do care a hell lot about synchronization with DMA, and it's
been a source of countless horrible to track down bugs in the past when
debugging high IO stress benchmarks on big POWER machines.

> So for example, we can pretty much depend on a "command completed"
> interrupt being asserted only after we've written the command to the chip. 
> No interface issues there.

Yes. That one is fine, except if we get a stale irq from a previous
command where we didn't care about the interrupt, or that sort of thing
of course.

> Similarly, if we read a status register in an 
> interrupt handler, we _will_ get the status of the interrupt, unless the 
> chip itself does some buffering at which point it is a driver issue to 
> handle that, rather than an interface issue.

Right. What we cannot rely on with interrupt is not taking them after
masking them. We _can_ rely on disable_irq() because it will mask at the
controller level and the arch code will take care of not delivering if
stale, but masking on-chip is never guaranteed to have a synchronizable
effect. At least, for level interrupts, we know that if we take it
anyway, we can just return and drop it until it goes away

> So the remaining issues are really things we already see with DMA, for
> example: if we read a mailbox from memory saying that DMA has completed,
> we need to have a read-memory barrier before we actually read the contents
> of the IO, otherwise the CPU might read buffer contents "prior" to the
> completion.

We need to have those 2 reads done in order yes, an lwsync on ppc would
be ok which is what we do on rmb(), but that is irrelevant to the IO
accessors, this is memory vs. memory

> The same would go for doing a "ioread()" that reads a status register in 
> MMIO that says "DMA is done". Before we can _trust_ that, we'd need to 
> synchronize with the DMA "out-of-band" stuff. I think that's an acceptable 
> interface, since it's something we already support for memory-based 
> interfaces. 

This is the typical case affecting most drivers. Read status from chip,
then read memory. We need 2 things here:

  - We need DMA synchronization, that is we need to enforce that the
MMIO read flushes the DMA. This is where the PCI spec is clear and where
we are getting this new 'relaxed' stuff potentially coming in the
picture, but I'm pretty much against making the relaxed case default

  - We also need to make sure the memory read isn't speculated and done
by the CPU prior to the IO read, which is currently acheive on PPC via
some deep magic inside of the IO reads (creating an artificial data
dependency on the result of all IO reads with a conditional trap that is
never taken followed an isync).

> It would be different, of course - it wouldn't be a read barrier, it would
> be a "ioread" barrier. But the _concept_ is the same. And it doesn't tend
> to hit us all that often, and the biggest pain is literally that in-spec
> PCI devices will never show this, so the real problem for hardware like
> SGI's in this case is lack of test coverage out in the rest of the world. 
> That's the price you pay if you do things differently.
> 
> Implementation shouldn't be that hard. On any conforming PCI platform, 
> it's a no-op, since reads from MMIO space are supposed to already 
> synchronize with any buffered DMA (it still leaves the question of CPU 
> memory ordering wrt uncached accesses, and thus we might want to have a 
> memory barrier in place depending on architecture). And SGI would have 
> something that synchronizes with the bridge nearest to the device.
> 
> So I _think_ the SGI case would be perfectly happy with an interface like 
> 
> 	void dma_sync(struct device *dev);

Hrm... I don't like that... Also, don't they need to do a read (just a
different form of read) to synchronize ? If they do, they actually need
a full IO accessor ... What does the PCI-X* (X, express, etc...) about
relaxed ordering IOs ?

> which on their SN2 machines would do "dev->bus->sync(dev)" (where they 
> would add something that reads from the bridge), and the rest of the world 
> might just do a memory barrier there, or leave it as a no-op.
> 
> And yes, a few drivers would have "dma_sync()" in a few places. Not that 
> many, likely.
> 
> Would driver writers get this wrong, and forget? Absolutely. But that's 
> true of any interface we could come up with. If there is something we can 
> absolutely depend on in life, it's that driver writers _will_ do something 
> wrong. 
> 
> 		Linus
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
