Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC93E7BC3
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896921; cv=none; b=DrKyJ40SJlcLHcEpsqJzGQpKJ6D30vIgWm6NWG3DddLqdWiDwZv1mxcxXptnl9YHo8dEmZyo/cEmmZzOeKNkm1sE+9IAiMiqD2vKDm9lfLPCncxaJLePhS4yCtDW0g0N3hJIlc4d0aecHJjneFh9z0apytMnPkjT8pTdR+IWkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896921; c=relaxed/simple;
	bh=S9kRmcv5hEZhi2B2ySsvNw6rb8hdkbwfF6by32jmsX0=;
	h=References:Subject:Content-Type:From:Date:Mime-Version:
	 In-Reply-To:Cc:Message-Id:To; b=sIkBpeGu0dX0zzjUbY+qLwCd4kxi0/ylcmNaayePvGt0sWSg+WvfKm0/gHI8D48S8bu+3OTrVrgggTwBayqhD5/2gGLiZVrFp7EsKKamNq1DxxHBgn4YQq40hxsCvpTUW6INlso1LUFMwdaaKNaZUiawPUn2CQIwasJD9l7LEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N3uTd82r; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N3uTd82r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782896908; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WhC/iGsiRai6AMLFSR8WX2iRwDXXIEDlLdd8uNqjgTM=;
 b=N3uTd82rd6AhkwEGWT43AwwPlgPAIuCbcb0dX5rm5QXgOm0626IzHCQvo6wIqzg+Nu4xuB
 438Fc/IRUhGx+X8L8Mw4wGozwSZJY8TliARUqvOvx5vakkVLrQ7uTjWfBmhOu0C3HGcSOR
 V5qcskpjvOsiaW9DG0cCm0ifNorzIvosU1Vr1juK5t2D77OydXIuoSbvsXLahg3saC+ldQ
 k1+u0DrYbrb2ymyyYAXggnxkaOEra69+2dcPiL9YdWDZXC99lubSCoY5OxhIWyHtwb4NBs
 xSzAGRqjxzaH/H00mTQEy6iO1q5Ptt9ZCmwEgcbG+npQV3M5d6bcrpfd5VdWPg==
Content-Transfer-Encoding: 7bit
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Subject: [PATCH v5 4/8] mm: add a template-based fast path for zone-device page init
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed,  1 Jul 2026 17:05:49 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a44d90a+09fb9b+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Message-Id: <20260701090553.62691-5-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>

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

Base(v7.2-rc1):
  First binding: 1456 ms
  Average of subsequent rebinds: 244.28 ms

With this patch and its prerequisites applied:
  First binding: 1440 ms
  Average of subsequent rebinds: 217.19 ms

This reduces the average rebind time from 244.28 ms to 217.19 ms, or
about 11%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4c7fad440c2a..cc8417951467 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1066,6 +1066,50 @@ static void __ref zone_device_page_init_slow(struct page *page,
 		set_page_count(page, 0);
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
+}
+
 /*
  * With compound page geometry and when struct pages are stored in ram most
  * tail pages are reused. Consequently, the amount of unique struct pages to
@@ -1121,6 +1165,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
+	bool use_template = zone_device_page_init_optimization_enabled();
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
@@ -1128,6 +1173,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
+	struct page template;
 
 	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
 		return;
@@ -1142,10 +1188,36 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		nr_pages = end_pfn - start_pfn;
 	}
 
-	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
-		struct page *page = pfn_to_page(pfn);
+
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
+				compound_nr_pages(start_pfn, altmap, pgmap));
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
 
 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
-- 
2.20.1
