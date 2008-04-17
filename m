From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [patch 2/2]: introduce fast_gup
Date: Thu, 17 Apr 2008 17:03:25 +0200
Message-ID: <1208444605.7115.2.camel@twins>
References: <20080328025455.GA8083@wotan.suse.de>
	 <20080328030023.GC8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080328030023.GC8083-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>

On Fri, 2008-03-28 at 04:00 +0100, Nick Piggin wrote:

> +++ linux-2.6/arch/x86/mm/gup.c
> @@ -0,0 +1,198 @@
> +/*
> + * Lockless fast_gup for x86
> + *
> + * Copyright (C) 2007 Nick Piggin
> + * Copyright (C) 2007 Novell Inc.
> + */
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/vmstat.h>
> +#include <asm/pgtable.h>
> +
> +/*
> + * The performance critical leaf functions are made noinline otherwise gcc
> + * inlines everything into a single function which results in too much
> + * register pressure.
> + */
> +static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
> +		unsigned long end, int write, struct page **pages, int *nr)
> +{
> +	unsigned long mask, result;
> +	pte_t *ptep;
> +
> +	result = _PAGE_PRESENT|_PAGE_USER;
> +	if (write)
> +		result |= _PAGE_RW;
> +	mask = result | _PAGE_SPECIAL;
> +
> +	ptep = pte_offset_map(&pmd, addr);
> +	do {
> +		/*
> +		 * XXX: careful. On 3-level 32-bit, the pte is 64 bits, and
> +		 * we need to make sure we load the low word first, then the
> +		 * high. This means _PAGE_PRESENT should be clear if the high
> +		 * word was not valid. Currently, the C compiler can issue
> +		 * the loads in any order, and I don't know of a wrapper
> +		 * function that will do this properly, so it is broken on
> +		 * 32-bit 3-level for the moment.
> +		 */
> +		pte_t pte = *ptep;
> +		struct page *page;
> +
> +		if ((pte_val(pte) & mask) != result)
> +			return 0;
> +		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
> +		page = pte_page(pte);
> +		get_page(page);
> +		pages[*nr] = page;
> +		(*nr)++;
> +
> +	} while (ptep++, addr += PAGE_SIZE, addr != end);
> +	pte_unmap(ptep - 1);
> +
> +	return 1;
> +}

Would this be sufficient to address that comment's conern?

Index: linux-2.6/arch/x86/mm/gup.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/gup.c
+++ linux-2.6/arch/x86/mm/gup.c
@@ -36,8 +36,16 @@ static noinline int gup_pte_range(pmd_t 
 		 * function that will do this properly, so it is broken on
 		 * 32-bit 3-level for the moment.
 		 */
-		pte_t pte = *ptep;
 		struct page *page;
+		pte_t pte;
+
+#ifdef CONFIG_X86_PAE
+		pte.pte_low = ptep->pte_low;
+		barrier();
+		pte.pte_high = ptep->pte_high;
+#else
+		pte = *ptep;
+#endif
 
 		if ((pte_val(pte) & mask) != result)
 			return 0;
