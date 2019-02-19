Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55580 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbfBSKdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 05:33:16 -0500
Message-ID: <20190219103233.810881730@infradead.org>
Date: Tue, 19 Feb 2019 11:32:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 16/18] asm-generic/tlb: Remove HAVE_GENERIC_MMU_GATHER
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20190219103204.jmE2sH_AgEUa_Vwr5v2Ccw_EilM8lHge-0oCjYtcYVU@z>

Since all architectures are now using it, it is redundant.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    1 -
 mm/mmu_gather.c           |    4 ----
 2 files changed, 5 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -142,7 +142,6 @@
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
  */
-#define HAVE_GENERIC_MMU_GATHER
 
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 /*
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -11,8 +11,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
-#ifdef HAVE_GENERIC_MMU_GATHER
-
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 
 static bool tlb_next_batch(struct mmu_gather *tlb)
@@ -109,8 +107,6 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	tlb_flush_mmu_free(tlb);
 }
 
-#endif /* HAVE_GENERIC_MMU_GATHER */
-
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 
 /*
