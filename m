Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268864AbUIQPDV@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:38803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268860AbUIQPDU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Sep 2004 11:03:20 -0400
Date: Fri, 17 Sep 2004 08:03:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <1095398446.5109.43.camel@gaston>
Message-ID: <Pine.LNX.4.58.0409170802100.2338@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>  <1095287935.1688.4.camel@mulgrave>
  <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org> <1095398446.5109.43.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Fri, 17 Sep 2004, Benjamin Herrenschmidt wrote:
> 
> > Actually, we could also take the "safe" approach, and just specify that 
> > the new "ioread()/iowrite()" interfaces are always very relaxed, and apart 
> > from endianness won't do much extra synchronization.
> 
> That would be catastrophic with 99% of the drivers on PPC. The processor
> may speculate reads from outside spinlocks and that sort of horror, or
> defer them to until much later, crossing writes and such things...

I didn't say "unordered". I said "relaxed", which in this case meant 
"unordered wrt DMA.

You still need to enforce memory ordering. Quite frankly, I do not believe 
a non-ordered IO access is EVER valid.

		Linus
