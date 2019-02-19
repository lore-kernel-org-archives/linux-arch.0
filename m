Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfBSMrn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 07:47:43 -0500
Date: Tue, 19 Feb 2019 12:47:38 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20190219124738.GD8501@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.207580251@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103233.207580251@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20190219124738.vCESpajuF1YG_slbgE_yES1pejWWlglpWIEtofy6CqY@z>

On Tue, Feb 19, 2019 at 11:31:54AM +0100, Peter Zijlstra wrote:
> Needed for ia64 -- alternatively we drop the entire hook.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/tlb.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -539,6 +539,8 @@ static inline void tlb_end_vma(struct mm
>  
>  #endif /* CONFIG_MMU */
>  
> +#ifndef tlb_migrate_finish
>  #define tlb_migrate_finish(mm) do {} while (0)
> +#endif

Fine for now, but I agree that we should drop the hook altogether. AFAICT,
this only exists to help an ia64 optimisation which looks suspicious to
me since it uses:

    mm == current->active_mm && atomic_read(&mm->mm_users) == 1

to identify a "single-threaded fork()" and therefore perform only local TLB
invalidation. Even if this was the right thing to do, it's not clear to me
that tlb_migrate_finish() is called on the right CPU anyway.

So I'd be keen to remove this hook before it spreads, but in the meantime:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
