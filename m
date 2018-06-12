Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34407 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbeFLHQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jun 2018 03:16:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so11616145pfl.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Jun 2018 00:16:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with precise TLB ranges in mmu_gather
Date: Tue, 12 Jun 2018 17:16:21 +1000
Message-ID: <20180612071621.26775-4-npiggin@gmail.com>
In-Reply-To: <20180612071621.26775-1-npiggin@gmail.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nadav Amit <nadav.amit@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180612071621.bjaHBi2ajsPQ_6ggyeV17XbjnPnac8Z2HQd0O-TBE08@z>

Use the page_start and page_end fields of mmu_gather to implement more
precise TLB flushing. (start, end) covers the entire TLB and page
table range that has been invalidated, for architectures that do not
have explicit page walk cache management. page_start and page_end are
just for ranges that may have TLB entries.

A tlb_flush may have no pages in this range, but still requires PWC
to be flushed. That is handled properly.

This brings the number of tlbiel instructions required by a kernel
compile from 33M to 25M, most avoided from exec->shift_arg_pages.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 67a6e86d3e7e..06452ad701cf 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -853,8 +853,11 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 		else
 			radix__flush_all_mm(mm);
 	} else {
-		unsigned long start = tlb->start;
-		unsigned long end = tlb->end;
+		unsigned long start = tlb->page_start;
+		unsigned long end = tlb->page_end;
+
+		if (end < start)
+			end = start;
 
 		if (!tlb->need_flush_all)
 			radix__flush_tlb_range_psize(mm, start, end, psize);
-- 
2.17.0
