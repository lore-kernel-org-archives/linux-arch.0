Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268077AbUIPNwv@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:27298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268064AbUIPNwv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 09:52:51 -0400
Date: Thu, 16 Sep 2004 06:52:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <1095337056.9144.2337.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0409160648440.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org>
 <20040915194001.GH642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409151256130.2333@ppc970.osdl.org>
 <1095337056.9144.2337.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <willy@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, David Woodhouse wrote:
>
>   At least they don't think it's sane to drag a crack-smoking
> hobo off the street and ask him to implement a PCI host bridge in an
> FPGA, so my life is a lot nicer :)

LOL.

I hope some of the poor unsuspecting souls who have to use the dang thing
will educate the hw hobos in question. Preferably with a baseball bat.

The good news is that hardware _does_ tend to slowly become saner. I don't
know if it's the crack supply that eventually dwindels, or what, but the
hw designers to tend to eventually take note when they find death-threats
in their cubby-holes. So if you do see a broken chip, tell them.  

Preferably by getting your company to say "we'll use that other _sane_
chip instead", and letting the broken vendor know why.

> I certainly don't recall just saying 'oh'; you may have inferred that
> from my silence.

Heh. I was talking about the other David, ie the "Miller" kind. 

		Linus
