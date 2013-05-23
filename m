Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33921 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab3EWRIS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2013 13:08:18 -0400
Received: by mail-wi0-f175.google.com with SMTP id hn14so4706137wib.14
        for <linux-arch@vger.kernel.org>; Thu, 23 May 2013 10:08:17 -0700 (PDT)
From: Steve Capper <steve.capper@linaro.org>
Subject: [PATCH 05/11] mm: thp: Correct the HPAGE_PMD_ORDER check.
Date: Thu, 23 May 2013 18:07:52 +0100
Message-ID: <1369328878-11706-6-git-send-email-steve.capper@linaro.org>
In-Reply-To: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, patches@linaro.org, Steve Capper <steve.capper@linaro.org>
Message-ID: <20130523170752.Ms9KgCNPxwhrmHZhSJnOSP7ys8f1XUkBGIc21QfmLU8@z>

All Transparent Huge Pages are allocated by the buddy allocator.

A compile time check is in place that fails when the order of a
transparent huge page is too large to be allocated by the buddy
allocator. Unfortunately that compile time check passes when:
HPAGE_PMD_ORDER == MAX_ORDER
( which is incorrect as the buddy allocator can only allocate
memory of order strictly less than MAX_ORDER. )

This patch updates the compile time check to fail in the above
case.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 include/linux/huge_mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 528454c..26ee56c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -123,7 +123,7 @@ extern void __split_huge_page_pmd(struct vm_area_struct *vma,
 	} while (0)
 extern void split_huge_page_pmd_mm(struct mm_struct *mm, unsigned long address,
 		pmd_t *pmd);
-#if HPAGE_PMD_ORDER > MAX_ORDER
+#if HPAGE_PMD_ORDER >= MAX_ORDER
 #error "hugepages can't be allocated by the buddy allocator"
 #endif
 extern int hugepage_madvise(struct vm_area_struct *vma,
-- 
1.8.1.4

