Return-Path: <andrea@suse.de>
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5293
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261397AbUCVL5Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 06:57:16 -0500
Date: Mon, 22 Mar 2004 12:58:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322115807.GO3649@dualathlon.random>
References: <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322044615.GC2045@holomorphy.com> <1079931403.5345.74.camel@mulgrave> <1079933188.22188.5.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079933188.22188.5.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 04:26:29PM +1100, Benjamin Herrenschmidt wrote:
> Well, I just went over this whole discussion and I think it's just
> going to hell.
> 
> So here are my 2 cents of suggestions:
> 
>  - We _WANT_ the ability to map coherent memory to userspace, that's
> the normal way to map sound buffers to userland for low latency (though
> mapping the actual DMA ptrs is a different matter and is definitely not
> working with a bunch of sound interfaces). This is also necessary for
> the infiniband/myrinet kind of things. DRI sort-of need that when not
> using AGP, AGP itself is a special case but could be considered as
> coherent memory in some platforms too (and will be with PCI Express
> afaik) etc...
> 
>  - Some architectures apparently cannot do that (parisc ?)
> 
>  - Too bad for them... They won't have low latency audio and fast
> networking and be done with it. Let's implement a couple of simple
> to use (driver-wise) helpers
> 
>    dma_can_mmap_coherent() -> parisc returns false here
>    dma_mmap_coherent()
>    dma_mmap_coherent_sg()
> 
> And be done with it. I don't see where is the debate here ? The
> API takes the same sglist as used for dma_map_sg, I don't see the
> point of anything different, I agree with linus that it's not worth
> even thinking about not having struct page here. 

I like your three functions and the clear decription.

The only reason I believe a paging mechanism would been nicer, is that
it would avoid latencies in dma_mmap_coherent (not necessairly scheduler
latencies, but you would pay all the cost of the pagetables immediatly
during the mmap syscall, so if you've to map gigs of ram that would tend
to hang the task doing the mmap a little bit, I found it nicer to use
the paging for this so we also only allocate the memory for the
pagetables that we need, but OTOH Linus's right that in most cases it
doesn't worth a single branch in a fast path).
