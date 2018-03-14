Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbeCNIs7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 04:48:59 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
Date: Wed, 14 Mar 2018 14:18:24 +0530
Message-ID: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180314084824.00AH8QQpjJHkYR2lW8M5atn9d6pTkRtbW4ywiNHJLW0@z>

While setting huge page, we need to take care of
previously existing next level mapping. Since,
we are going to overrite previous mapping, the
only reference to next level page table will get
lost and the next level page table will be zombie,
occupying space forever. So, free it before
overriding.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8c704f1..c0df264 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -32,7 +32,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
-
+#include <linux/hugetlb.h>
 #include <asm/barrier.h>
 #include <asm/cputype.h>
 #include <asm/fixmap.h>
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/page.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 		return 0;
 
 	BUG_ON(phys & ~PUD_MASK);
+	if (pud_val(*pud) && !pud_huge(*pud))
+		free_page((unsigned long)__va(pud_val(*pud)));
+
 	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
@@ -953,6 +957,9 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 		return 0;
 
 	BUG_ON(phys & ~PMD_MASK);
+	if (pmd_val(*pmd) && !pmd_huge(*pmd))
+		free_page((unsigned long)__va(pmd_val(*pmd)));
+
 	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
