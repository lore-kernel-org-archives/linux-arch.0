Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36321 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3ADFKw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2013 00:10:52 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so19395375iea.36
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2013 21:10:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1350576942-25299-5-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
	<1350576942-25299-5-git-send-email-steve.capper@arm.com>
Date: Fri, 4 Jan 2013 00:04:43 -0500
Message-ID: <CANM98qJz+3prJ3QL9OOuxdknbqsT50KnYmc3KFKb7=81GOnNuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] ARM: mm: HugeTLB support for non-LPAE systems.
From: Christoffer Dall <c.dall@virtualopensystems.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aarcange@redhat.com, bill4carson@gmail.com, tawfik@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com, cmetcalf@tilera.com, mhocko@suse.cz, maen@marvell.com, hoffman@marvell.com, notasas@gmail.com, kirill@shutemov.name, akpm@linux-foundation.org, shadi@marvell.com
Message-ID: <20130104050443.KICZ4HoI7n69jm0iQntcqbVn8H3dIxsCAE_ZdObdjRQ@z>

On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:
> Based on Bill Carson's HugeTLB patch, with the big difference being in the way
> PTEs are passed back to the memory manager. Rather than store a "Linux Huge
> PTE" separately; we make one up on the fly in huge_ptep_get. Also rather than
> consider 16M supersections, we focus solely on 2x1M sections.
>
> To construct a huge PTE on the fly we need additional information (such as the
> accessed flag and dirty bit) which we choose to store in the domain bits of the
> short section descriptor. In order to use these domain bits for storage, we need
> to make ourselves a client for all 16 domains and this is done in head.S.
>
> Storing extra information in the domain bits also makes it a lot easier to
> implement Transparent Huge Pages, and some of the code in pgtable-2level.h is
> arranged to facilitate THP support in a later patch.
>
> Non-LPAE HugeTLB pages are incompatible with the huge page migration code
> (enabled when CONFIG_MEMORY_FAILURE is selected) as that code dereferences PTEs
> directly, rather than calling huge_ptep_get and set_huge_pte_at.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> ---
>  arch/arm/Kconfig                      |    2 +-
>  arch/arm/include/asm/hugetlb-2level.h |   71 ++++++++++++++++++++
>  arch/arm/include/asm/hugetlb.h        |    4 ++
>  arch/arm/include/asm/pgtable-2level.h |   79 +++++++++++++++++++++-
>  arch/arm/include/asm/tlb.h            |   10 ++-
>  arch/arm/kernel/head.S                |   10 ++-
>  arch/arm/mm/Makefile                  |    4 ++
>  arch/arm/mm/fault.c                   |    6 +-
>  arch/arm/mm/hugetlbpage-2level.c      |  115 +++++++++++++++++++++++++++++++++
>  9 files changed, 293 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/include/asm/hugetlb-2level.h
>  create mode 100644 arch/arm/mm/hugetlbpage-2level.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d863781..dd0a230 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1769,7 +1769,7 @@ config HW_PERF_EVENTS
>
>  config SYS_SUPPORTS_HUGETLBFS
>         def_bool y
> -       depends on ARM_LPAE
> +       depends on ARM_LPAE || (!CPU_USE_DOMAINS && !MEMORY_FAILURE)
>
>  source "mm/Kconfig"
>
> diff --git a/arch/arm/include/asm/hugetlb-2level.h b/arch/arm/include/asm/hugetlb-2level.h
> new file mode 100644
> index 0000000..3532b54
> --- /dev/null
> +++ b/arch/arm/include/asm/hugetlb-2level.h
> @@ -0,0 +1,71 @@
> +/*
> + * arch/arm/include/asm/hugetlb-2level.h
> + *
> + * Copyright (C) 2012 ARM Ltd.
> + *
> + * Based on arch/x86/include/asm/hugetlb.h and Bill Carson's patches
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#ifndef _ASM_ARM_HUGETLB_2LEVEL_H
> +#define _ASM_ARM_HUGETLB_2LEVEL_H
> +
> +
> +pte_t huge_ptep_get(pte_t *ptep);
> +
> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> +                                  pte_t *ptep, pte_t pte);
> +
> +static inline pte_t pte_mkhuge(pte_t pte) { return pte; }
> +
> +static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> +                                        unsigned long addr, pte_t *ptep)
> +{
> +       flush_tlb_range(vma, addr, addr + HPAGE_SIZE);

don't you need to clear the old TLB entry first here, otherwise
another CPU could put an entry to the old page in its TLB and access
it even after the page_cache_release(old_page) in hugetlb_cow() ?

> +}
> +
> +static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> +                                          unsigned long addr, pte_t *ptep)
> +{
> +       pmd_t *pmdp = (pmd_t *) ptep;
> +       set_pmd_at(mm, addr, pmdp, pmd_wrprotect(*pmdp));
> +}
> +
> +
> +static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> +                                           unsigned long addr, pte_t *ptep)
> +{
> +       pmd_t *pmdp = (pmd_t *)ptep;
> +       pte_t pte = huge_ptep_get(ptep);
> +       pmd_clear(pmdp);
> +
> +       return pte;
> +}
> +
> +static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> +                                            unsigned long addr, pte_t *ptep,
> +                                            pte_t pte, int dirty)
> +{
> +       int changed = !pte_same(huge_ptep_get(ptep), pte);
> +
> +       if (changed) {
> +               set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +               huge_ptep_clear_flush(vma, addr, &pte);
> +       }
> +
> +       return changed;
> +}
> +
> +#endif /* _ASM_ARM_HUGETLB_2LEVEL_H */
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 7af9cf6..1e92975 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -24,7 +24,11 @@
>
>  #include <asm/page.h>
>
> +#ifdef CONFIG_ARM_LPAE
>  #include <asm/hugetlb-3level.h>
> +#else
> +#include <asm/hugetlb-2level.h>
> +#endif
>
>  static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>                                           unsigned long addr, unsigned long end,
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 662a00e..fd1d9be 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -163,7 +163,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>         return (pmd_t *)pud;
>  }
>
> -#define pmd_bad(pmd)           (pmd_val(pmd) & 2)
> +#define pmd_bad(pmd)           ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_FAULT)

this changes the semantics of the macro - is that on purpose and safe?

(fault entries didn't used to be bad, now they are...)

>
>  #define copy_pmd(pmdpd,pmdps)          \
>         do {                            \
> @@ -184,6 +184,83 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>
>  #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
>
> +
> +#ifdef CONFIG_SYS_SUPPORTS_HUGETLBFS
> +
> +/*
> + * now follows some of the definitions to allow huge page support, we can't put
> + * these in the hugetlb source files as they are also required for transparent
> + * hugepage support.
> + */
> +
> +#define HPAGE_SHIFT             PMD_SHIFT
> +#define HPAGE_SIZE              (_AC(1, UL) << HPAGE_SHIFT)
> +#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
> +#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
> +
> +#define HUGE_LINUX_PTE_COUNT       (PAGE_OFFSET >> HPAGE_SHIFT)
> +#define HUGE_LINUX_PTE_SIZE        (HUGE_LINUX_PTE_COUNT * sizeof(pte_t *))
> +#define HUGE_LINUX_PTE_INDEX(addr) (addr >> HPAGE_SHIFT)
> +
> +/*
> + *  We re-purpose the following domain bits in the section descriptor
> + */
> +#define PMD_DSECT_DIRTY                (_AT(pmdval_t, 1) << 5)
> +#define PMD_DSECT_AF           (_AT(pmdval_t, 1) << 6)
> +
> +#define PMD_BIT_FUNC(fn,op) \
> +static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
> +
> +PMD_BIT_FUNC(wrprotect,        &= ~PMD_SECT_AP_WRITE);
> +
> +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +                               pmd_t *pmdp, pmd_t pmd)
> +{
> +       /*
> +        * we can sometimes be passed a pmd pointing to a level 2 descriptor
> +        * from collapse_huge_page.
> +        */
> +       if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE) {
> +               pmdp[0] = __pmd(pmd_val(pmd));
> +               pmdp[1] = __pmd(pmd_val(pmd) + 256 * sizeof(pte_t));

eh, if I get this right, this means that in the case where the pmd
points to level 2 descriptor, all the pages are lined up to be a huge
page, so just point to the next level 2 pte, which directly follows
the next level 2 descriptor, because they share the same page. But
then why do we need to set any values here?

> +       } else {
> +               pmdp[0] = __pmd(pmd_val(pmd));                  /* first 1M section  */
> +               pmdp[1] = __pmd(pmd_val(pmd) + SECTION_SIZE);   /* second 1M section */
> +       }
> +
> +       flush_pmd_entry(pmdp);
> +}
> +
> +#define HPMD_XLATE(res, cmp, from, to) do { if (cmp & from) res |= to; \
> +                                           else res &= ~to;            \
> +                                         } while (0)
> +
> +static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> +{
> +       pmdval_t pmdval = pmd_val(pmd);
> +       pteval_t newprotval = pgprot_val(newprot);
> +
> +       HPMD_XLATE(pmdval, newprotval, L_PTE_XN, PMD_SECT_XN);
> +       HPMD_XLATE(pmdval, newprotval, L_PTE_SHARED, PMD_SECT_S);
> +       HPMD_XLATE(pmdval, newprotval, L_PTE_YOUNG, PMD_DSECT_AF);

consider something akin to:

#define L_PMD_DSECT_YOUNG (PMD_DSECT_AF)

then you don't have to change several places if you decide to
rearrange the mappings for whatever reason at it makes it slightly
easier to read this code.

> +       HPMD_XLATE(pmdval, newprotval, L_PTE_DIRTY, PMD_DSECT_DIRTY);
> +
> +       /* preserve bits C & B */
> +       pmdval |= (newprotval & (3 << 2));

this looks superfluous?

> +
> +       /* Linux PTE bit 4 corresponds to PMD TEX bit 0 */
> +       HPMD_XLATE(pmdval, newprotval, 1 << 4, PMD_SECT_TEX(1));

define L_PTE_TEX0 and group with the others above?

> +
> +       if (newprotval & L_PTE_RDONLY)
> +               pmdval &= ~PMD_SECT_AP_WRITE;
> +       else
> +               pmdval |= PMD_SECT_AP_WRITE;
> +
> +       return __pmd(pmdval);
> +}
> +
> +#endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_PGTABLE_2LEVEL_H */
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index 99a1951..685e9e87 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -92,10 +92,16 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>  static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long addr)
>  {
>         if (!tlb->fullmm) {
> +               unsigned long size = PAGE_SIZE;
> +
>                 if (addr < tlb->range_start)
>                         tlb->range_start = addr;
> -               if (addr + PAGE_SIZE > tlb->range_end)
> -                       tlb->range_end = addr + PAGE_SIZE;
> +
> +               if (tlb->vma && is_vm_hugetlb_page(tlb->vma))
> +                       size = HPAGE_SIZE;
> +
> +               if (addr + size > tlb->range_end)
> +                       tlb->range_end = addr + size;
>         }
>  }
>
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 4eee351..860f08e 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -410,13 +410,21 @@ __enable_mmu:
>         mov     r5, #0
>         mcrr    p15, 0, r4, r5, c2              @ load TTBR0
>  #else
> +#ifndef        CONFIG_SYS_SUPPORTS_HUGETLBFS
>         mov     r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
>                       domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
>                       domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
>                       domain_val(DOMAIN_IO, DOMAIN_CLIENT))
> +#else
> +       @ set ourselves as the client in all domains
> +       @ this allows us to then use the 4 domain bits in the
> +       @ section descriptors in our transparent huge pages
> +       ldr     r5, =0x55555555
> +#endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
> +
>         mcr     p15, 0, r5, c3, c0, 0           @ load domain access register
>         mcr     p15, 0, r4, c2, c0, 0           @ load page table pointer
> -#endif
> +#endif /* CONFIG_ARM_LPAE */
>         b       __turn_mmu_on
>  ENDPROC(__enable_mmu)
>
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> index 1560bbc..adf0b19 100644
> --- a/arch/arm/mm/Makefile
> +++ b/arch/arm/mm/Makefile
> @@ -17,7 +17,11 @@ obj-$(CONFIG_MODULES)                += proc-syms.o
>  obj-$(CONFIG_ALIGNMENT_TRAP)   += alignment.o
>  obj-$(CONFIG_HIGHMEM)          += highmem.o
>  obj-$(CONFIG_HUGETLB_PAGE)     += hugetlbpage.o
> +ifeq ($(CONFIG_ARM_LPAE),y)
>  obj-$(CONFIG_HUGETLB_PAGE)     += hugetlbpage-3level.o
> +else
> +obj-$(CONFIG_HUGETLB_PAGE)     += hugetlbpage-2level.o
> +endif
>
>  obj-$(CONFIG_CPU_ABRT_NOMMU)   += abort-nommu.o
>  obj-$(CONFIG_CPU_ABRT_EV4)     += abort-ev4.o
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 5dbf13f..0884936 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -488,13 +488,13 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
>  #endif                                 /* CONFIG_MMU */
>
>  /*
> - * Some section permission faults need to be handled gracefully.
> - * They can happen due to a __{get,put}_user during an oops.
> + * A fault in a section will likely be due to a huge page, treat it
> + * as a page fault.
>   */
>  static int
>  do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  {
> -       do_bad_area(addr, fsr, regs);
> +       do_page_fault(addr, fsr, regs);

doesn't the previous patch require this as well?

(so it should strictly speaking be part of that patch)

>         return 0;
>  }
>
> diff --git a/arch/arm/mm/hugetlbpage-2level.c b/arch/arm/mm/hugetlbpage-2level.c
> new file mode 100644
> index 0000000..4b2b38c
> --- /dev/null
> +++ b/arch/arm/mm/hugetlbpage-2level.c
> @@ -0,0 +1,115 @@
> +/*
> + * arch/arm/mm/hugetlbpage-2level.c
> + *
> + * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
> + * Copyright (C) 2012 ARM Ltd
> + * Copyright (C) 2012 Bill Carson.
> + *
> + * Based on arch/x86/include/asm/hugetlb.h and Bill Carson's patches
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/hugetlb.h>
> +#include <linux/pagemap.h>
> +#include <linux/err.h>
> +#include <linux/sysctl.h>
> +#include <asm/mman.h>
> +#include <asm/tlb.h>
> +#include <asm/tlbflush.h>
> +#include <asm/pgalloc.h>
> +
> +int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
> +{
> +       return 0;
> +}
> +
> +pte_t *huge_pte_alloc(struct mm_struct *mm,
> +                       unsigned long addr, unsigned long sz)
> +{
> +       pgd_t *pgd;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +
> +       pgd = pgd_offset(mm, addr);
> +       pud = pud_offset(pgd, addr);
> +       pmd = pmd_offset(pud, addr);
> +
> +       return (pte_t *)pmd; /* our huge pte is actually a pmd */
> +}
> +
> +struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
> +                            pmd_t *pmd, int write)
> +{
> +       struct page *page;
> +       unsigned long pfn;
> +
> +       BUG_ON((pmd_val(*pmd) & PMD_TYPE_MASK) != PMD_TYPE_SECT);

I could only see one caller who calls this only when this exact
condition is fulfilled, so unless we anticipate other callers, this
BUG_ON could go.

> +       pfn = ((pmd_val(*pmd) & HPAGE_MASK) >> PAGE_SHIFT);
> +       page = pfn_to_page(pfn);
> +       return page;
> +}
> +
> +pte_t huge_ptep_get(pte_t *ptep)
> +{
> +       pmd_t *pmdp = (pmd_t*)ptep;
> +       pmdval_t pmdval = pmd_val(*pmdp);
> +       pteval_t retval;
> +
> +       if (!pmdval)
> +               return __pte(0);
> +
> +       retval = (pteval_t) (pmdval & HPAGE_MASK);
> +       HPMD_XLATE(retval, pmdval, PMD_SECT_XN, L_PTE_XN);
> +       HPMD_XLATE(retval, pmdval, PMD_SECT_S, L_PTE_SHARED);
> +       HPMD_XLATE(retval, pmdval, PMD_DSECT_AF, L_PTE_YOUNG);
> +       HPMD_XLATE(retval, pmdval, PMD_DSECT_DIRTY, L_PTE_DIRTY);
> +
> +       /* preserve bits C & B */
> +       retval |= (pmdval & (3 << 2));
> +
> +       /* PMD TEX bit 0 corresponds to Linux PTE bit 4 */
> +       HPMD_XLATE(retval, pmdval, PMD_SECT_TEX(1), 1 << 4);
> +

again, I would define the 1 << 4 to something and treat like the others...

> +       if (pmdval & PMD_SECT_AP_WRITE)
> +               retval &= ~L_PTE_RDONLY;
> +       else
> +               retval |= L_PTE_RDONLY;
> +
> +       if ((pmdval & PMD_TYPE_MASK) == PMD_TYPE_SECT)
> +               retval |= L_PTE_VALID;
> +
> +       /* we assume all hugetlb pages are user */
> +       retval |= L_PTE_USER;
> +
> +       return __pte(retval);
> +}
> +
> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> +                                  pte_t *ptep, pte_t pte)
> +{
> +       pmdval_t pmdval = (pmdval_t) pte_val(pte);
> +       pmd_t *pmdp = (pmd_t*) ptep;
> +
> +       pmdval &= HPAGE_MASK;
> +       pmdval |= PMD_SECT_AP_READ | PMD_SECT_nG | PMD_TYPE_SECT;
> +       pmdval = pmd_val(pmd_modify(__pmd(pmdval), __pgprot(pte_val(pte))));
> +
> +       __sync_icache_dcache(pte);
> +
> +       set_pmd_at(mm, addr, pmdp, __pmd(pmdval));
> +}

so this whole scheme where the caller expects ptes, but really gets
pmds feels strange to me, but perhaps it makes more sense on other
architectures as to not change the caller instead of this magic?

-Christoffer
