Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266539AbUIPVhl@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:38365 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S266543AbUIPVhl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 17:37:41 -0400
Date: Thu, 16 Sep 2004 15:37:35 -0600
From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040916213735.GA24048@colo.lackof.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <200409161302.49135.jbarnes@engr.sgi.com> <1095367049.2014.21.camel@mulgrave> <200409161342.48505.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409161342.48505.jbarnes@engr.sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Grant Grundler <grundler@parisc-linux.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 16, 2004 at 01:42:48PM -0700, Jesse Barnes wrote:
> Depends on how you read the specs.

I'd say it depends on if the PCI-X device implements RO hint
correctly and if the platform chipset doesn't ignore RO bit
in the PCI-X commands that go across the wire.

> I think they're compatible, but others 
> think that PCI-X RO will require a different implementation.

No. PCI-X RO is an attribute the OS can set on the PCI-X device
before putting it to work. The device then decides when to use RO
hint and hopefully only uses RO hint when it's really ok (eg. most bulk
data transfer and not for all control data).

readX_relaxed() is ha^H^Hoptimization so SGI platform doesn't have
to pay a huge penalty to enforce PCI ordering rules on every MMIO read.
IIRC, the SGI Altix chipset will allow MMIO Read returns to bypass DMA writes.

Original thread discusses this in more detail:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1678.html

> > My understanding is that Relaxed Ordering is that it's two bit (i.e. two
> > separately allowable optimisations)

PCI-X "Enable RO" is only one bit in the PCI-X Command Register.

> > that allow either PIO writes to pass DMA reads

Most parisc platforms allow this to happen. I can't see any harm in it
though it's possible some PCI device will break because of it.
Since the PCI-X device isn't sourcing transactions in this direction,
I don't see how PCI-X RO would be involved.

> >  or PIO reads to pass DMA writes (or both) in the stream (I may
> > have this wrong, I copied Grant because he's been working on this).
> >
> > I thought your readX_relaxed was only the first half of this?
> 
> Only the second half, actually.
> It may also apply to intra-DMA block ordering.

readX_relaxed() has nothing to do with DMA ordering AFAICT.
PCI-X RO hint would if I understand you correctly.

thanks,
grant
