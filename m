Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:40311 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392645AbfBNVQz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2019 16:16:55 -0500
Received: by mail-it1-f196.google.com with SMTP id i2so18084102ite.5
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 13:16:54 -0800 (PST)
From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH] arm64: mm: enable per pmd page table lock
Date: Thu, 14 Feb 2019 14:16:42 -0700
Message-ID: <20190214211642.2200-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Message-ID: <20190214211642.53qK4VqVlXag-k6QIQhFGHFcJFFOWqIO93xPPJr9qO8@z>

Switch from per mm_struct to per pmd page table lock by enabling
ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
large system.

I'm not sure if there is contention on mm->page_table_lock. Given
the option comes at no cost (apart from initializing more spin
locks), why not enable it now.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 arch/arm64/include/asm/tlb.h     |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..104325a1ffc3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c73bf0..dabba4b2c61f 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -33,12 +33,22 @@
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	struct page *page;
+
+	page = alloc_page(PGALLOC_GFP);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	return page_address(page);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
 	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
+	pgtable_pmd_page_dtor(virt_to_page(pmdp));
 	free_page((unsigned long)pmdp);
 }
 
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 106fdc951b6e..4e3becfed387 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,7 +62,10 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pmdp));
+	struct page *page = virt_to_page(pmdp);
+
+	pgtable_pmd_page_dtor(page);
+	tlb_remove_table(tlb, page);
 }
 #endif
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog
