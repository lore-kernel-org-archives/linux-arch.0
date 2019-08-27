Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbfH0NSk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:40 -0400
From: Will Deacon <will@kernel.org>
Subject: [PATCH 3/6] arm64: mm: Add ISB instruction to set_pgd()
Date: Tue, 27 Aug 2019 14:18:15 +0100
Message-ID: <20190827131818.14724-4-will@kernel.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
References: <20190827131818.14724-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190827131815.tPIEcor6SoFPtvSLLvM2au1YL82E3R5XFsFoMsUEYoE@z>

Commit 6a4cbd63c25a ("Revert "arm64: Remove unnecessary ISBs from
set_{pte,pmd,pud}"") reintroduced ISB instructions to some of our
page table setter functions in light of a recent clarification to the
Armv8 architecture. Although 'set_pgd()' isn't currently used to update
a live page table, add the ISB instruction there too for consistency
with the other macros and to provide some future-proofing if we use it
on live tables in the future.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index feda7294320c..2faa77635942 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -605,6 +605,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 
 	WRITE_ONCE(*pgdp, pgd);
 	dsb(ishst);
+	isb();
 }
 
 static inline void pgd_clear(pgd_t *pgdp)
-- 
2.11.0
