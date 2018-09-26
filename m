From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/18] asm-generic/tlb: Provide generic tlb_flush
Date: Wed, 26 Sep 2018 15:11:41 +0200
Message-ID: <20180926131141.GA12444@hirez.programming.kicks-ass.net>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.770817616@infradead.org>
 <20180926125335.GG2979@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926125335.GG2979@brain-police>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 26, 2018 at 01:53:35PM +0100, Will Deacon wrote:
> On Wed, Sep 26, 2018 at 01:36:28PM +0200, Peter Zijlstra wrote:
> > +#ifndef tlb_flush
> > +
> > +#if defined(tlb_start_vma) || defined(tlb_end_vma)
> > +#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
> > +#endif
> > +
> > +#define tlb_flush tlb_flush
> 
> Do we need this #define?

Probably not, that was just my fingers doing the normal #ifndef #define
pattern. I'll take em out back for a 'hug' :-)

> > +static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > +{
> > +	if (tlb->fullmm)
> > +		return;
> > +
> > +	/*
> > +	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
> > +	 * mips-4k) flush only large pages.
> > +	 *
> > +	 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
> > +	 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
> > +	 * range.
> > +	 *
> > +	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
> > +	 * these values the batch is empty.
> > +	 */
> > +	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
> > +	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> 
> Hmm, does this result in code generation for archs that don't care about the
> vm_flags?

Yes. It's not much code, but if you deeply care we could frob things to
get rid of it.
