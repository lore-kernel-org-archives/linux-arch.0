From: Steve Capper <steve.capper@linaro.org>
Subject: [PATCH 2/6] arm: mm: Introduce special ptes for LPAE
Date: Wed, 25 Jun 2014 16:40:20 +0100
Message-ID: <1403710824-24340-3-git-send-email-steve.capper@linaro.org>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44446 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbaFYPkk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jun 2014 11:40:40 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so2297372wes.19
        for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2014 08:40:39 -0700 (PDT)
In-Reply-To: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, Steve Capper <steve.capper@linaro.org>

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
 arch/arm/include/asm/pgtable-2level.h | 2 ++
 arch/arm/include/asm/pgtable-3level.h | 8 ++++++++
 arch/arm/include/asm/pgtable.h        | 6 ++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 219ac88..f027941 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -182,6 +182,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
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
index 5478e5d..63b1db2 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -222,7 +222,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
-#define pte_special(pte)	(0)
 
 #define pte_valid_user(pte)	\
 	(pte_valid(pte) && (pte_val(pte) & L_PTE_USER) && pte_young(pte))
@@ -241,7 +240,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long ext = 0;
 
 	if (addr < TASK_SIZE && pte_valid_user(pteval)) {
-		__sync_icache_dcache(pteval);
+		if (!pte_special(pteval))
+			__sync_icache_dcache(pteval);
 		ext |= PTE_EXT_NG;
 	}
 
@@ -260,8 +260,6 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 PTE_BIT_FUNC(mkexec,   &= ~L_PTE_XN);
 PTE_BIT_FUNC(mknexec,   |= L_PTE_XN);
 
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
-- 
1.9.3
