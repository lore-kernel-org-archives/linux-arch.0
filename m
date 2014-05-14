From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 06/27] avr32: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:38 +0200
Message-ID: <1400093999-18703-7-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-arch.vger.kernel.org

It is no longer needed to define them on our own.

Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/avr32/include/asm/tlb.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/avr32/include/asm/tlb.h b/arch/avr32/include/asm/tlb.h
index 5c55f9c..2e5601d 100644
--- a/arch/avr32/include/asm/tlb.h
+++ b/arch/avr32/include/asm/tlb.h
@@ -14,13 +14,6 @@
 #define tlb_end_vma(tlb, vma) \
 	flush_tlb_range(vma, vma->vm_start, vma->vm_end)
 
-#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while(0)
-
-/*
- * Flush whole TLB for MM
- */
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 /*
-- 
1.8.4.2
