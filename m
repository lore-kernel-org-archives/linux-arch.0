Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268206AbUIPSXO@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:13481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268121AbUIPSVK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 14:21:10 -0400
Date: Thu, 16 Sep 2004 11:21:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave>
 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Matthew Wilcox <willy@debian.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, Matthew Wilcox wrote:
> 
> I think the reason you haven't seen much of it is that only SGI people
> care about it ;-)  The only drivers in the tree that use it are Fusion,
> qla1280 and qla2xxx, and the only architecture that defines readb_relaxed()
> to be anything other than readb() is ia64.

Bzzt.

ia64 actually defines readb to be the same as readb_relaxed.

It's literally only the sn2 _platform_ that does something stupid. In 
other words, it's not ia64 that is broken (surprise surprise - you never 
expected me to have said anything good about ia64), it's literally the SN2 
platform that seems broken.

And quite frankly, even than I'm not sure that it's the hw platform itself 
that is broken, it might well just be the architecture code. For some 
reason the SN2 code does:

	/*
	 * The following routines are SN Platform specific, called when
	 * a reference is made to readX/writeX set macros.  SN Platform
	 * readX set of macros ensures that Posted DMA writes on the
	 * Bridge is flushed.
	 *
	 * The routines should be self explainatory.
	 */

	static inline unsigned char
	___sn_readb (void *addr)
	{
	        unsigned char val;

	        val = *(volatile unsigned char *)addr;
	        __sn_mf_a();
	        sn_dma_flush((unsigned long)addr);
	        return val;
	}

in other words, it looks like there's a broken PCI "bridge" involved, that 
just doesn't follow the specs, and does bad things.

> However, they do see significant wins from using this.  According to
> Jeremy Higdon this can reduce a 50us read to a 1us read.  So it's probably
> worth doing for them.

I'd suggest to them to unbreak their silly "readb()" implementation, and 
 (a) talk to their hw engineers
 (b) add explicit flush code to the 5 (or so) drivers that they really 
     care about. Let's face it, I doubt there are that many different 
     devices that people use on the SN2. Make a nice "synchronize"  
     interface that you could architect, and make conforming platforms
     just make it into a no-op.

I'd hate to add complex new interfaces just because some hardware is 
broken. Don't make the generic interfaces suffer for broken hardware.

		Linus
