Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268029AbUIPMRt@vger.kernel.org>
Received: from imladris.demon.co.uk ([193.237.130.41]:63415 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S268026AbUIPMRt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 08:17:49 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.58.0409151256130.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
	 <20040915194001.GH642@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0409151256130.2333@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1095337056.9144.2337.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 13:17:36 +0100
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-09-15 at 13:10 -0700, Linus Torvalds wrote:
> On Wed, 15 Sep 2004, Matthew Wilcox wrote:
> 
> > Could we have a 'dev' parameter to ioread8()?  Please?
> 
> Nope. See earlier email on why. There is no "dev" any more at the point of
> a generic chipset handler: the "dev" may have any of millions of possible 
> types (well, ok, a few different bus architectures, but still).

It's not just about address spaces. Have you looked at some of the
implementations of readb() et al on some SH boards recently, with all
the if/elif/elif/ crap for different ranges of the address space? And
don't even get me started on the one where the PCI bridge allows you to
only map 48MiB of the PCI bus into the host address space at a time, so
MMIO accesses have to be done via an indirect method like config space
accesses are. You don't assign host addresses in ioremap() and you
_really_ get screwed over if broken drivers dereference __iomem
'pointers' instead of using the proper accessor functions :)

Yes, we _can_ continue do it the same way. But I was sort of hoping that
with a new API it'd get nicer.

> I seriously doubt that you don't have space to encode the same information 
> that was already there before in a pointer. David was kicking and 
> screaming too, until Jeff pointed out that it was all in the same address 
> space, and then he said "oh", and suddenly it was trivial.

Well actually I bitched a little more on IRC and not here, because this
is supposed to be a low-noise forum. 

I would have been a lot more coherent in my argument a couple of years
ago when I actually had platforms on my desk on which it matters.
Nowadays it's all ppc and ppc64 and they are relatively sane, at lst n
tht rspct. At least they don't think it's sane to drag a crack-smoking
hobo off the street and ask him to implement a PCI host bridge in an
FPGA, so my life is a lot nicer :)

I certainly don't recall just saying 'oh'; you may have inferred that
from my silence.

-- 
dwmw2
