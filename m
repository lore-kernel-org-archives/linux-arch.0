Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266357AbUIOPDJ@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:6846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266349AbUIOPDI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 11:03:08 -0400
Date: Wed, 15 Sep 2004 08:03:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>


Some of you guys may have noticed that the anal typechecking turned out to 
cause another IO interface to be grown.

Some drivers - notably SATA and a couple of network drivers - mixed PIO 
adn MMIO addresses on purpose, because they drive hardware that literally 
uses one or the other. Sometimes it's a compile option that just #defines 
'writel()' to 'inl()', sometimes it's a runtime decision depending on the 
hardware or configuration.

The anal typechecking obviously ended up being very unhappy about this, 
since it wants "void __iomem *" for MMIO pointers, and a normal "unsigned 
long" for PIO accesses.

Rather than scrapping the typechecking, or requiring drivers to do strange
and nasty casts all over the place, there's a new interface in town. It's
called "iomap", because it extends the old "ioremap()" interface to work
on the PIO accesses too. That way, the drivers that really want to do both
can very naturally do it.

Nothing currently uses it, although Jeff has patches for SATA for testing 
(and they clean up the code quite noticeably, never mind getting rid of 
the warnings).  The interface has been implemented by yours truly for x86 
and ppc64, and David did a first-pass version for sparc64 too (missing the 
"xxxx_rep()" functions that were added a bit later, I believe).

So far experience seems to show that it's a very natural interface for
most non-x86 hardware - they all tend to map in both PIO and MMIO into one
address space _anyway_, so the two aren't really any different. It's
mainly just x86 and it's ilk that actually have two different interfaces
for the two kinds of PCI accesses, and at least in that case it's trivial
to encode the difference in the virtual ioremap pointer.

The best way to explain the interface is to just point you guys at the
<asm-generic/iomap.h> file, which isn't very big, has about as much
comments than code, and contains nothing but the necessary function
declarations. The actual meaning of the functions should be pretty
obvious even without the comments.

You can use the <asm-generic/iomap.h> file for declarations even if you
don't use the actual "generic" (x86-ilk) implementation itself - that's
what ppc64 does, for example. Or you could just add the stuff to your own
<asm/io.h>, like davem did for sparc64.

Nothing uses the interface yet, but it's likely that a couple of drivers
will be moved over to it immediately after 2.6.9.  They may not matter for
your architecture, but please check out the new interfaces anyway. It's
likely about ~100 lines of code, although I have to admit that the IO 
access functions tend to be some of the densest and nastiest code around.

For examples, look at lib/iomap.c (x86-like "dual address space") or
arch/ppc64/kernel/eeh.c (Look for "Here comes the EEH implementation of
the IOMAP interfaces"). Or the sparc64 ones in include/asm-sparc64/io.h.

		Linus
