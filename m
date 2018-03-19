From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v3 2/3] arm64: Implement page table free interfaces
Date: Mon, 19 Mar 2018 18:10:55 +0530
Message-ID: <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

Implement pud_free_pmd_page() and pmd_free_pte_page().

Implementation requires,
 1) Freeing of the un-used next level page tables
 2) Clearing off the current pud/pmd entry
 3) Invalidate TLB which could have previously
    valid but not stale entry

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index da98828..c70f139 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/tlbflush.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -975,10 +976,35 @@ int pmd_clear_huge(pmd_t *pmdp)
 
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
-	return pud_none(*pud);
+	pmd_t *pmd;
+	int i;
+
+	pmd = __va(pud_val(*pud));
+	if (pud_val(*pud)) {
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE));
+
+		free_page((unsigned long) pmd);
+		pud_clear(pud);
+		flush_tlb_kernel_range(addr, addr + PUD_SIZE);
+	}
+	return 1;
 }
 
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
-	return pmd_none(*pmd);
+	if (pmd_val(*pmd)) {
+		free_page((unsigned long)__va(pmd_val(*pmd)));
+
+		pmd_clear(pmd);
+		/*
+		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
+		 *        ideal candidate here, which exactly
+		 *        flushes intermediate pgtables. But,
+		 *        this is broken (evident from tests).
+		 *        So, use safe TLB op unless that is fixed.
+		 */
+		flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	}
+	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
