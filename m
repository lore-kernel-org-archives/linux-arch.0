Return-Path: <SRS0=EpiA=6E=kvack.org=owner-linux-mm@kernel.org>
Date: Mon, 20 Apr 2020 13:46:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 4/6] tlb: mmu_gather: add tlb_set_*_range APIs
Message-ID: <20200420114651.GD20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-5-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090048.938-5-yezhenyu2@huawei.com>
Sender: owner-linux-mm@kvack.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200420114651.vcaUahgjJcrEB0PJfcuOAuAhzFlcT127bIeHt8BsIdw@z>

On Fri, Apr 03, 2020 at 05:00:46PM +0800, Zhenyu Ye wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> tlb_set_{pte|pmd|pud|p4d}_range() adjust the tlb->start and
> tlb->end, then set corresponding cleared_*.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  include/asm-generic/tlb.h | 55 ++++++++++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index f391f6b500b4..ee91310a65c6 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -511,6 +511,38 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>  }
>  #endif
>  
> +/*
> + * tlb_set_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,
> + * and set corresponding cleared_*.
> + */
> +static inline void tlb_set_pte_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_ptes = 1;
> +}
> +
> +static inline void tlb_set_pmd_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_pmds = 1;
> +}
> +
> +static inline void tlb_set_pud_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_puds = 1;
> +}
> +
> +static inline void tlb_set_p4d_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_p4ds = 1;
> +}

Uhm.. when I wrote that patch they were called tlb_flush_p*_range():

  https://lkml.kernel.org/r/20200401122004.GE20713@hirez.programming.kicks-ass.net

Your current naming makes no sense what so ever, we do not "set" the
range.
