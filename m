From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 05/17] asm-generic/tlb: Rename HAVE_RCU_TABLE_NO_INVALIDATE
Date: Wed, 11 Dec 2019 13:07:18 +0100
Message-ID: <20191211122955.940455408@infradead.org>
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
 arch/Kconfig              |    3 ++-
 arch/powerpc/Kconfig      |    2 +-
 arch/sparc/Kconfig        |    2 +-
 include/asm-generic/tlb.h |    2 +-
 mm/mmu_gather.c           |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -396,8 +396,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
 config MMU_GATHER_RCU_TABLE_FREE
 	bool
 
-config HAVE_RCU_TABLE_NO_INVALIDATE
+config MMU_GATHER_NO_TABLE_INVALIDATE
 	bool
+	depends on MMU_GATHER_RCU_TABLE_FREE
 
 config HAVE_MMU_GATHER_PAGE_SIZE
 	bool
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,7 +223,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if SMP
-	select HAVE_RCU_TABLE_NO_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_NO_TABLE_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -65,7 +65,7 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select MMU_GATHER_RCU_TABLE_FREE if SMP
-	select HAVE_RCU_TABLE_NO_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_NO_TABLE_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -137,7 +137,7 @@
  *  When used, an architecture is expected to provide __tlb_remove_table()
  *  which does the actual freeing of these pages.
  *
- *  HAVE_RCU_TABLE_NO_INVALIDATE
+ *  MMU_GATHER_NO_TABLE_INVALIDATE
  *
  *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
  *  freeing the page-table pages. This can be avoided if you use
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -102,7 +102,7 @@ bool __tlb_remove_page_size(struct mmu_g
  */
 static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 {
-#ifndef CONFIG_HAVE_RCU_TABLE_NO_INVALIDATE
+#ifndef CONFIG_MMU_GATHER_NO_TABLE_INVALIDATE
 	/*
 	 * Invalidate page-table caches used by hardware walkers. Then we still
 	 * need to RCU-sched wait while freeing the pages because software
