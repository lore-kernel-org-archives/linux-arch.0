From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 13/15] mm, parisc: Convert parisc to generic tlb
Date: Mon, 07 Mar 2011 18:14:03 +0100
Message-ID: <20110307172207.377641805@chello.nl>
References: <20110307171350.989666626@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=parisc-mmu_range.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Russell King <rmk@arm.linux.org.uk>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Kyle McMartin <kyle@mcmartin.ca>, James Bottomley <jejb@parisc-linux.org>
List-Id: linux-arch.vger.kernel.org

Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: James Bottomley <jejb@parisc-linux.org>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/parisc/Kconfig           |    1 +
 arch/parisc/include/asm/tlb.h |   10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6/arch/parisc/Kconfig
===================================================================
--- linux-2.6.orig/arch/parisc/Kconfig
+++ linux-2.6/arch/parisc/Kconfig
@@ -17,6 +17,7 @@ config PARISC
 	select IRQ_PER_CPU
 	select GENERIC_HARDIRQS_NO_DEPRECATED
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select HAVE_MMU_GATHER_RANGE
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
Index: linux-2.6/arch/parisc/include/asm/tlb.h
===================================================================
--- linux-2.6.orig/arch/parisc/include/asm/tlb.h
+++ linux-2.6/arch/parisc/include/asm/tlb.h
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
 
