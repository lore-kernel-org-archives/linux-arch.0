From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v1] arm64: tlb: don't set the ttl value in flush_tlb_page_nosync
Date: Fri, 10 Jul 2020 17:41:58 +0800
Message-ID: <20200710094158.468-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbgGJJm0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 05:42:26 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will@kernel.org
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com

flush_tlb_page_nosync() may be called from pmd level, so we
can not set the ttl = 3 here.

The callstack is as follows:

	pmdp_set_access_flags
		ptep_set_access_flags
			flush_tlb_fix_spurious_fault
				flush_tlb_page
					flush_tlb_page_nosync

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: e735b98a5fe0 ("arm64: Add tlbi_user_level TLB invalidation helper")
Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index edfec8139ef8..7528c84a94ef 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -252,9 +252,8 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
 
 	dsb(ishst);
-	/* This function is only called on a small page */
-	__tlbi_level(vale1is, addr, 3);
-	__tlbi_user_level(vale1is, addr, 3);
+	__tlbi(vale1is, addr);
+	__tlbi_user(vale1is, addr);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
-- 
2.19.1
