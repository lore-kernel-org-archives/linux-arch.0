Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268228AbUIPUH6@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53955
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268183AbUIPUH6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 16:07:58 -0400
Date: Thu, 16 Sep 2004 13:04:50 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: RFC: being more anal about iospace accesses..
Message-Id: <20040916130450.40b3f8a1.davem@davemloft.net>
In-Reply-To: <200409161152.54691.jbarnes@engr.sgi.com>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
	<200409161152.54691.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: torvalds@osdl.org, willy@debian.org, James.Bottomley@steeleye.com, geert@linux-m68k.org, linux-arch@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@redhat.com, jgarzik@pobox.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 16 Sep 2004 11:52:54 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Thursday, September 16, 2004 11:21 am, Linus Torvalds wrote:
> > It's literally only the sn2 _platform_ that does something stupid. In
> > other words, it's not ia64 that is broken (surprise surprise - you never
> > expected me to have said anything good about ia64), it's literally the SN2
> > platform that seems broken.
> 
> No, it's just the only smart platform.  Apparently we're the only ones who 
> realized that most PIO reads do not rely on prior DMA being complete (and 
> that it's expensive to make sure that they do), so we optimized that out of 
> our hardware.  Only interrupts will guarantee DMA completion on SGI 
> platforms.

Jesse, I think you might not need that hack in the I/O accessor
routines to handle this.  pci_dma_unmap(), pci_dma_sync_*() and
friends should be the place to perform this "prior DMA sync" thing.

Drivers aren't allowed to touch active DMA data areas until they
call one of those interfaces (see Documentation/DMA-mapping.txt)
so that should just work.
