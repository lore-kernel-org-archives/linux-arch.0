Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268716AbUIQMoE@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268397AbUIQMoE
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Sep 2004 08:44:04 -0400
Date: Fri, 17 Sep 2004 13:44:01 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040917124401.GR642@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave> <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org> <20040916223042.GO642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409161535490.2338@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409161535490.2338@ppc970.osdl.org>
Sender: <willy@www.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 16, 2004 at 03:42:34PM -0700, Linus Torvalds wrote:
> On Thu, 16 Sep 2004, Matthew Wilcox wrote:
> > 2004/09/14 torvalds   |  * They do _not_ update the port address. If you
> > 2004/09/14 torvalds   |  * want MMIO that copies stuff laid out in MMIO
> > 2004/09/14 torvalds   |  * memory across multiple ports, use "memcpy_toio()"
> > 2004/09/14 torvalds   |  * and friends.
> > 
> > That implies you can pass an iomap cookie to memcpy_toio()
> 
> Actually, no it does not. It very much says "if you want __MMIO__ that 
> copies stuff".
> 
> You can pass cookies the other way:  if you create a cookie with the old
> "ioremap()" interface (which means MMIO only, of course), I intended for
> that to work well with the new interfaces (ioread/iowrite). But a
> new-style IO-map cookie will _not_ work with the old interfaces. 

OK, you're thinking in x86-specific terms and I'm thinking in PA-specific
terms ;-)  I don't particularly want to be able to memcpy_fooio() on
ioport space.  But I do want to be able to memcpy_fooio() on big-endian
mmio space and I do want to design the iomap cookies such that you can't
pass the old ioremap cookies to the new interface.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
