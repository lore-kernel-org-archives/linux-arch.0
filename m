Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeIZSHk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Sep 2018 14:07:40 -0400
Message-ID: <20180926114800.822722731@infradead.org>
Date: Wed, 26 Sep 2018 13:36:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/18] asm-generic/tlb: Conditionally provide tlb_migrate_finish()
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20180926113629.hqLDqPYrsmBFGhje1qNcjjbLxLlGuUukCWFf_eKt9pI@z>

Needed for ia64 -- alternatively we drop the entire hook.

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -539,6 +539,8 @@ static inline void tlb_end_vma(struct mm
 
 #endif /* CONFIG_MMU */
 
+#ifndef tlb_migrate_finish
 #define tlb_migrate_finish(mm) do {} while (0)
+#endif
 
 #endif /* _ASM_GENERIC__TLB_H */
