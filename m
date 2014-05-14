Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62416 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbaENTII (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:08 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 16/27] mips: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:48 +0200
Message-ID: <1400093999-18703-17-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Ralf Baechle <ralf@linux-mips.org>, John Crispin <blogic@openwrt.org>, Markos Chandras <markos.chandras@imgtec.com>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, linux-mips@linux-mips.org
Message-ID: <20140514185948.xUmSwx7lZHxLianxg4LIQJethrwS2VL83ELN4fO6q-M@z>

It is no longer needed to define them on our own.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/mips/include/asm/tlb.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
index 4a23493..5ea43ca 100644
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -10,13 +10,6 @@
 		if (!tlb->fullmm)				\
 			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
 	}  while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
-
-/*
- * .. because we flush the whole mm when it fills up.
- */
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
 #define UNIQUE_ENTRYHI(idx)						\
 		((CKSEG0 + ((idx) << (PAGE_SHIFT + 1))) |		\
-- 
1.8.4.2

