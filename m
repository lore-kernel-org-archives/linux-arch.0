Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:21967 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261689AbUCVElp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 Mar 2004 23:41:45 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040322034509.GB2045@holomorphy.com>
References: <20040321204931.A11519@infradead.org>
	<1079902670.17681.324.camel@imladris.demon.co.uk>
	<Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
	<20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
	<20040321225117.F26708@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	<20040321234515.G26708@flint.arm.linux.org.uk>
	<20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
	<20040322034509.GB2045@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 21 Mar 2004 23:41:35 -0500
Message-Id: <1079930497.2045.69.camel@mulgrave>
Mime-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2004-03-21 at 22:45, William Lee Irwin III wrote:
> What we're trying to resolve here is drivers supporting ->mmap() doing
> virt_to_page() on the results of dma_alloc_coherent() and other things
> they shouldn't, and so passing back bogus page pointers as the return
> value from ->nopage(), and having no method of resolving it due to the
> fact mem_map[] may not cover the area referred to and there is no
> portable method for reliably determining pfn's or other information
> necessary even to establish mappings by hand. I think it's worth noting
> that (according to rmk) ->cpu_addr may not be in any way relevant to
> RAM, pfn's, or virtual mappings (I'm not actually sure what it is)
> and has to be treated as arch-private otherwise-opaque data.

Hang on a minute, what makes you think it's legal in any way shape or
form to construct a user mapping for a coherent area?

Such an entity, if it were made, wouldn't follow the rules for normal
mmaps.

Let me illustrate what would go wrong on parisc:  we have a VIPT cache
and the concept of an address space.  This means that when we allocate
coherent memory, we mean it will *only* be coherent with respect to the
single specified address space (which is currently the kernel).  We have
to make this explicit in the iommu by programming a so called coherence
index for each IOMMU pte (which tells the CPU's cache which line to
flush when the device writes to this address).  Thus, if you mmap our
coherent memory and the device does a write to this memory, the write
will not be seen by the user if the users address space has a cache
entry for it already.

Therefore, a user trying to make use of a coherent area mmap would have
to flush/invalidate everything all the time just to try to make sure
they weren't missing device updates (because we have no mechanism for
the kernel to know the data has changed and call flush_dcache_page).

James
