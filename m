Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:52966 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262019AbUCVP1N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 10:27:13 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040322151533.C11212@flint.arm.linux.org.uk>
References: <405E1859.5030906@pobox.com>
	<20040321225117.F26708@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	<20040321234515.G26708@flint.arm.linux.org.uk>
	<20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
	<20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>
	<20040322093029.A460@flint.arm.linux.org.uk>
	<1079967870.1759.12.camel@mulgrave>
	<20040322151533.C11212@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 22 Mar 2004 10:27:00 -0500
Message-Id: <1079969221.1759.25.camel@mulgrave>
Mime-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-03-22 at 10:15, Russell King wrote:
> Correct.  However, note that the kernels view of the DMA mapping would
> not be accessed in this instance.  I guess this still causes you some
> problems, though I suspect that given an adequate API, you could
> tweak your iommu appropriately.

Ah, well now we're getting into one of the problems with the kernel's
API.  Currently we have a two stage approach: the DMA API makes the
kernel space coherent, and then vm APIs make the user spaces coherent.

We could do this exactly as you propose: make the mapping directly
coherent with the user address space and never visible to the kernel and
everything would work correctly.  We could do this simply by loading the
user coherency index into the IOMMU ptes on the mapping.

I've already begun thinking that we may want to shift the API to this
model (i.e. have a preferred address space to do DMA operations to). 
Even in most filesystem streaming mappings, only one address space
ususally wants to see the data (sharing is the rarity rather than the
rule).

> (a) call remap_page_range() with appropriate pgprot
> (b) use a vm_operations_struct interally to fault the pages in,
>     again using the appropraite pgprot.
> (c) disallow the mmap if it is within the architectures rules
>     (eg, all mmapings are of the same cache colour/congruence
>     modulus)
> (d) adjust whatever hardware for device DMA such that the mapping
>     is coherent and then do (a) or (b) and/or (c).
> (e) disallow the mmap entirely.
> 
> I suspect x86, ARM and similar could be either (a) or (b).  PA RISC would
> be (c) and (d).

Yes, we could probably do (c).  Like I said, (d) is a bit of a paradigm
shift for the API, but it's also doable.

> Note: I don't see the need for dma_coherent_munmap() - the mappings are
> destroyed on process exit, and we should not be freeing the coherent
> mapping until the mmap of it has gone - and you get to know this via
> the ->release method.  However, with (b) an architecture can positively
> check that this rule is followed via suitable refcounting and checking
> in dma_free_coherent.

I could see a point: since we can only keep one address space coherent,
we cannot allow multiple mmappings of the same region.  Thus, processes
would be able to hand off the coherent mmap, but wouldn't be allowed
simultaneously to map.  the unmap API would be telling the arch that the
mapping was free to be remapped.

James
