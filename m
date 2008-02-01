Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pip23.gyao.ne.jp ([125.63.38.249]:54134 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762677AbYBAAKg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 31 Jan 2008 19:10:36 -0500
Date: Fri, 1 Feb 2008 09:09:17 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: asm-generic/tlb.h and check_pgt_cache()
Message-ID: <20080201000917.GD16399@linux-sh.org>
References: <20080131125425.7e91b54d@dhcp-252-066.norway.atmel.com> <20080131130328.GA29209@cs181133002.pp.htv.fi> <47A1F7C5.3020108@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47A1F7C5.3020108@goop.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Adrian Bunk <bunk@kernel.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, David Brownell <david-b@pacbell.net>, Jeff Dike <jdike@addtoit.com>

On Thu, Jan 31, 2008 at 08:31:01AM -0800, Jeremy Fitzhardinge wrote:
> Anyway, sorry about the breakage.  There's a cyclic dependency between 
> asm-generic/tlb.h and asm/pgalloc.h, since __*_free_tlb (often) uses 
> tlb_remove_page().
> 
> From the look of it:
> avr32 - no-op check_pgt_list
> sh - uses quicklist_*, and defines QUICK_* (unique among architectures)
> blackfin - how does this break? asm-blackfin/pgalloc.h is more or less no-op
> m32r - no-op check_pgt_list
> um - no-op check_pgt_list
> 
> I'm guessing in blackfin's case, the breakage is some indirect 
> dependency on asm-blackfin/pgalloc.h via asm/tlb.h->asm-generic/tlb.h 
> rather than a specific check_pgt_list() problem.  Adrian, is that 
> right?  That should be fixable by putting #include <asm/pgalloc.h> in 
> the appropriate places.
> 
> um also has a fairly simply pgalloc.h with no dependency on 
> asm-generic/tlb.h, so I assume the breakage there is also the result of 
> an indirect pgalloc.h dependency.
> 
> For avr32 and m32r there should be no problem in moving the no-op 
> check_pgt_list() definition to somewhere else, like asm-*/pgtable.h.
> 
> The only tricky case seems to be sh.  That needs a bit more thought.
> 
Yes, sh has the __pte_free_tlb() wrapping to tlb_remove_page(), but there
is nothing directly in asm/pgalloc.h that depends on __pte_free_tlb(), so
maybe the easiest solution is to just have asm/pgalloc.h included by
asm/tlb.h for the check_pgt_cache() def and move __pte_free_tlb() in to
asm/tlb.h directly. One could argue that the __x_free_tlb() routines make
more sense in asm/tlb.h just in terms of namespace anyways.

It's a bit ugly, but if sh is the odd one out here I can live with it.
This seems to work out ok at least..

---

 include/asm-sh/pgalloc.h |    4 ----
 include/asm-sh/tlb.h     |    7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/asm-sh/pgalloc.h b/include/asm-sh/pgalloc.h
index 18b613c..f3b2e56 100644
--- a/include/asm-sh/pgalloc.h
+++ b/include/asm-sh/pgalloc.h
@@ -64,15 +64,11 @@ static inline void pte_free(struct page *pte)
 	quicklist_free_page(QUICK_PT, NULL, pte);
 }
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
-
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
  * inside the pgd, so has no extra memory associated with it.
  */
-
 #define pmd_free(x)			do { } while (0)
-#define __pmd_free_tlb(tlb,x)		do { } while (0)
 
 static inline void check_pgt_cache(void)
 {
diff --git a/include/asm-sh/tlb.h b/include/asm-sh/tlb.h
index 56ad1fb..6f3eda5 100644
--- a/include/asm-sh/tlb.h
+++ b/include/asm-sh/tlb.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_SH_TLB_H
 #define __ASM_SH_TLB_H
 
+#include <asm/pgalloc.h>
+
 #ifdef CONFIG_SUPERH64
 # include "tlb_64.h"
 #endif
@@ -18,9 +20,12 @@
 /*
  * Flush whole TLBs for MM
  */
-#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
+#define tlb_flush(tlb)			flush_tlb_mm((tlb)->mm)
 
 #include <asm-generic/tlb.h>
 
+#define __pte_free_tlb(tlb,pte)		tlb_remove_page((tlb),(pte))
+#define __pmd_free_tlb(tlb,x)		do { } while (0)
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_SH_TLB_H */
