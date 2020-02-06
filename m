From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v6 06/11] powerpc/mm/book3s64/hash: Use functions to track
 lockless pgtbl walks
Date: Thu, 6 Feb 2020 07:06:07 +0100
Message-ID: <1b65f1a8-42a8-6ffc-3a06-08fbb34edab5@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-7-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <20200206030900.147032-7-leonardo@linux.ibm.com>
Content-Language: fr
Sender: kvm-ppc-owner@vger.kernel.org
To: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Applies the new tracking functions to all hash-related functions that do
> lockless pagetable walks.
> 
> hash_page_mm: Adds comment that explain that there is no need to
> local_int_disable/save given that it is only called from DataAccess
> interrupt, so interrupts are already disabled.
> 
> local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
> so there is no need to repeat it here.
> 
> Variable that saves the	irq mask was renamed from flags to irq_mask so it
> doesn't lose meaning now it's not directly passed to local_irq_* functions.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/mm/book3s64/hash_tlb.c   |  6 +++---
>   arch/powerpc/mm/book3s64/hash_utils.c | 27 +++++++++++++++++----------
>   2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
> index 4a70d8dd39cd..86547c4151f6 100644
> --- a/arch/powerpc/mm/book3s64/hash_tlb.c
> +++ b/arch/powerpc/mm/book3s64/hash_tlb.c
> @@ -194,7 +194,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>   {
>   	bool is_thp;
>   	int hugepage_shift;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   
>   	start = _ALIGN_DOWN(start, PAGE_SIZE);
>   	end = _ALIGN_UP(end, PAGE_SIZE);
> @@ -209,7 +209,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>   	 * to being hashed). This is not the most performance oriented
>   	 * way to do things but is fine for our needs here.
>   	 */
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	arch_enter_lazy_mmu_mode();
>   	for (; start < end; start += PAGE_SIZE) {
>   		pte_t *ptep = find_current_mm_pte(mm->pgd, start, &is_thp,
> @@ -229,7 +229,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>   			hpte_need_flush(mm, start, ptep, pte, hugepage_shift);
>   	}
>   	arch_leave_lazy_mmu_mode();
> -	local_irq_restore(flags);
> +	end_lockless_pgtbl_walk(irq_mask);
>   }
>   
>   void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 523d4d39d11e..e6d4ab42173b 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -1341,12 +1341,16 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   		ea &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
>   #endif /* CONFIG_PPC_64K_PAGES */
>   
> -	/* Get PTE and page size from page tables */
> +	/* Get PTE and page size from page tables :
> +	 * Called in from DataAccess interrupt (data_access_common: 0x300),
> +	 * interrupts are disabled here.
> +	 */

Comments formatting is not in line with Linux kernel rules. Should be no 
text on the first /* line.

> +	__begin_lockless_pgtbl_walk(false);

I think it would be better to not use __begin_lockless_pgtbl_walk() 
directly but keep it in a single place, and define something like 
begin_lockless_pgtbl_walk_noirq() similar to begin_lockless_pgtbl_walk()

>   	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
>   	if (ptep == NULL || !pte_present(*ptep)) {
>   		DBG_LOW(" no PTE !\n");
>   		rc = 1;
> -		goto bail;
> +		goto bail_pgtbl_walk;

What's the point in changing the name of this label ? There is only one 
label, why polute the function with so huge name ?

For me, everyone understand what 'bail' means. Unneccessary changes 
should be avoided. If you really really want to do it, it should be 
another patch.

See kernel codying style, chapter 'naming':
"LOCAL variable names should be short". This also applies to labels.

"C is a Spartan language, and so should your naming be. Unlike Modula-2 
and Pascal programmers, C programmers do not use cute names like 
ThisVariableIsATemporaryCounter. A C programmer would call that variable 
tmp, which is much easier to write, and not the least more difficult to 
understand."

>   	}
>   
>   	/* Add _PAGE_PRESENT to the required access perm */
> @@ -1359,7 +1363,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   	if (!check_pte_access(access, pte_val(*ptep))) {
>   		DBG_LOW(" no access !\n");
>   		rc = 1;
> -		goto bail;
> +		goto bail_pgtbl_walk;
>   	}
>   
>   	if (hugeshift) {
> @@ -1383,7 +1387,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   		if (current->mm == mm)
>   			check_paca_psize(ea, mm, psize, user_region);
>   
> -		goto bail;
> +		goto bail_pgtbl_walk;
>   	}
>   
>   #ifndef CONFIG_PPC_64K_PAGES
> @@ -1457,6 +1461,8 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   #endif
>   	DBG_LOW(" -> rc=%d\n", rc);
>   
> +bail_pgtbl_walk:
> +	__end_lockless_pgtbl_walk(0, false);
>   bail:
>   	exception_exit(prev_state);
>   	return rc;
> @@ -1545,7 +1551,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
>   	unsigned long vsid;
>   	pgd_t *pgdir;
>   	pte_t *ptep;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   	int rc, ssize, update_flags = 0;
>   	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
>   
> @@ -1567,11 +1573,12 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
>   	vsid = get_user_vsid(&mm->context, ea, ssize);
>   	if (!vsid)
>   		return;
> +

Is this new line related to the patch ?

>   	/*
>   	 * Hash doesn't like irqs. Walking linux page table with irq disabled
>   	 * saves us from holding multiple locks.
>   	 */
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   
>   	/*
>   	 * THP pages use update_mmu_cache_pmd. We don't do
> @@ -1616,7 +1623,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
>   				   mm_ctx_user_psize(&mm->context),
>   				   pte_val(*ptep));
>   out_exit:
> -	local_irq_restore(flags);
> +	end_lockless_pgtbl_walk(irq_mask);
>   }
>   
>   /*
> @@ -1679,16 +1686,16 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
>   {
>   	pte_t *ptep;
>   	u16 pkey = 0;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   
>   	if (!mm || !mm->pgd)
>   		return 0;
>   
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
>   	if (ptep)
>   		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
> -	local_irq_restore(flags);
> +	end_lockless_pgtbl_walk(irq_mask);
>   
>   	return pkey;
>   }
> 

Christophe
