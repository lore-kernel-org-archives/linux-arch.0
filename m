Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268234AbUIPWbE@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26335 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268282AbUIPWap
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 18:30:45 -0400
Date: Thu, 16 Sep 2004 23:30:42 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040916223042.GO642@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave> <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
Sender: <willy@www.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 15, 2004 at 09:28:01PM -0700, Linus Torvalds wrote:
> Indeed. Once created, the cookie is "bus-agnostic", which is very much the 
> point. Unlike the original pci DMA interfaces, there are no real bus 
> assumtions in the interfaces once set up. 

In designing the new iomap interface for PA, I noticed a problem.

2004/09/14 torvalds   |  * They do _not_ update the port address. If you
2004/09/14 torvalds   |  * want MMIO that copies stuff laid out in MMIO
2004/09/14 torvalds   |  * memory across multiple ports, use "memcpy_toio()"
2004/09/14 torvalds   |  * and friends.

That implies you can pass an iomap cookie to memcpy_toio(), which makes
designing the iomap interface significantly harder.  Could I ask for
iocopy_to(), iocopy_from() and ioset() interfaces too?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
