Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfLKMbm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:42 -0500
Message-ID: <20191211122956.572325873@infradead.org>
Date: Wed, 11 Dec 2019 13:07:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 16/17] nds32/tlb: Fix __p*_free_tlb()
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20191211120729.DtbAsgFiTgDWRdNJxOHqjjjBC8x4-d2SLyUKaFqrooY@z>

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

Even though NDS32 is UP only, we still need to observe this order
because mmu_gather is preemptible.

NDS32 does not in fact have PMDs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/nds32/include/asm/tlb.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -6,7 +6,12 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_table((tlb), (pte));		\
+} while (0)
+
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tln)->mm, pmd)
 
 #endif
