Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267319AbUIOTQs@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:62638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267314AbUIOTQs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 15:16:48 -0400
Date: Wed, 15 Sep 2004 12:16:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Wed, 15 Sep 2004, Geert Uytterhoeven wrote:
> 
> Before people really start using this: what's the advantage of this scheme
> compared to e.g. dev->busops->in8(), which some of us have been waiting for
> since a long time?

Ehh, exactly why would you wait for that? 

What this new interface is doing is to slowlt move "ioremap()" users over
to "pci_iomap()" (and by extension, maybe "sbus_ioremap()" etc if somebody
ever starts doing that too), which allows you to do the bus- and device-
specific translation just _once_.

Doing it at every IO op (aka "dev->busops->xxx()") is a complete waste of 
time, and extremely stupid, in my not-so-humble opinion. Let me count the 
ways:

 - it's more efficient to set up the mapping _once_. That's especailly 
   true since the mapping may need to do things like page table etc
   accesses, so you HAVE to prepare it anyway (ie doing it at IO time
   would be a bug)

 - doing it on a dev or bus-centric setup is totally idiotic, because it 
   makes it effectively impossible to share one chip-driver across X
   different buses: your scheme would have ten different "dev"s pointing 
   to their own ops. The pci_iomap() has _one_ mapping scheme per bus 
   type, and then you just pass in the cookie to "ioread()" and friends.

 - we've tried it in some circumstances (IDE driver and PCI config space 
   accesses if I recall correctly, which I obviously might not do), and it
   has been a total failure. 

In other words, I hereby proclaim that anybody who does "dev->busops" is a 
total idiot.

Of course, you're now free to try to change my mind. Some people that are
idiots today might well be the revolutionary thinkers of tomorrow. I'm
nothing if not flexible.

		Linus "Yoga of the Mind" Torvalds
