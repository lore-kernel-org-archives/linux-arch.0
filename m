Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16142 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263602AbUCYUZ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Mar 2004 15:25:56 -0500
Date: Thu, 25 Mar 2004 20:25:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040325202543.B16585@flint.arm.linux.org.uk>
References: <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com> <20040323123439.GJ22639@dualathlon.random> <20040323124027.D25134@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323124027.D25134@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Mar 23, 2004 at 12:40:27PM +0000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>, William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 23, 2004 at 12:40:27PM +0000, Russell King wrote:
> On Tue, Mar 23, 2004 at 01:34:39PM +0100, Andrea Arcangeli wrote:
> > anyways Linus vetoed the lazy approch so we probably should give it up
> > (the one thing I like most is to avoid the branch in the fast path).
> 
> I don't think he did - he vetoed adding another special condition to
> the fast path, or returning non-RAM pages via ->nopage.
> 
> However, I do not believe he has vetoed an architecture implementing
> dma_coherent_mmap() in such a way that it uses the ->nopage method,
> _provided_ ->nopage returns valid struct pages.

Ok, since this thread seems to have died without much action happening,
its time to re-start it (but note - I probably won't be around tomorrow.)
I'd like to get the dma_coherent_mmap() API sorted out such that everyone
is happy, and we can progress it.

From what I've gathered, we seem to be happy with the dma_coherent_mmap()
approach.  Is everyone happy with these prototypes?

int dma_coherent_mmap(struct device *dev, struct vm_area_struct *vma,
                      void *cpu_addr, dma_addr_t dma_addr, size_t size);

and, for the PA-RISC architecture (c/o James Bottomley):

void dma_coherent_munmap(struct device *dev, struct vm_area_struct *vma,
			 void *cpu_addr, dma_addr_t dma_addr, size_t size);

where:

- dev: the device for which this coherent region was created for
- vma: VM area struct describing the requested user mapping
- cpu_addr: the address returned from dma_alloc_coherent
- dma_addr: the DMA cookie returned from dma_alloc_coherent
- size: the size of the DMA allocation

As far as ARM goes, we (currently) only need cpu_addr to look up the
data associated with the kernels coherent DMA mapping.  Whether the
other arguments are useful depends on what other architectures require.

Is everyone happy with the name, or would people prefer it to be more
consistent with the other dma_xxx_coherent() functions (iow,
dma_mmap_coherent?)


PS, one of my pet annoyances with the DMA API is that dma_alloc_coherent()
doesn't return/take some architecturally defined structure, and that
there aren't accessor macros like dma_cpu_addr() dma_device_addr().
This means that we end up carrying around several bits of data, which
may be the same on some architectures.  People objected to this in 2.4,
and we ended up adding that yucky "DECLARE_PCI_UNMAP_ADDR" stuff - which
may happen during 2.6 to the DMA API.  Adding these further APIs is just
making this mistake worse IMO.  It's really a 2.7 problem though.  And
yes, I've just talked people out of the prototypes I've proposed above.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
