Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbfD3D30 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Apr 2019 23:29:26 -0400
Date: Tue, 30 Apr 2019 11:29:16 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190430032916.GA649@guoren-Inspiron-7460>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <mhng-4889b94b-2734-4657-83c2-654d3677733e@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-4889b94b-2734-4657-83c2-654d3677733e@palmer-si-x1e>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: ren_guo@c-sky.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tech-privileged@lists.riscv.org, Andrew Waterman <andrew@sifive.com>, anup.patel@wdc.com, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, green.hu@gmail.com, m.szyprowski@samsung.com, rppt@linux.ibm.com, robin.murphy@arm.com, swood@redhat.com, vincentc@andestech.com, xiaoyan_xiang@c-sky.com
Message-ID: <20190430032916.JCCWOWgihJsZaMEe6UZijjL3iFuF8c00XIW6BxHtfbo@z>

On Mon, Apr 29, 2019 at 01:11:43PM -0700, Palmer Dabbelt wrote:
> On Mon, 22 Apr 2019 08:44:30 PDT (-0700), guoren@kernel.org wrote:
> >From: Guo Ren <ren_guo@c-sky.com>
> >
> >The current riscv linux implementation requires SOC system to support
> >memory coherence between all I/O devices and CPUs. But some SOC systems
> >cannot maintain the coherence and they need support cache clean/invalid
> >operations to synchronize data.
> >
> >Current implementation is no problem with SiFive FU540, because FU540
> >keeps all IO devices and DMA master devices coherence with CPU. But to a
> >traditional SOC vendor, it may already have a stable non-coherency SOC
> >system, the need is simply to replace the CPU with RV CPU and rebuild
> >the whole system with IO-coherency is very expensive.
> >
> >So we should make riscv linux also support non-coherency memory model.
> >Here are the two points that riscv linux needs to be modified:
> >
> > - Add _PAGE_COHERENCY bit in current page table entry attributes. The bit
> >   designates a coherence for this page mapping. Software set the bit to
> >   tell the hardware that the region of the page's memory area must be
> >   coherent with IOs devices in SOC system by PMA settings.
> >   If IOs and CPU are already coherent in SOC system, CPU just ignore
> >   this bit.
> >
> >   PTE format:
> >   | XLEN-1  10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> >         PFN      C  RSW  D   A   G   U   X   W   R   V
> >                  ^
> >   BIT(9): Coherence attribute bit
> >          0: hardware needn't keep the page coherenct and software will
> >             maintain the coherence with cache clear/invalid operations.
> >          1: hardware must keep the page coherenct and software needn't
> >             maintain the coherence.
> >   BIT(8): Reserved for software and now it's _PAGE_SPECIAL in linux
> >
> >   Add a new hardware bit in PTE also need to modify Privileged
> >   Architecture Supervisor-Level ISA:
> >   https://github.com/riscv/riscv-isa-manual/pull/374
> 
> This is a RISC-V ISA modification, which isn't really appropriate to suggest on
> the kernel mailing lists.  The right place to talk about this is at the RISC-V
> foundation, which owns the ISA -- we can't change the hardware with a patch to
> Linux :).
I just want a discussion and a wide discussion is good for all of us :)

> 
> > - Add SBI_FENCE_DMA 9 in riscv-sbi.
> >   sbi_fence_dma(start, size, dir) could synchronize CPU cache data with
> >   DMA device in non-coherency memory model. The third param's definition
> >   is the same with linux's in include/linux/dma-direction.h:
> >
> >   enum dma_data_direction {
> >	DMA_BIDIRECTIONAL = 0,
> >	DMA_TO_DEVICE = 1,
> >	DMA_FROM_DEVICE = 2,
> >	DMA_NONE = 3,
> >   };
> >
> >   The first param:start must be physical address which could be handled
> >   in M-state.
> >
> >   Here is a pull request to the riscv-sbi-doc:
> >   https://github.com/riscv/riscv-sbi-doc/pull/15
> >
> >We have tested the patch on our fpga SOC system which network controller
> >connected to a non-cache-coherency interconnect in and it couldn't work
> >without the patch.
> >
> >There is no side effect for FU540 whose CPU don't care _PAGE_COHERENCY
> >in PTE, but FU540's bbl also need to implement a simple sbi_fence_dma
> >by directly return. In fact, if you give a correct configuration for
> >dev_is_dma_conherent(), linux dma framework wouldn't call sbi_fence_dma
> >any more.
> 
> Non-coherent fences also need to be discussed as part of a RISC-V ISA
  ^^^^^^^^^^^^ ^^^^^^
  fences instructions? not page attributes?
> extension.  
> I know people have expressed interest, but I don't know of a
> working group that's already been set up.
Is that mean current RISC-V ISA forces the SOC to be coherent memory model?

Best Regards
 Guo Ren
