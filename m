Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268240AbUIPUVY@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:26022 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268228AbUIPUU5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 16:20:57 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: RFC: being more anal about iospace accesses..
Date: Thu, 16 Sep 2004 13:20:31 -0700
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <200409161152.54691.jbarnes@engr.sgi.com> <20040916130450.40b3f8a1.davem@davemloft.net>
In-Reply-To: <20040916130450.40b3f8a1.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161320.31522.jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, willy@debian.org, James.Bottomley@steeleye.com, geert@linux-m68k.org, linux-arch@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@redhat.com, jgarzik@pobox.com
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 16, 2004 1:04 pm, David S. Miller wrote:
> On Thu, 16 Sep 2004 11:52:54 -0700
>
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > On Thursday, September 16, 2004 11:21 am, Linus Torvalds wrote:
> > > It's literally only the sn2 _platform_ that does something stupid. In
> > > other words, it's not ia64 that is broken (surprise surprise - you
> > > never expected me to have said anything good about ia64), it's
> > > literally the SN2 platform that seems broken.
> >
> > No, it's just the only smart platform.  Apparently we're the only ones
> > who realized that most PIO reads do not rely on prior DMA being complete
> > (and that it's expensive to make sure that they do), so we optimized that
> > out of our hardware.  Only interrupts will guarantee DMA completion on
> > SGI platforms.
>
> Jesse, I think you might not need that hack in the I/O accessor
> routines to handle this.  pci_dma_unmap(), pci_dma_sync_*() and
> friends should be the place to perform this "prior DMA sync" thing.

That would be ok, except for the fact that we wouldn't be able to provide 
'consistent' memory.  I think it's better to implement the expected PCI 
semantics but provide an out via the _relaxed interface (new interfaces 
aside).

Jesse
