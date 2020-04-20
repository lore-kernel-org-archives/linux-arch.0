Return-Path: <SRS0=EpiA=6E=kvack.org=owner-linux-mm@kernel.org>
Date: Mon, 20 Apr 2020 14:10:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
Message-ID: <20200420121055.GF20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-7-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090048.938-7-yezhenyu2@huawei.com>
Sender: owner-linux-mm@kvack.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200420121055.TQv44Otnphc0SKmbCgx9c1y8Xk2V08_-xM3S13dCXUY@z>

On Fri, Apr 03, 2020 at 05:00:48PM +0800, Zhenyu Ye wrote:
> This patch uses the cleared_* in struct mmu_gather to set the
> TTL field in flush_tlb_range().
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/tlb.h      | 26 +++++++++++++++++++++++++-
>  arch/arm64/include/asm/tlbflush.h | 14 ++++++++------
>  2 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index b76df828e6b7..d5ab72eccff4 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -21,11 +21,34 @@ static void tlb_flush(struct mmu_gather *tlb);
>  
>  #include <asm-generic/tlb.h>
>  
> +/*
> + * get the tlbi levels in arm64.  Default value is 0 if more than one
> + * of cleared_* is set or neither is set.
> + * Arm64 doesn't support p4ds now.
> + */
> +static inline int tlb_get_level(struct mmu_gather *tlb)
> +{
> +	int sum = tlb->cleared_ptes + tlb->cleared_pmds +
> +		  tlb->cleared_puds + tlb->cleared_p4ds;
> +
> +	if (sum != 1)
> +		return 0;
> +	else if (tlb->cleared_ptes)
> +		return 3;
> +	else if (tlb->cleared_pmds)
> +		return 2;
> +	else if (tlb->cleared_puds)
> +		return 1;
> +
> +	return 0;
> +}

That's some mighty wonky code. Please look at the generated asm.
