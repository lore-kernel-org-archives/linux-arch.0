From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATH V2 3/6] arm: mm: Enable HAVE_RCU_TABLE_FREE logic
Date: Wed, 27 Aug 2014 13:59:25 +0100
Message-ID: <20140827125924.GC7765@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-4-git-send-email-steve.capper@linaro.org>
 <20140827115010.GJ6968@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140827115010.GJ6968@arm.com>
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
