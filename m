Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50955 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262026AbUCVPPk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 10:15:40 -0500
Date: Mon, 22 Mar 2004 15:15:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322151533.C11212@flint.arm.linux.org.uk>
References: <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079967870.1759.12.camel@mulgrave>; from James.Bottomley@steeleye.com on Mon, Mar 22, 2004 at 10:04:23AM -0500
Sender: Russell King <rmk@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 10:04:23AM -0500, James Bottomley wrote:
> On Mon, 2004-03-22 at 04:30, Russell King wrote:
> > On Sun, Mar 21, 2004 at 11:41:35PM -0500, James Bottomley wrote:
> > > Let me illustrate what would go wrong on parisc:  we have a VIPT cache
> > > and the concept of an address space.
> > 
> > Is it not the case that VIPT caches are coloured, and mapping a page
> > into the appropriate place results in the same virtual index for both?
> 
> Not coloured exactly since the caches are associative, but we have a
> congruence modulus.  As long as two virtual addresses are equal modulo
> this, the cache will detect and unify virtual aliasing (basically it
> assigns the addresses the same coherence index).  So, as long as the
> proposed API gives the arch control over where in the user vm the
> mapping goes, we would be able to accommodate it.
> 
> However, my understanding of the API was that you *already* had a vm
> range and were trying to place a coherently mapped page into it.

Correct.  However, note that the kernels view of the DMA mapping would
not be accessed in this instance.  I guess this still causes you some
problems, though I suspect that given an adequate API, you could
tweak your iommu appropriately.

For example, if we had:

int dma_coherent_mmap(vma, cpuaddr, dmaaddr, size)

then the architecture could do whatever it needed to mmap that address
space.  It could:

(a) call remap_page_range() with appropriate pgprot
(b) use a vm_operations_struct interally to fault the pages in,
    again using the appropraite pgprot.
(c) disallow the mmap if it is within the architectures rules
    (eg, all mmapings are of the same cache colour/congruence
    modulus)
(d) adjust whatever hardware for device DMA such that the mapping
    is coherent and then do (a) or (b) and/or (c).
(e) disallow the mmap entirely.

I suspect x86, ARM and similar could be either (a) or (b).  PA RISC would
be (c) and (d).

Note: I don't see the need for dma_coherent_munmap() - the mappings are
destroyed on process exit, and we should not be freeing the coherent
mapping until the mmap of it has gone - and you get to know this via
the ->release method.  However, with (b) an architecture can positively
check that this rule is followed via suitable refcounting and checking
in dma_free_coherent.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
