Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268301AbUIPWqn@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268269AbUIPWqm
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 18:46:42 -0400
Message-ID: <414A17C0.9000309@pobox.com>
Date: Thu, 16 Sep 2004 18:46:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: Re: RFC: being more anal about iospace accesses..
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave> <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org> <20040916223042.GO642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409161535490.2338@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409161535490.2338@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:
> I don't see anybody ever wanting to do a "memcpy_to/from_pio()" anyway. 
> The op just doesn't make any real sense.

Actually, I do this in 8139too, to take a snapshot of the NIC's 
registers for the ethtool "get registers" command.  ;-)

If 8139too is compiled for MMIO, I use memcpy_fromio.  If 8139too is 
compiled for PIO...

	Jeff
