Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268162AbUIPTuY@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:34433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268161AbUIPTuY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 15:50:24 -0400
Date: Thu, 16 Sep 2004 12:50:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <4149E5C2.7010008@pobox.com>
Message-ID: <Pine.LNX.4.58.0409161229310.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave>
 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org> <4149E5C2.7010008@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > What are sane rules?
> 
> I'd err on the side of "simple and tough to screw up" :)

I definitely agree. As I said, I think strict memory ordering is a must
for that reason.

That said, if we make make things _too_ strict, and that then makes some 
people start looking at extended interfaces in order to get their work 
done, the rules then effectively become more complex again, because now we 
have a much bigger API - a "simple" set with strict rules and 
synchronization, mixed together with the "give them rope" set.

And quite frankly, we've already seen that many driver writers will then 
start using the "give them rope" set, if only because they really think 
they need to. And then they'll screw up again.

> What rules are most beneficial to the likely users of this API?

I think the "programmatic IO accesses are strictly in-order for one
particular device" rule is so fundamentally required that nobody will
really argue against it. There is very little hardware that doesn't really 
enforce that rule anyway, and most of the extensions to it ("allow 
bursting and other fancy stuff" is in practice done by the driver setup 
code anyway, and has nothing to do with the individual IO accesses).

So the only remaining source of issues would be synchronization between
devices (which we haven't really supported anyway, and which nobody really
tends to care about), and synchronization with "side-band signals". And
there are really only two side-band signals that I can think of: DMA and
IRQ's.

I would argue that we likely don't normally care about strict
synchronization with those side-band signals, because most of the
serialization that a driver would rely on would be strictly causal (and
thus happen regardless of what interface we make up:  I seriously doubt we
could come up with a non-causal interface, but some physicists might be
very interested indeed ;).

So for example, we can pretty much depend on a "command completed"
interrupt being asserted only after we've written the command to the chip. 
No interface issues there. Similarly, if we read a status register in an 
interrupt handler, we _will_ get the status of the interrupt, unless the 
chip itself does some buffering at which point it is a driver issue to 
handle that, rather than an interface issue.

So the remaining issues are really things we already see with DMA, for
example: if we read a mailbox from memory saying that DMA has completed,
we need to have a read-memory barrier before we actually read the contents
of the IO, otherwise the CPU might read buffer contents "prior" to the
completion.

The same would go for doing a "ioread()" that reads a status register in 
MMIO that says "DMA is done". Before we can _trust_ that, we'd need to 
synchronize with the DMA "out-of-band" stuff. I think that's an acceptable 
interface, since it's something we already support for memory-based 
interfaces. 

It would be different, of course - it wouldn't be a read barrier, it would
be a "ioread" barrier. But the _concept_ is the same. And it doesn't tend
to hit us all that often, and the biggest pain is literally that in-spec
PCI devices will never show this, so the real problem for hardware like
SGI's in this case is lack of test coverage out in the rest of the world. 
That's the price you pay if you do things differently.

Implementation shouldn't be that hard. On any conforming PCI platform, 
it's a no-op, since reads from MMIO space are supposed to already 
synchronize with any buffered DMA (it still leaves the question of CPU 
memory ordering wrt uncached accesses, and thus we might want to have a 
memory barrier in place depending on architecture). And SGI would have 
something that synchronizes with the bridge nearest to the device.

So I _think_ the SGI case would be perfectly happy with an interface like 

	void dma_sync(struct device *dev);

which on their SN2 machines would do "dev->bus->sync(dev)" (where they 
would add something that reads from the bridge), and the rest of the world 
might just do a memory barrier there, or leave it as a no-op.

And yes, a few drivers would have "dma_sync()" in a few places. Not that 
many, likely.

Would driver writers get this wrong, and forget? Absolutely. But that's 
true of any interface we could come up with. If there is something we can 
absolutely depend on in life, it's that driver writers _will_ do something 
wrong. 

		Linus
