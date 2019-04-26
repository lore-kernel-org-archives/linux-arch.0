Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDZQGL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Apr 2019 12:06:11 -0400
Date: Sat, 27 Apr 2019 00:05:58 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190426160558.GA10540@guoren-Inspiron-7460>
References: <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de>
 <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460>
 <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
 <20190424055703.GA3417@guoren-Inspiron-7460>
 <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
 <20190424142306.GB20974@lst.de>
 <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Gary Guo <gary@garyguo.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>, Anup Patel <anup.patel@wdc.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vincent Chen <vincentc@andestech.com>, Greentime Hu <green.hu@gmail.com>, "ren_guo@c-sky.com" <ren_guo@c-sky.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Message-ID: <20190426160558.cG7NyWNAJYv8yan48LRMTOOad_hErPG6puibIizlATs@z>

Hi Arnd,

On Thu, Apr 25, 2019 at 11:50:11AM +0200, Arnd Bergmann wrote:
> On Wed, Apr 24, 2019 at 4:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Apr 24, 2019 at 12:45:56PM +0000, Gary Guo wrote:
> > > The RISC-V privileged spec is explicitly designed to allow the
> > > techniques described above (this is the sole purpose of MSTATUS.TVM). It
> > > might be as high performance as a hardware with H-extension, but is
> > > definitely a legit use case. In fact, it is vital for use cases like
> > > recursive virtualization.
> > >
> > > Also, I believe the PTE format of RISC-V is already frozen -- therefore
> > > it is impossible now to merge GLOBAL and USER bit, nor to replace RSW
> > > bit with another bit.
> >
> > Yes, I do not think we can just repurpose a bit.  Even using a currently
> > unused one would require some gymnastics.
> >
> > That being said IFF we want to support non-coherent DMA (and I think we
> > do as people glue together their SOCs using shoestring and paper clips,
> > as already demonstrated by Andes and C-SKY in RISC-V space, and most
> > arm, mips and ppc SOCs) we need something like this flag.  The current
> > RISC-V method that only allows M-mode to set up such attributes on
> > a small number or PMP regions just doesn't work well with the way how
> > Linux and most non-trivial OSes implement DMA memory allocations.
> >
> > Note that I said well - in theory we can have a firmware provided
> > uncached pool - that is what Linux does on most nommu (that is without
> > pagetables) ports, but the fixed sized pool really does suck and will
> > make users very unhappy.
> 
> You could probably get away with allowing uncached mappings only
> for huge pages, and using one or two of the bits the PMD for it.
> This should cover most use cases, since in practice coherent allocations
> tend to be either small and rare (device descriptors) or very big
> (frame buffer etc), and both cases can be handled with hugepages
> and gen_pool_alloc, possibly CMA added in since there will likely
> not be an IOMMU either on the systems that lack cache coherent DMA.
Generally attributs in huge-tlb-entry and leaf-tlb-entry should be the
same. Only put _PAGE_CACHE and _PAGE_BUF bits in huge-tlb-entry sounds
a bit strange.

The gen_pool_alloc only 256KB by default, but a huge tlb entry is 4MB.
Hardware couldn't setup vitual-4MB to a phys-256KB range mapping in TLB.

> 
> One downside is that you need a little more care for drivers that
> use dma_mmap_coherent() to expose coherent buffers to user space.
> 
> Two other points about the proposal:
> - Aside from completely uncached/unbuffered mappings, you typically
>   want uncached/buffered mappings to cover dma_alloc_wc() that is
>   typically used for frame buffers etc that need write-combining to get
>   acceptable performance
I agree dma_alloc_wc is necessary, and we need add another more attribute
bit in PTE: _PAGE_BUF. 
Perhaps using _PAGE_BUF + _PAGE_CACHE are better then _PAGE_CONHENCY.

> - you need to decide what is supposed to happen when there are
>   multiple conflicting mappings for the same physical address.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
What's the mulitple confilcing mappings ?

Best Regards
 Guo Ren
