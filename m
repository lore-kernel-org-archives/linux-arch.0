Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AC40B6E4
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549176; cv=none; b=cWbvwMxzulcy45rB9Ra+VKbxmz/A4vi22UrGy6f1WVLIWKrM7nxOgSwi2zOnUCIoEfFUBHZRHabnDlp7iAsxTXPKxmdpFAmNL+kkhePHB+nVhZ3q5AY6AiU4v48b8DRY/WZnySyKBKF1uSFdFApVlY+np+NkZIw5OB4yG2WH41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549176; c=relaxed/simple;
	bh=qgr93Zs18EPBcOvB82j2q2F+PNjlHHhMDXF5BEM6q6Q=;
	h=To:Cc:In-Reply-To:From:Date:Mime-Version:Content-Type:Subject:
	 Message-Id:References; b=UE9ve5fR6UFz5y9lAh2LH2uExXA4db0qI99VOyzWlGe7kEeHs0TbRe5aLcz58gHI5J1/wQFxIJso31p/aSY9UhMAda8kJ5kcpz/zQ7Dl67d/IQEFaz+agYHkZbFXEEF08CkK2PPbYJS7VtBNrgZA2TztG3nW7Z53AEqs6K93MyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g3AQwYTz; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g3AQwYTz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549170; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=1OXSJ03+XyIqi02GqEj3ajlM+g5iP3d6qhTy7H8GWxg=;
 b=g3AQwYTzMCsotReS2bPVjKGI9UDq/bp5hW2wjSfUJ7bdtGu4/08SsgOOVL1Mp6Pdj6vbqr
 6xQzE3M84/J5OwlFCQWy2XWio88dc2cotCm727QtOysazZnH/MI3oplNrzApAWLGZ8NnUQ
 R/pq4jeyARcLNOrEX1SQ1zzDV0SGxUyAtAYhNVXFq1uQ1fSGn4ZDK4pppw5TI8xrtWruIj
 xoVXr2xPLKjP0alNZ4U6Ak+/VR+8vBmbZILX8YKnqoXOAuYZ8MwgBnDXG2OgnXD0GBdW1N
 GXUqRCiOLeKiuRHAQz5pa/ywmHbVNk/NbJs1qGogTaOsCafuXeITa8/Z2rA8iw==
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 20 Jul 2026 20:02:54 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v7 4/9] mm: add a template-based fast path for zone-device page init
Message-Id: <20260720120259.1545-6-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a5e0f30+24d8e1+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com>

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

This reduces the average memmap initialization time measured during rebind
from 244.28 ms to 217.19 ms, or about 11%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a70acb7431a6..c2645b9bcef3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1065,6 +1065,44 @@ static void __ref zone_device_page_init_slow(struct page *page,
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
@@ -1120,6 +1158,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
+	bool use_template = zone_device_page_init_optimization_enabled();
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
@@ -1127,6 +1166,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
+	struct page template;
 
 	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
 		return;
@@ -1144,7 +1184,24 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
+		if (!use_template) {
+			zone_device_page_init_slow(page, pfn, zone_idx,
+						   nid, pgmap);
+		} else if (pfn == start_pfn) {
+			/*
+			 * Seed the reusable head-page template from the
+			 * first real struct page, because the existing
+			 * page-init and pageblock helpers expect a real
+			 * memmap entry rather than a stack object.
+			 */
+			zone_device_page_init_slow(page, pfn, zone_idx,
+						   nid, pgmap);
+			/* init template page */
+			memcpy(&template, page, sizeof(*page));
+		} else {
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+		}
 
 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
-- 
2.20.1
