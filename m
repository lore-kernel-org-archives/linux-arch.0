From: Steve Capper <steve.capper@linaro.org>
Subject: [RFC PATCH V4 2/7] arm: mm: Introduce special ptes for LPAE
Date: Fri, 28 Mar 2014 15:01:27 +0000
Message-ID: <1396018892-6773-3-git-send-email-steve.capper@linaro.org>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:32971 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaC1PBo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Mar 2014 11:01:44 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so854205wiv.15
        for <linux-arch@vger.kernel.org>; Fri, 28 Mar 2014 08:01:43 -0700 (PDT)
In-Reply-To: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: peterz@infradead.org, gary.robertson@linaro.org, anders.roxell@linaro.org, akpm@linux-foundation.org, Steve Capper <steve.capper@linaro.org>

We need a mechanism to tag ptes as being special, this indicates that
no attempt should be made to access the underlying struct page *
associated with the pte. This is used by the fast_gup when operating on
ptes as it has no means to access VMAs (that also contain this
information) locklessly.

The L_PTE_SPECIAL bit is already allocated for LPAE, this patch modifies
pte_special and pte_mkspecial to make use of it, and defines
__HAVE_ARCH_PTE_SPECIAL.

This patch also excludes special ptes from the icache/dcache sync logic.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changed in V4: set_pte_at will not perform an icache sync for special
ptes.
---
 arch/arm/include/asm/pgtable-2level.h | 2 ++
 arch/arm/include/asm/pgtable-3level.h | 8 ++++++++
 arch/arm/include/asm/pgtable.h        | 6 ++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index dfff709..26d1742 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -181,6 +181,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_addr_end(addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
+#define pte_special(pte)	(0)
+static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 /*
  * We don't have huge page support for short descriptors, for the moment
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 85c60ad..b286ba9 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -207,6 +207,14 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
 #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
 
+#define pte_special(pte)	(!!(pte_val(pte) & L_PTE_SPECIAL))
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	pte_val(pte) |= L_PTE_SPECIAL;
+	return pte;
+}
+#define	__HAVE_ARCH_PTE_SPECIAL
+
 #define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
 
 #define __HAVE_ARCH_PMD_WRITE
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 7d59b52..e6139e3 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -220,7 +220,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
-#define pte_special(pte)	(0)
 
 #define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
 
@@ -238,7 +237,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long ext = 0;
 
 	if (addr < TASK_SIZE && pte_present_user(pteval)) {
-		__sync_icache_dcache(pteval);
+		if (!pte_special(pteval))
+			__sync_icache_dcache(pteval);
 		ext |= PTE_EXT_NG;
 	}
 
@@ -257,8 +257,6 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 PTE_BIT_FUNC(mkexec,   &= ~L_PTE_XN);
 PTE_BIT_FUNC(mknexec,   |= L_PTE_XN);
 
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
-- 
1.8.1.4
