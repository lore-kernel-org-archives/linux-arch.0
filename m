Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268237AbUIPUn3@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:41399 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268240AbUIPUn3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 16:43:29 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: RFC: being more anal about iospace accesses..
Date: Thu, 16 Sep 2004 13:42:48 -0700
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <200409161302.49135.jbarnes@engr.sgi.com> <1095367049.2014.21.camel@mulgrave>
In-Reply-To: <1095367049.2014.21.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161342.48505.jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Grant Grundler <grundler@parisc-linux.org>
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 16, 2004 1:37 pm, James Bottomley wrote:
> On Thu, 2004-09-16 at 16:02, Jesse Barnes wrote:
> > Note that PCI-X and PCI Express allow a lack of synchronization via the
> > relaxed ordering bit.  So platforms can either set that bit in their
> > iomap functions and deal with synchronization via dma_sync or not use it
> > I guess.
>
> Now you've confused me again.  I thought the SGI implementation of this
> relaxed read thing was *not* the same as the PCI-X RO bit which was why
> you needed a special readX_relaxed?

Depends on how you read the specs.  I think they're compatible, but others 
think that PCI-X RO will require a different implementation.  We'll know when 
we see hardware that supports it.

> My understanding is that Relaxed Ordering is that it's two bit (i.e. two
> separately allowable optimisations) that allow either PIO writes to pass
> DMA reads or PIO reads to pass DMA writes (or both) in the stream (I may
> have this wrong, I copied Grant because he's been working on this).
>
> I thought your readX_relaxed was only the first half of this?

Only the second half, actually.  It may also apply to intra-DMA block 
ordering.

Jesse
