Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268157AbUIKHZl@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43223 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268159AbUIKHZl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Sep 2004 03:25:41 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1094887383.2578.172.camel@gaston>
Mime-Version: 1.0
Date: Sat, 11 Sep 2004 17:23:04 +1000
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2004-09-11 at 16:09, Linus Torvalds wrote:

> 
> Doing the conversion was usually trivial, but sometimes showed some bugs. 
> For example, the ATI radeon fbcon driver is clearly horribly buggy:
> 
> 	drivers/video/aty/radeon_base.c:1725:42: warning: incorrect type in argument 2 (different address spaces)
> 	drivers/video/aty/radeon_base.c:1725:42:    expected void const *from
> 	drivers/video/aty/radeon_base.c:1725:42:    got void [noderef] *[assigned] base_addr<asn:2>
> 	drivers/video/aty/radeon_base.c:1757:39: warning: incorrect type in argument 1 (different address spaces)
> 	drivers/video/aty/radeon_base.c:1757:39:    expected void *to
> 	drivers/video/aty/radeon_base.c:1757:39:    got void [noderef] *[assigned] base_addr<asn:2>
> 
> comes from it doing
> 
> 	count -= copy_to_user(buf, base_addr+p, count);
> 	..
> 	count -= copy_from_user(base_addr+p, buf, count);
> 
> where we are copying memory-mapped PCI space to/from user space. THIS IS
> REALLY REALLY WRONG! It's especially wrong as it can cause things like
> cache control and prefetch instructions to be used on PCI space, which
> migth well trigger serious bugs. That's ignoring the fact that on some 
> architectures the PCI IO space isn't even accessible that way in the first 
> place. At least not at the address that is the "PCI base address"..
> 
I know... I want to get rid of this asap. It actually comes from the
generic fbdev code (though that one has been fixed since then), the
reason radeonfb had its own copies was because of the ioremap limit
that it has... I need to fix all that asap, though hopefully, almost
nobody uses fb read/write ops anyway

Anyway, last I remember, AMD machines could do strange things if you did 
> prefecthing on IO space. So this is not relegated to "weird 
> architectures".
> 
> One such weird architecture is PPC64, which is why that one does this:
> 
> 	drivers/video/aty/radeon_base.c:2249:17: warning: incorrect type in assignment (different base types)
> 	drivers/video/aty/radeon_base.c:2249:17:    expected void [noderef] *fb_base<asn:2>
> 	drivers/video/aty/radeon_base.c:2249:17:    got unsigned long 
> 
> from:
> 
> 		/* Argh. Scary arch !!! */
> 	#ifdef CONFIG_PPC64
> 		rinfo->fb_base = IO_TOKEN_TO_ADDR(rinfo->fb_base);
> 	#endif
> 
> which just "pre-translates" the address. Never mind that this is 
> conceptually wrong, it means that we later will "iounmap()" basically a 
> random address. Whee.

And it is sort-of bullshit too anyways. Unless we end up with eeh tokens
in the top bits of fb_base which I doubt will ever happen. It's that
sort of stuff taht should probably be removed by now. I think we added
it bcs fbdev can access the ioremap'ed memory bypassing readW/writeX,
but in the case of the fbdev, this is not neededd anyway.

> I think the real fix is to write a "memcpy_fromio_touser()" and it's 
> reverse brother, just using a simple readbwl/writebwl loop with the proper 
> __get_user/__put_user. That would likely make the ppc64 horrible "Scary 
> arch" thing also go away.
> 
> Benh: while doign the ppc64 thing, I also encountered something clearly
> broken in arch/ppc64/mm/init.c: iounmap_explicit(). I just commented out
> the stupid thing (it was wrong regardless of which way the preceding
> branch went: it would either call iounmap() twice on the same area, or it
> would get a NULL pointer dereference). Can you check what that is 
> _supposed_ to be doing?
> 

It's supposed to unmap PHB IO space, I have to double check. I want
to rewrite this all anyway, we have this "speacial" allocator for
ioremap space separate from the real vmalloc one for reasons that
are no longer valid (if they ever were) imho and I want to remove that,
I'm just too busy at the moment to do it. At this point, I'm thinking
of trashing the _explicit variants of ioremap. They are used to create
a contiguous area containing all PCI IO spaces of PHBs appende to each
other. We still need to do this but can probably do it in a cleaner
way.

Ben. 
