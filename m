From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 1/4] asm/tlbflush: Add flush_tlb_pgtable() for ARM64
Date: Thu, 15 Mar 2018 18:15:03 +0530
Message-ID: <1521117906-20107-2-git-send-email-cpandya@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

ARM64 MMU implements invalidation of TLB for
intermediate page tables for perticular VA. This
may or may not be available for other arch. So,
provide this API hook only for ARM64, for now.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/include/asm/tlbflush.h | 5 +++++
 include/asm-generic/tlb.h         | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 9e82dd7..5f656f0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -209,6 +209,11 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 	dsb(ish);
 }
 
+static inline void flush_tlb_pgtable(struct mm_struct *mm,
+				       unsigned long uaddr)
+{
+	__flush_tlb_pgtable(mm, uaddr);
+}
 #endif
 
 #endif
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index faddde4..7832c0a 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -295,4 +295,10 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 
 #define tlb_migrate_finish(mm) do {} while (0)
 
+#ifndef CONFIG_ARM64
+static inline void flush_tlb_pgtable(struct mm_struct *mm,
+					unsigned long uaddr)
+{
+}
+#endif
 #endif /* _ASM_GENERIC__TLB_H */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
