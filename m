Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268077AbUIPNnF@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2451 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268076AbUIPNlz
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 09:41:55 -0400
Date: Thu, 16 Sep 2004 14:41:52 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave> <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
Sender: <willy@www.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 15, 2004 at 09:28:01PM -0700, Linus Torvalds wrote:
> > The relaxed attribute is, I think, not a property of the space we're
> > looking at.  It's a property of any given transaction.  So I think we
> > really do want a set of ioreadXX_relaxed() functions.
> 
> I haven't seen very many people actually use this. I've been assuming that 
> what people want is the same "reasonably relaxed" behaviour that the 
> regular MMIO functions have (as opposed to what traditional PIO is: it's 
> slow as hell because it doesn't support posting). Are there actually users 
> of any other model out there?

I think the reason you haven't seen much of it is that only SGI people
care about it ;-)  The only drivers in the tree that use it are Fusion,
qla1280 and qla2xxx, and the only architecture that defines readb_relaxed()
to be anything other than readb() is ia64.

However, they do see significant wins from using this.  According to
Jeremy Higdon this can reduce a 50us read to a 1us read.  So it's probably
worth doing for them.

> > Byte ordering I'm less clear on.  Is this a property of the area "this
> > area is little endian on the bus, but the host cpu is big endian",
> > or is it a property of an individual transaction?
> 
> I'd suggest individual transaction, although again, I doubt it is all that
> much used. The "repeat" versions do IO-native byte order, which is really
> the only case where we've ever really cared. David mentioned that some
> network devices had tried to use "host-native" byte order (which some
> hardware supports), but that it hadn't been worth the pain and apparently
> got ripped out.

After some further thought, I think it's a property of the remapping
transaction.  I'm thinking about the case of a chip that's connected
either via PCI or via a host-native bus on a big-endian platform.  The
foo_iomap() would mark the area as being big-endian and pci_iomap() as
little-endian.

> In other words, I'd like to keep the interfaces as simple as humanly
> possible, and only introduce new concepts if absolutely required. For
> example, one issue is 64-bit accesses: they will _not_ be atomic on most
> architectures, and given that the question is whether they are worth
> supporting at all, or whether drivers should just be expected to make the
> non-atomicity explicit (by loading two dwords, the way they have to do
> with the old interfaces anyway).

There's a readq() on all 64 bit architectures.  It's not used very much,
but (for example), the s2io 10GE driver uses it extensively.  I think
if we _don't_ provide an ioread64() we'll see these drivers either not
switch to this interface or, worse, reimplement readq themselves with
predictably horrible consequences.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
