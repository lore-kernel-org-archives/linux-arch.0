Return-Path: <andrea@suse.de>
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49845
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262609AbUCWPfw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 10:35:52 -0500
Date: Tue, 23 Mar 2004 16:36:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323153641.GM22639@dualathlon.random>
References: <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com> <20040323123439.GJ22639@dualathlon.random> <20040323124027.D25134@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403230722120.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403230722120.1106@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 23, 2004 at 07:25:31AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 23 Mar 2004, Russell King wrote:
> >
> > On Tue, Mar 23, 2004 at 01:34:39PM +0100, Andrea Arcangeli wrote:
> > > anyways Linus vetoed the lazy approch so we probably should give it up
> > > (the one thing I like most is to avoid the branch in the fast path).
> > 
> > I don't think he did - he vetoed adding another special condition to
> > the fast path, or returning non-RAM pages via ->nopage.
> 
> Indeed.

note that I was talking about non-ram, obviously ram pages can be
returned via ->nopage and that's what drivers are using already.

I know there is a problem with ram pages too, but as far as the ->nopage
API is concerned the only problem are the non-ram pages. Russell's
problem have nothing to do with ->nopage itself.

> What I _don't_ want is top add a new VM op function pointer as a special 
> case. I abhor special cases, since they never go away, and end up making 
> the code really hard to follow.
> 
> > However, I do not believe he has vetoed an architecture implementing
> > dma_coherent_mmap() in such a way that it uses the ->nopage method,
> > _provided_ ->nopage returns valid struct pages.
> 
> Yes. For all I care, the "struct page" migth even be dynamically
> allocated, or something else very special (eg in a zone of its own that

I don't think it's sane to use discontigmem just to make ->nopage work
with non-ram, if one has to use discontigmem just for that then I think
it's much simpler to fill all the pagetables in ->mmap using the pfn w/o
page_t.

> the rest of the VM never ever actually sees). As long as "page_to_pfn()" 

zones cannot create holes in the middle of mem_map, only discontigmem
can. I'd expect in most archs to have holes between ram and mmio
regions (at least in various common ram configuration). That's why I
guess discontigmem would be needed for that.
