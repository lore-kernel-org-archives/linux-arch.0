Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268409AbUIPXPe@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:42177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268339AbUIPXPU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2004 19:15:20 -0400
Date: Thu, 16 Sep 2004 16:15:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <414A17C0.9000309@pobox.com>
Message-ID: <Pine.LNX.4.58.0409161607000.2338@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.GSO.4.58.0409152100080.12701@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409151205230.2333@ppc970.osdl.org> <1095287935.1688.4.camel@mulgrave>
 <20040916023325.GJ642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409152117020.2333@ppc970.osdl.org>
 <20040916223042.GO642@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409161535490.2338@ppc970.osdl.org> <414A17C0.9000309@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>



On Thu, 16 Sep 2004, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > I don't see anybody ever wanting to do a "memcpy_to/from_pio()" anyway. 
> > The op just doesn't make any real sense.
> 
> Actually, I do this in 8139too, to take a snapshot of the NIC's 
> registers for the ethtool "get registers" command.  ;-)

It doesn't have good semantics, though. For example, would your code work
if the copy was byte-by-byte? Word-for-word? Long-for-long? It might work
on some hardware, but it's not an operation that makes sense "in general".

And yes, there is likely hardware out there where "memcpy_fromio()" 
doesn't work even on MMIO (it might put restrictions on how the memory is 
accessed), but at least it still makes sense _conceptually_.

(I actually suspect your memcpy_fromio() doesn't even work on MMIO. For
example, the ppc64 iSeries memcpy_fromio() really _does_ do byte-at-a-time
copies. Slow and broken? Maybe. I don't have an iSeries. But arguably 
perfectly ok. Now, do you think your hardware does the right thing there? 
Or alternatively, do you think it's ok if a 64-bit architecture does 
quad-word loads?)

In other words, memcpy_fromio() really only makes sense on truly "flat" 
MMIO. RAM/ROM-like things, in other words. It can be dangerous to use on 
things like noncached control register areas..

		Linus
