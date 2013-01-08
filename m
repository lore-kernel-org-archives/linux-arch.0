From: Steve Capper <steve.capper@arm.com>
Subject: Re: [RFC PATCH 5/6] ARM: mm: Transparent huge page support for LPAE
 systems.
Date: Tue, 8 Jan 2013 17:59:08 +0000
Message-ID: <20130108175908.GE18347@e103986-lin>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
 <1350576942-25299-6-git-send-email-steve.capper@arm.com>
 <CANM98qJmN0ZGK48pKVSMQ5D+d0hrydqr0CHQEH5vk=x=NZ=8Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50554 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231Ab3AHR7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2013 12:59:12 -0500
In-Reply-To: <CANM98qJmN0ZGK48pKVSMQ5D+d0hrydqr0CHQEH5vk=x=NZ=8Mw@mail.gmail.com>
Content-Language: en-US
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoffer Dall <c.dall@virtualopensystems.com>
Cc: Steve Capper <Steve.Capper@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "bill4carson@gmail.com" <bill4carson@gmail.com>, "tawfik@marvell.com" <tawfik@marvell.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "mhocko@suse.cz" <mhocko@suse.cz>, "maen@marvell.com" <maen@marvell.com>, "hoffman@marvell.com" <hoffman@marvell.com>, "notasas@gmail.com" <notasas@gmail.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shadi@marvell.com" <shadi@marvell.com>

On Fri, Jan 04, 2013 at 05:04:50AM +0000, Christoffer Dall wrote:
> On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:

> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > index d086f61..31c071f 100644
> > --- a/arch/arm/include/asm/pgtable-3level.h
> > +++ b/arch/arm/include/asm/pgtable-3level.h
> > @@ -85,6 +85,9 @@
> >  #define L_PTE_DIRTY            (_AT(pteval_t, 1) << 55)        /* unused */
> >  #define L_PTE_SPECIAL          (_AT(pteval_t, 1) << 56)        /* unused */
> >
> > +#define PMD_SECT_DIRTY         (_AT(pmdval_t, 1) << 55)
> > +#define PMD_SECT_SPLITTING     (_AT(pmdval_t, 1) << 57)
> > +
> >  /*
> >   * To be used in assembly code with the upper page attributes.
> >   */
> > @@ -166,6 +169,60 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
> >  #define pte_mkhuge(pte)                (__pte((pte_val(pte) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
> >
> >
> > +#define pmd_present(pmd)       ((pmd_val(pmd) & PMD_TYPE_MASK) != PMD_TYPE_FAULT)
> > +#define pmd_young(pmd)         (pmd_val(pmd) & PMD_SECT_AF)
> > +
> > +#define __HAVE_ARCH_PMD_WRITE
> > +#define pmd_write(pmd)         (!(pmd_val(pmd) & PMD_SECT_RDONLY))
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +#define pmd_trans_huge(pmd)    ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
> > +#define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
> > +#endif
> > +
> > +#define PMD_BIT_FUNC(fn,op) \
> > +static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
> > +
> > +PMD_BIT_FUNC(wrprotect,        |= PMD_SECT_RDONLY);
> > +PMD_BIT_FUNC(mkold,    &= ~PMD_SECT_AF);
> > +PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
> > +PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
> > +PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
> > +PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
> > +PMD_BIT_FUNC(mknotpresent, &= ~PMD_TYPE_MASK);
> 
> personally I would prefer not to automate the prefixing of pmd_: it
> doesn't really save a lot of characters, it doesn't improve
> readability and it breaks grep/cscope.
> 

This follows the pte bit functions to a degree.

> > +
> > +#define pmd_mkhuge(pmd)                (__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
> > +
> > +#define pmd_pfn(pmd)           ((pmd_val(pmd) & PHYS_MASK) >> PAGE_SHIFT)
> 
> the arm arm says UNK/SBZP, so we should be fine here right? (noone is
> crazy enough to try and squeeze some extra information in the extra
> bits here or something like that). For clarity, one could consider:
> 
> (((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
> 

Thanks, yes, it's better to PMD_MASK the value too.

> > +#define pfn_pmd(pfn,prot)      (__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
> > +#define mk_pmd(page,prot)      pfn_pmd(page_to_pfn(page),prot)
> > +
> > +static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> > +{
> > +       const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_RDONLY;
> > +       pmd_val(pmd) = (pmd_val(pmd) & ~mask) | (pgprot_val(newprot) & mask);
> > +       return pmd;
> > +}
> > +
> > +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> > +{
> > +       *pmdp = pmd;
> > +}
> 
> why this level of indirection?
> 

Over manipulation in git :-), this can be scrubbed.

> > +
> > +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> > +                             pmd_t *pmdp, pmd_t pmd)
> > +{
> > +       BUG_ON(addr >= TASK_SIZE);
> > +       pmd = __pmd(pmd_val(pmd) | PMD_SECT_nG);
> 
> why this side affect?
> 

This replicates the side effect found when placing ptes into page tables. We
need the NG bit for user pages.

> > +       set_pmd(pmdp, pmd);
> > +       flush_pmd_entry(pmdp);
> > +}
> > +
> > +static inline int has_transparent_hugepage(void)
> > +{
> > +       return 1;
> > +}
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* _ASM_PGTABLE_3LEVEL_H */
> > diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> > index c35bf46..767aa7c 100644
> > --- a/arch/arm/include/asm/pgtable.h
> > +++ b/arch/arm/include/asm/pgtable.h
> > @@ -24,6 +24,9 @@
> >  #include <asm/memory.h>
> >  #include <asm/pgtable-hwdef.h>
> >
> > +
> > +#include <asm/tlbflush.h>
> > +
> >  #ifdef CONFIG_ARM_LPAE
> >  #include <asm/pgtable-3level.h>
> >  #else
> > @@ -163,7 +166,6 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> >  #define pgd_offset_k(addr)     pgd_offset(&init_mm, addr)
> >
> >  #define pmd_none(pmd)          (!pmd_val(pmd))
> > -#define pmd_present(pmd)       (pmd_val(pmd))
> >
> >  static inline pte_t *pmd_page_vaddr(pmd_t pmd)
> >  {
> > diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> > index 685e9e87..0fc2d9d 100644
> > --- a/arch/arm/include/asm/tlb.h
> > +++ b/arch/arm/include/asm/tlb.h
> > @@ -229,6 +229,12 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
> >  #endif
> >  }
> >
> > +static inline void
> > +tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
> > +{
> > +       tlb_add_flush(tlb, addr);
> > +}
> > +
> >  #define pte_free_tlb(tlb, ptep, addr)  __pte_free_tlb(tlb, ptep, addr)
> >  #define pmd_free_tlb(tlb, pmdp, addr)  __pmd_free_tlb(tlb, pmdp, addr)
> >  #define pud_free_tlb(tlb, pudp, addr)  pud_free((tlb)->mm, pudp)
> > diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
> > index 6e924d3..907cede 100644
> > --- a/arch/arm/include/asm/tlbflush.h
> > +++ b/arch/arm/include/asm/tlbflush.h
> > @@ -505,6 +505,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> >  }
> >  #endif
> >
> > +#define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
> > +
> >  #endif
> >
> >  #endif /* CONFIG_MMU */
> > diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
> > index 05a4e94..47f4c6f 100644
> > --- a/arch/arm/mm/fsr-3level.c
> > +++ b/arch/arm/mm/fsr-3level.c
> > @@ -9,7 +9,7 @@ static struct fsr_info fsr_info[] = {
> >         { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "level 3 translation fault"     },
> >         { do_bad,               SIGBUS,  0,             "reserved access flag fault"    },
> >         { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 1 access flag fault"     },
> > -       { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 2 access flag fault"     },
> > +       { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 2 access flag fault"     },
> >         { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 3 access flag fault"     },
> >         { do_bad,               SIGBUS,  0,             "reserved permission fault"     },
> >         { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 1 permission fault"      },
> > --
> > 1.7.9.5
> >
> 
> Besides the nits it looks fine to me. I've done quite extensive
> testing with varied workloads on this code over the last couple of
> months on the vexpress TC2 and on the ARNDALE board using KVM/ARM with
> huge pages, and it gives a nice ~15% performance increase on average
> and is completely stable.

That's great to hear \o/.
Also I've found a decent perf boost when running tools like xz backed by huge pages.
(One can use the LD_PRELOAD mechanism in libhugetlbfs to make mallocs point to
huge pages).

> 
> -Christoffer
> 
