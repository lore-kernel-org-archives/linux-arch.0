Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267460AbUIPE2K@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:23980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267457AbUIPE2K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 00:28:10 -0400
Date: Wed, 15 Sep 2004 21:28:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave>
 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Matthew Wilcox <willy@debian.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, Matthew Wilcox wrote:
> 
> Actually, I think we're OK with the current interface here.  The routines
> we have that give us an iomem pointer are:
> 
> /* Create a virtual mapping cookie for an IO port range */
> extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
> extern void ioport_unmap(void __iomem *);
> 
> /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
> struct pci_dev;
> extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
> 
> So rather than pass the struct device in, we've got a special function
> for each bus type.

Indeed. Once created, the cookie is "bus-agnostic", which is very much the 
point. Unlike the original pci DMA interfaces, there are no real bus 
assumtions in the interfaces once set up. 

And set-up obviously _does_ need to be bus-specific, the same way device
discovery is. You don't dicsover non-specific devices. You very much
initialize one particular instance of one particular device/bus.

Now, other buses might want to choose to ignore the ioread/iowrite 
interfaces, and do their own bus-specific ones. I doubt it makes much 
sense, but it's not like we want to _force_ one particular IO model on 
people. 

> What we haven't dealt with in this interface are:
> 
>  - relaxed reads
>  - byte ordering
> 
> The relaxed attribute is, I think, not a property of the space we're
> looking at.  It's a property of any given transaction.  So I think we
> really do want a set of ioreadXX_relaxed() functions.

I haven't seen very many people actually use this. I've been assuming that 
what people want is the same "reasonably relaxed" behaviour that the 
regular MMIO functions have (as opposed to what traditional PIO is: it's 
slow as hell because it doesn't support posting). Are there actually users 
of any other model out there?

> Byte ordering I'm less clear on.  Is this a property of the area "this
> area is little endian on the bus, but the host cpu is big endian",
> or is it a property of an individual transaction?

I'd suggest individual transaction, although again, I doubt it is all that
much used. The "repeat" versions do IO-native byte order, which is really
the only case where we've ever really cared. David mentioned that some
network devices had tried to use "host-native" byte order (which some
hardware supports), but that it hadn't been worth the pain and apparently
got ripped out.

In other words, I'd like to keep the interfaces as simple as humanly
possible, and only introduce new concepts if absolutely required. For
example, one issue is 64-bit accesses: they will _not_ be atomic on most
architectures, and given that the question is whether they are worth
supporting at all, or whether drivers should just be expected to make the
non-atomicity explicit (by loading two dwords, the way they have to do
with the old interfaces anyway).

(Note that 64-bit accesses aren't necessarily atomic even on 64-bit
architectures. BenH says that the IO architecture on a G5 means that when
you do a 64-bit load, it will be done as two 32-bit bus cycles
regardless).

		Linus
