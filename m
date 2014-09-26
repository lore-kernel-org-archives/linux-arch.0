From: Steve Capper <steve.capper@linaro.org>
Subject: [PATCH V4 5/6] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
Date: Fri, 26 Sep 2014 15:03:52 +0100
Message-ID: <1411740233-28038-6-git-send-email-steve.capper@linaro.org>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:53618 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbaIZOER (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Sep 2014 10:04:17 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so1236583wgh.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Sep 2014 07:04:16 -0700 (PDT)
In-Reply-To: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com, Steve Capper <steve.capper@linaro.org>

In order to implement fast_get_user_pages we need to ensure that the
page table walker is protected from page table pages being freed from
under it.

This patch enables HAVE_RCU_TABLE_FREE, any page table pages belonging
to address spaces with multiple users will be call_rcu_sched freed.
Meaning that disabling interrupts will block the free and protect the
fast gup page walker.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
Tested-by: Dann Frazier <dann.frazier@canonical.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/tlb.h | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a..ce9062b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -54,6 +54,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 62731ef..a82c0c5 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -23,6 +23,20 @@
 
 #include <asm-generic/tlb.h>
 
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+
+#define tlb_remove_entry(tlb, entry)	tlb_remove_table(tlb, entry)
+static inline void __tlb_remove_table(void *_table)
+{
+	free_page_and_swap_cache((struct page *)_table);
+}
+#else
+#define tlb_remove_entry(tlb, entry)	tlb_remove_page(tlb, entry)
+#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+
 /*
  * There's three ways the TLB shootdown code is used:
  *  1. Unmapping a range of vmas.  See zap_page_range(), unmap_region().
@@ -88,7 +102,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	pgtable_page_dtor(pte);
 	tlb_add_flush(tlb, addr);
-	tlb_remove_page(tlb, pte);
+	tlb_remove_entry(tlb, pte);
 }
 
 #if CONFIG_ARM64_PGTABLE_LEVELS > 2
@@ -96,7 +110,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
 	tlb_add_flush(tlb, addr);
-	tlb_remove_page(tlb, virt_to_page(pmdp));
+	tlb_remove_entry(tlb, virt_to_page(pmdp));
 }
 #endif
 
@@ -105,7 +119,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
 	tlb_add_flush(tlb, addr);
-	tlb_remove_page(tlb, virt_to_page(pudp));
+	tlb_remove_entry(tlb, virt_to_page(pudp));
 }
 #endif
 
-- 
1.9.3
