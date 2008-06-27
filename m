From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 02/20] mm: generic show_mem()
Date: Fri, 27 Jun 2008 13:53:51 +0200
Message-ID: <20080627120048.059732179@saeurebad.de>
References: <20080627115349.743368154@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38993 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760428AbYF0MFQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 08:05:16 -0400
Content-Disposition: inline; filename=0003-generic-show_mem.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

This implements a platform-independent version of show_mem().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
---
 mm/Kconfig      |    3 +++
 mm/page_alloc.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -45,6 +45,7 @@
 #include <linux/fault-inject.h>
 #include <linux/page-isolation.h>
 #include <linux/memcontrol.h>
+#include <linux/nmi.h>
 #include <linux/debugobjects.h>
 
 #include <asm/tlbflush.h>
@@ -2042,6 +2043,60 @@ static void zoneref_set_zone(struct zone
 	zoneref->zone_idx = zone_idx(zone);
 }
 
+#ifdef CONFIG_HAVE_GENERIC_SHOW_MEM
+void show_mem(void)
+{
+	pg_data_t *pgdat;
+	int total = 0, reserved = 0, shared = 0, nonshared = 0, highmem = 0;
+
+	printk(KERN_INFO "Mem-Info:\n");
+	show_free_areas();
+
+	for_each_online_pgdat(pgdat) {
+		unsigned long i, flags;
+
+		pgdat_resize_lock(pgdat, &flags);
+		for (i = 0; i < pgdat->node_spanned_pages; i++) {
+			struct page *page;
+			unsigned long pfn = pgdat->node_start_pfn + i;
+
+			if (unlikely((i % MAX_ORDER_NR_PAGES) == 0))
+				touch_nmi_watchdog();
+
+			if (!pfn_valid(pfn))
+				continue;
+
+			page = pfn_to_page(pfn);
+
+			if (PageHighMem(page))
+				highmem++;
+
+			if (PageReserved(page))
+				reserved++;
+			else if (page_count(page) == 1)
+				nonshared++;
+			else if (page_count(page) > 1)
+				shared += page_count(page) - 1;
+
+			total++;
+		}
+		pgdat_resize_unlock(pgdat, &flags);
+	}
+
+	printk(KERN_INFO "%d pages RAM\n", total);
+#ifdef CONFIG_HIGHMEM
+	printk(KERN_INFO "%d pages HighMem\n", highmem);
+#endif
+	printk(KERN_INFO "%d pages reserved\n", reserved);
+	printk(KERN_INFO "%d pages shared\n", shared);
+	printk(KERN_INFO "%d pages non-shared\n", nonshared);
+#ifdef CONFIG_QUICKLIST
+	printk(KERN_INFO "%d pages in pagetable cache\n",
+		quicklist_total_size());
+#endif
+}
+#endif /* CONFIG_HAVE_GENERIC_SHOW_MEM */
+
 /*
  * Builds allocation fallback zone lists.
  *
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -213,6 +213,9 @@ config VIRT_TO_BUS
 config PAGE_WALKER
 	def_bool n
 
+config HAVE_GENERIC_SHOW_MEM
+	def_bool n
+
 config UNEVICTABLE_LRU
 	bool "Add LRU list to track non-evictable pages"
 	default y

-- 
