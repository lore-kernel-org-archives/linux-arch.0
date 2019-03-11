Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:51144 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfCKXKX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Mar 2019 19:10:23 -0400
Received: by mail-it1-f196.google.com with SMTP id m137so1445415ita.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2019 16:10:22 -0700 (PDT)
Date: Mon, 11 Mar 2019 17:10:17 -0600
From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v3 3/3] arm64: mm: enable per pmd page table lock
Message-ID: <20190311231017.GA207964@google.com>
References: <20190218231319.178224-1-yuzhao@google.com>
 <20190310011906.254635-1-yuzhao@google.com>
 <20190310011906.254635-3-yuzhao@google.com>
 <dfc727b4-0806-4867-2f9c-0bb8fdd459ad@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc727b4-0806-4867-2f9c-0bb8fdd459ad@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190311231017.2hqgk9E7kDs1MhLOvikTFbvDMMfxyKfRXvRe1iI0SPM@z>

On Mon, Mar 11, 2019 at 01:58:27PM +0530, Anshuman Khandual wrote:
> On 03/10/2019 06:49 AM, Yu Zhao wrote:
> > Switch from per mm_struct to per pmd page table lock by enabling
> > ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
> > large system.
> > 
> > I'm not sure if there is contention on mm->page_table_lock. Given
> > the option comes at no cost (apart from initializing more spin
> > locks), why not enable it now.
> > 
> > We only do so when pmd is not folded, so we don't mistakenly call
> > pgtable_pmd_page_ctor() on pud or p4d in pgd_pgtable_alloc(). (We
> > check shift against PMD_SHIFT, which is same as PUD_SHIFT when pmd
> > is folded).
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  arch/arm64/Kconfig               |  3 +++
> >  arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
> >  arch/arm64/include/asm/tlb.h     |  5 ++++-
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index cfbf307d6dc4..a3b1b789f766 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
> >  config ARCH_HAS_CACHE_LINE_SIZE
> >  	def_bool y
> >  
> > +config ARCH_ENABLE_SPLIT_PMD_PTLOCK
> > +	def_bool y if PGTABLE_LEVELS > 2
> > +
> >  config SECCOMP
> >  	bool "Enable seccomp to safely compute untrusted bytecode"
> >  	---help---
> > diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> > index 52fa47c73bf0..dabba4b2c61f 100644
> > --- a/arch/arm64/include/asm/pgalloc.h
> > +++ b/arch/arm64/include/asm/pgalloc.h
> > @@ -33,12 +33,22 @@
> >  
> >  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> >  {
> > -	return (pmd_t *)__get_free_page(PGALLOC_GFP);
> > +	struct page *page;
> > +
> > +	page = alloc_page(PGALLOC_GFP);
> > +	if (!page)
> > +		return NULL;
> > +	if (!pgtable_pmd_page_ctor(page)) {
> > +		__free_page(page);
> > +		return NULL;
> > +	}
> > +	return page_address(page);
> >  }
> >  
> >  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
> >  {
> >  	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
> > +	pgtable_pmd_page_dtor(virt_to_page(pmdp));
> >  	free_page((unsigned long)pmdp);
> >  }
> 
> There is just one problem here. ARM KVM's stage2_pmd_free() calls into pmd_free() on a page
> originally allocated with __get_free_page() and never went through pgtable_pmd_page_ctor().
> So when ARCH_ENABLE_SPLIT_PMD_PTLOCK is enabled
> 
> stage2_pmd_free()
> 	pgtable_pmd_page_dtor()
> 		ptlock_free()
> 			kmem_cache_free(page_ptl_cachep, page->ptl)
> 
> Though SLUB implementation for kmem_cache_free() seems to be handling NULL page->ptl (as the
> page never got it's lock allocated or initialized) correctly I am not sure if it is a right
> thing to do.

Thanks for reminding me. This should be fixed as well. Will do it
in a separate patch.
