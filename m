Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62428 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaENTIL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:11 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 02/27] powerpc: Override defaults from generic/tlb.h
Date: Wed, 14 May 2014 20:59:34 +0200
Message-ID: <1400093999-18703-3-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20140514185934.oq-oYr47oNoakOn9hI_Of_6EzXo6FMuPiNOhtVzWsbA@z>

Make sure to not conflict with the defaults provided
by generic/tlb.h.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/powerpc/include/asm/pgalloc.h | 1 -
 arch/powerpc/include/asm/tlb.h     | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index e9a9f60..5fddba7 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -3,7 +3,6 @@
 #ifdef __KERNEL__
 
 #include <linux/mm.h>
-#include <asm-generic/tlb.h>
 
 #ifdef CONFIG_PPC_BOOK3E
 extern void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address);
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index e2b428b..392e5ef 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -30,6 +30,10 @@
 
 extern void tlb_flush(struct mmu_gather *tlb);
 
+/* These defines are needed to override the defaults from asm-generic/tlb.h */
+#define tlb_flush tlb_flush
+#define __tlb_remove_tlb_entry __tlb_remove_tlb_entry
+
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
-- 
1.8.4.2

