Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268275AbUIPVJx@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:23240 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268268AbUIPVJx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 17:09:53 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.58.0409161229310.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
	 <1095287935.1688.4.camel@mulgrave>
	 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
	 <20040916134152.GK642@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0409161110070.2333@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409161152010.2333@ppc970.osdl.org>
	 <4149E5C2.7010008@pobox.com>
	 <Pine.LNX.4.58.0409161229310.2333@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095365223.23136.48.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 21:07:03 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

Right now we have writeb and __writeb() the later of which isn't store
ordering but requires the driver author makes an effort to step on a
land mine. It does help performance having these in some cases so can't
we propogate the same "__" functions on
