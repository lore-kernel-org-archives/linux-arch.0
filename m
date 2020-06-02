From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v4 3/6] arm64: Add tlbi_user_level TLB invalidation helper
Date: Tue, 2 Jun 2020 21:58:33 +0800
Message-ID: <20200602135836.1620-4-yezhenyu2@huawei.com>
References: <20200602135836.1620-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:5770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbgFBN7N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jun 2020 09:59:13 -0400
In-Reply-To: <20200602135836.1620-1-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

Add a level-hinted parameter to __tlbi_user, which only gets used
if ARMv8.4-TTL gets detected.

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated.

This patch set the default level value of flush_tlb_range() to 0,
which will be updated in future patches.  And set the ttl value of
flush_tlb_page_nosync() to 3 because it is only called to flush a
single pte page.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 8adbd6fd8489..bfb58e62c127 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -88,6 +88,12 @@
 	__tlbi(op,  arg);					\
 } while (0)
 
+#define __tlbi_user_level(op, arg, level) do {				\
+	if (arm64_kernel_unmapped_at_el0())				\
+		__tlbi_level(op, (arg | USER_ASID_FLAG), level);	\
+} while (0)
+
+
 /*
  *	TLB Invalidation
  *	================
@@ -189,8 +195,9 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
 
 	dsb(ishst);
-	__tlbi(vale1is, addr);
-	__tlbi_user(vale1is, addr);
+	/* This function is only called on a small page */
+	__tlbi_level(vale1is, addr, 3);
+	__tlbi_user_level(vale1is, addr, 3);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -230,11 +237,11 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	dsb(ishst);
 	for (addr = start; addr < end; addr += stride) {
 		if (last_level) {
-			__tlbi(vale1is, addr);
-			__tlbi_user(vale1is, addr);
+			__tlbi_level(vale1is, addr, 0);
+			__tlbi_user_level(vale1is, addr, 0);
 		} else {
-			__tlbi(vae1is, addr);
-			__tlbi_user(vae1is, addr);
+			__tlbi_level(vae1is, addr, 0);
+			__tlbi_user_level(vae1is, addr, 0);
 		}
 	}
 	dsb(ish);
-- 
2.19.1
