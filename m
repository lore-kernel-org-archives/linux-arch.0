Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267602AbUIKGp3@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:41701 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267470AbUIKGp3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Sep 2004 02:45:29 -0400
Date: Sat, 11 Sep 2004 16:42:05 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040911064205.GE6005@krispykreme>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

 
> Benh: while doign the ppc64 thing, I also encountered something clearly
> broken in arch/ppc64/mm/init.c: iounmap_explicit(). I just commented out
> the stupid thing (it was wrong regardless of which way the preceding
> branch went: it would either call iounmap() twice on the same area, or it
> would get a NULL pointer dereference). Can you check what that is 
> _supposed_ to be doing?

Yuck, that change was made in preparation for hotplug removal of host
bridges and is obviously broken.

BTW One of our problems is how drivers can tap IO addresses without doing
something to map them first. We end up doing the ioremap of IO space
during PCI init.

The problem comes when we have to remove a host bridge from a partition
and must have all IO and memory resources unmapped. Memory resources
take care of themselves since drivers iounmap those resources. IO
resources do not.

Anton
