Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:2223 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbXGMNcS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 09:32:18 -0400
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/7] sparsemem: clean up spelling error in comments
References: <exportbomb.1184333503@pinky>
Message-Id: <E1I9LIZ-00006Q-HD@hellhawk.shadowen.org>
Date: Fri, 13 Jul 2007 14:35:07 +0100
Sender: linux-arch-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>


Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Acked-by: Mel Gorman <mel@csn.ul.ie>
---
diff --git a/mm/sparse.c b/mm/sparse.c
index b2327e0..ec6ead6 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -101,7 +101,7 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
 
 /*
  * Although written for the SPARSEMEM_EXTREME case, this happens
- * to also work for the flat array case becase
+ * to also work for the flat array case because
  * NR_SECTION_ROOTS==NR_MEM_SECTIONS.
  */
 int __section_nr(struct mem_section* ms)
