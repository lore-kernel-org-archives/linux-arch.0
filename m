Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268032AbUIKHhM@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:17083 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267638AbUIKHhM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Sep 2004 03:37:12 -0400
Date: Sat, 11 Sep 2004 09:29:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040911064205.GE6005@krispykreme>
Message-ID: <Pine.GSO.4.58.0409110927340.17924@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org> <20040911064205.GE6005@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Anton Blanchard <anton@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 11 Sep 2004, Anton Blanchard wrote:
> > Benh: while doign the ppc64 thing, I also encountered something clearly
> > broken in arch/ppc64/mm/init.c: iounmap_explicit(). I just commented out
> > the stupid thing (it was wrong regardless of which way the preceding
> > branch went: it would either call iounmap() twice on the same area, or it
> > would get a NULL pointer dereference). Can you check what that is
> > _supposed_ to be doing?
>
> Yuck, that change was made in preparation for hotplug removal of host
> bridges and is obviously broken.
>
> BTW One of our problems is how drivers can tap IO addresses without doing
> something to map them first. We end up doing the ioremap of IO space
> during PCI init.
>
> The problem comes when we have to remove a host bridge from a partition
> and must have all IO and memory resources unmapped. Memory resources
> take care of themselves since drivers iounmap those resources. IO
> resources do not.

Add ioioremap()?

(or more painful for maintenance but conceptually cleaner:
s/ioremap/iomemremap/g and add ioremap()?)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
