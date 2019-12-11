From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/17] asm-generic/tlb: Rename HAVE_MMU_GATHER_PAGE_SIZE
Date: Wed, 11 Dec 2019 13:07:19 +0100
Message-ID: <20191211122955.997638865@infradead.org>
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
 arch/powerpc/Kconfig      |    2 +-
 include/asm-generic/tlb.h |    9 ++++++---
 mm/mmu_gather.c           |    4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -400,7 +400,7 @@ config MMU_GATHER_NO_TABLE_INVALIDATE
 	bool
 	depends on MMU_GATHER_RCU_TABLE_FREE
 
-config HAVE_MMU_GATHER_PAGE_SIZE
+config MMU_GATHER_PAGE_SIZE
 	bool
 
 config MMU_GATHER_NO_RANGE
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -224,7 +224,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if SMP
 	select MMU_GATHER_NO_TABLE_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
-	select HAVE_MMU_GATHER_PAGE_SIZE
+	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -121,11 +121,14 @@
  *
  * Additionally there are a few opt-in features:
  *
- *  HAVE_MMU_GATHER_PAGE_SIZE
+ *  MMU_GATHER_PAGE_SIZE
  *
  *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
  *  changes the size and provides mmu_gather::page_size to tlb_flush().
  *
+ *  This might be useful if your architecture has size specific TLB
+ *  invalidation instructions.
+ *
  *  MMU_GATHER_RCU_TABLE_FREE
  *
  *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
@@ -271,7 +274,7 @@ struct mmu_gather {
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
 
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
 #endif
@@ -422,7 +425,7 @@ static inline void tlb_remove_page(struc
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	if (tlb->page_size && tlb->page_size != page_size) {
 		if (!tlb->fullmm && !tlb->need_flush_all)
 			tlb_flush_mmu(tlb);
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -69,7 +69,7 @@ bool __tlb_remove_page_size(struct mmu_g
 
 	VM_BUG_ON(!tlb->end);
 
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	VM_WARN_ON(tlb->page_size != page_size);
 #endif
 
@@ -223,7 +223,7 @@ void tlb_gather_mmu(struct mmu_gather *t
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb->batch = NULL;
 #endif
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
 #endif
 
