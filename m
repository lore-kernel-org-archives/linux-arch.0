Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267386AbUIOUVi@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267382AbUIOUVG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 16:21:06 -0400
Date: Wed, 15 Sep 2004 21:20:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040915212056.C31396@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Sep 15, 2004 at 12:16:35PM -0700
Sender: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 15, 2004 at 12:16:35PM -0700, Linus Torvalds wrote:
> On Wed, 15 Sep 2004, Geert Uytterhoeven wrote:
> > Before people really start using this: what's the advantage of this scheme
> > compared to e.g. dev->busops->in8(), which some of us have been waiting for
> > since a long time?
> 
> Ehh, exactly why would you wait for that? 
> 
> What this new interface is doing is to slowlt move "ioremap()" users over
> to "pci_iomap()" (and by extension, maybe "sbus_ioremap()" etc if somebody
> ever starts doing that too), which allows you to do the bus- and device-
> specific translation just _once_.

What about (PCI!) bus types where you need to write one register with
the address and one with the data.  (I'm glaring at a certain embedded
CPU produced by a well known large chip manufacturer, which I think we
need to do these games to get byte accesses to work correctly.)

Sometimes unified accessor macros/functions just don't work.

> In other words, I hereby proclaim that anybody who does "dev->busops" is a 
> total idiot.

Good, I'll pass that comment on to other people and maybe we can force
certain sillycon manufacturers to stop selling broken hardware.  Or
maybe the universe will implode.  I think the latter is a more likely
scenario than the former.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
