From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
Date: Mon, 20 Apr 2020 14:10:55 +0200
Message-ID: <20200420121055.GF20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-7-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200403090048.938-7-yezhenyu2@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, linux-mm@kvack.org, guohanjun@huawei.com, will@kernel.org, linux-arch@vger.kernel.org, yuzhao@google.com, maz@kernel.org, steven.price@arm.com, arm@kernel.org, Dave.Martin@arm.com, arnd@arndb.de, suzuki.poulose@arm.com, npiggin@gmail.com, zhangshaokun@hisilicon.com, broonie@kernel.org, rostedt@goodmis.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com, linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
