Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:3223 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbXHBJNw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2007 05:13:52 -0400
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 4/4] vmemmap ppc64: convert VMM_* macros to a real function
References: <exportbomb.1186045945@pinky>
Message-Id: <E1IGWwO-0002Yc-8h@hellhawk.shadowen.org>
Date: Thu, 02 Aug 2007 10:25:56 +0100
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>


The code to convert an address within the vmemmap to the start of the
section is currently implemented using macros.  Convert these over to
a new helper function, clarifying the code and gaining type checking.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 arch/powerpc/mm/init_64.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 49c9f7c..05c7e93 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -185,14 +185,19 @@ void pgtable_cache_init(void)
 #ifdef CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP
 
 /*
- * Convert an address within the vmemmap into a pfn.  Note that we have
- * to do this by hand as the proffered address may not be correctly aligned.
+ * Given an address within the vmemmap, determine the pfn of the page that
+ * represents the start of the section it is within.  Note that we have to
+ * do this by hand as the proffered address may not be correctly aligned.
  * Subtraction of non-aligned pointers produces undefined results.
  */
-#define VMM_SECTION(addr) \
-		(((((unsigned long)(addr)) - ((unsigned long)(vmemmap))) / \
-		sizeof(struct page)) >> PFN_SECTION_SHIFT)
-#define VMM_SECTION_PAGE(addr)	(VMM_SECTION(addr) << PFN_SECTION_SHIFT)
+unsigned long __meminit vmemmap_section_start(struct page *page)
+{
+	unsigned long offset = ((unsigned long)page) -
+						((unsigned long)(vmemmap));
+
+	/* Return the pfn of the start of the section. */
+	return (offset / sizeof(struct page)) & PAGE_SECTION_MASK;
+}
 
 /*
  * Check if this vmemmap page is already initialised.  If any section
@@ -204,7 +209,7 @@ int __meminit vmemmap_populated(unsigned long start, int page_size)
 	unsigned long end = start + page_size;
 
 	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
-		if (pfn_valid(VMM_SECTION_PAGE(start)))
+		if (pfn_valid(vmemmap_section_start(start)))
 			return 1;
 
 	return 0;
