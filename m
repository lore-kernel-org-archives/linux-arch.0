Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:39255 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbaH0M73 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Aug 2014 08:59:29 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so181585wgh.11
        for <linux-arch@vger.kernel.org>; Wed, 27 Aug 2014 05:59:28 -0700 (PDT)
Date: Wed, 27 Aug 2014 13:59:25 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATH V2 3/6] arm: mm: Enable HAVE_RCU_TABLE_FREE logic
Message-ID: <20140827125924.GC7765@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-4-git-send-email-steve.capper@linaro.org>
 <20140827115010.GJ6968@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140827115010.GJ6968@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>
Message-ID: <20140827125925._D5O_pPAnE5NFdovPvpJ5DPkggDhm5-OD0Ppa7-Dam4@z>

On Wed, Aug 27, 2014 at 12:50:10PM +0100, Catalin Marinas wrote:
> On Thu, Aug 21, 2014 at 04:43:29PM +0100, Steve Capper wrote:
> > --- a/arch/arm/include/asm/tlb.h
> > +++ b/arch/arm/include/asm/tlb.h
> > @@ -35,12 +35,39 @@
> >  
> >  #define MMU_GATHER_BUNDLE	8
> >  
> > +#ifdef CONFIG_HAVE_RCU_TABLE_FREE
> > +static inline void __tlb_remove_table(void *_table)
> > +{
> > +	free_page_and_swap_cache((struct page *)_table);
> > +}
> > +
> > +struct mmu_table_batch {
> > +	struct rcu_head		rcu;
> > +	unsigned int		nr;
> > +	void			*tables[0];
> > +};
> > +
> > +#define MAX_TABLE_BATCH		\
> > +	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
> > +
> > +extern void tlb_table_flush(struct mmu_gather *tlb);
> > +extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
> > +
> > +#define tlb_remove_entry(tlb, entry)	tlb_remove_table(tlb, entry)
> > +#else
> > +#define tlb_remove_entry(tlb, entry)	tlb_remove_page(tlb, entry)
> > +#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
> > +
> >  /*
> >   * TLB handling.  This allows us to remove pages from the page
> >   * tables, and efficiently handle the TLB issues.
> >   */
> >  struct mmu_gather {
> >  	struct mm_struct	*mm;
> > +#ifdef CONFIG_HAVE_RCU_TABLE_FREE
> > +	struct mmu_table_batch	*batch;
> > +	unsigned int		need_flush;
> > +#endif
> 
> We add need_flush here just because it is set by tlb_remove_table() but
> it won't actually be checked by anything since arch/arm uses its own
> version of tlb_flush_mmu(). But I wouldn't go for #ifdefs in the core
> code either.
> 
> We should (as a separate patchset) convert arch/arm to generic
> mmu_gather. I know Russell had objections in the past but mmu_gather has
> evolved since and it's not longer inefficient (I think the only case is
> shift_arg_pages but that's pretty much lost in the noise).

I would be happy to help out with a conversion to generic mmu_gather if
it's wanted for arm.

> 
> For this patch:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers.
