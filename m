From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 18/20] mm, parisc: Convert parisc to generic tlb
Date: Wed, 27 Jun 2012 23:15:58 +0200
Message-ID: <20120627212831.867208560@chello.nl>
References: <20120627211540.459910855@chello.nl>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline; filename=parisc-mmu_range.patch
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Alex Shi <alex.shi@intel.com>, "Nikunj A. Dadhania" <nikunj@linux.vnet.ibm.com>, Konrad Rzeszutek Wilk <konrad@darnok.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tony Luck <tony.luck@intel.com>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Hans-Christian Egtvedt <hans-christian.egtvedt@>
List-Id: linux-arch.vger.kernel.org

Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: James Bottomley <jejb@parisc-linux.org>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/parisc/Kconfig           |    1 +
 arch/parisc/include/asm/tlb.h |   10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -19,6 +19,7 @@ config PARISC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
+	select HAVE_MMU_GATHER_RANGE
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
--- a/arch/parisc/include/asm/tlb.h
+++ b/arch/parisc/include/asm/tlb.h
@@ -1,16 +1,6 @@
 #ifndef _PARISC_TLB_H
 #define _PARISC_TLB_H
 
-#define tlb_start_vma(tlb, vma) \
-do {	if (!(tlb)->fullmm)	\
-		flush_cache_range(vma, vma->vm_start, vma->vm_end); \
-} while (0)
-
-#define tlb_end_vma(tlb, vma)	\
-do {	if (!(tlb)->fullmm)	\
-		flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
-} while (0)
-
 #define __tlb_remove_tlb_entry(tlb, pte, address) \
 	do { } while (0)
 


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
