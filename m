From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v9 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
Date: Mon, 30 Apr 2018 13:11:34 +0530
Message-ID: <1525074094-25839-5-git-send-email-cpandya@codeaurora.org>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Philip Elcan <pelcan@codeaurora.org>, James Morse <james.morse@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

This commit 15122ee2c515a ("arm64: Enforce BBM for huge
IO/VMAP mappings") is a temporary work-around until the
issues with CONFIG_HAVE_ARCH_HUGE_VMAP gets fixed.

Revert this change as we have fixes for the issue.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0f651db..170009b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -935,10 +935,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pud_present(READ_ONCE(*pudp)))
-		return 0;
-
 	BUG_ON(phys & ~PUD_MASK);
 	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
@@ -949,10 +945,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pmd_present(READ_ONCE(*pmdp)))
-		return 0;
-
 	BUG_ON(phys & ~PMD_MASK);
 	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
