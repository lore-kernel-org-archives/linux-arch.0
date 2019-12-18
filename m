From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] asm-generic/tlb: Avoid potential double flush
Date: Wed, 18 Dec 2019 10:19:06 +0100
Message-ID: <20191218091906.GP2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-3-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191218053530.73053-3-aneesh.kumar@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 18, 2019 at 11:05:30AM +0530, Aneesh Kumar K.V wrote:

> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -402,7 +402,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>  
>  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  {
> -	if (!tlb->end)
> +	/*
> +	 * Anything calling __tlb_adjust_range() also sets at least one of
> +	 * these bits.
> +	 */
> +	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> +	      tlb->cleared_puds || tlb->cleared_p4ds))
>  		return;

FWIW I looked at the GCC generated assembly output for this (x86_64) and
it did a single load and mask as expected.
