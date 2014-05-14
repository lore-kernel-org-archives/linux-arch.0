Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62409 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbaENTNH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:13:07 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 20/27] powerpc: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:52 +0200
Message-ID: <1400093999-18703-21-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20140514185952.n5Ai63unR61AKp9J_RpJjnZ7F5JttO1GgEZTJpB_k0k@z>

It is no longer needed to define them on our own.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/powerpc/include/asm/tlb.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 392e5ef..bdea7f5 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -25,9 +25,6 @@
 
 #include <linux/pagemap.h>
 
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-
 extern void tlb_flush(struct mmu_gather *tlb);
 
 /* These defines are needed to override the defaults from asm-generic/tlb.h */
-- 
1.8.4.2

