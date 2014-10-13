From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
Date: Mon, 13 Oct 2014 11:52:26 +0530
Message-ID: <87a9501obh.fsf@linux.vnet.ibm.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org> <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
Sender: owner-linux-mm@kvack.org
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com, Steve Capper <steve.capper@linaro.org>
List-Id: linux-arch.vger.kernel.org

Steve Capper <steve.capper@linaro.org> writes:

.....

> +
> +static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> +		unsigned long end, int write, struct page **pages, int *nr)
> +{
> +	struct page *head, *page, *tail;
> +	int refs;
> +
> +	if (write && !pmd_write(orig))
> +		return 0;
> +
> +	refs = 0;
> +	head = pmd_page(orig);
> +	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> +	tail = page;
> +	do {
> +		VM_BUG_ON_PAGE(compound_head(page) != head, page);
> +		pages[*nr] = page;
> +		(*nr)++;
> +		page++;
> +		refs++;
> +	} while (addr += PAGE_SIZE, addr != end);
> +
> +	if (!page_cache_add_speculative(head, refs)) {
> +		*nr -= refs;
> +		return 0;
> +	}
> +
> +	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> +		*nr -= refs;
> +		while (refs--)
> +			put_page(head);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Any tail pages need their mapcount reference taken before we
> +	 * return. (This allows the THP code to bump their ref count when
> +	 * they are split into base pages).
> +	 */
> +	while (refs--) {
> +		if (PageTail(tail))
> +			get_huge_page_tail(tail);
> +		tail++;
> +	}
> +
> +	return 1;
> +}
> +
.....

> +static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
> +		int write, struct page **pages, int *nr)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp;
> +
> +	pmdp = pmd_offset(&pud, addr);
> +	do {
> +		pmd_t pmd = ACCESS_ONCE(*pmdp);
> +
> +		next = pmd_addr_end(addr, end);
> +		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
> +			return 0;
> +
> +		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd))) {

We don't check the _PAGE_PRESENT here


> +			/*
> +			 * NUMA hinting faults need to be handled in the GUP
> +			 * slowpath for accounting purposes and so that they
> +			 * can be serialised against THP migration.
> +			 */
> +			if (pmd_numa(pmd))
> +				return 0;
> +
> +			if (!gup_huge_pmd(pmd, pmdp, addr, next, write,
> +				pages, nr))
> +				return 0;
> +
> +		} else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
> +				return 0;
> +	} while (pmdp++, addr = next, addr != end);
> +
> +	return 1;
> +}
> +

-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
