Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268472AbUIQFTM@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43432 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268420AbUIQFTM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Sep 2004 01:19:12 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200409161152.54691.jbarnes@engr.sgi.com>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
	 <200409161152.54691.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1095398253.5108.38.camel@gaston>
Mime-Version: 1.0
Date: Fri, 17 Sep 2004 15:17:34 +1000
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-09-17 at 04:52, Jesse Barnes wrote:
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

Hrm... that's weird... on sane DMA hardward, most PIO/MMIO reads are
actually here just to guarantee that completion, interrupts isn't enough
especially if we do things like polling (NAPI) etc... besides,
interrupts are usually totally asynchronous to anything else, so I
wouldn't say it's sane.

> Sure, that's the way I'd like to go, but that's a dangerous route.  Devices 
> that want to do a PIO read to see if their DMA is complete will work most of 
> the time, but you'll get occasional data corruption.  IOW, specifying reads 
> that you know *aren't* dependent is much easier to do, and safer.  It also 
> allows SGI hardware to run all current drivers w/o modification, which is 
> nice.

Agreed. Reads must NOT be relaxed by default

> If you want to explicitly document that the new io* interface doesn't 
> guarantee DMA coherence, great, we can start from scratch with a good 
> implementation that has an explicit flush mechanism.
> 
> Thanks,
> Jesse
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
