Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9626 "EHLO huawei.com"
 rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP id S1729486AbgAPDOM
 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 22:14:12 -0500
From: Xuefeng Wang <wxf.wang@hisilicon.com>
Subject: [PATCH 2/2] arm64: mm: rework the pmd protect changing flow
Date: Thu, 16 Jan 2020 11:09:17 +0800
Message-ID: <1579144157-7736-3-git-send-email-wxf.wang@hisilicon.com>
In-Reply-To: <1579144157-7736-1-git-send-email-wxf.wang@hisilicon.com>
References: <1579144157-7736-1-git-send-email-wxf.wang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, chenzhou10@huawei.com
Message-ID: <20200116030917.LNpJ_XisAWbxojbnpdUhf5bnj3yBq4GaTCcFo1cCsBs@z>

On KunPeng920 board. When changing permission of a large range region,
pmdp_invalidate() takes about 65% in profile (with hugepages) in JIT tool.
Kernel will flush tlb twice: first flush happens in pmdp_invalidate, second
flush happens at the end of change_protect_range(). The first pmdp_invalidate
is not necessary if the hardware support atomic pmdp changing. The atomic
changing pimd to zero can prevent the hardware from update asynchronous.
So reconstruct it and remove the first pmdp_invalidate. And the second tlb
flush can make sure the new tlb entry valid.

Add pmdp_modify_prot_start() in arm64, which uses pmdp_huge_get_and_clear()
to fetch the pmd and zero entry, preventing racing of any hardware updates.

After rework, the mprotect can get 3~13 times performace gain in range
64M to 512M.

4K granule/THP on
memory size(M)	64	128	256	320	448	512
pre-patch		0.77	1.40	2.64	3.23	4.49	5.10
post-patch		0.20	0.23	0.28	0.31	0.37	0.39

Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/include/asm/pgtable.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index cd5de0e40bfa..bccdaa5bd5f2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -769,6 +769,20 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */

+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_PMDP_MODIFY_PROT_TRANSACTION
+static inline pmd_t pmdp_modify_prot_start(struct vm_area_struct *vma,
+						unsigned long addr,
+						pmd_t *pmdp)
+{
+	/*
+	 * Atomic change pmd to zero, prevent the hardware from update
+	 * aynchronously update it.
+	 */
+	return pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * ptep_set_wrprotect - mark read-only while trasferring potential hardware
  * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
-- 
2.17.1
