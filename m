Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62409 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbaENTIG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:06 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 27/27] xtensa: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:59 +0200
Message-ID: <1400093999-18703-28-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Message-ID: <20140514185959.pvegBLy9j9HrqQADp1JrdvnXCrn_XOw5Ylm63fvmWuk@z>

It is no longer needed to define them on our own.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/xtensa/include/asm/tlb.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/xtensa/include/asm/tlb.h b/arch/xtensa/include/asm/tlb.h
index 0d766f9..09ed867 100644
--- a/arch/xtensa/include/asm/tlb.h
+++ b/arch/xtensa/include/asm/tlb.h
@@ -14,15 +14,7 @@
 #include <asm/cache.h>
 #include <asm/page.h>
 
-#if (DCACHE_WAY_SIZE <= PAGE_SIZE)
-
-/* Note, read http://lkml.org/lkml/2004/1/15/6 */
-
-# define tlb_start_vma(tlb,vma)			do { } while (0)
-# define tlb_end_vma(tlb,vma)			do { } while (0)
-
-#else
-
+#if (DCACHE_WAY_SIZE > PAGE_SIZE)
 # define tlb_start_vma(tlb, vma)					      \
 	do {								      \
 		if (!tlb->fullmm)					      \
@@ -34,14 +26,8 @@
 		if (!tlb->fullmm)					      \
 			flush_tlb_range(vma, vma->vm_start, vma->vm_end);     \
 	} while(0)
-
 #endif
 
-#define __tlb_remove_tlb_entry(tlb,pte,addr)	do { } while (0)
-#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
-
 #endif	/* _XTENSA_TLB_H */
-- 
1.8.4.2

