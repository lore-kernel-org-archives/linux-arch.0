Return-Path: <SRS0=WXCa=4P=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [RFC PATCH v9 14/27] mm: Handle Shadow Stack page fault
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-15-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <4902a6ee-cb0f-2700-1f6d-9d756593183c@intel.com>
Date: Wed, 26 Feb 2020 16:08:06 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-15-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200227000806.4EMFGwZ38EJ5gH7XjC_KANZETTSbkpPT6Gfn99UZJB8@z>

> diff --git a/mm/memory.c b/mm/memory.c
> index 45442d9a4f52..6daa28614327 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -772,7 +772,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	 * If it's a COW mapping, write protect it both
>  	 * in the parent and the child
>  	 */
> -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> +	if ((is_cow_mapping(vm_flags) && pte_write(pte)) ||
> +	    arch_copy_pte_mapping(vm_flags)) {
>  		ptep_set_wrprotect(src_mm, addr, src_pte);
>  		pte = pte_wrprotect(pte);
>  	}

You have to modify this because pte_write()==0 for shadow stack PTEs, right?

Aren't shadow stack ptes *logically* writable, even if they don't have
the write bit set?  What would happen if we made pte_write()==1 for them?

> @@ -2417,6 +2418,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
>  	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  	entry = pte_mkyoung(vmf->orig_pte);
>  	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	entry = pte_set_vma_features(entry, vma);
>  	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
>  		update_mmu_cache(vma, vmf->address, vmf->pte);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -2504,6 +2506,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +		entry = pte_set_vma_features(entry, vma);
>  		/*
>  		 * Clear the pte entry and flush it first, before updating the
>  		 * pte with the new entry. This will avoid a race condition
> @@ -3023,6 +3026,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	pte = mk_pte(page, vma->vm_page_prot);
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
>  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> +		pte = pte_set_vma_features(pte, vma);
>  		vmf->flags &= ~FAULT_FLAG_WRITE;
>  		ret |= VM_FAULT_WRITE;
>  		exclusive = RMAP_EXCLUSIVE;
> @@ -3165,6 +3169,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	entry = mk_pte(page, vma->vm_page_prot);
>  	if (vma->vm_flags & VM_WRITE)
>  		entry = pte_mkwrite(pte_mkdirty(entry));
> +	entry = pte_set_vma_features(entry, vma);
>  
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>  			&vmf->ptl);
> 

These seem wrong, or at best inconsistent with what's already done.

We don't need anything like pte_set_vma_features() today because we have
vma->vm_page_prot.  We could easily have done what you suggest here for
things like protection keys: ignore the pkey PTE bits until we create
the final PTE then shove them in there.

What are the bit patterns of the shadow stack bits that come out of
these sites?  Can they be represented in ->vm_page_prot?
