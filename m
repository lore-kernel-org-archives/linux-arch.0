Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f202.google.com ([209.85.166.202]:38071 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfCLA6J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Mar 2019 20:58:09 -0400
Received: by mail-it1-f202.google.com with SMTP id r136so807799ith.3
        for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2019 17:58:09 -0700 (PDT)
Date: Mon, 11 Mar 2019 18:57:49 -0600
In-Reply-To: <20190312005749.30166-1-yuzhao@google.com>
Message-ID: <20190312005749.30166-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20190310011906.254635-1-yuzhao@google.com> <20190312005749.30166-1-yuzhao@google.com>
Subject: [PATCH v4 4/4] arm64: mm: enable per pmd page table lock
From: Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Message-ID: <20190312005749.nj0jRUqxmZ0vqlS0uiYg0P8-XcpIagHu4nW0ilYALQs@z>

Switch from per mm_struct to per pmd page table lock by enabling
ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
large system.

I'm not sure if there is contention on mm->page_table_lock. Given
the option comes at no cost (apart from initializing more spin
locks), why not enable it now.

We only do so when pmd is not folded, so we don't mistakenly call
pgtable_pmd_page_ctor() on pud or p4d in pgd_pgtable_alloc().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 arch/arm64/include/asm/tlb.h     |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cfbf307d6dc4..a3b1b789f766 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y if PGTABLE_LEVELS > 2
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
2.21.0.360.g471c308f928-goog
