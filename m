From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v4 6/6] arm64: tlb: Set the TTL field in flush_*_tlb_range
Date: Tue, 2 Jun 2020 21:58:36 +0800
Message-ID: <20200602135836.1620-7-yezhenyu2@huawei.com>
References: <20200602135836.1620-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:54148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbgFBN7S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jun 2020 09:59:18 -0400
In-Reply-To: <20200602135836.1620-1-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

This patch implement flush_{pmd|pud}_tlb_range() in arm64 by
calling __flush_tlb_range() with the corresponding stride and
tlb_level values.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 538c85e62f86..bc59814eda64 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -40,6 +40,16 @@ extern void __pmd_error(const char *file, int line, unsigned long val);
 extern void __pud_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+
+/* Set stride and tlb_level in flush_*_tlb_range */
+#define flush_pmd_tlb_range(vma, addr, end)	\
+	__flush_tlb_range(vma, addr, end, PMD_SIZE, false, 2)
+#define flush_pud_tlb_range(vma, addr, end)	\
+	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
-- 
2.19.1
