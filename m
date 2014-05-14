From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 25/27] unicore32: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:57 +0200
Message-ID: <1400093999-18703-26-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

It is no longer needed to define them on our own.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/unicore32/include/asm/tlb.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/unicore32/include/asm/tlb.h b/arch/unicore32/include/asm/tlb.h
index 9cca15c..e6ba38a 100644
--- a/arch/unicore32/include/asm/tlb.h
+++ b/arch/unicore32/include/asm/tlb.h
@@ -12,11 +12,6 @@
 #ifndef __UNICORE_TLB_H__
 #define __UNICORE_TLB_H__
 
-#define tlb_start_vma(tlb, vma)				do { } while (0)
-#define tlb_end_vma(tlb, vma)				do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
-
 #define __pte_free_tlb(tlb, pte, addr)				\
 	do {							\
 		pgtable_page_dtor(pte);				\
-- 
1.8.4.2
