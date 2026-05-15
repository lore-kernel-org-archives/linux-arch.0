Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31D3FB7C1
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833422; cv=none; b=TbHGP7FxIGJn2Xe75t07gu9QFqVUAVAqDVHtxB6UIXpnLlZra9SF8KMklXb+BxUb1P7JtIGYNT46nkc9TDm4zGNiab/XWXj2ol04gDrgZW+veYh+fSIO04ZdLlgG6XRXD3N6NENXXxMjYl2wMYi/Tx3MY30X0lOmMPGFFLo6T7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833422; c=relaxed/simple;
	bh=J3EgBO/5LYc9AQPMmRRsFll7CbgJo+wX0KbyuXE8Vyc=;
	h=From:Message-Id:Mime-Version:To:Cc:Subject:Date:In-Reply-To:
	 References:Content-Type; b=LavXQB4/y+az2b2Y+4J86FdzlsZAUf8RXpswKnlf3L0zyuWobv+x+Nvxhl2b2VGzbcUg2ZGi1nX74PqH6a2bRYkjWNat3x9r8lL/1e5fiIGtsflfWBAC9FAd38z2Trq3/ToSkdu6vdNqrWHKplW3yxF+VyjQf5uzhkpxsvRh9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ikEngAOe; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ikEngAOe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778833296; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=KYb1xv6fWKLs8dME6r+hxjVFSc26mPwlUU+4YrBCihU=;
 b=ikEngAOel18imdYLdMQmxTJ4kLHkc6P/0fmNIJB/ybRYYrnA6WDfFwMInw/H4JeSoPA1Jg
 h72QGwtYr5a7SQ6LHiPs+te8719/kHvTYdHJoRgtRUjfU2mt7bNVik49NYuRnI0+ccyP+F
 gll7JjgEC05N/nE3pBFnccLfoac+42eAzJwygxsiyba//hTywmbDNoVcBX3UVbK2ofRgYU
 QuOqyhVXd5EaBbb8zfBvr/1rH83MUJeoJ9qbnCj4WnEUcYMrbiLDX3nH4yOU1qu6AGCioC
 uBw+Gxj6ZZooBlrhvGwEB/34tJt7to3DiupxpnFwINTyRRhYblT2GJIzQg4B2A==
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260515082045.63029-3-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <arnd@arndb.de>, <rppt@kernel.org>, 
	<akpm@linux-foundation.org>, <david@kernel.org>
Cc: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a06d78e+df1ba0+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2/4] mm: add a template-based fast path for zone-device page init
Date: Fri, 15 May 2026 16:20:43 +0800
In-Reply-To: <20260515082045.63029-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
References: <20260515082045.63029-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8

On 64-bit builds, memmap_init_zone_device() spends most of its time
repeating the same struct page initialization for every PFN. Prepare a
template page through the existing slow path once, then copy that
template into each destination page and fix up the PFN-dependent state
afterwards.

Keep the optimized path disabled when the page_ref_set tracepoint is
active, because the template-copy path bypasses set_page_count() and
would otherwise hide the corresponding trace event.

Non-64-bit builds continue to use the existing slow path.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
path (pfns_per_compound == 1).

Test procedure:
Rebind the nd_pmem driver 30 times and collect the memmap initialization
time from the pr_debug() output of memmap_init_zone_device().

Base(v7.1-rc3):
  First binding: 1486 ms
  Average of subsequent rebinds: 273.52 ms

With this patch:
  First binding: 1421 ms
  Average of subsequent rebinds: 246.14 ms

This reduces the average rebind time from 273.52 ms to 246.14 ms, or
about 10%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5244acb96dbb..4c475c71a9d6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1013,7 +1013,7 @@ static inline int zone_device_page_init_refcount(
 	}
 }
 
-static void __ref generic_init_zone_device_page(struct page *page,
+static void __ref generic_init_zone_device_page_slow(struct page *page,
 		unsigned long pfn, unsigned long zone_idx, int nid,
 		struct dev_pagemap *pgmap)
 {
@@ -1040,12 +1040,9 @@ static void __ref generic_init_zone_device_page(struct page *page,
 		set_page_count(page, 0);
 }
 
-static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
-					  unsigned long zone_idx, int nid,
-					  struct dev_pagemap *pgmap)
+static void __ref zone_device_page_init_pageblock(struct page *page,
+						  unsigned long pfn)
 {
-	generic_init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
-
 	/*
 	 * Mark the block movable so that blocks are reserved for
 	 * movable at startup. This will force kernel allocations
@@ -1062,6 +1059,88 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 }
 
+static inline void __init_zone_device_page(struct page *page, unsigned long pfn,
+					   unsigned long zone_idx, int nid,
+					   struct dev_pagemap *pgmap)
+{
+	generic_init_zone_device_page_slow(page, pfn, zone_idx, nid, pgmap);
+	zone_device_page_init_pageblock(page, pfn);
+}
+
+#if BITS_PER_LONG == 64
+static inline bool zone_device_page_init_optimization_enabled(void)
+{
+	/*
+	 * We use template pages and assign page->_refcount via memory copy.
+	 * This means the optimized path bypasses set_page_count(), so the
+	 * page_ref_set tracepoint cannot observe this initialization.
+	 * Skip the optimized path when the tracepoint is enabled.
+	 */
+	return !page_ref_tracepoint_active(page_ref_set);
+}
+
+static inline void struct_page_layout_check(void)
+{
+	BUILD_BUG_ON(sizeof(struct page) & (sizeof(u64) - 1));
+}
+
+static inline void init_template_page(struct page *template,
+				      unsigned long pfn,
+				      unsigned long zone_idx,
+				      int nid,
+				      struct dev_pagemap *pgmap)
+{
+	generic_init_zone_device_page_slow(template, pfn, zone_idx, nid, pgmap);
+}
+
+/*
+ * Initialize parts that differ from the template
+ */
+static inline void generic_init_zone_device_page_finish(struct page *page,
+							unsigned long pfn)
+{
+#ifdef SECTION_IN_PAGE_FLAGS
+	set_page_section(page, pfn_to_section_nr(pfn));
+#endif
+#ifdef WANT_PAGE_VIRTUAL
+	if (!is_highmem_idx(ZONE_DEVICE))
+		set_page_address(page, __va(pfn << PAGE_SHIFT));
+#endif
+}
+
+static void init_zone_device_page_from_template(struct page *page,
+		unsigned long pfn, const struct page *template)
+{
+	const u64 *src = (const u64 *)template;
+	u64 *dst = (u64 *)page;
+	unsigned int i;
+
+	for (i = 0; i < sizeof(struct page) / sizeof(u64); i++)
+		dst[i] = src[i];
+	generic_init_zone_device_page_finish(page, pfn);
+	zone_device_page_init_pageblock(page, pfn);
+}
+#else
+static inline bool zone_device_page_init_optimization_enabled(void)
+{
+	return false;
+}
+static inline void init_template_page(struct page *template,
+				      unsigned long pfn,
+				      unsigned long zone_idx,
+				      int nid,
+				      struct dev_pagemap *pgmap)
+{
+}
+static inline void struct_page_layout_check(void)
+{
+}
+static void init_zone_device_page_from_template(struct page *page,
+		unsigned long pfn, const struct page *template)
+{
+}
+#endif
+
 /*
  * With compound page geometry and when struct pages are stored in ram most
  * tail pages are reused. Consequently, the amount of unique struct pages to
@@ -1110,6 +1189,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
+	bool use_template = zone_device_page_init_optimization_enabled();
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
@@ -1117,6 +1197,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
+	struct page template;
 
 	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
 		return;
@@ -1131,10 +1212,18 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		nr_pages = end_pfn - start_pfn;
 	}
 
+	if (use_template) {
+		struct_page_layout_check();
+		init_template_page(&template, start_pfn, zone_idx, nid, pgmap);
+	}
+
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		if (use_template)
+			init_zone_device_page_from_template(page, pfn, &template);
+		else
+			__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
 		if (pfns_per_compound == 1)
 			continue;
-- 
2.20.1
