From: Will Deacon <will@kernel.org>
Subject: [PATCH 2/6] arm64: tlb: Ensure we execute an ISB following walk cache invalidation
Date: Tue, 27 Aug 2019 14:18:14 +0100
Message-ID: <20190827131818.14724-3-will@kernel.org>
References: <20190827131818.14724-1-will@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

05f2d2f83b5a ("arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable")
added a new TLB invalidation helper which is used when freeing
intermediate levels of page table used for kernel mappings, but is
missing the required ISB instruction after completion of the TLBI
instruction.

Add the missing barrier.

Cc: <stable@vger.kernel.org>
Fixes: 05f2d2f83b5a ("arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable")
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 8af7a85f76bd..bc3949064725 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -251,6 +251,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 	dsb(ishst);
 	__tlbi(vaae1is, addr);
 	dsb(ish);
+	isb();
 }
 #endif
 
-- 
2.11.0
