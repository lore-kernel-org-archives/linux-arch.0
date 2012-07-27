Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53789 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab2G0Q5y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jul 2012 12:57:54 -0400
Received: by vcbfk26 with SMTP id fk26so2928515vcb.19
        for <linux-arch@vger.kernel.org>; Fri, 27 Jul 2012 09:57:54 -0700 (PDT)
Date: Fri, 27 Jul 2012 12:57:50 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH 1/2] add mm argument to lazy mmu mode hooks
Message-ID: <20120727165749.GB7190@localhost.localdomain>
References: <1343317634-13197-1-git-send-email-schwidefsky@de.ibm.com>
 <1343317634-13197-2-git-send-email-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1343317634-13197-2-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Zachary Amsden <zach@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20120727165750.Qp7a0vFCcMIidlVKAtzN1PTfH2tfl0hFh5vfCyIxxls@z>

On Thu, Jul 26, 2012 at 05:47:13PM +0200, Martin Schwidefsky wrote:
> To enable lazy TLB flush schemes with a scope limited to a single
> mm_struct add the mm pointer as argument to the three lazy mmu mode
> hooks.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/powerpc/include/asm/tlbflush.h |    6 +++---
>  arch/powerpc/mm/subpage-prot.c      |    4 ++--
>  arch/powerpc/mm/tlb_hash64.c        |    4 ++--
>  arch/tile/mm/fault.c                |    2 +-
>  arch/tile/mm/highmem.c              |    4 ++--
>  arch/x86/include/asm/paravirt.h     |    6 +++---
>  arch/x86/kernel/paravirt.c          |   10 +++++-----
>  arch/x86/mm/highmem_32.c            |    4 ++--
>  arch/x86/mm/iomap_32.c              |    2 +-
>  include/asm-generic/pgtable.h       |    6 +++---
>  mm/memory.c                         |   16 ++++++++--------
>  mm/mprotect.c                       |    4 ++--
>  mm/mremap.c                         |    4 ++--
>  13 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
> index 81143fc..7851e0c1 100644
> --- a/arch/powerpc/include/asm/tlbflush.h
> +++ b/arch/powerpc/include/asm/tlbflush.h
> @@ -108,14 +108,14 @@ extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
>  
>  #define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>  
> -static inline void arch_enter_lazy_mmu_mode(void)
> +static inline void arch_enter_lazy_mmu_mode(struct mm_struct *mm)
>  {
>  	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
>  
>  	batch->active = 1;
>  }
>  
> -static inline void arch_leave_lazy_mmu_mode(void)
> +static inline void arch_leave_lazy_mmu_mode(struct mm_struct *mm)
>  {
>  	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
>  
> @@ -124,7 +124,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
>  	batch->active = 0;
>  }
>  
> -#define arch_flush_lazy_mmu_mode()      do {} while (0)
> +#define arch_flush_lazy_mmu_mode(mm)	  do {} while (0)
>  
>  
>  extern void flush_hash_page(unsigned long va, real_pte_t pte, int psize,
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index e4f8f1f..bf95185 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -76,13 +76,13 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
>  	if (pmd_none(*pmd))
>  		return;
>  	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> -	arch_enter_lazy_mmu_mode();
> +	arch_enter_lazy_mmu_mode(mm);
>  	for (; npages > 0; --npages) {
>  		pte_update(mm, addr, pte, 0, 0);
>  		addr += PAGE_SIZE;
>  		++pte;
>  	}
> -	arch_leave_lazy_mmu_mode();
> +	arch_leave_lazy_mmu_mode(mm);
>  	pte_unmap_unlock(pte - 1, ptl);
>  }
>  
> diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
> index 31f1820..73fd065 100644
> --- a/arch/powerpc/mm/tlb_hash64.c
> +++ b/arch/powerpc/mm/tlb_hash64.c
> @@ -205,7 +205,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>  	 * way to do things but is fine for our needs here.
>  	 */
>  	local_irq_save(flags);
> -	arch_enter_lazy_mmu_mode();
> +	arch_enter_lazy_mmu_mode(mm);
>  	for (; start < end; start += PAGE_SIZE) {
>  		pte_t *ptep = find_linux_pte(mm->pgd, start);
>  		unsigned long pte;
> @@ -217,7 +217,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>  			continue;
>  		hpte_need_flush(mm, start, ptep, pte, 0);
>  	}
> -	arch_leave_lazy_mmu_mode();
> +	arch_leave_lazy_mmu_mode(mm);
>  	local_irq_restore(flags);
>  }
>  
> diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c
> index 84ce7ab..0d78f93 100644
> --- a/arch/tile/mm/fault.c
> +++ b/arch/tile/mm/fault.c
> @@ -123,7 +123,7 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
>  		return NULL;
>  	if (!pmd_present(*pmd)) {
>  		set_pmd(pmd, *pmd_k);
> -		arch_flush_lazy_mmu_mode();
> +		arch_flush_lazy_mmu_mode(&init_mm);
>  	} else
>  		BUG_ON(pmd_ptfn(*pmd) != pmd_ptfn(*pmd_k));
>  	return pmd_k;
> diff --git a/arch/tile/mm/highmem.c b/arch/tile/mm/highmem.c
> index ef8e5a6..85b061e 100644
> --- a/arch/tile/mm/highmem.c
> +++ b/arch/tile/mm/highmem.c
> @@ -114,7 +114,7 @@ static void kmap_atomic_register(struct page *page, enum km_type type,
>  
>  	list_add(&amp->list, &amp_list);
>  	set_pte(ptep, pteval);
> -	arch_flush_lazy_mmu_mode();
> +	arch_flush_lazy_mmu_mode(&init_mm);
>  
>  	spin_unlock(&amp_lock);
>  	homecache_kpte_unlock(flags);
> @@ -259,7 +259,7 @@ void __kunmap_atomic(void *kvaddr)
>  		BUG_ON(vaddr >= (unsigned long)high_memory);
>  	}
>  
> -	arch_flush_lazy_mmu_mode();
> +	arch_flush_lazy_mmu_mode(&init_mm);
>  	pagefault_enable();
>  }
>  EXPORT_SYMBOL(__kunmap_atomic);
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 0b47ddb..b097945 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -694,17 +694,17 @@ static inline void arch_end_context_switch(struct task_struct *next)
>  }
>  
>  #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
> -static inline void arch_enter_lazy_mmu_mode(void)
> +static inline void arch_enter_lazy_mmu_mode(struct mm_struct *mm)
>  {
>  	PVOP_VCALL0(pv_mmu_ops.lazy_mode.enter);

If you are doing that, you should probably also update the pvops call to
pass in the 'struct mm_struct'?

