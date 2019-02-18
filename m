Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:37409 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfBRXNZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 18:13:25 -0500
Received: by mail-it1-f194.google.com with SMTP id z124so1937337itc.2
        for <linux-arch@vger.kernel.org>; Mon, 18 Feb 2019 15:13:25 -0800 (PST)
From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Date: Mon, 18 Feb 2019 16:13:17 -0700
Message-ID: <20190218231319.178224-1-yuzhao@google.com>
In-Reply-To: <20190214211642.2200-1-yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Message-ID: <20190218231317.dAm8k2SZk0yINRVjwDwSZ9U5BdvND4RbNRQJwcLJWEU@z>

For pte page, use pgtable_page_ctor(); for pmd page, use
pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
p4d and pgd), don't use any.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b6f5aa52ac67..fa7351877af3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -98,7 +98,7 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static phys_addr_t __init early_pgtable_alloc(void)
+static phys_addr_t __init early_pgtable_alloc(int shift)
 {
 	phys_addr_t phys;
 	void *ptr;
@@ -173,7 +173,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void),
+				phys_addr_t (*pgtable_alloc)(int),
 				int flags)
 {
 	unsigned long next;
@@ -183,7 +183,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	if (pmd_none(pmd)) {
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
-		pte_phys = pgtable_alloc();
+		pte_phys = pgtable_alloc(PAGE_SHIFT);
 		__pmd_populate(pmdp, pte_phys, PMD_TYPE_TABLE);
 		pmd = READ_ONCE(*pmdp);
 	}
@@ -207,7 +207,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot,
-		     phys_addr_t (*pgtable_alloc)(void), int flags)
+		     phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pmd_t *pmdp;
@@ -245,7 +245,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void), int flags)
+				phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
@@ -257,7 +257,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	if (pud_none(pud)) {
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
-		pmd_phys = pgtable_alloc();
+		pmd_phys = pgtable_alloc(PMD_SHIFT);
 		__pud_populate(pudp, pmd_phys, PUD_TYPE_TABLE);
 		pud = READ_ONCE(*pudp);
 	}
@@ -293,7 +293,7 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 
 static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(void),
+			   phys_addr_t (*pgtable_alloc)(int),
 			   int flags)
 {
 	unsigned long next;
@@ -303,7 +303,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	if (pgd_none(pgd)) {
 		phys_addr_t pud_phys;
 		BUG_ON(!pgtable_alloc);
-		pud_phys = pgtable_alloc();
+		pud_phys = pgtable_alloc(PUD_SHIFT);
 		__pgd_populate(pgdp, pud_phys, PUD_TYPE_TABLE);
 		pgd = READ_ONCE(*pgdp);
 	}
@@ -344,7 +344,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 unsigned long virt, phys_addr_t size,
 				 pgprot_t prot,
-				 phys_addr_t (*pgtable_alloc)(void),
+				 phys_addr_t (*pgtable_alloc)(int),
 				 int flags)
 {
 	unsigned long addr, length, end, next;
@@ -370,11 +370,20 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
-static phys_addr_t pgd_pgtable_alloc(void)
+static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
-	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
-		BUG();
+	BUG_ON(!ptr);
+
+	/*
+	 * Initialize page table locks in case later we need to
+	 * call core mm functions like apply_to_page_range() on
+	 * this pre-allocated page table.
+	 */
+	if (shift == PAGE_SHIFT)
+		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
+	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
+		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));
 
 	/* Ensure the zeroed page is visible to the page table walker */
 	dsb(ishst);
-- 
2.21.0.rc0.258.g878e2cd30e-goog
