Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268240AbUIPUii@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:18092 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268237AbUIPUiB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 16:38:01 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <200409161302.49135.jbarnes@engr.sgi.com>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<200409161152.54691.jbarnes@engr.sgi.com>
	<Pine.LNX.4.58.0409161203430.2333@ppc970.osdl.org>
	<200409161302.49135.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 16 Sep 2004 16:37:23 -0400
Message-Id: <1095367049.2014.21.camel@mulgrave>
Mime-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Grant Grundler <grundler@parisc-linux.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-09-16 at 16:02, Jesse Barnes wrote:
> Note that PCI-X and PCI Express allow a lack of synchronization via the 
> relaxed ordering bit.  So platforms can either set that bit in their iomap 
> functions and deal with synchronization via dma_sync or not use it I guess.

Now you've confused me again.  I thought the SGI implementation of this
relaxed read thing was *not* the same as the PCI-X RO bit which was why
you needed a special readX_relaxed?

My understanding is that Relaxed Ordering is that it's two bit (i.e. two
separately allowable optimisations) that allow either PIO writes to pass
DMA reads or PIO reads to pass DMA writes (or both) in the stream (I may
have this wrong, I copied Grant because he's been working on this).

I thought your readX_relaxed was only the first half of this?

James
