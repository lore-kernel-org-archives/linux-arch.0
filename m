Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINWLq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Sep 2018 18:11:46 -0400
Date: Fri, 14 Sep 2018 17:56:43 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 02/11] asm-generic/tlb: Provide
 HAVE_MMU_GATHER_PAGE_SIZE
Message-ID: <20180914165643.GH6236@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.955706111@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913092811.955706111@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180914165643.GXefO9N6FeqPVOPERQ9JqKQhvb0_GcqkLreZsfmxRm4@z>

On Thu, Sep 13, 2018 at 11:21:12AM +0200, Peter Zijlstra wrote:
> Move the mmu_gather::page_size things into the generic code instead of
> powerpc specific bits.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/Kconfig                   |    3 +++
>  arch/arm/include/asm/tlb.h     |    3 +--
>  arch/ia64/include/asm/tlb.h    |    3 +--
>  arch/powerpc/Kconfig           |    1 +
>  arch/powerpc/include/asm/tlb.h |   17 -----------------
>  arch/s390/include/asm/tlb.h    |    4 +---
>  arch/sh/include/asm/tlb.h      |    4 +---
>  arch/um/include/asm/tlb.h      |    4 +---
>  include/asm-generic/tlb.h      |   25 +++++++++++++------------
>  mm/huge_memory.c               |    4 ++--
>  mm/hugetlb.c                   |    2 +-
>  mm/madvise.c                   |    2 +-
>  mm/memory.c                    |    4 ++--
>  mm/mmu_gather.c                |    5 +++++
>  14 files changed, 33 insertions(+), 48 deletions(-)

Looks fine to me, but I hope we can remove this option altogether in future:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
