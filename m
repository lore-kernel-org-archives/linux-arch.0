Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268229AbUIPSy7@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:20445 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268145AbUIPSxy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 14:53:54 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: RFC: being more anal about iospace accesses..
Date: Thu, 16 Sep 2004 11:52:54 -0700
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161152.54691.jbarnes@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 16, 2004 11:21 am, Linus Torvalds wrote:
> It's literally only the sn2 _platform_ that does something stupid. In
> other words, it's not ia64 that is broken (surprise surprise - you never
> expected me to have said anything good about ia64), it's literally the SN2
> platform that seems broken.

No, it's just the only smart platform.  Apparently we're the only ones who 
realized that most PIO reads do not rely on prior DMA being complete (and 
that it's expensive to make sure that they do), so we optimized that out of 
our hardware.  Only interrupts will guarantee DMA completion on SGI 
platforms.

> And quite frankly, even than I'm not sure that it's the hw platform itself
> that is broken, it might well just be the architecture code. For some
> reason the SN2 code does:
>
>  /*
>   * The following routines are SN Platform specific, called when
>   * a reference is made to readX/writeX set macros.  SN Platform
>   * readX set of macros ensures that Posted DMA writes on the
>   * Bridge is flushed.
>   *
>   * The routines should be self explainatory.
>   */
>
>  static inline unsigned char
>  ___sn_readb (void *addr)
>  {
>          unsigned char val;
>
>          val = *(volatile unsigned char *)addr;
>          __sn_mf_a();
>          sn_dma_flush((unsigned long)addr);
>          return val;
>  }
>
> in other words, it looks like there's a broken PCI "bridge" involved, that
> just doesn't follow the specs, and does bad things.

Correct, it doesn't follow the specs.  See above.

> I'd suggest to them to unbreak their silly "readb()" implementation, and
>  (a) talk to their hw engineers
>  (b) add explicit flush code to the 5 (or so) drivers that they really
>      care about. Let's face it, I doubt there are that many different
>      devices that people use on the SN2. Make a nice "synchronize"
>      interface that you could architect, and make conforming platforms
>      just make it into a no-op.
>
> I'd hate to add complex new interfaces just because some hardware is
> broken. Don't make the generic interfaces suffer for broken hardware.

Sure, that's the way I'd like to go, but that's a dangerous route.  Devices 
that want to do a PIO read to see if their DMA is complete will work most of 
the time, but you'll get occasional data corruption.  IOW, specifying reads 
that you know *aren't* dependent is much easier to do, and safer.  It also 
allows SGI hardware to run all current drivers w/o modification, which is 
nice.

If you want to explicitly document that the new io* interface doesn't 
guarantee DMA coherence, great, we can start from scratch with a good 
implementation that has an explicit flush mechanism.

Thanks,
Jesse
