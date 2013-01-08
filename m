From: Christoffer Dall <c.dall@virtualopensystems.com>
Subject: Re: [RFC PATCH 3/6] ARM: mm: HugeTLB support for LPAE systems.
Date: Tue, 8 Jan 2013 13:10:06 -0500
Message-ID: <CANM98qLYMMKabtKPA8-w375c2MBW5v7KB-nbVmXGiV9F4G19hw@mail.gmail.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
	<1350576942-25299-4-git-send-email-steve.capper@arm.com>
	<CANM98qLkOULQT0LJxmjmLMzPULotthNJW4HTvuJBH6L7puXg3g@mail.gmail.com>
	<20130108175724.GC18347@e103986-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60974 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab3AHSKG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2013 13:10:06 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so922094ieb.31
        for <linux-arch@vger.kernel.org>; Tue, 08 Jan 2013 10:10:06 -0800 (PST)
In-Reply-To: <20130108175724.GC18347@e103986-lin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "bill4carson@gmail.com" <bill4carson@gmail.com>, "tawfik@marvell.com" <tawfik@marvell.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "mhocko@suse.cz" <mhocko@suse.cz>, "maen@marvell.com" <maen@marvell.com>, "hoffman@marvell.com" <hoffman@marvell.com>, "notasas@gmail.com" <notasas@gmail.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shadi@marvell.com" <shadi@marvell.com>

On Tue, Jan 8, 2013 at 12:57 PM, Steve Capper <steve.capper@arm.com> wrote:
> On Fri, Jan 04, 2013 at 05:03:59AM +0000, Christoffer Dall wrote:
>> On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:
>
>> > +++ b/arch/arm/include/asm/hugetlb.h
>> > @@ -0,0 +1,83 @@
>> > +/*
>> > + * arch/arm/include/asm/hugetlb.h
>> > + *
>> > + * Copyright (C) 2012 ARM Ltd.
>> > + *
>> > + * Based on arch/x86/include/asm/hugetlb.h
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program; if not, write to the Free Software
>> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>> > + */
>> > +
>> > +#ifndef _ASM_ARM_HUGETLB_H
>> > +#define _ASM_ARM_HUGETLB_H
>> > +
>> > +#include <asm/page.h>
>> > +
>> > +#include <asm/hugetlb-3level.h>
>>
>> I feel like it wouldn't hurt anyone to put a comment here explaining
>> that these "ptes" are in fact pmd section descriptors disguised in pte
>> types.
>>
>
> Yes, that does make sense. I'll put something in to that effect.
>
>> > +
>> > +static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>> > +                                         unsigned long addr, unsigned long end,
>> > +                                         unsigned long floor,
>> > +                                         unsigned long ceiling)
>> > +{
>> > +       free_pgd_range(tlb, addr, end, floor, ceiling);
>> > +}
>> > +
>> > +
>> > +static inline int is_hugepage_only_range(struct mm_struct *mm,
>> > +                                        unsigned long addr, unsigned long len)
>> > +{
>> > +       return 0;
>> > +}
>> > +
>> > +static inline int prepare_hugepage_range(struct file *file,
>> > +                                        unsigned long addr, unsigned long len)
>> > +{
>> > +       struct hstate *h = hstate_file(file);
>> > +       if (len & ~huge_page_mask(h))
>> > +               return -EINVAL;
>> > +       if (addr & ~huge_page_mask(h))
>> > +               return -EINVAL;
>> > +       return 0;
>> > +}
>> > +
>> > +static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm)
>> > +{
>> > +}
>> > +
>> > +static inline int huge_pte_none(pte_t pte)
>> > +{
>> > +       return pte_none(pte);
>> > +}
>> > +
>> > +static inline pte_t huge_pte_wrprotect(pte_t pte)
>> > +{
>> > +       return pte_wrprotect(pte);
>> > +}
>> > +
>> > +static inline int arch_prepare_hugepage(struct page *page)
>> > +{
>> > +       return 0;
>> > +}
>> > +
>> > +static inline void arch_release_hugepage(struct page *page)
>> > +{
>> > +}
>> > +
>> > +static inline void arch_clear_hugepage_flags(struct page *page)
>> > +{
>> > +       clear_bit(PG_dcache_clean, &page->flags);
>>
>> why do we clear this bit here?
>>
>
> This is called when the huge page is freed, and it indicates that the
> dcache needs to be flushed for this page. The mechanism was added by commit:
> 5d3a551c28c6669dc43be40d8fafafbc2ec8f42b.
> "mm: hugetlb: add arch hook for clearing page flags before entering pool"
>
>> > diff --git a/arch/arm/mm/hugetlbpage-3level.c b/arch/arm/mm/hugetlbpage-3level.c
>> > new file mode 100644
>> > index 0000000..86474f0
>> > --- /dev/null
>> > +++ b/arch/arm/mm/hugetlbpage-3level.c
>> > @@ -0,0 +1,190 @@
>> > +/*
>> > + * arch/arm/mm/hugetlbpage-3level.c
>> > + *
>> > + * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
>> > + * Copyright (C) 2012 ARM Ltd.
>> > + *
>> > + * Based on arch/x86/mm/hugetlbpage.c
>> > + *
>>
>> this seems to be an almost 1-to-1 copy of the x86 code. Is it not
>> worth sharing it somehow? Possible?
>>
>
> Yeah, good point, I have a cunning plan though; please see below.
>
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program; if not, write to the Free Software
>> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>> > + */
>> > +
>> > +#include <linux/init.h>
>> > +#include <linux/fs.h>
>> > +#include <linux/mm.h>
>> > +#include <linux/hugetlb.h>
>> > +#include <linux/pagemap.h>
>> > +#include <linux/err.h>
>> > +#include <linux/sysctl.h>
>> > +#include <asm/mman.h>
>> > +#include <asm/tlb.h>
>> > +#include <asm/tlbflush.h>
>> > +#include <asm/pgalloc.h>
>> > +
>> > +static unsigned long page_table_shareable(struct vm_area_struct *svma,
>> > +                               struct vm_area_struct *vma,
>> > +                               unsigned long addr, pgoff_t idx)
>> > +{
>> > +       unsigned long saddr = ((idx - svma->vm_pgoff) << PAGE_SHIFT) +
>> > +                               svma->vm_start;
>> > +       unsigned long sbase = saddr & PUD_MASK;
>> > +       unsigned long s_end = sbase + PUD_SIZE;
>>
>> these are to check that the potential vma to steal the pmd from covers
>> the entire pud entry's address space, correct?
>
> Yes that's correct.
>
>>
>> it's pretty confusing with the idx conversion back and forward,
>> especially given that mm/hugetlb.c uses idx to index into number of
>> huge pages, where this idx is index into number of regular pages, so I
>> would suggest some clear static conversion functions or a comment.
>>
>> > +
>> > +       /* Allow segments to share if only one is marked locked */
>>
>> exactly one or at most one? the code below checks that exactly one is
>> marked locked, if I read it correctly. Again, for me, the comment
>> would be more helpful if it stated *why* that's a requirement, not
>> just that it *is* a requirement.
>>
>
> This originates from commit:
> 32b154c0b0bae2879bf4e549d861caf1759a3546
> "x86: ignore VM_LOCKED when determining if hugetlb-backed page tables can be shared or not"
> and the commit title is clearer.
>
>> > +       unsigned long vm_flags = vma->vm_flags & ~VM_LOCKED;
>> > +       unsigned long svm_flags = svma->vm_flags & ~VM_LOCKED;
>> > +
>> > +       /*
>> > +        * match the virtual addresses, permission and the alignment of the
>> > +        * page table page.
>> > +        */
>> > +       if (pmd_index(addr) != pmd_index(saddr) ||
>> > +           vm_flags != svm_flags ||
>> > +           sbase < svma->vm_start || svma->vm_end < s_end)
>> > +               return 0;
>> > +
>> > +       return saddr;
>> > +}
>> > +
>> > +static int vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>> > +{
>> > +       unsigned long base = addr & PUD_MASK;
>> > +       unsigned long end = base + PUD_SIZE;
>> > +
>> > +       /*
>> > +        * check on proper vm_flags and page table alignment
>> > +        */
>> > +       if (vma->vm_flags & VM_MAYSHARE &&
>> > +           vma->vm_start <= base && end <= vma->vm_end)
>> > +               return 1;
>> > +       return 0;
>> > +}
>> > +
>> > +/*
>> > + * search for a shareable pmd page for hugetlb.
>>
>> nit:
>>
>> perhaps this is completely standard knowledge for your garden variety
>> mm hacker, but I needed to spend 5 minutes figuring out the purpose
>> here - if I get it right: multiple mappings the hugetlbfs file for the
>> same mm covering the same pud address range mapping the same data can
>> use the same pmd, right?
>>
>
> Yes, that's correct. Multiple puds can point to the same block of 512 pmds.
> Which can then lead to cache use reduction when page tables are walked.
>
> This is introduced in commit: 39dde65c9940c97fcd178a3d2b1c57ed8b7b68aa
> "[PATCH] shared page table for hugetlb page"
>
>> I would either rename the function to find_huge_pmd_share and get rid
>> of the comment or expand on the comment.
>>
>> > + */
>> > +static pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr,
>> > +                            pud_t *pud)
>> > +{
>> > +       struct vm_area_struct *vma = find_vma(mm, addr);
>> > +       struct address_space *mapping = vma->vm_file->f_mapping;
>> > +       pgoff_t idx = ((addr - vma->vm_start) >> PAGE_SHIFT) +
>> > +                       vma->vm_pgoff;
>> > +       struct vm_area_struct *svma;
>> > +       unsigned long saddr;
>> > +       pte_t *spte = NULL;
>> > +       pte_t *pte;
>> > +
>> > +       if (!vma_shareable(vma, addr))
>> > +               return (pte_t *)pmd_alloc(mm, pud, addr);
>> > +
>> > +       mutex_lock(&mapping->i_mmap_mutex);
>> > +       vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
>> > +               if (svma == vma)
>> > +                       continue;
>> > +
>> > +               saddr = page_table_shareable(svma, vma, addr, idx);
>> > +               if (saddr) {
>> > +                       spte = huge_pte_offset(svma->vm_mm, saddr);
>> > +                       if (spte) {
>> > +                               get_page(virt_to_page(spte));
>> > +                               break;
>> > +                       }
>> > +               }
>> > +       }
>> > +
>> > +       if (!spte)
>> > +               goto out;
>> > +
>> > +       spin_lock(&mm->page_table_lock);
>> > +       if (pud_none(*pud))
>> > +               pud_populate(mm, pud, (pmd_t *)((unsigned long)spte & PAGE_MASK));
>> > +       else
>> > +               put_page(virt_to_page(spte));
>> > +       spin_unlock(&mm->page_table_lock);
>> > +out:
>> > +       pte = (pte_t *)pmd_alloc(mm, pud, addr);
>> > +       mutex_unlock(&mapping->i_mmap_mutex);
>> > +       return pte;
>> > +}
>> > +
>> > +/*
>> > + * unmap huge page backed by shared pte.
>> > + *
>> > + * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
>> > + * indicated by page_count > 1, unmap is achieved by clearing pud and
>> > + * decrementing the ref count. If count == 1, the pte page is not shared.
>> > + *
>> > + * called with vma->vm_mm->page_table_lock held.
>> > + *
>> > + * returns: 1 successfully unmapped a shared pte page
>> > + *         0 the underlying pte page is not shared, or it is the last user
>> > + */
>> > +int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
>> > +{
>> > +       pgd_t *pgd = pgd_offset(mm, *addr);
>> > +       pud_t *pud = pud_offset(pgd, *addr);
>> > +
>> > +       BUG_ON(page_count(virt_to_page(ptep)) == 0);
>> > +       if (page_count(virt_to_page(ptep)) == 1)
>> > +               return 0;
>> > +
>> > +       pud_clear(pud);
>> > +       put_page(virt_to_page(ptep));
>> > +       *addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
>>
>> huh? this hurts my brain. Why the minus HPAGE_SIZE?
>>
>
> This is called in two places: hugetlb_change_protection and
> __unmap_hugepage_range. In both cases it is called as part of a loop where
> *addr is incremented by the huge page size when the loop advances. If
> huge_pmd_unshare returns 1, then the loop "continue"s. The -HPAGE_SIZE cancels
> out the *addr increment at the end of the loop.
>

yuck! That logic should really be in the loop if at all posssible -
this current design makes it hard to read both the caller and the
callee.

>> > +       return 1;
>> > +}
>> > +
>> > +pte_t *huge_pte_alloc(struct mm_struct *mm,
>> > +                       unsigned long addr, unsigned long sz)
>> > +{
>> > +       pgd_t *pgd;
>> > +       pud_t *pud;
>> > +       pte_t *pte = NULL;
>> > +
>> > +       pgd = pgd_offset(mm, addr);
>> > +       pud = pud_alloc(mm, pgd, addr);
>> > +       if (pud) {
>> > +               BUG_ON(sz != PMD_SIZE);
>>
>> is this really necessary?
>>
>> VM_BUG_ON?
>>
>
> Thanks, I'll clean this up.
>
> So, on to my cunning plan :-)....
>
> Essentially the huge pmd sharing takes place under the following circumstances:
> 1) At least 1GB of huge memory must be requested in a vm_area block.
> 2) This must be VM_SHAREABLE; so mmap using MAP_SHARED on hugetlbfs or shmget.
> 3) The mapping must be at a 1GB memory boundary (to kick off a new pud).
> 4) Another process must request this same backing file; but again, this must be
>    mapped on a 1GB boundary in the other process too.
>
> I've only been able to get this working with a 3GB user VM split, and my test
> case needed to be statically compiled as .so's were mmaped right where I wanted
> to mmap the 1GB huge memory block (at 0x40000000).
>
> Having thought more about this; I don't think the above conditions are likely to
> crop up with 2GB or 3GB user VM area in the wild. Thus I am tempted to remove
> the huge pmd sharing from the LPAE hugetlb code and simplify things a bit more.
>
> If I've missed a use case where huge pmd sharing may be useful, please give me
> a shout?
>

I think your reasoning sounds completely sane.

>> > +               if (pud_none(*pud))
>> > +                       pte = huge_pmd_share(mm, addr, pud);
>> > +               else
>> > +                       pte = (pte_t *)pmd_alloc(mm, pud, addr);
>> > +       }
>> > +       BUG_ON(pte && !pte_none(*pte) && !pte_huge(*pte));
>> > +
>> > +       return pte;
>> > +}
>> > +
>> > +struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>> > +                            pmd_t *pmd, int write)
>> > +{
>> > +       struct page *page;
>> > +
>> > +       page = pte_page(*(pte_t *)pmd);
>> > +       if (page)
>> > +               page += ((address & ~PMD_MASK) >> PAGE_SHIFT);
>> > +       return page;
>> > +}
>> > +
>> > +struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
>> > +                            pud_t *pud, int write)
>> > +{
>> > +       struct page *page;
>> > +
>> > +       page = pte_page(*(pte_t *)pud);
>> > +       if (page)
>> > +               page += ((address & ~PUD_MASK) >> PAGE_SHIFT);
>> > +       return page;
>>
>> why implement this? this should never be called right? Shouldn't it
>> just be a BUG();
>>
>
> Yes, thanks, it should be BUG().
>
>> > +}
>> > diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
>> > new file mode 100644
>> > index 0000000..32fe7fd
>> > --- /dev/null
>> > +++ b/arch/arm/mm/hugetlbpage.c
>> > @@ -0,0 +1,65 @@
>> > +/*
>> > + * arch/arm/mm/hugetlbpage.c
>> > + *
>> > + * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
>> > + * Copyright (C) 2012 ARM Ltd.
>> > + *
>> > + * Based on arch/x86/mm/hugetlbpage.c
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program; if not, write to the Free Software
>> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>> > + */
>> > +
>> > +#include <linux/init.h>
>> > +#include <linux/fs.h>
>> > +#include <linux/mm.h>
>> > +#include <linux/hugetlb.h>
>> > +#include <linux/pagemap.h>
>> > +#include <linux/err.h>
>> > +#include <linux/sysctl.h>
>> > +#include <asm/mman.h>
>> > +#include <asm/tlb.h>
>> > +#include <asm/tlbflush.h>
>> > +#include <asm/pgalloc.h>
>> > +
>> > +pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>> > +{
>> > +       pgd_t *pgd;
>> > +       pud_t *pud;
>> > +       pmd_t *pmd = NULL;
>> > +
>> > +       pgd = pgd_offset(mm, addr);
>> > +       if (pgd_present(*pgd)) {
>> > +               pud = pud_offset(pgd, addr);
>> > +               if (pud_present(*pud))
>> > +                       pmd = pmd_offset(pud, addr);
>> > +       }
>> > +
>> > +       return (pte_t *)pmd;
>> > +}
>> > +
>> > +struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
>> > +                             int write)
>> > +{
>> > +       return ERR_PTR(-EINVAL);
>> > +}
>> > +
>> > +int pmd_huge(pmd_t pmd)
>> > +{
>> > +       return (pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT;
>> > +}
>> > +
>> > +int pud_huge(pud_t pud)
>> > +{
>> > +       return 0;
>> > +}
>> > --
>> > 1.7.9.5
>> >
>> >
>
>>
>> -Christoffer
>>
>
