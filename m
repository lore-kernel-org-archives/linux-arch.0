Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLDNfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 08:35:20 -0500
Date: Wed, 4 Dec 2019 14:34:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191204133454.GW2844@hirez.programming.kicks-ass.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Message-ID: <20191204133454.FAINcjB3UFFucEnKfJ01ya4OsxRaNMyifkeYf8s8hlo@z>

On Wed, Dec 04, 2019 at 01:32:58PM +0100, Geert Uytterhoeven wrote:

> > Does the below help?
> 
> Unfortunately not.
> 
> > diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> > index 22d968bfe9bb..73a2c00de6c5 100644
> > --- a/arch/sh/include/asm/pgalloc.h
> > +++ b/arch/sh/include/asm/pgalloc.h
> > @@ -36,9 +36,8 @@ do {                                                  \
> >  #if CONFIG_PGTABLE_LEVELS > 2
> >  #define __pmd_free_tlb(tlb, pmdp, addr)                        \
> >  do {                                                   \
> > -       struct page *page = virt_to_page(pmdp);         \
> > -       pgtable_pmd_page_dtor(page);                    \
> > -       tlb_remove_page((tlb), page);                   \
> > +       pgtable_pmd_page_dtor(pmdp);                    \
> 
> expected ‘struct page *’ but argument is of type ‘pmd_t * {aka struct
> <anonymous> *}’
> 
> > +       tlb_remove_page((tlb), (pmdp));                 \
> 
> likewise

Duh.. clearly I misplaced my SH cross compiler. Let me go find it.

Also, looking at pgtable.c the pmd_t* actually comes from a kmemcach()
and should probably use pmd_free() (which is what the old code did too).

Also, since SH doesn't have ARCH_ENABLE_SPLIT_PMD_PTLOCK, it will never
need pgtable_pmd_page_dtor().

The below seems to build se7722_defconfig using sh4-linux-. That is, the
build fails, on 'node_reclaim_distance', not pgtable stuff.

Does this fare better?

---
 arch/sh/include/asm/pgalloc.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 22d968bfe9bb..c910e5bcde62 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -36,9 +36,7 @@ do {							\
 #if CONFIG_PGTABLE_LEVELS > 2
 #define __pmd_free_tlb(tlb, pmdp, addr)			\
 do {							\
-	struct page *page = virt_to_page(pmdp);		\
-	pgtable_pmd_page_dtor(page);			\
-	tlb_remove_page((tlb), page);			\
+	pmd_free((tlb)->mm, (pmdp));			\
 } while (0);
 #endif
 
