Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62418 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbaENTIK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:10 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 09/27] cris: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:41 +0200
Message-ID: <1400093999-18703-10-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com
Message-ID: <20140514185941.mgsCXtEvIhChrU-4h5rc4RyfreCQ_BXDQEL5rkSD-BE@z>

It is no longer needed to define them on our own.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-cris-kernel@axis.com
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/cris/include/asm/tlb.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/cris/include/asm/tlb.h b/arch/cris/include/asm/tlb.h
index 77384ea..4cc840f 100644
--- a/arch/cris/include/asm/tlb.h
+++ b/arch/cris/include/asm/tlb.h
@@ -2,18 +2,7 @@
 #define _CRIS_TLB_H
 
 #include <linux/pagemap.h>
-
 #include <arch/tlb.h>
-
-/*
- * cris doesn't need any special per-pte or
- * per-vma handling..
- */
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
-
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 #include <asm-generic/tlb.h>
 
 #endif
-- 
1.8.4.2

