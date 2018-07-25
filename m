Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43482 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeGYRFO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2018 13:05:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so5589416pgr.10
        for <linux-arch@vger.kernel.org>; Wed, 25 Jul 2018 08:52:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 1/4] mm: munmap optimise single threaded page freeing
Date: Thu, 26 Jul 2018 01:52:43 +1000
Message-Id: <20180725155246.1085-2-npiggin@gmail.com>
In-Reply-To: <20180725155246.1085-1-npiggin@gmail.com>
References: <20180725155246.1085-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org

In case a single threaded process is zapping its own mappings, there
should be no concurrent memory accesses through the TLBs, and so it
is safe to free pages immediately rather than batch them up.
---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 135d18b31e44..773d588b371d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -296,6 +296,15 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 	VM_BUG_ON(!tlb->end);
 	VM_WARN_ON(tlb->page_size != page_size);
 
+	/*
+	 * When this is our mm and there are no other users, there can not be
+	 * a concurrent memory access.
+	 */
+	if (current->mm == tlb->mm && atomic_read(&tlb->mm->mm_users) < 2) {
+		free_page_and_swap_cache(page);
+		return false;
+	}
+
 	batch = tlb->active;
 	/*
 	 * Add the page and check if we are full. If so
-- 
2.17.0
