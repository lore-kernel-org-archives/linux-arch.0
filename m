From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [patch 3/5] x86: lockless get_user_pages_fast
Date: Thu, 29 May 2008 12:20:59 -0500
Message-ID: <1212081659.6308.10.camel@norville.austin.ibm.com>
References: <20080529122050.823438000@nick.local0.net>
	 <20080529122602.330656000@nick.local0.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48277 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbYE2RVR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 13:21:17 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4THL0dG002902
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:21:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4THL0Zw147662
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:21:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m4THKxNs028519
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:21:00 -0400
In-Reply-To: <20080529122602.330656000@nick.local0.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

On Thu, 2008-05-29 at 22:20 +1000, npiggin@suse.de wrote:
 
> +int get_user_pages_fast(unsigned long start, int nr_pages, int write, struct page **pages)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long end = start + (nr_pages << PAGE_SHIFT);
> +	unsigned long addr = start;
> +	unsigned long next;
> +	pgd_t *pgdp;
> +	int nr = 0;
> +
> +	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
> +					start, nr_pages*PAGE_SIZE)))
> +		goto slow_irqon;
> +
> +	/*
> +	 * XXX: batch / limit 'nr', to avoid large irq off latency
> +	 * needs some instrumenting to determine the common sizes used by
> +	 * important workloads (eg. DB2), and whether limiting the batch size
> +	 * will decrease performance.
> +	 *
> +	 * It seems like we're in the clear for the moment. Direct-IO is
> +	 * the main guy that batches up lots of get_user_pages, and even
> +	 * they are limited to 64-at-a-time which is not so many.
> +	 */
> +	/*
> +	 * This doesn't prevent pagetable teardown, but does prevent
> +	 * the pagetables and pages from being freed on x86.
> +	 *
> +	 * So long as we atomically load page table pointers versus teardown
> +	 * (which we do on x86, with the above PAE exception), we can follow the
> +	 * address down to the the page and take a ref on it.
> +	 */
> +	local_irq_disable();
> +	pgdp = pgd_offset(mm, addr);
> +	do {
> +		pgd_t pgd = *pgdp;
> +
> +		next = pgd_addr_end(addr, end);
> +		if (pgd_none(pgd))
> +			goto slow;
> +		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
> +			goto slow;
> +	} while (pgdp++, addr = next, addr != end);
> +	local_irq_enable();
> +
> +	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
> +	return nr;
> +
> +	{
> +		int i, ret;
> +
> +slow:
> +		local_irq_enable();
> +slow_irqon:
> +		/* Try to get the remaining pages with get_user_pages */
> +		start += nr << PAGE_SHIFT;
> +		pgaes += nr;

Typo: s/pgaes/pages/

> +
> +		down_read(&mm->mmap_sem);
> +		ret = get_user_pages(current, mm, start,
> +			(end - start) >> PAGE_SHIFT, write, 0, pages, NULL);
> +		up_read(&mm->mmap_sem);
> +
> +		/* Have to be a bit careful with return values */
> +		if (nr > 0) {
> +			if (ret < 0)
> +				ret = nr;
> +			else
> +				ret += nr;
> +		}
> +
> +		return ret;
> +	}
> +}

-- 
David Kleikamp
IBM Linux Technology Center
