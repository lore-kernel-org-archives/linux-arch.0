Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268105AbUIPTCQ@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:11210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268064AbUIPTCP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 15:02:15 -0400
Date: Thu, 16 Sep 2004 12:01:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave>
 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Matthew Wilcox <willy@debian.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, Linus Torvalds wrote:
> 
> I'd suggest to them to unbreak their silly "readb()" implementation, and 
>  (a) talk to their hw engineers
>  (b) add explicit flush code to the 5 (or so) drivers that they really 
>      care about. Let's face it, I doubt there are that many different 
>      devices that people use on the SN2. Make a nice "synchronize"  
>      interface that you could architect, and make conforming platforms
>      just make it into a no-op.

Actually, we could also take the "safe" approach, and just specify that 
the new "ioread()/iowrite()" interfaces are always very relaxed, and apart 
from endianness won't do much extra synchronization.

What are sane rules? Clearly it is _not_ a sane rule to allow memory 
re-ordering to the same device, because most driver authors have problems 
as-is, and trying to make them aware of speculative reads and writes 
passing writes is just not going to fly. So a minimal sane rule would be 
that each device seens programmatic IO accesses in "thread order".

But I think it would be ok to say that DMA needs explicit synchronization,
and obviously write posting (as long as it doesn't re-order IO accesses)  
is fine. The latter is already true for MMIO (and arguably acceptable even
for PIO, although x86's have historically had slightly stricter ordering
on PIO).

So how about trying to come up with a sane interface for "synchronize
DMA". I _suspect_ it will have to be device-specific, so we should aim for
a similar interface to the "dma-mapping" ones (ie based on "struct
device", not the bus it's on).

In most cases it would be a no-op, or we could hide some pointer a la
"dev->bus->sync(dev)" (which could do a status read from the bridge or
whatever..)

		Linus
