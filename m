Return-Path: <torvalds@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:5352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262647AbUCWPtW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 10:49:22 -0500
Date: Tue, 23 Mar 2004 07:46:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040323153641.GM22639@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0403230739370.1106@ppc970.osdl.org>
References: <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com>
 <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston>
 <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random>
 <20040323114452.GE2045@holomorphy.com> <20040323123439.GJ22639@dualathlon.random>
 <20040323124027.D25134@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403230722120.1106@ppc970.osdl.org>
 <20040323153641.GM22639@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Andrea Arcangeli <andrea@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>, William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>



On Tue, 23 Mar 2004, Andrea Arcangeli wrote:
> > 
> > Yes. For all I care, the "struct page" migth even be dynamically
> > allocated, or something else very special (eg in a zone of its own that
> 
> I don't think it's sane to use discontigmem just to make ->nopage work
> with non-ram, if one has to use discontigmem just for that then I think
> it's much simpler to fill all the pagetables in ->mmap using the pfn w/o
> page_t.

Oh, I absolutely agree. My point was that I really don't care how a driver 
does things, as long as it does _not_ create any VM special cases. And I 
definitely think that for non-RAM pages it tends to make most sense to 
just statically set up the mapping at ->mmap() time.

But I'm also saying that if a driver _wants_ to do dynamic mapping for
some really strange architecture reasons, then such an architecture could
choose to have a magic zone or something like that for that case. At that
point it is an _architecture_ special case, which contains the problem
enough that I don't need to care.

That kind of "strange 'struct page'" approach would cover the case where
you really want to have a "struct page" associated with a DMA coherent
allocation, even if such a page would never be part of any _normal_ memory
allocations (and I seriously doubt that any sane architecture would want
to do anything like that, but I could well imagine that some Amiga with
"chip ram" or similar might go this route).

In general, I'd _prefer_ for really special mappings to be as static as
possible. So we should probably aim for having "IO mappings" be set up at
"->mmap()" time if at all possible. The less clever stuff that happens
dynamically, the better, imho.

			Linus
