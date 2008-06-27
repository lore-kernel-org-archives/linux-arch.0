From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 02/20 fixed] mm: generic show_mem()
Date: Fri, 27 Jun 2008 23:17:06 +0200
Message-ID: <87od5mwpbh.fsf_-_@skyscraper.fehenstaub.lan>
References: <20080627115349.743368154@saeurebad.de>
	<20080627120048.059732179@saeurebad.de>
	<20080627144329.GA7634@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:43953 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381AbYF0VRl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 17:17:41 -0400
In-Reply-To: <20080627144329.GA7634@osiris.ibm.com> (Heiko Carstens's message
	of "Fri, 27 Jun 2008 16:43:30 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

This implements a platform-independent version of show_mem().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
---
 mm/Kconfig      |    3 +++
 mm/page_alloc.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

Heiko Carstens <heiko.carstens@de.ibm.com> writes:

>> +#ifdef CONFIG_HAVE_GENERIC_SHOW_MEM
>> +void show_mem(void)
>> +{
>> +	pg_data_t *pgdat;
>> +	int total = 0, reserved = 0, shared = 0, nonshared = 0, highmem = 0;
>
> All of these should be unsigned long. Might overflow on very large
> configurations otherwise.

Thanks Heiko for pointing it out.  quicklist_total_size() also returns
UL so I fixed up the format character there as well.

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -45,6 +45,7 @@
 #include <linux/fault-inject.h>
 #include <linux/page-isolation.h>
 #include <linux/memcontrol.h>
+#include <linux/nmi.h>
 #include <linux/debugobjects.h>
 
 #include <asm/tlbflush.h>
@@ -2042,6 +2043,61 @@ static void zoneref_set_zone(struct zone
 	zoneref->zone_idx = zone_idx(zone);
 }
 
+#ifdef CONFIG_HAVE_GENERIC_SHOW_MEM
+void show_mem(void)
+{
+	pg_data_t *pgdat;
+	unsigned long total = 0, reserved = 0, shared = 0,
+		nonshared = 0, highmem = 0;
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
+	printk(KERN_INFO "%lu pages RAM\n", total);
+#ifdef CONFIG_HIGHMEM
+	printk(KERN_INFO "%lu pages HighMem\n", highmem);
+#endif
+	printk(KERN_INFO "%lu pages reserved\n", reserved);
+	printk(KERN_INFO "%lu pages shared\n", shared);
+	printk(KERN_INFO "%lu pages non-shared\n", nonshared);
+#ifdef CONFIG_QUICKLIST
+	printk(KERN_INFO "%lu pages in pagetable cache\n",
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
