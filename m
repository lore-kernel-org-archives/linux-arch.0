Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268138AbUIPTJr@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:43726 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268105AbUIPTJr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 15:09:47 -0400
Date: Thu, 16 Sep 2004 12:09:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <200409161152.54691.jbarnes@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0409161203430.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org> <200409161152.54691.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, Jesse Barnes wrote:
> 
> Sure, that's the way I'd like to go, but that's a dangerous route.

It might be slightly less dangerous if we only do this for the new 
interface. It would still be up to you guys to verify that drivers use 
whatever new "dma_synchronize(dev)" interface, but hey, that's the price 
you pay for not following the standard. 

I know hardware people love saying "we can do this faster doing XXX and 
then sw can take care of it". Make the powers-that-be realize that if 
software takes care of it, it means that sw needs resources to track it..

> If you want to explicitly document that the new io* interface doesn't 
> guarantee DMA coherence, great, we can start from scratch with a good 
> implementation that has an explicit flush mechanism.

I think that's the right thing to do at this point, but since nobody else
will really see this issue (since standard PCI does synchronize DMA),
there will inevitably be bugs that are SGI-specific. Just as everybody is
aware of the issue, and realizes that there's going to be some cost of
that to SGI in the form of testing and verification, this sounds like the
way to go..

Does that sound reasonable to everybody?

		Linus
