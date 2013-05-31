From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 2/2] mm: tlb_fast_mode check missing in tlb_finish_mmu()
Date: Fri, 31 May 2013 16:23:50 +0530
Message-ID: <1369997630-6522-3-git-send-email-vgupta@synopsys.com>
References: <1369997630-6522-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:52106 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab3EaK5N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2013 06:57:13 -0400
In-Reply-To: <1369997630-6522-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>, Rik van Riel <riel@redhat.com>, David Rientjes <rientjes@google.com>, Peter Zijlstra <peterz@infradead.org>

This removes some unused generated code for tlb_fast_mode() == true

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org <linux-arch@vger.kernel.org>
---
 mm/memory.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index d9d5fd9..569ffe1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -269,6 +269,9 @@ void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long e
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
 
+	if (tlb_fast_mode(tlb))
+		return;
+
 	for (batch = tlb->local.next; batch; batch = next) {
 		next = batch->next;
 		free_pages((unsigned long)batch, 0);
-- 
1.7.10.4
