Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267602AbUIKGKA@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:31402 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267578AbUIKGKA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Sep 2004 02:10:00 -0400
Date: Fri, 10 Sep 2004 23:09:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>


Ok, I've committed the first batch of these things. It should all compile
to exactly the same thing, and I've tried to remove the warnings gcc
generates for the x86/ppc64 configurations I use.

It does generate more warnings than I'd like from gcc. As mentioned, they 
should all be "harmless" in the sense that it doesn't affect code 
generation, but clearly it would be good to try to fix up the worst cases. 
Hint hint.

The sparse ones are a different matter, though: I've removed some of them.
Quite often it's just a matter of declaring the "mmio_base" pointer with
the right type - a one-line change in ieee1394 made hundreds of warnings 
just go away.

But other times there are drivers that seem to take a perverse pleasure in 
mixing types for IOMEM accesses, and sometims mixes the data structure 
between containing IOMEM and IOPORT addresses (one is now "void __iomem 
*", the other one has always been an integer). libata springs to mind, 
where it really looks like it might be better to separate out the "mmio" 
addresses from the "pio" addresses.

Doing the conversion was usually trivial, but sometimes showed some bugs. 
For example, the ATI radeon fbcon driver is clearly horribly buggy:

	drivers/video/aty/radeon_base.c:1725:42: warning: incorrect type in argument 2 (different address spaces)
	drivers/video/aty/radeon_base.c:1725:42:    expected void const *from
	drivers/video/aty/radeon_base.c:1725:42:    got void [noderef] *[assigned] base_addr<asn:2>
	drivers/video/aty/radeon_base.c:1757:39: warning: incorrect type in argument 1 (different address spaces)
	drivers/video/aty/radeon_base.c:1757:39:    expected void *to
	drivers/video/aty/radeon_base.c:1757:39:    got void [noderef] *[assigned] base_addr<asn:2>

comes from it doing

	count -= copy_to_user(buf, base_addr+p, count);
	..
	count -= copy_from_user(base_addr+p, buf, count);

where we are copying memory-mapped PCI space to/from user space. THIS IS
REALLY REALLY WRONG! It's especially wrong as it can cause things like
cache control and prefetch instructions to be used on PCI space, which
migth well trigger serious bugs. That's ignoring the fact that on some 
architectures the PCI IO space isn't even accessible that way in the first 
place. At least not at the address that is the "PCI base address"..

Anyway, last I remember, AMD machines could do strange things if you did 
prefecthing on IO space. So this is not relegated to "weird 
architectures".

One such weird architecture is PPC64, which is why that one does this:

	drivers/video/aty/radeon_base.c:2249:17: warning: incorrect type in assignment (different base types)
	drivers/video/aty/radeon_base.c:2249:17:    expected void [noderef] *fb_base<asn:2>
	drivers/video/aty/radeon_base.c:2249:17:    got unsigned long 

from:

		/* Argh. Scary arch !!! */
	#ifdef CONFIG_PPC64
		rinfo->fb_base = IO_TOKEN_TO_ADDR(rinfo->fb_base);
	#endif

which just "pre-translates" the address. Never mind that this is 
conceptually wrong, it means that we later will "iounmap()" basically a 
random address. Whee.

I think the real fix is to write a "memcpy_fromio_touser()" and it's 
reverse brother, just using a simple readbwl/writebwl loop with the proper 
__get_user/__put_user. That would likely make the ppc64 horrible "Scary 
arch" thing also go away.

Benh: while doign the ppc64 thing, I also encountered something clearly
broken in arch/ppc64/mm/init.c: iounmap_explicit(). I just commented out
the stupid thing (it was wrong regardless of which way the preceding
branch went: it would either call iounmap() twice on the same area, or it
would get a NULL pointer dereference). Can you check what that is 
_supposed_ to be doing?

		Linus
