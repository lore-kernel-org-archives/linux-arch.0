Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267689AbUIOWjp@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:50049 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267685AbUIOWjO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 18:39:14 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	<Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
	<Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 15 Sep 2004 18:38:50 -0400
Message-Id: <1095287935.1688.4.camel@mulgrave>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-09-15 at 15:16, Linus Torvalds wrote:
> What this new interface is doing is to slowlt move "ioremap()" users over
> to "pci_iomap()" (and by extension, maybe "sbus_ioremap()" etc if somebody
> ever starts doing that too), which allows you to do the bus- and device-
> specific translation just _once_.

Please can we not do it this way, that was the old pci_map_single et al
which we've just spent quite a bit of time converting to
dma_map_single.  It might not matter to the PCI centric people, but the
generic DMA API was a wonderful simplification to the rest of us.

Can we start iomap off on the right foot and simply do dma_iomap (or
dev_iomap since dma_ may end up to be confusing), taking a struct device
as an argument and let the platform, which knows where the buses are,
map this to the correct operations?

James
