From: Steve Capper <steve.capper@linaro.org>
Subject: [PATCH 4/6] arm: mm: Enable RCU fast_gup
Date: Wed, 25 Jun 2014 16:40:22 +0100
Message-ID: <1403710824-24340-5-git-send-email-steve.capper@linaro.org>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37122 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757331AbaFYPkq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jun 2014 11:40:46 -0400
Received: by mail-wi0-f175.google.com with SMTP id r20so8229865wiv.8
        for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2014 08:40:42 -0700 (PDT)
In-Reply-To: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, Steve Capper <steve.capper@linaro.org>

Activate the RCU fast_gup for ARM. We also need to force THP splits to
broadcast an IPI s.t. we block in the fast_gup page walker. As THP
splits are comparatively rare, this should not lead to a noticeable
performance degradation.

Some pre-requisite functions pud_write and pud_page are also added.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/Kconfig                      |  4 ++++
 arch/arm/include/asm/pgtable-3level.h |  8 ++++++++
 arch/arm/mm/flush.c                   | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 888bc8a..6d86ff6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1712,6 +1712,10 @@ config ARCH_SELECT_MEMORY_MODEL
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
+config HAVE_RCU_GUP
+	def_bool y
+	depends on ARM_LPAE
+
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index b286ba9..fa8dcb2 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -219,6 +219,8 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
+#define pud_write(pud)		(0)
+#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
@@ -226,6 +228,12 @@ static inline pte_t pte_mkspecial(pte_t pte)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
 #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
+
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
+void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp);
+#endif
 #endif
 
 #define PMD_BIT_FUNC(fn,op) \
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 43d54f5..9422820 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -400,3 +400,22 @@ void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned l
 	 */
 	__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
 }
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+static void thp_splitting_flush_sync(void *arg)
+{
+}
+
+void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp)
+{
+	pmd_t pmd = pmd_mksplitting(*pmdp);
+	VM_BUG_ON(address & ~PMD_MASK);
+	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
+
+	/* dummy IPI to serialise against fast_gup */
+	smp_call_function(thp_splitting_flush_sync, NULL, 1);
+}
+#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
1.9.3
