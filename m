From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 16/18] asm-generic/tlb: Remove HAVE_GENERIC_MMU_GATHER
Date: Wed, 26 Sep 2018 13:36:39 +0200
Message-ID: <20180926114801.366086396@infradead.org>
References: <20180926113623.863696043@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
List-Id: linux-arch.vger.kernel.org

Since all architectures are now using it, it is redundant.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    1 -
 mm/mmu_gather.c           |    4 ----
 2 files changed, 5 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -139,7 +139,6 @@
  *  page-tables natively.
  *
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
