Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:50688 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfCIDwe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Mar 2019 22:52:34 -0500
Received: by mail-it1-f196.google.com with SMTP id m137so23981955ita.0
        for <linux-arch@vger.kernel.org>; Fri, 08 Mar 2019 19:52:33 -0800 (PST)
Date: Fri, 8 Mar 2019 20:52:27 -0700
From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 2/3] arm64: mm: don't call page table ctors for init_mm
Message-ID: <20190309035227.GA214016@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <20190218231319.178224-2-yuzhao@google.com>
 <20190226151307.GB20230@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226151307.GB20230@lakrids.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190309035227.CsLVmMTHCzdECYLcm3hHEvEZA8Gl05L2T7rfDbAJhy0@z>

On Tue, Feb 26, 2019 at 03:13:07PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Mon, Feb 18, 2019 at 04:13:18PM -0700, Yu Zhao wrote:
> > init_mm doesn't require page table lock to be initialized at
> > any level. Add a separate page table allocator for it, and the
> > new one skips page table ctors.
> 
> Just to check, in a previous reply you mentioned we need to call the
> ctors for our efi_mm, since we use apply_to_page_range() on that. Is
> that only because apply_to_pte_range() tries to take the ptl for non
> init_mm?

Precisely.

> ... or did I miss something else?
> 
> > The ctors allocate memory when ALLOC_SPLIT_PTLOCKS is set. Not
> > calling them avoids memory leak in case we call pte_free_kernel()
> > on init_mm.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Assuming that was all, this patch makes sense to me. FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks.

> Thanks,
> Mark.
> 
> > ---
> >  arch/arm64/mm/mmu.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index fa7351877af3..e8bf8a6300e8 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -370,6 +370,16 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  	} while (pgdp++, addr = next, addr != end);
> >  }
> >  
> > +static phys_addr_t pgd_kernel_pgtable_alloc(int shift)
> > +{
> > +	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> > +	BUG_ON(!ptr);
> > +
> > +	/* Ensure the zeroed page is visible to the page table walker */
> > +	dsb(ishst);
> > +	return __pa(ptr);
> > +}
> > +
> >  static phys_addr_t pgd_pgtable_alloc(int shift)
> >  {
> >  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> > @@ -591,7 +601,7 @@ static int __init map_entry_trampoline(void)
> >  	/* Map only the text into the trampoline page table */
> >  	memset(tramp_pg_dir, 0, PGD_SIZE);
> >  	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> > -			     prot, pgd_pgtable_alloc, 0);
> > +			     prot, pgd_kernel_pgtable_alloc, 0);
> >  
> >  	/* Map both the text and data into the kernel page table */
> >  	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
> > @@ -1067,7 +1077,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> >  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >  
> >  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > -			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
> > +			     size, PAGE_KERNEL, pgd_kernel_pgtable_alloc,
> > +			     flags);
> >  
> >  	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
> >  			   altmap, want_memblock);
> > -- 
> > 2.21.0.rc0.258.g878e2cd30e-goog
> > 
