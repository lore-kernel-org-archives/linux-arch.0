Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:36494 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261665AbUCVDpP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 Mar 2004 22:45:15 -0500
Date: Sun, 21 Mar 2004 19:45:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322034509.GB2045@holomorphy.com>
References: <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405E3387.1050505@pobox.com>
To: linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

Sorry about the top posting and long quote; I wanted to fully quote the
API under discussion while getting the central issues aired in the first
few lines. The suggested dma_scatterlist structure, for the API
proposed below, was:

struct dma_scatterlist {
        dma_addr_t dma_addr;            /* DMA address */
        void *cpu_addr;                 /* cpu address */
        unsigned long length;           /* in units of pages */
};

What we're trying to resolve here is drivers supporting ->mmap() doing
virt_to_page() on the results of dma_alloc_coherent() and other things
they shouldn't, and so passing back bogus page pointers as the return
value from ->nopage(), and having no method of resolving it due to the
fact mem_map[] may not cover the area referred to and there is no
portable method for reliably determining pfn's or other information
necessary even to establish mappings by hand. I think it's worth noting
that (according to rmk) ->cpu_addr may not be in any way relevant to
RAM, pfn's, or virtual mappings (I'm not actually sure what it is)
and has to be treated as arch-private otherwise-opaque data.

The way this is expected to solve the problem is by providing a method
for the arch to establish mappings of these areas not reliant on struct
page or fault handling. That is, these functions prefault the areas
into the process address space, thus insulating the core from the
details of fault handling on these areas and eliminating fault handling
on these areas altogether.

I tried to translate a function prototype for prefaulting these areas
into userspace that rmk gave as an example into a full set of operations
based on his proposed piece of the API. So what I'm looking for here
is to find out whether this is good enough for all of the various
arches, and if not, how we can get something together that will fix the
bugs in these drivers that will work portably.

jgarzik's comments on suitability for sound drivers follow the API
itself.


William Lee Irwin III wrote:
>>int dma_mmap_coherent_sg(struct dma_scatterlist *sglist,
>>                        int nr_sglist_elements,     /* length of sglist */
>>                        struct vm_area_struct *vma, /* for address space */
>>                        unsigned long address,      /* user virtual 
>>                        address */
>>                        unsigned long offset,       /* offset (in pages) */
>>                        unsigned long nr_pages);    /* length (in pages) */
>>
>>int dma_munmap_coherent_sg(struct dma_scatterlist *sglist,
>>                        int nr_sglist_elements,     /* length of sglist */
>>                        struct vm_area_struct *vma, /* for address space */
>>                        unsigned long address,      /* user virtual 
>>                        address */
>>                        unsigned long offset,       /* offset (in pages) */
>>                        unsigned long nr_pages);    /* length (in pages) */
>>
>>int dma_alloc_coherent_sg(struct dma_scatterlist **sglist,
>>                        unsigned long length);      /* length in pages */
>>
>>int dma_free_coherent_sg(struct dma_scatterlist **sglist,
>>                        unsigned long length);      /* length in pages */

Where it was proposed that these would be helper functions that sit
atop primitive functions like:

int dma_mmap_coherent(struct vm_area_struct *vma,
                        unsigned long address,      
                        dma_addr_t dma_addr,            /* DMA address */
                        void *cpu_addr,                 /* cpu address */
                        unsigned long nr_pages);        /* length (in pages) */

int dma_munmap_coherent(struct vm_area_struct *vma,
                        unsigned long address,
                        dma_addr_t dma_addr,            /* DMA address */
                        void *cpu_addr,                 /* cpu address */
                        unsigned long nr_pages);        /* length (in pages) */


jgarzik's assessment was:


On Sun, Mar 21, 2004 at 07:29:59PM -0500, Jeff Garzik wrote:
> No comment on struct dma_scatterlist, but the above is the most natural 
> API for audio drivers at least.
> Audio drivers allocate buffers at ->probe() or open(2), and the only 
> entity that actually cares about the contents of the buffers are (a) the 
> hardware and (b) userland.  via82cxxx_audio only uses 
> pci_alloc_consistent because there's not a more appropriate DMA 
> allocator for the use to which that memory is put.
> Audio drivers only need to read/write the buffers inside the kernel when 
> implementing read(2) and write(2) via copy_{to,from}_user().

One thing that concerns me about this is that jgarzik seems to be
saying that via82cxxx_audio's needs aren't covered, so some alteration
to accommodate it may be necessary.


-- wli
