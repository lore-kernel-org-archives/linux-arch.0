From: Christoffer Dall <c.dall@virtualopensystems.com>
Subject: Re: [RFC PATCH 6/6] ARM: mm: Transparent huge page support for
 non-LPAE systems.
Date: Tue, 8 Jan 2013 13:17:30 -0500
Message-ID: <CANM98qKaAZh5FMCUoakDihP5Qi3jj4S5-FYF2zywgOJNDiDCnw@mail.gmail.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
	<1350576942-25299-7-git-send-email-steve.capper@arm.com>
	<CANM98qJ5Yy2S3K5+nCK+XF1z-v9TqtuzjNj7VL1sOjkVdiN6Rw@mail.gmail.com>
	<20130108175924.GF18347@e103986-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:55010 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab3AHSRb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2013 13:17:31 -0500
Received: by mail-ia0-f175.google.com with SMTP id 21so503058iay.34
        for <linux-arch@vger.kernel.org>; Tue, 08 Jan 2013 10:17:30 -0800 (PST)
In-Reply-To: <20130108175924.GF18347@e103986-lin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "bill4carson@gmail.com" <bill4carson@gmail.com>, "tawfik@marvell.com" <tawfik@marvell.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "mhocko@suse.cz" <mhocko@suse.cz>, "maen@marvell.com" <maen@marvell.com>, "hoffman@marvell.com" <hoffman@marvell.com>, "notasas@gmail.com" <notasas@gmail.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shadi@marvell.com" <shadi@marvell.com>

On Tue, Jan 8, 2013 at 12:59 PM, Steve Capper <steve.capper@arm.com> wrote:
> On Fri, Jan 04, 2013 at 05:04:57AM +0000, Christoffer Dall wrote:
>> On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:
>> > Much of the required code for THP has been implemented in the earlier non-LPAE
>> > HugeTLB patch.
>> >
>> > One more domain bits is used (to store whether or not the THP is splitting).
>>
>> s/bits/bit/
>>
> Thanks.
>
>> >
>> > Some THP helper functions are defined; and we have to re-define pmd_page such
>> > that it distinguishes between page tables and sections.
>>
>> super nit: not sure the semi-colon is warranted here.
>>
> Cheers, it is a superfluous semicolon.
>
>> >
>> > Signed-off-by: Will Deacon <will.deacon@arm.com>
>> > Signed-off-by: Steve Capper <steve.capper@arm.com>
>> > ---
>> >  arch/arm/Kconfig                      |    2 +-
>> >  arch/arm/include/asm/pgtable-2level.h |   68 ++++++++++++++++++++++++++++++++-
>> >  arch/arm/include/asm/pgtable-3level.h |    2 +
>> >  arch/arm/include/asm/pgtable.h        |    7 +++-
>> >  4 files changed, 75 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 9621d5f..d459673 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -1773,7 +1773,7 @@ config SYS_SUPPORTS_HUGETLBFS
>> >
>> >  config HAVE_ARCH_TRANSPARENT_HUGEPAGE
>> >         def_bool y
>> > -       depends on ARM_LPAE
>> > +       depends on SYS_SUPPORTS_HUGETLBFS
>> >
>> >  source "mm/Kconfig"
>> >
>> > diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
>> > index 34f4775..67eabb4 100644
>> > --- a/arch/arm/include/asm/pgtable-2level.h
>> > +++ b/arch/arm/include/asm/pgtable-2level.h
>> > @@ -179,6 +179,13 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>> >                 clean_pmd_entry(pmdp);  \
>> >         } while (0)
>> >
>> > +
>>
>> stray whitespace?
>>
>
> Thanks.
>
>> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> > +#define _PMD_HUGE(pmd) ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
>> > +#else
>> > +#define _PMD_HUGE(pmd) (0)
>> > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> > +
>> >  /* we don't need complex calculations here as the pmd is folded into the pgd */
>> >  #define pmd_addr_end(addr,end) (end)
>> >
>> > @@ -197,7 +204,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>> >
>> >  #define HPAGE_SHIFT             PMD_SHIFT
>> >  #define HPAGE_SIZE              (_AC(1, UL) << HPAGE_SHIFT)
>> > -#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
>> >  #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
>> >
>> >  #define HUGE_LINUX_PTE_COUNT       (PAGE_OFFSET >> HPAGE_SHIFT)
>> > @@ -209,6 +215,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>> >   */
>> >  #define PMD_DSECT_DIRTY                (_AT(pmdval_t, 1) << 5)
>> >  #define PMD_DSECT_AF           (_AT(pmdval_t, 1) << 6)
>> > +#define PMD_DSECT_SPLITTING    (_AT(pmdval_t, 1) << 7)
>> >
>> >  #define PMD_BIT_FUNC(fn,op) \
>> >  static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
>> > @@ -261,8 +268,67 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>> >         return __pmd(pmdval);
>> >  }
>> >
>> > +#else
>> > +#define        HPAGE_SIZE      0
>>
>> why this and the conditional define of _PMD_HUGE, you could just do
>> like in pgtable.h and put the #ifdef around the condition in
>> pmd_page(pmt_t pmd).
>>
>
> Thanks, I'll take a look at this.
>
>> >  #endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
>> >
>> > +#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
>> > +
>> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> > +#define pmd_mkhuge(pmd)                (__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
>> > +
>> > +PMD_BIT_FUNC(mkold, &= ~PMD_DSECT_AF);
>> > +PMD_BIT_FUNC(mksplitting, |= PMD_DSECT_SPLITTING);
>> > +PMD_BIT_FUNC(mkdirty, |= PMD_DSECT_DIRTY);
>> > +PMD_BIT_FUNC(mkyoung, |= PMD_DSECT_AF);
>> > +PMD_BIT_FUNC(mkwrite, |= PMD_SECT_AP_WRITE);
>> > +PMD_BIT_FUNC(mknotpresent, &= ~PMD_TYPE_MASK);
>> > +
>> > +#define pmd_trans_splitting(pmd)       (pmd_val(pmd) & PMD_DSECT_SPLITTING)
>> > +#define pmd_young(pmd)                 (pmd_val(pmd) & PMD_DSECT_AF)
>> > +#define pmd_write(pmd)                 (pmd_val(pmd) & PMD_SECT_AP_WRITE)
>> > +#define pmd_trans_huge(pmd)            ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
>> > +
>> > +static inline unsigned long pmd_pfn(pmd_t pmd)
>> > +{
>> > +       /*
>> > +        * for a section, we need to mask off more of the pmd
>> > +        * before looking up the pfn
>> > +        */
>> > +       if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
>> > +               return __phys_to_pfn(pmd_val(pmd) & HPAGE_MASK);
>> > +       else
>> > +               return __phys_to_pfn(pmd_val(pmd) & PHYS_MASK);
>> > +}
>> > +
>> > +static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>> > +{
>> > +       pmd_t pmd = __pmd(__pfn_to_phys(pfn) | PMD_SECT_AP_READ | PMD_SECT_nG);
>> > +
>> > +       return pmd_modify(pmd, prot);
>> > +}
>> > +
>> > +#define mk_pmd(page,prot) pfn_pmd(page_to_pfn(page),prot);
>> > +
>> > +static inline int has_transparent_hugepage(void)
>> > +{
>> > +       return 1;
>> > +}
>> > +
>> > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> > +
>> > +static inline struct page *pmd_page(pmd_t pmd)
>> > +{
>> > +       /*
>> > +        * for a section, we need to mask off more of the pmd
>> > +        * before looking up the page as it is a section descriptor.
>> > +        */
>> > +       if (_PMD_HUGE(pmd))
>> > +               return phys_to_page(pmd_val(pmd) & HPAGE_MASK);
>> > +
>> > +       return phys_to_page(pmd_val(pmd) & PHYS_MASK);
>> > +}
>> > +
>> >  #endif /* __ASSEMBLY__ */
>> >
>> >  #endif /* _ASM_PGTABLE_2LEVEL_H */
>> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
>> > index 31c071f..8360814 100644
>> > --- a/arch/arm/include/asm/pgtable-3level.h
>> > +++ b/arch/arm/include/asm/pgtable-3level.h
>> > @@ -197,6 +197,8 @@ PMD_BIT_FUNC(mknotpresent, &= ~PMD_TYPE_MASK);
>> >  #define pfn_pmd(pfn,prot)      (__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
>> >  #define mk_pmd(page,prot)      pfn_pmd(page_to_pfn(page),prot)
>> >
>> > +#define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
>> > +
>> >  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>> >  {
>> >         const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_RDONLY;
>> > diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
>> > index 767aa7c..2d96381 100644
>> > --- a/arch/arm/include/asm/pgtable.h
>> > +++ b/arch/arm/include/asm/pgtable.h
>> > @@ -169,11 +169,14 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>> >
>> >  static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>> >  {
>> > +#ifdef SYS_SUPPORTS_HUGETLBFS
>> > +       if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
>> > +               return __va(pmd_val(pmd) & HPAGE_MASK);
>> > +#endif
>> > +
>> >         return __va(pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK);
>> >  }
>> >
>> > -#define pmd_page(pmd)          pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
>> > -
>> >  #ifndef CONFIG_HIGHPTE
>> >  #define __pte_map(pmd)         pmd_page_vaddr(*(pmd))
>> >  #define __pte_unmap(pte)       do { } while (0)
>> > --
>> > 1.7.9.5
>> >
>> The whole series looks functionally correct to me:
>>
>> Reviewed-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>
>
> A big thank you for going through this Christoffer.
>
> I'm correcting/simplifying/testing the huge pages code and will send out another
> version soon.
>
Great. This really makes a performance difference for running VMs, so
I'm happy to have the code for KVM/ARM. Please remember to cc me
and/or the kvmarm mailing list for a new version of this series.

-Christoffer
