Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267325AbUIOTCZ@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:942 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267326AbUIOTCZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 15:02:25 -0400
Date: Wed, 15 Sep 2004 21:02:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 15 Sep 2004, Linus Torvalds wrote:
> Rather than scrapping the typechecking, or requiring drivers to do strange
> and nasty casts all over the place, there's a new interface in town. It's
> called "iomap", because it extends the old "ioremap()" interface to work
> on the PIO accesses too. That way, the drivers that really want to do both
> can very naturally do it.
>
> Nothing currently uses it, although Jeff has patches for SATA for testing

Before people really start using this: what's the advantage of this scheme
compared to e.g. dev->busops->in8(), which some of us have been waiting for
since a long time?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
