Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267165AbUIPFFK@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:14751 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267527AbUIPFE6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 01:04:58 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
	 <1095287935.1688.4.camel@mulgrave>
	 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1095310669.5109.4.camel@gaston>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 14:57:49 +1000
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-09-16 at 14:28, Linus Torvalds wrote:

> (Note that 64-bit accesses aren't necessarily atomic even on 64-bit
> architectures. BenH says that the IO architecture on a G5 means that when
> you do a 64-bit load, it will be done as two 32-bit bus cycles
> regardless).

Yup, at least with the current models, due to the fact that the U3
northbridge basically has a 32 bits path to IO devices. Note that this
isn't the case with IBM machines who do proper 64 bits PCI IOs.

Ben.
