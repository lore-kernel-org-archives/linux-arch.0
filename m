From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 4/9] asm-gemeric/tlb: Remove stray function declarations
Date: Tue, 14 Jan 2020 15:31:40 +0530
Message-ID: <20200114100145.365527-5-aneesh.kumar@linux.ibm.com>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANKCY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 05:02:24 -0500
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>

From: Peter Zijlstra <peterz@infradead.org>

We removed the actual functions a while ago.

Fixes: 1808d65b55e4 ("asm-generic/tlb: Remove arch_tlb*_mmu()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/asm-generic/tlb.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b36b3bef5661..1a4cea5f95df 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -285,11 +285,7 @@ struct mmu_gather {
 #endif
 };
 
-void arch_tlb_gather_mmu(struct mmu_gather *tlb,
-	struct mm_struct *mm, unsigned long start, unsigned long end);
 void tlb_flush_mmu(struct mmu_gather *tlb);
-void arch_tlb_finish_mmu(struct mmu_gather *tlb,
-			 unsigned long start, unsigned long end, bool force);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address,
-- 
2.24.1
