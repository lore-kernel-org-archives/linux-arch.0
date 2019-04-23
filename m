Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbfDWAN5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Apr 2019 20:13:57 -0400
Date: Tue, 23 Apr 2019 08:13:48 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190423001348.GA31639@guoren-Inspiron-7460>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422161814.GA30694@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: ren_guo@c-sky.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tech-privileged@lists.riscv.org, Andrew Waterman <andrew@sifive.com>, Anup Patel <anup.patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>, Greentime Hu <green.hu@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@sifive.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, Vincent Chen <vincentc@andestech.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>
Message-ID: <20190423001348.u8W-FrcCiOqUlcOUfj8t1bFrVD2Z_sNg3hQVSzNU2w0@z>

Thx Christoph,

On Mon, Apr 22, 2019 at 06:18:14PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 22, 2019 at 11:44:30PM +0800, guoren@kernel.org wrote:
> >  - Add _PAGE_COHERENCY bit in current page table entry attributes. The bit
> >    designates a coherence for this page mapping. Software set the bit to
> >    tell the hardware that the region of the page's memory area must be
> >    coherent with IOs devices in SOC system by PMA settings.
> >    If IOs and CPU are already coherent in SOC system, CPU just ignore
> >    this bit.
> > 
> >    PTE format:
> >    | XLEN-1  10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> >          PFN      C  RSW  D   A   G   U   X   W   R   V
> >                   ^
> >    BIT(9): Coherence attribute bit
> >           0: hardware needn't keep the page coherenct and software will
> >              maintain the coherence with cache clear/invalid operations.
> >           1: hardware must keep the page coherenct and software needn't
> >              maintain the coherence.
> >    BIT(8): Reserved for software and now it's _PAGE_SPECIAL in linux
> > 
> >    Add a new hardware bit in PTE also need to modify Privileged
> >    Architecture Supervisor-Level ISA:
> >    https://github.com/riscv/riscv-isa-manual/pull/374
> > 
> >  - Add SBI_FENCE_DMA 9 in riscv-sbi.
> >    sbi_fence_dma(start, size, dir) could synchronize CPU cache data with
> >    DMA device in non-coherency memory model. The third param's definition
> >    is the same with linux's in include/linux/dma-direction.h:
> 
> Please don't make this an SBI call.  We need a proper instruction
> for cache flushing and invalidation.  We'll also need that for pmem
> support for example.  I heard at least one other vendor already
> had an instruction, and we really need to get this into the privileged
> spec ASAP (yesterday in fact).
> 
> If you have your own instructions already we can probably binary
> patch those in using the Linux alternatives mechanism once we have
> a standardized way in the privileged spec.
> 
> We should probably start a working group for this ASAP unless we can
> get another working group to help taking care of it.
Good news, I prefer to use instructions directly instead of SBI_CALL.

Our instruction is "dcache.c/iva %0" (one cache line) and the parameter is
virtual address in S-state. When get into M-state by SBI_CALL, we could
let dcache.c/iva use physical addres directly and it needn't kmap page
for RV32 with highmem (Of cause highmem is not ready in RV32 now).

> 
> > +#define pgprot_noncached pgprot_noncached
> > +static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> > +{
> > +	unsigned long prot = pgprot_val(_prot);
> > +
> > +	prot |= _PAGE_COHERENCY;
> > +
> > +	return __pgprot(prot);
> 
> Nitpick: this can be shortened to
> 
> 	return __pgprot(pgprot_val(prot) | _PAGE_COHERENCY));
Good.

> 
> Also is this really a coherent flag, or an 'uncached' flag like in
> many other architectures?
There are a lot of features about coherency attributes, eg: cacheable,
bufferable, strong order ..., and coherency is a more abstract name to
contain all of these. In our hardware, coherence = uncached +
unbufferable + (stong order).

But I'm not very care about the name is, uncached is also ok. My key
point is the bits of page attributes is very precious and this patch
will use the last unused attribute bit in PTE.

Another point is we could get more attribute bits by modify the riscv
spec:
 - Remove Global bit, I think it's duplicate with the User bit in linux.
 - Change _PAGE_PFN_SHIFT from 10 to 12, because the huge pfn in RV32 is
   very useless and current RV32 linux doesn't even implement highmem.

And then we could get another three page attribute bits in PTE.

> 
> > +++ b/arch/riscv/mm/dma-mapping.c
> 
> This should probably be called dma-noncoherent.c
> 
> It should also have a user visible config option so that we don't
> have to build it for fully coherent systems.
Ok, dma-noncoherent.c is more clear.

> 
> > +void arch_dma_prep_coherent(struct page *page, size_t size)
> > +{
> > +	memset(page_address(page), 0, size);
> 
> No need for this memset, the caller takes care of it.
Ok

> 
> > diff --git a/arch/riscv/mm/ioremap.c b/arch/riscv/mm/ioremap.c
> > index bd2f2db..f6aaf1e 100644
> > --- a/arch/riscv/mm/ioremap.c
> > +++ b/arch/riscv/mm/ioremap.c
> > @@ -73,7 +73,7 @@ static void __iomem *__ioremap_caller(phys_addr_t addr, size_t size,
> >   */
> >  void __iomem *ioremap(phys_addr_t offset, unsigned long size)
> >  {
> > -	return __ioremap_caller(offset, size, PAGE_KERNEL,
> > +	return __ioremap_caller(offset, size, PAGE_KERNEL_COHERENCY,
> >  		__builtin_return_address(0));
> >  }
> >  EXPORT_SYMBOL(ioremap);
> 
> I think ioremap is a different story, and should be a separate patch.
Ok

Best Regards
 Guo Ren
