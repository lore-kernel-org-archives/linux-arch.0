Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:3194 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbXHBJMu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2007 05:12:50 -0400
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/4] vmemmap: remove excess debugging
References: <exportbomb.1186045945@pinky>
Message-Id: <E1IGWvO-0002XN-6q@hellhawk.shadowen.org>
Date: Thu, 02 Aug 2007 10:24:54 +0100
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>


Outputting each and every PTE as it is loaded is somewhat overkill
zap this debug.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Acked-by: Mel Gorman <mel@csn.ul.ie>
---
 mm/sparse.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)
diff --git a/mm/sparse.c b/mm/sparse.c
index 7dcea95..76316d4 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -340,9 +340,6 @@ static int __meminit vmemmap_populate_pte(pmd_t *pmd, unsigned long addr,
 			entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
 			set_pte(pte, entry);
 
-			printk(KERN_DEBUG "[%lx-%lx] PTE ->%p on node %d\n",
-				addr, addr + PAGE_SIZE - 1, p, node);
-
 		} else
 			vmemmap_verify(pte, node, addr + PAGE_SIZE, end);
 
