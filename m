From: Christoffer Dall <c.dall@virtualopensystems.com>
Subject: Re: [RFC PATCH 5/6] ARM: mm: Transparent huge page support for LPAE systems.
Date: Fri, 4 Jan 2013 00:04:50 -0500
Message-ID: <CANM98qJmN0ZGK48pKVSMQ5D+d0hrydqr0CHQEH5vk=x=NZ=8Mw@mail.gmail.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
	<1350576942-25299-6-git-send-email-steve.capper@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:50513 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3ADFEv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2013 00:04:51 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so19307306ieb.34
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2013 21:04:51 -0800 (PST)
In-Reply-To: <1350576942-25299-6-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aarcange@redhat.com, bill4carson@gmail.com, tawfik@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com, cmetcalf@tilera.com, mhocko@suse.cz, maen@marvell.com, hoffman@marvell.com, notasas@gmail.com, kirill@shutemov.name, akpm@linux-foundation.org, shadi@marvell.com

On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> The patch adds support for THP (transparent huge pages) to LPAE systems. When
> this feature is enabled, the kernel tries to map anonymous pages as 2MB
> sections where possible.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> [steve.capper@arm.com: symbolic constants used, value of PMD_SECT_SPLITTING
> adjusted, tlbflush.h included in pgtable.h]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> ---
>  arch/arm/Kconfig                            |    4 ++
>  arch/arm/include/asm/pgtable-2level.h       |    2 +
>  arch/arm/include/asm/pgtable-3level-hwdef.h |    2 +
>  arch/arm/include/asm/pgtable-3level.h       |   57 +++++++++++++++++++++++++++
>  arch/arm/include/asm/pgtable.h              |    4 +-
>  arch/arm/include/asm/tlb.h                  |    6 +++
>  arch/arm/include/asm/tlbflush.h             |    2 +
>  arch/arm/mm/fsr-3level.c                    |    2 +-
>  8 files changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dd0a230..9621d5f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1771,6 +1771,10 @@ config SYS_SUPPORTS_HUGETLBFS
>         def_bool y
>         depends on ARM_LPAE || (!CPU_USE_DOMAINS && !MEMORY_FAILURE)
>
> +config HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +       def_bool y
> +       depends on ARM_LPAE
> +
>  source "mm/Kconfig"
>
>  config FORCE_MAX_ZONEORDER
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index fd1d9be..34f4775 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -182,6 +182,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  /* we don't need complex calculations here as the pmd is folded into the pgd */
>  #define pmd_addr_end(addr,end) (end)
>
> +#define pmd_present(pmd)        ((pmd_val(pmd) & PMD_TYPE_MASK) != PMD_TYPE_FAULT)
> +
>  #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
>
>
> diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
> index d795282..53c7f67 100644
> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -38,6 +38,8 @@
>   */
>  #define PMD_SECT_BUFFERABLE    (_AT(pmdval_t, 1) << 2)
>  #define PMD_SECT_CACHEABLE     (_AT(pmdval_t, 1) << 3)
> +#define PMD_SECT_USER          (_AT(pmdval_t, 1) << 6)         /* AP[1] */
> +#define PMD_SECT_RDONLY                (_AT(pmdval_t, 1) << 7)         /* AP[2] */
>  #define PMD_SECT_S             (_AT(pmdval_t, 3) << 8)
>  #define PMD_SECT_AF            (_AT(pmdval_t, 1) << 10)
>  #define PMD_SECT_nG            (_AT(pmdval_t, 1) << 11)
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index d086f61..31c071f 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -85,6 +85,9 @@
>  #define L_PTE_DIRTY            (_AT(pteval_t, 1) << 55)        /* unused */
>  #define L_PTE_SPECIAL          (_AT(pteval_t, 1) << 56)        /* unused */
>
> +#define PMD_SECT_DIRTY         (_AT(pmdval_t, 1) << 55)
> +#define PMD_SECT_SPLITTING     (_AT(pmdval_t, 1) << 57)
> +
>  /*
>   * To be used in assembly code with the upper page attributes.
>   */
> @@ -166,6 +169,60 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  #define pte_mkhuge(pte)                (__pte((pte_val(pte) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
>
>
> +#define pmd_present(pmd)       ((pmd_val(pmd) & PMD_TYPE_MASK) != PMD_TYPE_FAULT)
> +#define pmd_young(pmd)         (pmd_val(pmd) & PMD_SECT_AF)
> +
> +#define __HAVE_ARCH_PMD_WRITE
> +#define pmd_write(pmd)         (!(pmd_val(pmd) & PMD_SECT_RDONLY))
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define pmd_trans_huge(pmd)    ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
> +#define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
> +#endif
> +
> +#define PMD_BIT_FUNC(fn,op) \
> +static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
> +
> +PMD_BIT_FUNC(wrprotect,        |= PMD_SECT_RDONLY);
> +PMD_BIT_FUNC(mkold,    &= ~PMD_SECT_AF);
> +PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
> +PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
> +PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
> +PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
> +PMD_BIT_FUNC(mknotpresent, &= ~PMD_TYPE_MASK);

personally I would prefer not to automate the prefixing of pmd_: it
doesn't really save a lot of characters, it doesn't improve
readability and it breaks grep/cscope.

> +
> +#define pmd_mkhuge(pmd)                (__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
> +
> +#define pmd_pfn(pmd)           ((pmd_val(pmd) & PHYS_MASK) >> PAGE_SHIFT)

the arm arm says UNK/SBZP, so we should be fine here right? (noone is
crazy enough to try and squeeze some extra information in the extra
bits here or something like that). For clarity, one could consider:

(((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)

> +#define pfn_pmd(pfn,prot)      (__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
> +#define mk_pmd(page,prot)      pfn_pmd(page_to_pfn(page),prot)
> +
> +static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> +{
> +       const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_RDONLY;
> +       pmd_val(pmd) = (pmd_val(pmd) & ~mask) | (pgprot_val(newprot) & mask);
> +       return pmd;
> +}
> +
> +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> +{
> +       *pmdp = pmd;
> +}

why this level of indirection?

> +
> +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +                             pmd_t *pmdp, pmd_t pmd)
> +{
> +       BUG_ON(addr >= TASK_SIZE);
> +       pmd = __pmd(pmd_val(pmd) | PMD_SECT_nG);

why this side affect?

> +       set_pmd(pmdp, pmd);
> +       flush_pmd_entry(pmdp);
> +}
> +
> +static inline int has_transparent_hugepage(void)
> +{
> +       return 1;
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_PGTABLE_3LEVEL_H */
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index c35bf46..767aa7c 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -24,6 +24,9 @@
>  #include <asm/memory.h>
>  #include <asm/pgtable-hwdef.h>
>
> +
> +#include <asm/tlbflush.h>
> +
>  #ifdef CONFIG_ARM_LPAE
>  #include <asm/pgtable-3level.h>
>  #else
> @@ -163,7 +166,6 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  #define pgd_offset_k(addr)     pgd_offset(&init_mm, addr)
>
>  #define pmd_none(pmd)          (!pmd_val(pmd))
> -#define pmd_present(pmd)       (pmd_val(pmd))
>
>  static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>  {
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index 685e9e87..0fc2d9d 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -229,6 +229,12 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>  #endif
>  }
>
> +static inline void
> +tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
> +{
> +       tlb_add_flush(tlb, addr);
> +}
> +
>  #define pte_free_tlb(tlb, ptep, addr)  __pte_free_tlb(tlb, ptep, addr)
>  #define pmd_free_tlb(tlb, pmdp, addr)  __pmd_free_tlb(tlb, pmdp, addr)
>  #define pud_free_tlb(tlb, pudp, addr)  pud_free((tlb)->mm, pudp)
> diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
> index 6e924d3..907cede 100644
> --- a/arch/arm/include/asm/tlbflush.h
> +++ b/arch/arm/include/asm/tlbflush.h
> @@ -505,6 +505,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  }
>  #endif
>
> +#define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
> +
>  #endif
>
>  #endif /* CONFIG_MMU */
> diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
> index 05a4e94..47f4c6f 100644
> --- a/arch/arm/mm/fsr-3level.c
> +++ b/arch/arm/mm/fsr-3level.c
> @@ -9,7 +9,7 @@ static struct fsr_info fsr_info[] = {
>         { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "level 3 translation fault"     },
>         { do_bad,               SIGBUS,  0,             "reserved access flag fault"    },
>         { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 1 access flag fault"     },
> -       { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 2 access flag fault"     },
> +       { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 2 access flag fault"     },
>         { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 3 access flag fault"     },
>         { do_bad,               SIGBUS,  0,             "reserved permission fault"     },
>         { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 1 permission fault"      },
> --
> 1.7.9.5
>

Besides the nits it looks fine to me. I've done quite extensive
testing with varied workloads on this code over the last couple of
months on the vexpress TC2 and on the ARNDALE board using KVM/ARM with
huge pages, and it gives a nice ~15% performance increase on average
and is completely stable.

-Christoffer
