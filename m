Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267335AbUIOTkD@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62431 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267333AbUIOTkD
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 15:40:03 -0400
Date: Wed, 15 Sep 2004 20:40:01 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040915194001.GH642@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be> <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
Sender: <willy@www.linux.org.uk>
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

I'm no fan of bus->ops->in8, but the ioread8() interface is basically
impossible for some architectures.  There's just not enough information
in a single void * cookie to make this work; not without screwing the
speed of readb() down the the speed of inb().

For example, on some of the older PA machines, we can have an EISA
controller and multiple PCI controllers.  readb() is great, it's all
mapped into a flat memory space, and there are no problems.  But inb()
is a royal PITA.  First, we have to decode the port number to figure
out which controller it's under, then (if it's EISA) swizzle the bits in
the port number to get to an address, but if it's PCI, we have to take a
spinlock, write the port number into a register of the right controller,
read the data back from a different register (which is what triggers
the io port cycle to be generated on the PCI bus) and unlock the spinlock.

ioport_map() looks great for the EISA controller because it lets us
pre-map the port number to an address.  But it'd actually be deadly
if the device has more than 8 consecutive IO ports [1].  For the PCI
controllers, it's a complete misery.  We could do something horrid like
assuming no IO is less than 2GB and returning a cookie from ioport_map()
that then gets decoded into somethign similar to the current dance,
but that's really not pleasant.

I'm told SH is in even worse state than PA, but I haven't looked at
that code.

Could we have a 'dev' parameter to ioread8()?  Please?


[1] The implementation is:
        if (port & 0x300) {
                return 0xfc000000 | ((port & 0xfc00) >> 6)
                        | ((port & 0x3f8) << 9) | (port & 7);
        } else {
                return 0xfc000000 | port;
        }

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
