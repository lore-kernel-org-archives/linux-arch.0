From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 05/18] asm-generic/tlb: Provide generic tlb_flush
Date: Thu, 27 Sep 2018 13:14:26 +0100
Message-ID: <20180927121425.GC5028@brain-police>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.770817616@infradead.org>
 <20180926125335.GG2979@brain-police>
 <20180926131141.GA12444@hirez.programming.kicks-ass.net>
 <20180926180727.GA7455@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926180727.GA7455@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 26, 2018 at 08:07:27PM +0200, Peter Zijlstra wrote:
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -305,7 +305,8 @@ static inline void __tlb_reset_range(str
>  #error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
>  #endif
>  
> -#define tlb_flush tlb_flush
> +#define generic_tlb_flush
> +
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
>  	if (tlb->fullmm || tlb->need_flush_all) {
> @@ -391,12 +392,12 @@ static inline unsigned long tlb_get_unma
>   * the vmas are adjusted to only cover the region to be torn down.
>   */
>  #ifndef tlb_start_vma
> -#define tlb_start_vma tlb_start_vma
>  static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
>  	if (tlb->fullmm)
>  		return;
>  
> +#ifdef generic_tlb_flush
>  	/*
>  	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
>  	 * mips-4k) flush only large pages.
> @@ -410,13 +411,13 @@ static inline void tlb_start_vma(struct
>  	 */
>  	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
>  	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> +#endif

Alternatively, we could wrap the two assignments above in a macro like:

	tlb_update_vma_flags(tlb, vma)

which could be empty if the generic tlb_flush isn't in use?

Anyway, as long as we resolve this one way or the other, you can add my Ack:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
