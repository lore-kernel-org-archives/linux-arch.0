From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 22/25] arm64: mte: Enable swap of tagged pages
Date: Thu, 25 Jun 2020 12:59:10 +0100
Message-ID: <20200625115909.GA14812@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-23-catalin.marinas@arm.com>
 <c9aa526c-b85f-4f73-828c-7fc0c4e7fbb2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404285AbgFYL7W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 07:59:22 -0400
Content-Disposition: inline
In-Reply-To: <c9aa526c-b85f-4f73-828c-7fc0c4e7fbb2@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Price <steven.price@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jun 25, 2020 at 12:37:40PM +0100, Steven Price wrote:
> On 24/06/2020 18:52, Catalin Marinas wrote:
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index 3e08aea56e7a..1712c504df15 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -10,6 +10,8 @@
> >   #include <linux/sched.h>
> >   #include <linux/sched/mm.h>
> >   #include <linux/string.h>
> > +#include <linux/swap.h>
> > +#include <linux/swapops.h>
> >   #include <linux/thread_info.h>
> >   #include <linux/uio.h>
> > @@ -18,15 +20,30 @@
> >   #include <asm/ptrace.h>
> >   #include <asm/sysreg.h>
> > +static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
> > +{
> > +	pte_t old_pte = READ_ONCE(*ptep);
> > +
> > +	if (check_swap && is_swap_pte(old_pte)) {
> > +		swp_entry_t entry = pte_to_swp_entry(old_pte);
> > +
> > +		if (!non_swap_entry(entry) && mte_restore_tags(entry, page))
> > +			return;
> > +	}
> > +
> > +	mte_clear_page_tags(page_address(page));
> > +}
> > +
> >   void mte_sync_tags(pte_t *ptep, pte_t pte)
> >   {
> >   	struct page *page = pte_page(pte);
> >   	long i, nr_pages = compound_nr(page);
> > +	bool check_swap = nr_pages == 0;
> >   	/* if PG_mte_tagged is set, tags have already been initialised */
> >   	for (i = 0; i < nr_pages; i++, page++) {
> 
> This is broken - for check_swap to be true, nr_pages==0, which means we
> never enter the loop and nothing happens...
> 
> Except I don't believe compound_nr() will return 0 - it's defined as:
> 
>   static inline unsigned long compound_nr(struct page *page)
>   {
>   	return 1UL << compound_order(page);
>   }
> 
> Changing it to nr_pages==1 works for me.

Ah, I had it as compound_order() and changes to compound_nr() but left
the 0 check. Fixed locally.

Thanks.

-- 
Catalin
