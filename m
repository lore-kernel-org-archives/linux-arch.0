Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfLLJbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 04:31:20 -0500
Date: Thu, 12 Dec 2019 10:30:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 08/17] asm-generic/tlb: Provide MMU_GATHER_TABLE_FREE
Message-ID: <20191212093055.GT2827@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211122956.112607298@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20191212093055.kH37wP9DM55GKXtpaRsgeRP1rxSaMEXnNLtyMPsfAT8@z>

On Wed, Dec 11, 2019 at 01:07:21PM +0100, Peter Zijlstra wrote:
> @@ -56,6 +56,15 @@
>   *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
>   *    there's large holes between the VMAs.
>   *
> + *  - tlb_remove_table()
> + *
> + *    tlb_remove_table() is the basic primitive to free page-table directories
> + *    (__p*_free_tlb()).  In it's most primitive form it is an alias for
> + *    tlb_remove_page() below, for when page directories are pages and have no
> + *    additional constraints.
> + *
> + *    See also MMU_GATHER_TABLE_FREE and MMU_GATHER_RCU_TABLE_FREE.
> + *
>   *  - tlb_remove_page() / __tlb_remove_page()
>   *  - tlb_remove_page_size() / __tlb_remove_page_size()
>   *

> @@ -202,7 +193,16 @@ struct mmu_table_batch {
>  
>  extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>  
> -#endif
> +#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
> +
> +/*
> + * Without either HAVE_TABLE_FREE || CONFIG_HAVE_RCU_TABLE_FREE the
> + * architecture is assumed to have page based page directories and
> + * we can use the normal page batching to free them.
> + */
> +#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
> +
> +#endif /* CONFIG_MMU_GATHER_TABLE_FREE */

The build robot kindly notified me that this breaks ARM because it does
the exact same #define for the same reason.

(and I noticed the comment is stale)

I'll post a new version of this patch with the below delta.

---
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -37,10 +37,6 @@ static inline void __tlb_remove_table(vo
 
 #include <asm-generic/tlb.h>
 
-#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-#define tlb_remove_table(tlb, entry) tlb_remove_page(tlb, entry)
-#endif
-
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -196,9 +196,8 @@ extern void tlb_remove_table(struct mmu_
 #else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
 
 /*
- * Without either HAVE_TABLE_FREE || CONFIG_HAVE_RCU_TABLE_FREE the
- * architecture is assumed to have page based page directories and
- * we can use the normal page batching to free them.
+ * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
+ * page directories and we can use the normal page batching to free them.
  */
 #define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
 
