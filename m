Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268293AbUIPWmt@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:28578 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268304AbUIPWmt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 18:42:49 -0400
Date: Thu, 16 Sep 2004 15:42:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040916223042.GO642@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0409161535490.2338@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave>
 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
 <20040916223042.GO642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Matthew Wilcox <willy@debian.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, Matthew Wilcox wrote:
> 
> 2004/09/14 torvalds   |  * They do _not_ update the port address. If you
> 2004/09/14 torvalds   |  * want MMIO that copies stuff laid out in MMIO
> 2004/09/14 torvalds   |  * memory across multiple ports, use "memcpy_toio()"
> 2004/09/14 torvalds   |  * and friends.
> 
> That implies you can pass an iomap cookie to memcpy_toio()

Actually, no it does not. It very much says "if you want __MMIO__ that 
copies stuff".

You can pass cookies the other way:  if you create a cookie with the old
"ioremap()" interface (which means MMIO only, of course), I intended for
that to work well with the new interfaces (ioread/iowrite). But a
new-style IO-map cookie will _not_ work with the old interfaces. 

In other words, we don't magically make the old interfaces support PIO 
accesses. That includes "memcpy_toio()" and friends. They support MMIO 
only.

I don't see anybody ever wanting to do a "memcpy_to/from_pio()" anyway. 
The op just doesn't make any real sense.

And that is actually enforced by the x86 implementation: creating a
new-style PIO cookie and trying to use them with the old-style interfaces
will create an instant oops. So there's no real worry that some
enterprising driver writer would try to do this. He'd notice that it 
doesn't work very quickly indeed ;)

			Linus
