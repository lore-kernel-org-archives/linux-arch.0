Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38535 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbaH1Op1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Aug 2014 10:45:27 -0400
Received: by mail-wi0-f179.google.com with SMTP id q5so1028463wiv.6
        for <linux-arch@vger.kernel.org>; Thu, 28 Aug 2014 07:45:25 -0700 (PDT)
From: Steve Capper <steve.capper@linaro.org>
Subject: [PATCH V3 2/6] arm: mm: Introduce special ptes for LPAE
Date: Thu, 28 Aug 2014 15:45:03 +0100
Message-ID: <1409237107-24228-3-git-send-email-steve.capper@linaro.org>
In-Reply-To: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
References: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, Steve Capper <steve.capper@linaro.org>
Message-ID: <20140828144503.zJwbDrIPt1qJz8a_U6Jnv6OJlJdZvOtX9Xe0aomSOKU@z>

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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h | 2 ++
 arch/arm/include/asm/pgtable-3level.h | 7 +++++++
 arch/arm/include/asm/pgtable.h        | 6 ++----
 3 files changed, 11 insertions(+), 4 deletions(-)

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
index 06e0bc0..16122d4 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -213,6 +213,13 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_isclear(pmd, val)	(!(pmd_val(pmd) & (val)))
 
 #define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
+#define pte_special(pte)	(pte_isset((pte), L_PTE_SPECIAL))
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	pte_val(pte) |= L_PTE_SPECIAL;
+	return pte;
+}
+#define	__HAVE_ARCH_PTE_SPECIAL
 
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 01baef0..90aa4583 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -226,7 +226,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
 #define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
 #define pte_exec(pte)		(pte_isclear((pte), L_PTE_XN))
-#define pte_special(pte)	(0)
 
 #define pte_valid_user(pte)	\
 	(pte_valid(pte) && pte_isset((pte), L_PTE_USER) && pte_young(pte))
@@ -245,7 +244,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long ext = 0;
 
 	if (addr < TASK_SIZE && pte_valid_user(pteval)) {
-		__sync_icache_dcache(pteval);
+		if (!pte_special(pteval))
+			__sync_icache_dcache(pteval);
 		ext |= PTE_EXT_NG;
 	}
 
@@ -264,8 +264,6 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 PTE_BIT_FUNC(mkexec,   &= ~L_PTE_XN);
 PTE_BIT_FUNC(mknexec,   |= L_PTE_XN);
 
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
-- 
1.9.3

