Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:36530 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbaJMGWu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Oct 2014 02:22:50 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Mon, 13 Oct 2014 16:22:48 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1210F3578048
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2014 17:22:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s9D6OY5h24444990
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2014 17:24:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s9D6MeNY014836
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2014 17:22:42 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org> <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
Date: Mon, 13 Oct 2014 11:52:26 +0530
Message-ID: <87a9501obh.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com
Message-ID: <20141013062226.-3pKfEiD_Bf447m2cOoK6FQbaZA4p2fpF6nx2-Fod88@z>

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

