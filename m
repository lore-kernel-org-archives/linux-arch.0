From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 13/27] m68k: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:45 +0200
Message-ID: <1400093999-18703-14-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
List-Id: linux-arch.vger.kernel.org

It is no longer needed to define them on our own.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/m68k/include/asm/tlb.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/m68k/include/asm/tlb.h b/arch/m68k/include/asm/tlb.h
index 1785cff..74c15f6 100644
--- a/arch/m68k/include/asm/tlb.h
+++ b/arch/m68k/include/asm/tlb.h
@@ -1,19 +1,11 @@
 #ifndef _M68K_TLB_H
 #define _M68K_TLB_H
 
-/*
- * m68k doesn't need any special per-pte or
- * per-vma handling..
- */
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
-
-/*
- * .. because we flush the whole mm when it
- * fills up.
- */
-#define tlb_flush(tlb)		flush_tlb_mm((tlb)->mm)
+#ifdef CONFIG_MMU && !defined(CONFIG_COLDFIRE) && !defined(CONFIG_SUN3)
+/* These defines are needed to override the defaults from asm-generic/tlb.h */
+#define __pte_free_tlb __pte_free_tlb
+#define __pmd_free_tlb __pmd_free_tlb
+#endif
 
 #include <asm-generic/tlb.h>
 
-- 
1.8.4.2
