Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268153AbUIKH25@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50903 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268149AbUIKH25 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Sep 2004 03:28:57 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040911064205.GE6005@krispykreme>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
	 <20040911064205.GE6005@krispykreme>
Content-Type: text/plain
Message-Id: <1094887577.2543.175.camel@gaston>
Mime-Version: 1.0
Date: Sat, 11 Sep 2004 17:26:18 +1000
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>


> 
> The problem comes when we have to remove a host bridge from a partition
> and must have all IO and memory resources unmapped. Memory resources
> take care of themselves since drivers iounmap those resources. IO
> resources do not.

I've been thinking about changing that to normal ioremap's like ppc32,
relying on normal pointer arithmetic to get us the right address, but
that would only work if all drivers properly stored their IO port "base"
in a long, not an int, which might not be the case...

As I wrote earlier, I also want to get rid of the imalloc stuff ....

Ben.
