From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v9 14/27] mm: Handle Shadow Stack page fault
Date: Tue, 07 Apr 2020 11:14:58 -0700
Message-ID: <444d97c4a4f70ccbb12da5e8f7ff498b37a9f60d.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-15-yu-cheng.yu@intel.com>
         <4902a6ee-cb0f-2700-1f6d-9d756593183c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4902a6ee-cb0f-2700-1f6d-9d756593183c-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2020-02-26 at 16:08 -0800, Dave Hansen wrote:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 45442d9a4f52..6daa28614327 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -772,7 +772,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  	 * If it's a COW mapping, write protect it both
> >  	 * in the parent and the child
> >  	 */
> > -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> > +	if ((is_cow_mapping(vm_flags) && pte_write(pte)) ||
> > +	    arch_copy_pte_mapping(vm_flags)) {
> >  		ptep_set_wrprotect(src_mm, addr, src_pte);
> >  		pte = pte_wrprotect(pte);
> >  	}
> 
> You have to modify this because pte_write()==0 for shadow stack PTEs, right?
> 
> Aren't shadow stack ptes *logically* writable, even if they don't have
> the write bit set?  What would happen if we made pte_write()==1 for them?

Here the vm_flags needs to have VM_MAYWRITE, and the PTE needs to have
_PAGE_WRITE.  A shadow stack does not have either.

To fix checking vm_flags, what about adding a "arch_is_cow_mappping()" to the
generic is_cow_mapping()?

For the PTE, the check actually tries to determine if the PTE is not already
being copy-on-write, which is:

	(!_PAGE_RW && !_PAGE_DIRTY_HW)

So what about making it pte_cow()?

	/*
	 * The PTE is in copy-on-write status.
	 */
	static inline int pte_cow(pte_t pte)
	{
		return !(pte_flags(pte) & (_PAGE_WRITE | _PAGE_DIRTY_HW));
	}
> 
> > @@ -2417,6 +2418,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
> >  	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
> >  	entry = pte_mkyoung(vmf->orig_pte);
> >  	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> > +	entry = pte_set_vma_features(entry, vma);
> >  	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
> >  		update_mmu_cache(vma, vmf->address, vmf->pte);
> >  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > @@ -2504,6 +2506,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
> >  		entry = mk_pte(new_page, vma->vm_page_prot);
> >  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> > +		entry = pte_set_vma_features(entry, vma);
> >  		/*
> >  		 * Clear the pte entry and flush it first, before updating the
> >  		 * pte with the new entry. This will avoid a race condition
> > @@ -3023,6 +3026,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  	pte = mk_pte(page, vma->vm_page_prot);
> >  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
> >  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> > +		pte = pte_set_vma_features(pte, vma);
> >  		vmf->flags &= ~FAULT_FLAG_WRITE;
> >  		ret |= VM_FAULT_WRITE;
> >  		exclusive = RMAP_EXCLUSIVE;
> > @@ -3165,6 +3169,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >  	entry = mk_pte(page, vma->vm_page_prot);
> >  	if (vma->vm_flags & VM_WRITE)
> >  		entry = pte_mkwrite(pte_mkdirty(entry));
> > +	entry = pte_set_vma_features(entry, vma);
> >  
> >  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> >  			&vmf->ptl);
> > 
> 
> These seem wrong, or at best inconsistent with what's already done.
> 
> We don't need anything like pte_set_vma_features() today because we have
> vma->vm_page_prot.  We could easily have done what you suggest here for
> things like protection keys: ignore the pkey PTE bits until we create
> the final PTE then shove them in there.
> 
> What are the bit patterns of the shadow stack bits that come out of
> these sites?  Can they be represented in ->vm_page_prot?

Yes, we can put _PAGE_DIRTY_HW in vm_page_prot.  Also set the bit in
ptep_set_access_flags() for shadow stack PTEs.
