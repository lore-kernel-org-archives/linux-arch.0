Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268474AbUIQFWJ@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47528 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268476AbUIQFWI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Sep 2004 01:22:08 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org>
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
Content-Type: text/plain
Message-Id: <1095398446.5109.43.camel@gaston>
Mime-Version: 1.0
Date: Fri, 17 Sep 2004 15:20:46 +1000
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>


> Actually, we could also take the "safe" approach, and just specify that 
> the new "ioread()/iowrite()" interfaces are always very relaxed, and apart 
> from endianness won't do much extra synchronization.

That would be catastrophic with 99% of the drivers on PPC. The processor
may speculate reads from outside spinlocks and that sort of horror, or
defer them to until much later, crossing writes and such things...

And we don't always have nice way of providing barriers. For example,
for enforcing a read to happen "now", the only way is to actually create
a pseudo dependency on the data returned by the read, so an
function/macro like "read_barrier()" can't be implemented unless it
takes the result of the read as an argument.

> What are sane rules? Clearly it is _not_ a sane rule to allow memory 
> re-ordering to the same device, because most driver authors have problems 
> as-is, and trying to make them aware of speculative reads and writes 
> passing writes is just not going to fly. So a minimal sane rule would be 
> that each device seens programmatic IO accesses in "thread order".
> 
> But I think it would be ok to say that DMA needs explicit synchronization,
> and obviously write posting (as long as it doesn't re-order IO accesses)  
> is fine. The latter is already true for MMIO (and arguably acceptable even
> for PIO, although x86's have historically had slightly stricter ordering
> on PIO).

Write posting is always assumed since it's already fine per PCI spec. I
don't agree with read vs. DMA.

> So how about trying to come up with a sane interface for "synchronize
> DMA". I _suspect_ it will have to be device-specific, so we should aim for
> a similar interface to the "dma-mapping" ones (ie based on "struct
> device", not the bus it's on).
> 
> In most cases it would be a no-op, or we could hide some pointer a la
> "dev->bus->sync(dev)" (which could do a status read from the bridge or
> whatever..)

Ok, well, synchronize DMA would end up having to do a read on most
setups, so that mean knowing of a register on the device with no side
effects etc... difficult to acheive outside of the driver...

Ben.
