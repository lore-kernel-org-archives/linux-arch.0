Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268147AbUIPTNX@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24262 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268145AbUIPTNX
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 15:13:23 -0400
Message-ID: <4149E5C2.7010008@pobox.com>
Date: Thu, 16 Sep 2004 15:13:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: Re: RFC: being more anal about iospace accesses..
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave> <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org> <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:
> What are sane rules?

I'd err on the side of "simple and tough to screw up" :)

What rules are most beneficial to the likely users of this API?

	Jeff
