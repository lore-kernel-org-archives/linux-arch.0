Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266603AbUIPCd1@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14512 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266555AbUIPCd1
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 22:33:27 -0400
Date: Thu, 16 Sep 2004 03:33:25 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095287935.1688.4.camel@mulgrave>
Sender: <willy@www.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 15, 2004 at 06:38:50PM -0400, James Bottomley wrote:
> Please can we not do it this way, that was the old pci_map_single et al
> which we've just spent quite a bit of time converting to
> dma_map_single.  It might not matter to the PCI centric people, but the
> generic DMA API was a wonderful simplification to the rest of us.
> 
> Can we start iomap off on the right foot and simply do dma_iomap (or
> dev_iomap since dma_ may end up to be confusing), taking a struct device
> as an argument and let the platform, which knows where the buses are,
> map this to the correct operations?

Actually, I think we're OK with the current interface here.  The routines
we have that give us an iomem pointer are:

/* Create a virtual mapping cookie for an IO port range */
extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
extern void ioport_unmap(void __iomem *);

/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
struct pci_dev;
extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
extern void pci_iounmap(struct pci_dev *dev, void __iomem *);

So rather than pass the struct device in, we've got a special function
for each bus type.


What we haven't dealt with in this interface are:

 - relaxed reads
 - byte ordering

The relaxed attribute is, I think, not a property of the space we're
looking at.  It's a property of any given transaction.  So I think we
really do want a set of ioreadXX_relaxed() functions.

Byte ordering I'm less clear on.  Is this a property of the area "this
area is little endian on the bus, but the host cpu is big endian",
or is it a property of an individual transaction?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
