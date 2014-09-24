Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:46942 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbaIXNgo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Sep 2014 09:36:44 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so8596265pdj.4
        for <linux-arch@vger.kernel.org>; Wed, 24 Sep 2014 06:36:44 -0700 (PDT)
Date: Wed, 24 Sep 2014 06:34:56 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V3 1/6] mm: Introduce a general RCU
 get_user_pages_fast.
In-Reply-To: <1409237107-24228-2-git-send-email-steve.capper@linaro.org>
Message-ID: <alpine.LSU.2.11.1409240633190.10068@eggly.anvils>
References: <1409237107-24228-1-git-send-email-steve.capper@linaro.org> <1409237107-24228-2-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de
Message-ID: <20140924133456.kF90Pnq8DTccMchzHG3IN_DoI7dfGU2OBTjVWScEPUI@z>

On Thu, 28 Aug 2014, Steve Capper wrote:

> get_user_pages_fast attempts to pin user pages by walking the page
> tables directly and avoids taking locks. Thus the walker needs to be
> protected from page table pages being freed from under it, and needs
> to block any THP splits.
> 
> One way to achieve this is to have the walker disable interrupts, and
> rely on IPIs from the TLB flushing code blocking before the page table
> pages are freed.
> 
> On some platforms we have hardware broadcast of TLB invalidations, thus
> the TLB flushing code doesn't necessarily need to broadcast IPIs; and
> spuriously broadcasting IPIs can hurt system performance if done too
> often.
> 
> This problem has been solved on PowerPC and Sparc by batching up page
> table pages belonging to more than one mm_user, then scheduling an
> rcu_sched callback to free the pages. This RCU page table free logic
> has been promoted to core code and is activated when one enables
> HAVE_RCU_TABLE_FREE. Unfortunately, these architectures implement
> their own get_user_pages_fast routines.
> 
> The RCU page table free logic coupled with a an IPI broadcast on THP
> split (which is a rare event), allows one to protect a page table
> walker by merely disabling the interrupts during the walk.
> 
> This patch provides a general RCU implementation of get_user_pages_fast
> that can be used by architectures that perform hardware broadcast of
> TLB invalidations.
> 
> It is based heavily on the PowerPC implementation by Nick Piggin.

That's a helpful description above, thank you; and the patch looks
mostly good to me.  I took a look because I see time is running out,
and you're having trouble getting review of this one: I was hoping
to give you a quick acked-by, but cannot do so as yet.

Most of my remarks below are trivial comments on where it
needs a little more, to be presented as a generic implementation in
mm/gup.c.  And most come from comparing against an up-to-date version
of arch/x86/mm/gup.c: please do the same, I may have missed some.

It would be a pity to mess up your arm schedule for lack of linkage
to this one: maybe this patch can go in as is, and be fixed up a
litte later (that would be up to Andrew); or maybe you'll have
no trouble making the changes before the merge window; or maybe
this should just be kept with arm and arm64 for now (but thank
you for making the effort to give us a generic version).

Hugh

> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> Tested-by: Dann Frazier <dann.frazier@canonical.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  mm/Kconfig |   3 +
>  mm/gup.c   | 278 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 281 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 886db21..0ceb8a5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
>  config HAVE_MEMBLOCK_PHYS_MAP
>  	boolean
>  
> +config HAVE_GENERIC_RCU_GUP

I'm not wild about that name (fast GUP does require that page tables
cannot be freed beneath it, and RCU freeing of page tables is one way
in which that can be guaranteed for this implementation); but I cannot
suggest a better, so let's stick with it.

> +	boolean
> +
>  config ARCH_DISCARD_MEMBLOCK
>  	boolean
>  
> diff --git a/mm/gup.c b/mm/gup.c
> index 91d044b..5e6f6cb 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -10,6 +10,10 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  
> +#include <linux/sched.h>
> +#include <linux/rwsem.h>
> +#include <asm/pgtable.h>
> +
>  #include "internal.h"
>  
>  static struct page *no_page_table(struct vm_area_struct *vma,
> @@ -672,3 +676,277 @@ struct page *get_dump_page(unsigned long addr)
>  	return page;
>  }
>  #endif /* CONFIG_ELF_CORE */
> +
> +#ifdef CONFIG_HAVE_GENERIC_RCU_GUP

This desperately needs a long comment explaining the assumptions made,
and what an architecture must supply and guarantee to use this option.

Maybe your commit message already provides a good enough comment (I
have not now re-read it in that light) and can simply be inserted here.
I don't think it needs to spell everything out, but it does need to
direct a maintainer to thinking through the appropriate issues.

> +
> +#ifdef __HAVE_ARCH_PTE_SPECIAL
> +static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> +			 int write, struct page **pages, int *nr)
> +{
> +	pte_t *ptep, *ptem;
> +	int ret = 0;
> +
> +	ptem = ptep = pte_offset_map(&pmd, addr);
> +	do {
> +		pte_t pte = ACCESS_ONCE(*ptep);

Here is my only substantive criticism.  I don't know the arm architecture,
but my guess is that your LPAE has a similar problem to x86's PAE: that
the pte entry is bigger than the natural word size of the architecture,
and so cannot be safely accessed in one operation on SMP or PREEMPT -
there's a danger that you get mismatched top and bottom halves here.
And how serious that is depends upon the layout of the pte bits.

See comments on gup_get_pte() in arch/x86/mm/gup.c,
and pte_unmap_same() in mm/memory.c.

And even if arm's LPAE is safe, this is unsafe to present in generic
code, or not without a big comment that GENERIC_RCU_GUP should not be
used for such configs; or, better than a comment, a build time error
according to sizeof(pte_t).

(It turns out not to be a problem at pmd, pud and pgd level: IIRC
that's because the transitions at those levels are much more restricted,
limited to setting, then clearing on pagetable teardown - except for
the THP transitions which the local_irq_disable() guards against.)

Ah, enlightenment: arm (unlike arm64) does not __HAVE_ARCH_PTE_SPECIAL,
so this "dangerous" code won't be compiled in for it, it's only using
the stub below.  Well, you can see my point about needing more
comments, those would have saved me a LOT of time.

> +		struct page *page;
> +
> +		if (!pte_present(pte) || pte_special(pte)
> +			|| (write && !pte_write(pte)))

The " ||" at end of line above please.  And, more importantly,
we need a pte_numa() test in here nowadays, for generic use.

> +			goto pte_unmap;
> +
> +		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
> +		page = pte_page(pte);
> +
> +		if (!page_cache_get_speculative(page))
> +			goto pte_unmap;
> +
> +		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> +			put_page(page);
> +			goto pte_unmap;
> +		}
> +
> +		pages[*nr] = page;
> +		(*nr)++;
> +
> +	} while (ptep++, addr += PAGE_SIZE, addr != end);
> +
> +	ret = 1;
> +
> +pte_unmap:
> +	pte_unmap(ptem);
> +	return ret;
> +}
> +#else
> +
> +/*
> + * If we can't determine whether or not a pte is special, then fail immediately
> + * for ptes. Note, we can still pin HugeTLB and THP as these are guaranteed not
> + * to be special.
