From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 03/27] generic/tlb.h: Move common defines into generic tlb.h
Date: Wed, 14 May 2014 20:59:35 +0200
Message-ID: <1400093999-18703-4-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62412 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbaENTIG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:06 -0400
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>

Move most common defines into the generic tlb.h to avoid
duplicate code.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/asm-generic/tlb.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 5672d7e..6e15413 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -149,6 +149,30 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 #define __tlb_remove_pmd_tlb_entry(tlb, pmdp, address) do {} while (0)
 #endif
 
+#ifndef tlb_start_vma
+#define tlb_start_vma(tlb, vma) do {} while (0)
+#endif
+
+#ifndef tlb_end_vma
+#define tlb_end_vma(tlb, vma) do {} while (0)
+#endif
+
+#ifndef __tlb_remove_tlb_entry
+#define __tlb_remove_tlb_entry(tlb, ptep, address) do {} while (0)
+#endif
+
+#ifndef tlb_flush
+#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
+#endif
+
+#ifndef __pte_free_tlb
+#define __pte_free_tlb(tlb, pte, address) pte_free((tlb)->mm, pte)
+#endif
+
+#ifndef __pmd_free_tlb
+#define __pmd_free_tlb(tlb, pmd, address) pmd_free((tlb)->mm, pmd)
+#endif
+
 #define tlb_remove_pmd_tlb_entry(tlb, pmdp, address)		\
 	do {							\
 		tlb->need_flush = 1;				\
-- 
1.8.4.2
