Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7413E3DAF
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833317; cv=none; b=kRi9rB3qlT4WVZZMZZXBQIfutQYn0Fkqmuvf+kT8Li79JU7zGtKNPdmHfl9oOQ66pJlZACAlXgedjzCy5f5KdBm1Pj0t8Z9cLCVRcye9CH7ccstIsoHPKa1KjXrwz0yLl+3Irh3giDPwk4c/ItQAl/eBZZekmGyernz1FpqEZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833317; c=relaxed/simple;
	bh=EHy7Y6yPbAaCC7X9iIBaO18b4WkZQLBPwR5SiJ305uA=;
	h=Subject:Message-Id:Mime-Version:Content-Type:Cc:From:References:
	 To:In-Reply-To:Date; b=UDs8cW+PHDKqMOU6XTdCS6mcfI7pjRQ+Lq/WlaQeLVO0Bik16oOkPuMZh99SstARUpZAImeOAx10DRh2qXG00tUdBxRJ6G3K30uHT51B8zJorb2YUPrU65xKlZuDRIitcgEi6SLSB1lPahBS7VfIOOO54rThgAy9Ghf7OoPSFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZownNw4E; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZownNw4E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778833311; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HYCBjnYEKsIsIlLg+PNgaRy21lWqkR++g+DLMmjalIQ=;
 b=ZownNw4E13Cc0p/oxGHEh3k98nfl4IUBsVpQt5EySV10B7Qd1SmchQIMegOtgHFkB9fRqV
 ytvY1aIaYzD0xM/93Esv2zZ0ha3Yq1C5TRD4IVlAMOFSJQcNlLWOb9TtdinTp5xozvLUpv
 i8XSWafUORMqNhqaNfzxgfrRzhmPePpo1I7QGeiNva/NKAEpBHHV/yKSwxZCmCN9WEsrgt
 ps60DNlHiwfzcS7ftJzcbEv/J4ecv8BL+vCxR5P/W9HPJcCec4Z0poB3rMpuLujMmMD7Ao
 gvNllXB3YhXudZnhkSAyXJC0A8pygXDckvdE62PzjPrxd+JGlryc37StJ7sFvQ==
Subject: [PATCH 3/4] mm: extend the template fast path to zone-device compound tails
Message-Id: <20260515082045.63029-4-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
References: <20260515082045.63029-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <arnd@arndb.de>, <rppt@kernel.org>, 
	<akpm@linux-foundation.org>, <david@kernel.org>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <20260515082045.63029-1-lizhe.67@bytedance.com>
Date: Fri, 15 May 2026 16:20:44 +0800
X-Lms-Return-Path: <lba+26a06d79d+f7e82d+vger.kernel.org+lizhe.67@bytedance.com>

The template-based fast path currently only accelerates head-page
initialization in memmap_init_zone_device(). Compound tails still go
through the slow path one by one in memmap_init_compound().

Add separate head and tail template builders and reuse a prepared tail
template for all tail pages in the same compound range. Move the
head-page refcount handling out of generic_init_zone_device_page_slow()
so the two template builders can set their different initial refcount
states explicitly: head pages follow zone_device_page_init_refcount(),
while compound tails always start with a refcount of 0.

This extends the template-copy fast path to pfns_per_compound > 1
without changing the existing slow path.

Tested in a VM with a 100 GB devdax namespace (align=2097152) on Intel
Ice Lake server. This test exercises the dax_pmem rebind path and
measures memmap initialization latency.

Test procedure:
Unbind and rebind the dax_pmem driver, collect memmap initialization
time from the pr_debug() output of memmap_init_zone_device().

Base(v7.1-rc3):
  First binding: 1515 ms
  Average of subsequent rebinds: 313.45 ms

With this patch
  First binding: 1425 ms
  Average of subsequent rebinds: 255.47 ms

This reduces the average rebind time from 313.45 ms to 255.47 ms, or
about 20%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 80 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4c475c71a9d6..5a9e6ecfa894 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1035,9 +1035,6 @@ static void __ref generic_init_zone_device_page_slow(struct page *page,
 	 */
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
-
-	if (!zone_device_page_init_refcount(pgmap))
-		set_page_count(page, 0);
 }
 
 static void __ref zone_device_page_init_pageblock(struct page *page,
@@ -1064,6 +1061,8 @@ static inline void __init_zone_device_page(struct page *page, unsigned long pfn,
 					   struct dev_pagemap *pgmap)
 {
 	generic_init_zone_device_page_slow(page, pfn, zone_idx, nid, pgmap);
+	if (!zone_device_page_init_refcount(pgmap))
+		set_page_count(page, 0);
 	zone_device_page_init_pageblock(page, pfn);
 }
 
@@ -1084,13 +1083,28 @@ static inline void struct_page_layout_check(void)
 	BUILD_BUG_ON(sizeof(struct page) & (sizeof(u64) - 1));
 }
 
-static inline void init_template_page(struct page *template,
-				      unsigned long pfn,
-				      unsigned long zone_idx,
-				      int nid,
-				      struct dev_pagemap *pgmap)
+static inline void init_template_head_page(struct page *template,
+					   unsigned long pfn,
+					   unsigned long zone_idx,
+					   int nid,
+					   struct dev_pagemap *pgmap)
+{
+	generic_init_zone_device_page_slow(template, pfn, zone_idx, nid, pgmap);
+	if (!zone_device_page_init_refcount(pgmap))
+		set_page_count(template, 0);
+}
+
+static inline void init_template_tail_page(struct page *template,
+					   unsigned long pfn,
+					   unsigned long zone_idx,
+					   int nid,
+					   struct dev_pagemap *pgmap,
+					   const struct page *head,
+					   unsigned int order)
 {
 	generic_init_zone_device_page_slow(template, pfn, zone_idx, nid, pgmap);
+	prep_compound_tail(template, head, order);
+	set_page_count(template, 0);
 }
 
 /*
@@ -1125,11 +1139,11 @@ static inline bool zone_device_page_init_optimization_enabled(void)
 {
 	return false;
 }
-static inline void init_template_page(struct page *template,
-				      unsigned long pfn,
-				      unsigned long zone_idx,
-				      int nid,
-				      struct dev_pagemap *pgmap)
+static inline void init_template_head_page(struct page *template,
+					   unsigned long pfn,
+					   unsigned long zone_idx,
+					   int nid,
+					   struct dev_pagemap *pgmap)
 {
 }
 static inline void struct_page_layout_check(void)
@@ -1139,6 +1153,15 @@ static void init_zone_device_page_from_template(struct page *page,
 		unsigned long pfn, const struct page *template)
 {
 }
+static inline void init_template_tail_page(struct page *template,
+					   unsigned long pfn,
+					   unsigned long zone_idx,
+					   int nid,
+					   struct dev_pagemap *pgmap,
+					   const struct page *head,
+					   unsigned int order)
+{
+}
 #endif
 
 /*
@@ -1162,10 +1185,12 @@ static void __ref memmap_init_compound(struct page *head,
 				       unsigned long head_pfn,
 				       unsigned long zone_idx, int nid,
 				       struct dev_pagemap *pgmap,
-				       unsigned long nr_pages)
+				       unsigned long nr_pages,
+				       bool use_template)
 {
 	unsigned long pfn, end_pfn = head_pfn + nr_pages;
 	unsigned int order = pgmap->vmemmap_shift;
+	struct page template;
 
 	/*
 	 * We have to initialize the pages, including setting up page links.
@@ -1174,12 +1199,27 @@ static void __ref memmap_init_compound(struct page *head,
 	 * the pages in the same go.
 	 */
 	__SetPageHead(head);
+
+	/*
+	 * A tail template can be reused for all tail pages in the same compound page
+	 * because shared state for compound tails is pre-set by prep_compound_tail().
+	 * The per-page page->virtual and section in flags are fixed up after copying.
+	 */
+	if (use_template)
+		init_template_tail_page(&template, head_pfn + 1, zone_idx, nid,
+					pgmap, head, order);
+
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
+		if (use_template) {
+			init_zone_device_page_from_template(page, pfn,
+							    &template);
+		} else {
+			__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+			prep_compound_tail(page, head, order);
+			set_page_count(page, 0);
+		}
 	}
 	prep_compound_head(head, order);
 }
@@ -1214,7 +1254,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 	if (use_template) {
 		struct_page_layout_check();
-		init_template_page(&template, start_pfn, zone_idx, nid, pgmap);
+		init_template_head_page(&template, start_pfn, zone_idx,
+					nid, pgmap);
 	}
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
@@ -1229,7 +1270,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(altmap, pgmap),
+				     use_template);
 	}
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
-- 
2.20.1
