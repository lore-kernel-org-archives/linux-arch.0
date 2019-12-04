Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDQmS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 11:42:18 -0500
Date: Wed, 4 Dec 2019 17:41:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191204164143.GB2810@hirez.programming.kicks-ass.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
 <20191204133454.GW2844@hirez.programming.kicks-ass.net>
 <CAMuHMdVnhNFBqPQXKYCQbCnoQjZPSXRkuxbsbaguZ7_TcXXmVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVnhNFBqPQXKYCQbCnoQjZPSXRkuxbsbaguZ7_TcXXmVg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Message-ID: <20191204164143.XM1ckPymahHfvIdJYRe4chH2AvajNOTGfZ5jh7Nn35s@z>

On Wed, Dec 04, 2019 at 04:07:53PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 4, 2019 at 2:35 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Does this fare better?
> 
> Yes. Migo-R is happy again.
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/sh/include/asm/pgalloc.h
> > +++ b/arch/sh/include/asm/pgalloc.h
> > @@ -36,9 +36,7 @@ do {                                                  \
> >  #if CONFIG_PGTABLE_LEVELS > 2
> >  #define __pmd_free_tlb(tlb, pmdp, addr)                        \
> >  do {                                                   \
> > -       struct page *page = virt_to_page(pmdp);         \
> > -       pgtable_pmd_page_dtor(page);                    \
> > -       tlb_remove_page((tlb), page);                   \
> > +       pmd_free((tlb)->mm, (pmdp));                    \
> >  } while (0);
> >  #endif

OK, so I was going to write a Changelog to go with that, but then I
realized that while this works and is similar to before the patch, I'm
not sure this is in fact correct.

With this on (and also before) we're freeing the PMD before we've done
the TLB invalidate, that seems wrong!

Looking at the size of that pmd_cache, that looks to be 30-(12+12-3)+3
== 12, which is exactly 1 page, for PAGE_SIZE_4K, less for the larger
pages.

I'm thinking perhaps we should do something like the below instead?


---
 arch/sh/mm/pgtable.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 5c8f9247c3c2..fac7e822fd0c 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -5,9 +5,6 @@
 #define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
 
 static struct kmem_cache *pgd_cachep;
-#if PAGETABLE_LEVELS > 2
-static struct kmem_cache *pmd_cachep;
-#endif
 
 void pgd_ctor(void *x)
 {
@@ -23,11 +20,6 @@ void pgtable_cache_init(void)
 	pgd_cachep = kmem_cache_create("pgd_cache",
 				       PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
 				       PAGE_SIZE, SLAB_PANIC, pgd_ctor);
-#if PAGETABLE_LEVELS > 2
-	pmd_cachep = kmem_cache_create("pmd_cache",
-				       PTRS_PER_PMD * (1<<PTE_MAGNITUDE),
-				       PAGE_SIZE, SLAB_PANIC, NULL);
-#endif
 }
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
@@ -48,11 +40,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
-}
-
-void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	kmem_cache_free(pmd_cachep, pmd);
+	BUILD_BUG_ON(PTRS_PER_PMD * (1<<PTE_MAGNITUDE) <= PAGE_SIZE);
+	return (pmd_t *)__get_free_page(PGALLOC_GFP);
 }
 #endif /* PAGETABLE_LEVELS > 2 */
