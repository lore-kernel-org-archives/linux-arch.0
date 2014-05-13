From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [RFC PATCH V5 4/6] arm: mm: Enable RCU fast_gup
Date: Tue, 13 May 2014 11:31:24 -0400
Message-ID: <53723ACC.7020500@codeaurora.org>
References: <1399390209-1756-1-git-send-email-steve.capper@linaro.org> <1399390209-1756-5-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1399390209-1756-5-git-send-email-steve.capper@linaro.org>
Sender: owner-linux-mm@kvack.org
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, anders.roxell@linaro.org, peterz@infradead.org, gary.robertson@linaro.org, will.deacon@arm.com, akpm@linux-foundation.org, christoffer.dall@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Steve,

On 05/06/2014 11:30 AM, Steve Capper wrote:
> Activate the RCU fast_gup for ARM. We also need to force THP splits to
> broadcast an IPI s.t. we block in the fast_gup page walker. As THP
> splits are comparatively rare, this should not lead to a noticeable
> performance degradation.

> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 3387e60..91a2b59 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -377,3 +377,22 @@ void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned l
>  	 */
>  	__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
>  }
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifdef CONFIG_HAVE_RCU_TABLE_FREE

This is trivia, but I for one find the form #if defined(a) && defined(b)
easier to read. (Applies to the A64 version as well).

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
