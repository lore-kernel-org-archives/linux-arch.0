Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268216AbUIPUGJ@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:26515 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268209AbUIPUDv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 16:03:51 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: RFC: being more anal about iospace accesses..
Date: Thu, 16 Sep 2004 13:02:49 -0700
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <200409161152.54691.jbarnes@engr.sgi.com> <Pine.LNX.4.58.0409161203430.2333@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409161203430.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161302.49135.jbarnes@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 16, 2004 12:09 pm, Linus Torvalds wrote:
> On Thu, 16 Sep 2004, Jesse Barnes wrote:
> > Sure, that's the way I'd like to go, but that's a dangerous route.
>
> It might be slightly less dangerous if we only do this for the new
> interface. It would still be up to you guys to verify that drivers use
> whatever new "dma_synchronize(dev)" interface, but hey, that's the price
> you pay for not following the standard.

Sure, sounds fair.  I just wanted to avoid changing the existing interfaces, 
that's all.

> I know hardware people love saying "we can do this faster doing XXX and
> then sw can take care of it". Make the powers-that-be realize that if
> software takes care of it, it means that sw needs resources to track it..

Yep.

> > If you want to explicitly document that the new io* interface doesn't
> > guarantee DMA coherence, great, we can start from scratch with a good
> > implementation that has an explicit flush mechanism.
>
> I think that's the right thing to do at this point, but since nobody else
> will really see this issue (since standard PCI does synchronize DMA),

Note that PCI-X and PCI Express allow a lack of synchronization via the 
relaxed ordering bit.  So platforms can either set that bit in their iomap 
functions and deal with synchronization via dma_sync or not use it I guess.

> there will inevitably be bugs that are SGI-specific. Just as everybody is
> aware of the issue, and realizes that there's going to be some cost of
> that to SGI in the form of testing and verification, this sounds like the
> way to go..
>
> Does that sound reasonable to everybody?

Sure, thanks.

Jesse
