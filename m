Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:37557 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfBTUWt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Feb 2019 15:22:49 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so18868874itc.2
        for <linux-arch@vger.kernel.org>; Wed, 20 Feb 2019 12:22:48 -0800 (PST)
Date: Wed, 20 Feb 2019 13:22:44 -0700
From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190220202244.GA80497@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
 <20190219222828.GA68281@google.com>
 <f7e4db43-b836-4ac2-1aea-922be585d8b1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e4db43-b836-4ac2-1aea-922be585d8b1@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Message-ID: <20190220202244.yZ0oziNC5-CcVGNScfEXxdtoF_HaWteBVJRWV2YBK28@z>

On Wed, Feb 20, 2019 at 03:57:59PM +0530, Anshuman Khandual wrote:
> 
> 
> On 02/20/2019 03:58 AM, Yu Zhao wrote:
> > On Tue, Feb 19, 2019 at 11:47:12AM +0530, Anshuman Khandual wrote:
> >> + Matthew Wilcox
> >>
> >> On 02/19/2019 11:02 AM, Yu Zhao wrote:
> >>> On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
> >>>>
> >>>>
> >>>> On 02/19/2019 04:43 AM, Yu Zhao wrote:
> >>>>> For pte page, use pgtable_page_ctor(); for pmd page, use
> >>>>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> >>>>> p4d and pgd), don't use any.
> >>>> pgtable_page_ctor()/dtor() is not optional for any level page table page
> >>>> as it determines the struct page state and zone statistics.
> >>>
> >>> This is not true. pgtable_page_ctor() is only meant for user pte
> >>> page. The name isn't perfect (we named it this way before we had
> >>> split pmd page table lock, and never bothered to change it).
> >>>
> >>> The commit cccd843f54be ("mm: mark pages in use for page tables")
> >>> clearly states so:
> >>>   Note that only pages currently accounted as NR_PAGETABLES are
> >>>   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.
> >>
> >> I think the commit is the following one and it does say so. But what is
> >> the rationale of tagging only PTE page as PageTable and updating the zone
> >> stat but not doing so for higher level page table pages ? Are not they
> >> used as page table pages ? Should not they count towards NR_PAGETABLE ?
> >>
> >> 1d40a5ea01d53251c ("mm: mark pages in use for page tables")
> > 
> > Well, I was just trying to clarify how the ctor is meant to be used.
> > The rational behind it is probably another topic.
> > 
> > For starters, the number of pmd/pud/p4d/pgd is at least two orders
> > of magnitude less than the number of pte, which makes them almost
> > negligible. And some archs use kmem for them, so it's infeasible to
> > SetPageTable on or account them in the way the ctor does on those
> > archs.
> > 
> 
> I understand the kmem cases which are definitely problematic and should
> be fixed. IIRC there is a mechanism to custom init pages allocated for
> slab cache with a ctor function which in turn can call pgtable_page_ctor().
> But destructor helper support for slab has been dropped I guess.
> 
> 
> > But, as I said, it's not something can't be changed. It's just not
> > the concern of this patch.
> 
> Using pgtable_pmd_page_ctor() during PMD level pgtable page allocation
> as suggested in the patch breaks pmd_alloc_one() changes as per the
> previous proposal. Hence we all would need some agreement here.
> 
> https://www.spinics.net/lists/arm-kernel/msg701960.html

A proposal that requires all page tables to go through a same set of
ctors on all archs is not only inefficient (for kernel page tables)
but also infeasible (for arches use kmem for page tables). I've
explained this clearly.

The generalized page table functions must recognize the differences
on different levels and between user and kernel page tables, and
provide unified api that is capable of handling the differences.

The change below is not helping at all.

> 
> We can still accommodate the split PMD ptlock feature in pmd_alloc_one().
> A possible solution can be like this above and over the previous series.
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4168d366127..c02abb2a69f7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -9,6 +9,7 @@ config ARM64
>         select ACPI_SPCR_TABLE if ACPI
>         select ACPI_PPTT if ACPI
>         select ARCH_CLOCKSOURCE_DATA
> +       select ARCH_ENABLE_SPLIT_PMD_PTLOCK if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>         select ARCH_HAS_DEBUG_VIRTUAL
>         select ARCH_HAS_DEVMEM_IS_ALLOWED
>         select ARCH_HAS_DMA_COHERENT_TO_PFN
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index a02a4d1d967d..258e09fb3ce2 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -37,13 +37,29 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pte);
>  
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -       return (pmd_t *)pte_alloc_one_virt(mm);
> +       pgtable_t ptr;
> +
> +       ptr = pte_alloc_one(mm);
> +       if (!ptr)
> +               return 0;
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && USE_SPLIT_PMD_PTLOCKS
> +       ptr->pmd_huge_pte = NULL;
> +#endif
> +       return (pmd_t *)page_to_virt(ptr);
>  }
>  
>  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
>  {
> +       struct page *page;
> +
>         BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
> -       pte_free(mm, virt_to_page(pmdp));
> +       page = virt_to_page(pmdp);
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && USE_SPLIT_PMD_PTLOCKS
> +       VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
> +#endif
> +       pte_free(mm, page);
>  }
> 
> 
> > 
> >>>
> >>> I'm sure if we go back further, we can find similar stories: we
> >>> don't set PageTable on page tables other than pte; and we don't
> >>> account page tables other than pte. I don't have any objection if
> >>> you want change these two. But please make sure they are consistent
> >>> across all archs.
> >>
> >> pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
> >> for generalization which has been already acknowledged earlier. But for now we
> >> can atleast fix this on arm64.
> >>
> >> https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/
> > 
> > This is again not true. Please stop making claims not backed up by
> > facts. And the link is completely irrelevant to the ctor.
> > 
> > I just checked *all* arches. Only four arches call the ctor outside
> > pte_alloc_one(). They are arm, arm64, ppc and s390. The last two do
> > so not because they want to SetPageTable on or account pmd/pud/p4d/
> > pgd, but because they have to work around something, as arm/arm64
> > do.
> 
> That reaffirms the fact that pgtable_page_ctor()/dtor() are getting used
> not in a consistent manner.

Now it's getting absurd. I'll just stop before this turns into
complete nonsense.
