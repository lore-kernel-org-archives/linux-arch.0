Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267385AbUIOUhJ@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:31873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267377AbUIOUfL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 16:35:11 -0400
Date: Wed, 15 Sep 2004 13:34:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040915212056.C31396@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0409151327000.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <20040915212056.C31396@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Russell King <rmk@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Wed, 15 Sep 2004, Russell King wrote:
> 
> What about (PCI!) bus types where you need to write one register with
> the address and one with the data.  (I'm glaring at a certain embedded
> CPU produced by a well known large chip manufacturer, which I think we
> need to do these games to get byte accesses to work correctly.)

Well, that's really the exact same issue as with architectures that cram
memory and PCI into the same 32-bit address space: clearly that "can't
work", since PCI wants 32 bits, and memory wants at least a noticeable 
fraction of the same.

You have a "address register" (which is the 32 physical CPU address output
on the address bus), and you have a "data register" (which is what gets
output on the data bus).

Does it work? Hell yes. Every single PC out there today does exactly that.
It works by having the resource manager say "region X is reserved for RAM,
region Y is reserved for MMIO, and region Z is reserved for PIO" (well, 
the latter is not PC any more, it's ppc, alpha and others).

Same issue, exactly. If you see this thing in practice, just
force-relocate the resources away from each other. Say that MMIO is not
allowed in the 0x0000-0xffff region, and declare that that is reserved for
PIO. And then you just test at run-time. Easy. Change details to suit your
particular problem (maybe you want to use the high bit as a marker. Maybe
you use a water-mark or other more dynamic behaviour).

This is a _real_ solution, btw. It's not a cop-out. It's the solution that
has been used over and over again, and it just works. It's basically 
saying "theory doesn't matter - this is practice".

		Linus
