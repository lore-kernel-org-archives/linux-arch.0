From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 07/17] asm-generic/tlb: Rename HAVE_MMU_GATHER_NO_GATHER
Date: Wed, 11 Dec 2019 13:07:20 +0100
Message-ID: <20191211122956.055418242@infradead.org>
References: <20191211120713.360281197@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-arch.vger.kernel.org

Towards a more consistent naming scheme.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig              |    2 +-
 arch/s390/Kconfig         |    2 +-
 include/asm-generic/tlb.h |   14 ++++++++++++--
 mm/mmu_gather.c           |   10 +++++-----
 4 files changed, 19 insertions(+), 9 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -406,7 +406,7 @@ config MMU_GATHER_PAGE_SIZE
 config MMU_GATHER_NO_RANGE
 	bool
 
-config HAVE_MMU_GATHER_NO_GATHER
+config MMU_GATHER_NO_GATHER
 	bool
 
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -162,7 +162,7 @@ config S390
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
-	select HAVE_MMU_GATHER_NO_GATHER
+	select MMU_GATHER_NO_GATHER
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -147,6 +147,16 @@
  *  MMU_GATHER_NO_RANGE
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
+ *
+ *  MMU_GATHER_NO_GATHER
+ *
+ *  If the option is set the mmu_gather will not track individual pages for
+ *  delayed page free anymore. A platform that enables the option needs to
+ *  provide its own implementation of the __tlb_remove_page_size() function to
+ *  free pages.
+ *
+ *  This is useful if your architecture already flushes TLB entries in the
+ *  various ptep_get_and_clear() functions.
  */
 
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
@@ -191,7 +201,7 @@ extern void tlb_remove_table(struct mmu_
 
 #endif
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
  * If we can't allocate a page to make a big batch of page pointers
  * to work on, then just handle a few from the on-stack structure.
@@ -266,7 +276,7 @@ struct mmu_gather {
 
 	unsigned int		batch_count;
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -11,7 +11,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 
 static bool tlb_next_batch(struct mmu_gather *tlb)
 {
@@ -89,7 +89,7 @@ bool __tlb_remove_page_size(struct mmu_g
 	return false;
 }
 
-#endif /* HAVE_MMU_GATHER_NO_GATHER */
+#endif /* MMU_GATHER_NO_GATHER */
 
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 
@@ -180,7 +180,7 @@ static void tlb_flush_mmu_free(struct mm
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
 #endif
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_pages_flush(tlb);
 #endif
 }
@@ -211,7 +211,7 @@ void tlb_gather_mmu(struct mmu_gather *t
 	/* Is it from 0 to ~0? */
 	tlb->fullmm     = !(start | (end+1));
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb->need_flush_all = 0;
 	tlb->local.next = NULL;
 	tlb->local.nr   = 0;
@@ -271,7 +271,7 @@ void tlb_finish_mmu(struct mmu_gather *t
 
 	tlb_flush_mmu(tlb);
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_list_free(tlb);
 #endif
 	dec_tlb_flush_pending(tlb->mm);
