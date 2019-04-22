Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59591 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbfDVRJJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Apr 2019 13:09:09 -0400
Subject: Re: [PATCH] [v2] x86/mpx: fix recursive munmap() corruption
References: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <fe0ba8f2-ee2c-4dcc-39e8-629a02ac583c@linux.alibaba.com>
Date: Mon, 22 Apr 2019 10:08:46 -0700
MIME-Version: 1.0
In-Reply-To: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: rguenther@suse.de, hjl.tools@gmail.com, mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net, x86@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-arch@vger.kernel.org, gxt@pku.edu.cn, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Message-ID: <20190422170846.UWoZo-LIVVbAvlN8yqNP1w1llFtLW4CgaNdl6p0eJE0@z>



On 4/19/19 12:47 PM, Dave Hansen wrote:
> Changes from v1:
>   * Fix compile errors on UML and non-x86 arches
>   * Clarify commit message and Fixes about the origin of the
>     bug and add the impact to powerpc / uml / unicore32
>
> --
>
> This is a bit of a mess, to put it mildly.  But, it's a bug
> that only seems to have showed up in 4.20 but wasn't noticed
> until now because nobody uses MPX.
>
> MPX has the arch_unmap() hook inside of munmap() because MPX
> uses bounds tables that protect other areas of memory.  When
> memory is unmapped, there is also a need to unmap the MPX
> bounds tables.  Barring this, unused bounds tables can eat 80%
> of the address space.
>
> But, the recursive do_munmap() that gets called vi arch_unmap()
> wreaks havoc with __do_munmap()'s state.  It can result in
> freeing populated page tables, accessing bogus VMA state,
> double-freed VMAs and more.
>
> To fix this, call arch_unmap() before __do_unmap() has a chance
> to do anything meaningful.  Also, remove the 'vma' argument
> and force the MPX code to do its own, independent VMA lookup.
>
> == UML / unicore32 impact ==
>
> Remove unused 'vma' argument to arch_unmap().  No functional
> change.
>
> I compile tested this on UML but not unicore32.
>
> == powerpc impact ==
>
> powerpc uses arch_unmap() well to watch for munmap() on the
> VDSO and zeroes out 'current->mm->context.vdso_base'.  Moving
> arch_unmap() makes this happen earlier in __do_munmap().  But,
> 'vdso_base' seems to only be used in perf and in the signal
> delivery that happens near the return to userspace.  I can not
> find any likely impact to powerpc, other than the zeroing
> happening a little earlier.
>
> powerpc does not use the 'vma' argument and is unaffected by
> its removal.
>
> I compile-tested a 64-bit powerpc defconfig.
>
> == x86 impact ==
>
> For the common success case this is functionally identical to
> what was there before.  For the munmap() failure case, it's
> possible that some MPX tables will be zapped for memory that
> continues to be in use.  But, this is an extraordinarily
> unlikely scenario and the harm would be that MPX provides no
> protection since the bounds table got reset (zeroed).
>
> I can't imagine anyone doing this:
>
> 	ptr = mmap();
> 	// use ptr
> 	ret = munmap(ptr);
> 	if (ret)
> 		// oh, there was an error, I'll
> 		// keep using ptr.
>
> Because if you're doing munmap(), you are *done* with the
> memory.  There's probably no good data in there _anyway_.
>
> This passes the original reproducer from Richard Biener as
> well as the existing mpx selftests/.
>
> ====
>
> The long story:
>
> munmap() has a couple of pieces:
> 1. Find the affected VMA(s)
> 2. Split the start/end one(s) if neceesary
> 3. Pull the VMAs out of the rbtree
> 4. Actually zap the memory via unmap_region(), including
>     freeing page tables (or queueing them to be freed).
> 5. Fixup some of the accounting (like fput()) and actually
>     free the VMA itself.
>
> This specific ordering was actually introduced by:
>
> 	dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
>
> during the 4.20 merge window.  The previous __do_munmap() code
> was actually safe because the only thing after arch_unmap() was
> remove_vma_list().  arch_unmap() could not see 'vma' in the
> rbtree because it was detached, so it is not even capable of
> doing operations unsafe for remove_vma_list()'s use of 'vma'.
>
> Richard Biener reported a test that shows this in dmesg:
>
> [1216548.787498] BUG: Bad rss-counter state mm:0000000017ce560b idx:1 val:551
> [1216548.787500] BUG: non-zero pgtables_bytes on freeing mm: 24576
>
> What triggered this was the recursive do_munmap() called via
> arch_unmap().  It was freeing page tables that has not been
> properly zapped.
>
> But, the problem was bigger than this.  For one, arch_unmap()
> can free VMAs.  But, the calling __do_munmap() has variables
> that *point* to VMAs and obviously can't handle them just
> getting freed while the pointer is still in use.
>
> I tried a couple of things here.  First, I tried to fix the page
> table freeing problem in isolation, but I then found the VMA
> issue.  I also tried having the MPX code return a flag if it
> modified the rbtree which would force __do_munmap() to re-walk
> to restart.  That spiralled out of control in complexity pretty
> fast.
>
> Just moving arch_unmap() and accepting that the bonkers failure
> case might eat some bounds tables seems like the simplest viable
> fix.
>
> This was also reported in the following kernel bugzilla entry:
>
> 	https://bugzilla.kernel.org/show_bug.cgi?id=203123
>
> There are some reports that dd2283f2605 ("mm: mmap: zap pages
> with read mmap_sem in munmap") triggered this issue.  While that
> commit certainly made the issues easier to hit, I belive the
> fundamental issue has been with us as long as MPX itself, thus
> the Fixes: tag below is for one of the original MPX commits.
>
> Reported-by: Richard Biener <rguenther@suse.de>
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: x86@kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-um@lists.infradead.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-arch@vger.kernel.org
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> ---
>
>   b/arch/powerpc/include/asm/mmu_context.h   |    1 -
>   b/arch/um/include/asm/mmu_context.h        |    1 -
>   b/arch/unicore32/include/asm/mmu_context.h |    1 -
>   b/arch/x86/include/asm/mmu_context.h       |    6 +++---
>   b/arch/x86/include/asm/mpx.h               |    5 ++---
>   b/arch/x86/mm/mpx.c                        |   10 ++++++----
>   b/include/asm-generic/mm_hooks.h           |    1 -
>   b/mm/mmap.c                                |   15 ++++++++-------
>   8 files changed, 19 insertions(+), 21 deletions(-)
>
> diff -puN mm/mmap.c~mpx-rss-pass-no-vma mm/mmap.c
> --- a/mm/mmap.c~mpx-rss-pass-no-vma	2019-04-19 09:31:09.851509404 -0700
> +++ b/mm/mmap.c	2019-04-19 09:31:09.864509404 -0700
> @@ -2730,9 +2730,17 @@ int __do_munmap(struct mm_struct *mm, un
>   		return -EINVAL;
>   
>   	len = PAGE_ALIGN(len);
> +	end = start + len;
>   	if (len == 0)
>   		return -EINVAL;
>   
> +	/*
> +	 * arch_unmap() might do unmaps itself.  It must be called
> +	 * and finish any rbtree manipulation before this code
> +	 * runs and also starts to manipulate the rbtree.
> +	 */
> +	arch_unmap(mm, start, end);
> +
>   	/* Find the first overlapping VMA */
>   	vma = find_vma(mm, start);
>   	if (!vma)
> @@ -2741,7 +2749,6 @@ int __do_munmap(struct mm_struct *mm, un
>   	/* we have  start < vma->vm_end  */
>   
>   	/* if it doesn't overlap, we have nothing.. */
> -	end = start + len;
>   	if (vma->vm_start >= end)
>   		return 0;
>   
> @@ -2811,12 +2818,6 @@ int __do_munmap(struct mm_struct *mm, un
>   	/* Detach vmas from rbtree */
>   	detach_vmas_to_be_unmapped(mm, vma, prev, end);
>   
> -	/*
> -	 * mpx unmap needs to be called with mmap_sem held for write.
> -	 * It is safe to call it before unmap_region().
> -	 */
> -	arch_unmap(mm, vma, start, end);
> -
>   	if (downgrade)
>   		downgrade_write(&mm->mmap_sem);

Thanks for debugging this. The change looks good to me. Reviewed-by: 
Yang Shi <yang.shi@linux.alibaba.com>

>   
> diff -puN arch/x86/include/asm/mmu_context.h~mpx-rss-pass-no-vma arch/x86/include/asm/mmu_context.h
> --- a/arch/x86/include/asm/mmu_context.h~mpx-rss-pass-no-vma	2019-04-19 09:31:09.853509404 -0700
> +++ b/arch/x86/include/asm/mmu_context.h	2019-04-19 09:31:09.865509404 -0700
> @@ -277,8 +277,8 @@ static inline void arch_bprm_mm_init(str
>   	mpx_mm_init(mm);
>   }
>   
> -static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
> -			      unsigned long start, unsigned long end)
> +static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
> +			      unsigned long end)
>   {
>   	/*
>   	 * mpx_notify_unmap() goes and reads a rarely-hot
> @@ -298,7 +298,7 @@ static inline void arch_unmap(struct mm_
>   	 * consistently wrong.
>   	 */
>   	if (unlikely(cpu_feature_enabled(X86_FEATURE_MPX)))
> -		mpx_notify_unmap(mm, vma, start, end);
> +		mpx_notify_unmap(mm, start, end);
>   }
>   
>   /*
> diff -puN include/asm-generic/mm_hooks.h~mpx-rss-pass-no-vma include/asm-generic/mm_hooks.h
> --- a/include/asm-generic/mm_hooks.h~mpx-rss-pass-no-vma	2019-04-19 09:31:09.856509404 -0700
> +++ b/include/asm-generic/mm_hooks.h	2019-04-19 09:31:09.865509404 -0700
> @@ -18,7 +18,6 @@ static inline void arch_exit_mmap(struct
>   }
>   
>   static inline void arch_unmap(struct mm_struct *mm,
> -			struct vm_area_struct *vma,
>   			unsigned long start, unsigned long end)
>   {
>   }
> diff -puN arch/x86/mm/mpx.c~mpx-rss-pass-no-vma arch/x86/mm/mpx.c
> --- a/arch/x86/mm/mpx.c~mpx-rss-pass-no-vma	2019-04-19 09:31:09.858509404 -0700
> +++ b/arch/x86/mm/mpx.c	2019-04-19 09:31:09.866509404 -0700
> @@ -881,9 +881,10 @@ static int mpx_unmap_tables(struct mm_st
>    * the virtual address region start...end have already been split if
>    * necessary, and the 'vma' is the first vma in this range (start -> end).
>    */
> -void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
> -		unsigned long start, unsigned long end)
> +void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
> +		      unsigned long end)
>   {
> +       	struct vm_area_struct *vma;
>   	int ret;
>   
>   	/*
> @@ -902,11 +903,12 @@ void mpx_notify_unmap(struct mm_struct *
>   	 * which should not occur normally. Being strict about it here
>   	 * helps ensure that we do not have an exploitable stack overflow.
>   	 */
> -	do {
> +	vma = find_vma(mm, start);
> +	while (vma && vma->vm_start < end) {
>   		if (vma->vm_flags & VM_MPX)
>   			return;
>   		vma = vma->vm_next;
> -	} while (vma && vma->vm_start < end);
> +	}
>   
>   	ret = mpx_unmap_tables(mm, start, end);
>   	if (ret)
> diff -puN arch/x86/include/asm/mpx.h~mpx-rss-pass-no-vma arch/x86/include/asm/mpx.h
> --- a/arch/x86/include/asm/mpx.h~mpx-rss-pass-no-vma	2019-04-19 09:31:09.860509404 -0700
> +++ b/arch/x86/include/asm/mpx.h	2019-04-19 09:31:09.866509404 -0700
> @@ -78,8 +78,8 @@ static inline void mpx_mm_init(struct mm
>   	 */
>   	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
>   }
> -void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
> -		      unsigned long start, unsigned long end);
> +void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
> +		unsigned long end);
>   
>   unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len,
>   		unsigned long flags);
> @@ -100,7 +100,6 @@ static inline void mpx_mm_init(struct mm
>   {
>   }
>   static inline void mpx_notify_unmap(struct mm_struct *mm,
> -				    struct vm_area_struct *vma,
>   				    unsigned long start, unsigned long end)
>   {
>   }
> diff -puN arch/um/include/asm/mmu_context.h~mpx-rss-pass-no-vma arch/um/include/asm/mmu_context.h
> --- a/arch/um/include/asm/mmu_context.h~mpx-rss-pass-no-vma	2019-04-19 09:42:05.789507768 -0700
> +++ b/arch/um/include/asm/mmu_context.h	2019-04-19 09:42:57.962507638 -0700
> @@ -22,7 +22,6 @@ static inline int arch_dup_mmap(struct m
>   }
>   extern void arch_exit_mmap(struct mm_struct *mm);
>   static inline void arch_unmap(struct mm_struct *mm,
> -			struct vm_area_struct *vma,
>   			unsigned long start, unsigned long end)
>   {
>   }
> diff -puN arch/unicore32/include/asm/mmu_context.h~mpx-rss-pass-no-vma arch/unicore32/include/asm/mmu_context.h
> --- a/arch/unicore32/include/asm/mmu_context.h~mpx-rss-pass-no-vma	2019-04-19 09:42:06.189507767 -0700
> +++ b/arch/unicore32/include/asm/mmu_context.h	2019-04-19 09:43:25.425507569 -0700
> @@ -88,7 +88,6 @@ static inline int arch_dup_mmap(struct m
>   }
>   
>   static inline void arch_unmap(struct mm_struct *mm,
> -			struct vm_area_struct *vma,
>   			unsigned long start, unsigned long end)
>   {
>   }
> diff -puN arch/powerpc/include/asm/mmu_context.h~mpx-rss-pass-no-vma arch/powerpc/include/asm/mmu_context.h
> --- a/arch/powerpc/include/asm/mmu_context.h~mpx-rss-pass-no-vma	2019-04-19 09:42:06.388507766 -0700
> +++ b/arch/powerpc/include/asm/mmu_context.h	2019-04-19 09:43:27.392507564 -0700
> @@ -237,7 +237,6 @@ extern void arch_exit_mmap(struct mm_str
>   #endif
>   
>   static inline void arch_unmap(struct mm_struct *mm,
> -			      struct vm_area_struct *vma,
>   			      unsigned long start, unsigned long end)
>   {
>   	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
> _
