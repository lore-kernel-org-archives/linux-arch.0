From: Chen Gang <chengang@emindsoft.com.cn>
Subject: [PATCH trivial] include/asm-generic/tlb.h: Notice about the coding
 style
Date: Sun, 13 Dec 2015 17:06:15 +0800
Message-ID: <566D3507.9050204@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail113-251.mail.alibaba.com ([205.204.113.251]:38278 "EHLO
	us-alimail-mta1.hst.scl.en.alidc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751210AbbLMJJr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Dec 2015 04:09:47 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, trivial@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Gang <gang.chen.5i5j@gmail.com>, chenwei@emindsoft.com.cn


Notice about 80 columns.

Notice about function parameter alignment.

Append 'UL' to hard code numbers which are related with the unsigned
long variables.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 include/asm-generic/tlb.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 9dbb739..3fc72bd 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -111,10 +111,11 @@ struct mmu_gather {
 
 #define HAVE_GENERIC_MMU_GATHER
 
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm, unsigned long start, unsigned long end);
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+		    unsigned long start, unsigned long end);
 void tlb_flush_mmu(struct mmu_gather *tlb);
 void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start,
-							unsigned long end);
+		    unsigned long end);
 int __tlb_remove_page(struct mmu_gather *tlb, struct page *page);
 
 /* tlb_remove_page
@@ -137,10 +138,10 @@ static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 static inline void __tlb_reset_range(struct mmu_gather *tlb)
 {
 	if (tlb->fullmm) {
-		tlb->start = tlb->end = ~0;
+		tlb->start = tlb->end = ~0UL;
 	} else {
 		tlb->start = TASK_SIZE;
-		tlb->end = 0;
+		tlb->end = 0UL;
 	}
 }
 
-- 
1.9.3
