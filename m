Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD09346E4A
	for <linux-arch@vger.kernel.org>; Wed,  3 Jun 2026 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473939; cv=none; b=uUtuuskBjqHPIvIqXQlzLb8Mr3LyVgQdJF7UYAxpxB/O2aMETnZb7l4p9zi5nSEaIHSNl/Hy1zNIrli3WbcRr+jfVDkk0EhGekITWbt6iwIzLgZa22PdjniB8bL609w5DhErA/SX0NcWPDDqkg9vgL1kZN/RoWLk3LWTVAxb7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473939; c=relaxed/simple;
	bh=/pYgzuRQ6iq6nYtxlWbo/GZKyUbyCI63h8deMoKd5M0=;
	h=To:Subject:Message-Id:In-Reply-To:References:Date:From:
	 Content-Type:Cc:Mime-Version; b=B3NkGWnO/2bMTaPO12B1E55OBHMjhuVA5V96pgXLAksetHqUzmoHkEdka5gy1khmHjfLqmM9ds9EiAuaeDM3/dYo/HlRfbmeuDNMwKSkdZBE8xhv6QhWt50c4VlvjkzYvdrCo35LKwmFNcwqhHyBC6x/ATPYOTe/9y0dsaK7PVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZLrF88yr; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZLrF88yr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780473932; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=yy6XV8hK8oauYu/xVX9D1lPDIbV+Br2ZbBHBJaftx+0=;
 b=ZLrF88yrw0Nzm2arTnuzExC5kIY/vk+nde66tD5n4K7wAdlp8Y4KcqGSZTG+Ron/yDXItV
 GoEPagz8RFHgpXEFcKw8l44nkDsEnRI0f0h3Qy7Ke5b+k+3awfWUhUV7zyvZ2c6fK24d4E
 CznItthwfvCx5Di0TfFWL2mt4vyATW7tjB0kN8DokSactI8q1U7dKDmBMqMgvBrRVdVTpL
 PxIL4JmeIUKa9WLnwZF1gVlV6NvJjWdBHs8jL2oxj+fcwEB1Y5zXI5P0QOgHGpIXgonH71
 OvQWensr1Q/3a0Et0oPJFBj0FjKGp5noK19664J4PsS4BSO49ekAaIDU7LkH/w==
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Subject: [PATCH v4 4/8] mm: add a template-based fast path for zone-device page init
Message-Id: <20260603080152.64728-5-lizhe.67@bytedance.com>
In-Reply-To: <20260603080152.64728-1-lizhe.67@bytedance.com>
References: <20260603080152.64728-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Wed,  3 Jun 2026 16:01:48 +0800
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a1fe04a+adee8a+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

memmap_init_zone_device() repeats nearly identical head-page
initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
template through the existing slow path, refresh the PFN-dependent
fields in that template before each copy, and memcpy it into each
destination page.

The optimized path assigns _refcount through the copied template, so
keep it disabled when the page_ref_set tracepoint is enabled.

This patch accelerates head-page initialization. The pfns_per_compound
== 1 case gets the full benefit here, compound tails are handled in the
next patch.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
path (pfns_per_compound == 1).

Test procedure:
Rebind the nd_pmem driver 30 times and collect the memmap initialization
time from the pr_debug() output of memmap_init_zone_device().

Base(v7.1-rc6):
  First binding: 1466 ms
  Average of subsequent rebinds: 262.12 ms

With this patch and its prerequisites applied:
  First binding: 1432 ms
  Average of subsequent rebinds: 246.30 ms

This reduces the average rebind time from 262.12 ms to 246.30 ms, or
about 6%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2e5899c5cf35..56fe71e966ae 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1068,6 +1068,51 @@ static void __ref zone_device_page_init_slow(struct page *page,
 	zone_device_page_init_pageblock(page, pfn);
 }
 
+static inline bool zone_device_page_init_optimization_enabled(void)
+{
+	/*
+	 * The template fast path copies a preinitialized struct page image.
+	 * Skip it when the page_ref_set tracepoint is enabled.
+	 */
+	return !page_ref_tracepoint_active(page_ref_set);
+}
+
+static inline void zone_device_template_page_init(struct page *template,
+						  struct page *src)
+{
+	memcpy(template, src, sizeof(*template));
+}
+
+/*
+ * 'template' is a reusable page prototype rather than a strictly immutable
+ * object. Most ZONE_DEVICE fields stay constant across the pages covered by
+ * the current template, but section bits and page->virtual may still depend
+ * on the PFN. Refresh those PFN-dependent fields in the template before
+ * copying it into @page.
+ */
+static inline void zone_device_page_update_template(struct page *template,
+		unsigned long pfn)
+{
+	set_page_section_from_pfn(template, pfn);
+#ifdef WANT_PAGE_VIRTUAL
+	if (!is_highmem_idx(ZONE_DEVICE))
+		set_page_address(template, __va(pfn << PAGE_SHIFT));
+#endif
+}
+
+static void zone_device_page_init_from_template(struct page *page,
+		unsigned long pfn, struct page *template)
+{
+	/*
+	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
+	 * page. Update the PFN-dependent fields in place before copying it
+	 * to the destination page.
+	 */
+	zone_device_page_update_template(template, pfn);
+	memcpy(page, template, sizeof(*page));
+	zone_device_page_init_pageblock(page, pfn);
+}
+
 /*
  * With compound page geometry and when struct pages are stored in ram most
  * tail pages are reused. Consequently, the amount of unique struct pages to
@@ -1116,6 +1161,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
+	bool use_template = zone_device_page_init_optimization_enabled();
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
@@ -1123,6 +1169,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
+	struct page template;
 
 	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
 		return;
@@ -1137,10 +1184,35 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		nr_pages = end_pfn - start_pfn;
 	}
 
-	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
-		struct page *page = pfn_to_page(pfn);
+	if (!nr_pages)
+		return;
+
+	pfn = start_pfn;
+	/*
+	 * Seed the reusable head-page template from the first real struct
+	 * page, because the existing page-init and pageblock helpers expect
+	 * a real memmap entry rather than a stack object.
+	 */
+	if (use_template) {
+		struct page *page = pfn_to_page(start_pfn);
 
 		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
+		zone_device_template_page_init(&template, page);
+		if (pfns_per_compound != 1)
+			memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
+					     compound_nr_pages(altmap, pgmap));
+		pfn += pfns_per_compound;
+	}
+
+	for (; pfn < end_pfn; pfn += pfns_per_compound) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (use_template)
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+		else
+			zone_device_page_init_slow(page, pfn, zone_idx,
+						   nid, pgmap);
 
 		if (pfns_per_compound == 1)
 			continue;
-- 
2.20.1
