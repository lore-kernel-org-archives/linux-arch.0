Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267367AbUIOULf@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:6362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267365AbUIOUKn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 16:10:43 -0400
Date: Wed, 15 Sep 2004 13:10:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040915194001.GH642@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0409151256130.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
 <20040915194001.GH642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Matthew Wilcox <willy@debian.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Wed, 15 Sep 2004, Matthew Wilcox wrote:

> Could we have a 'dev' parameter to ioread8()?  Please?

Nope. See earlier email on why. There is no "dev" any more at the point of
a generic chipset handler: the "dev" may have any of millions of possible 
types (well, ok, a few different bus architectures, but still).

I seriously doubt that you don't have space to encode the same information 
that was already there before in a pointer. David was kicking and 
screaming too, until Jeff pointed out that it was all in the same address 
space, and then he said "oh", and suddenly it was trivial.

> [1] The implementation is:
>         if (port & 0x300) {
>                 return 0xfc000000 | ((port & 0xfc00) >> 6)
>                         | ((port & 0x3f8) << 9) | (port & 7);
>         } else {
>                 return 0xfc000000 | port;
>         }

So? Without knowing the details of how stupid the PA-RISC IO mappings are, 
the above already makes me suspect that you have one memory space, and the 
0xfc000000 area is used for IO. Goodie. So now you make

	/* We've hard-mapped the IO region at 0xfc000000 */
	void __iomem *ioport_map(unsigned long port)
	{
		return (void __iomem *) (port | 0xfc000000);
	}

and then in ioread8() you do

	unsigned int ioread8(void __iomem *addr)
	{
		unsigned long bits = (unsigned long __force) addr;
		if ((bits & 0xfc000000) == 0xfc000000)
			addr = io_port_swizle_bits(bits & 0x3ffffff);
		/* MMIO has already been mapped */
		return __raw_readb(addr);
	}

with "io_mem_read()" doing the old bit swizzle, exactly like before.

The _only_ thing you need is an _virtual_ area of the cookie space (aka 
"void __iomem *") that you can just test. It clearly exists, because your 
PCI code does "ioremap()", so _any_ memory area that cannot be reached 
with ioremap() is by default something you can use as a flag for it being 
PIO. Then you do all the same things that you did before.

Is it uglier than sane architectures? Sure. Some architectures do 
_everything_ at pci_iomap() time, and then they just do a simple 
special-memory dereference that is common to both PIO and MMIO code in 
"ioreadXX()".

The fact that PARISC did their PCI translation wrong is painful for you.  
That doesn't mean that Linux should do the same mistakes the PARISC system
designers made.

Think of the positive side: It builds character.

		Linus
