Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267475AbUIOUxm@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:62095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267413AbUIOUwd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 16:52:33 -0400
Date: Wed, 15 Sep 2004 13:51:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409151327000.2333@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409151347200.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <20040915212056.C31396@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0409151327000.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Russell King <rmk@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Wed, 15 Sep 2004, Linus Torvalds wrote:
> 
> This is a _real_ solution, btw. It's not a cop-out. It's the solution that
> has been used over and over again, and it just works. It's basically 
> saying "theory doesn't matter - this is practice".

Btw, if your architecture supports DMA, you pretty much _have_ to have a
hole in the PCI MMIO space to map real RAM anyway. That hole would tend to 
be the optimal place to "hide" the IO ports in.

That's effectively what the generic lib/iomap.c does (except you may, of
course, have your RAM mapped at some non-zero address). 

			Linus
