Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:44265 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261745AbUCVFks (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 00:40:48 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1079931403.5345.74.camel@mulgrave>
References: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
	 <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
	 <20040321225117.F26708@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	 <20040321234515.G26708@flint.arm.linux.org.uk>
	 <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
	 <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>
	 <20040322044615.GC2045@holomorphy.com>  <1079931403.5345.74.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1079933188.22188.5.camel@gaston>
Mime-Version: 1.0
Date: Mon, 22 Mar 2004 16:26:29 +1100
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

Well, I just went over this whole discussion and I think it's just
going to hell.

So here are my 2 cents of suggestions:

 - We _WANT_ the ability to map coherent memory to userspace, that's
the normal way to map sound buffers to userland for low latency (though
mapping the actual DMA ptrs is a different matter and is definitely not
working with a bunch of sound interfaces). This is also necessary for
the infiniband/myrinet kind of things. DRI sort-of need that when not
using AGP, AGP itself is a special case but could be considered as
coherent memory in some platforms too (and will be with PCI Express
afaik) etc...

 - Some architectures apparently cannot do that (parisc ?)

 - Too bad for them... They won't have low latency audio and fast
networking and be done with it. Let's implement a couple of simple
to use (driver-wise) helpers

   dma_can_mmap_coherent() -> parisc returns false here
   dma_mmap_coherent()
   dma_mmap_coherent_sg()

And be done with it. I don't see where is the debate here ? The
API takes the same sglist as used for dma_map_sg, I don't see the
point of anything different, I agree with linus that it's not worth
even thinking about not having struct page here. 

Ben.
