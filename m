From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/18] asm-generic/tlb: Provide generic tlb_flush
Date: Wed, 26 Sep 2018 20:07:27 +0200
Message-ID: <20180926180727.GA7455@hirez.programming.kicks-ass.net>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.770817616@infradead.org>
 <20180926125335.GG2979@brain-police>
 <20180926131141.GA12444@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926131141.GA12444@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 26, 2018 at 03:11:41PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 26, 2018 at 01:53:35PM +0100, Will Deacon wrote:

> > > +static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > > +{
> > > +	if (tlb->fullmm)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
> > > +	 * mips-4k) flush only large pages.
> > > +	 *
> > > +	 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
> > > +	 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
> > > +	 * range.
> > > +	 *
> > > +	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
> > > +	 * these values the batch is empty.
> > > +	 */
> > > +	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
> > > +	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> > 
> > Hmm, does this result in code generation for archs that don't care about the
> > vm_flags?
> 
> Yes. It's not much code, but if you deeply care we could frob things to
> get rid of it.

Something a little like the below... not particularly pretty but should
work.

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -305,7 +305,8 @@ static inline void __tlb_reset_range(str
 #error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
 #endif
 
-#define tlb_flush tlb_flush
+#define generic_tlb_flush
+
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	if (tlb->fullmm || tlb->need_flush_all) {
@@ -391,12 +392,12 @@ static inline unsigned long tlb_get_unma
  * the vmas are adjusted to only cover the region to be torn down.
  */
 #ifndef tlb_start_vma
-#define tlb_start_vma tlb_start_vma
 static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	if (tlb->fullmm)
 		return;
 
+#ifdef generic_tlb_flush
 	/*
 	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
 	 * mips-4k) flush only large pages.
@@ -410,13 +411,13 @@ static inline void tlb_start_vma(struct
 	 */
 	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
+#endif
 
 	flush_cache_range(vma, vma->vm_start, vma->vm_end);
 }
 #endif
 
 #ifndef tlb_end_vma
-#define tlb_end_vma tlb_end_vma
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	if (tlb->fullmm)
