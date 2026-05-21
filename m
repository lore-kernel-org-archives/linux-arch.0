Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F96385D61
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336250; cv=none; b=nbHckG3SP6Rbkitge6m721ouPksEfJt61cVRpRuKoh7wqgjaxp3hNcdej0EsBo/9+mrIW3bbHvL3SxvkQvICNvdZNVk1kBnYk4+uFCADXQiYfaTxhlkUv7Iwu74RWXtSicHoLbOaH64bQd5KTjugJjoAZDskL+PVNNIvv3LqSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336250; c=relaxed/simple;
	bh=RV/jS1HZjbCKHpmnihIY2xDk2fZb53H6/Fht2BOMwkg=;
	h=To:Cc:In-Reply-To:Content-Type:Date:Mime-Version:References:From:
	 Subject:Message-Id; b=BTjYdMUDt5tM/E3DCNGRRv8qYphII+rsdugGCp+My2a/qTCBebDs93NnWZ/41PMicuSDg+IwtNbBg4b0gBN9pK3xYKOfSVEHqetFCtm5rjrV+Sn3c6vSmkhOaQdO3MD1H1D/KuTsQH6NsxqFSElW5U3j5qW5cNwSGtmq3KSXEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lLkvFm22; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lLkvFm22"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779336243; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=AofTeM9rzRb3Y51PR5zzdSLZE+dFDRAZqaps3o2hj6g=;
 b=lLkvFm229mLzQjJtQzLIywMtrv1W3GLcKSZ2rNjfYNeB0jku+lLJtcVxDN1RiZ7dYRhlAG
 xxunFHHFU7Yu0iPrfd82omJ247Ti24r6mysFBzV3Far1OMJF48Ja/9goxB5AAJHNzJ4ysh
 7kKrKa9uPGbkImacrl2FWg+wCT8qFCKDXYYCUWzWpae3hlo3Uij6D7+Hy4BRSSdr5YE/xo
 E3lLETxV2O9X4vQz/bMz49fJuiBS7OoF6sCUc2zQSq3l0FVviRuSErK94UX/X13/pYbeGD
 5RoJvN3FrKQcB4wWdciqTUBY4ghlJ9mektmcGTce72gXQNGTCg2Bw28Ac+rP8Q==
To: <apopple@nvidia.com>, <akpm@linux-foundation.org>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>, 
	<kees@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <x86@kernel.org>, 
	<linux-hardening@vger.kernel.org>
In-Reply-To: <20260521040124.10608-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 12:01:21 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a0e8431+418ddc+vger.kernel.org+lizhe.67@bytedance.com>
Subject: [PATCH v2 4/7] mm: extend the template fast path to zone-device compound tails
Message-Id: <20260521040124.10608-5-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2

The template fast path from the previous patch only accelerates head
pages. Compound tails in memmap_init_compound() still go through the
slow path one by one.

Build separate head and tail templates and reuse one prepared tail
template across the tail pages in a compound range. Head pages keep the
zone_device_page_init_refcount() policy, while compound tails always
start with a refcount of 0 after prep_compound_tail().

This extends the template-copy fast path to pfns_per_compound > 1
without changing the existing slow path.

Tested in a VM with a 100 GB devdax namespace (align=2097152) on Intel
Ice Lake server. This test exercises the dax_pmem rebind path and
measures memmap initialization latency.

Test procedure:
Unbind and rebind the dax_pmem driver 30 times, collect memmap
initialization time from the pr_debug() output of memmap_init_zone_device().

Base(v7.1-rc3):
  First binding: 1515 ms
  Average of subsequent rebinds: 313.45 ms

With patches 1-4 applied:
  First binding: 1422 ms
  Average of subsequent rebinds: 256.56 ms

This reduces the average rebind time from 313.45 ms to 256.56 ms, or
about 18.1%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2992711351a0..17a84d4cda01 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1084,17 +1084,25 @@ static inline bool zone_device_page_init_optimization_enabled(void)
 		IS_ALIGNED(sizeof(struct page), sizeof(u64));
 }
 
-static inline void zone_device_template_page_init(struct page *template,
-						  unsigned long pfn,
-						  unsigned long zone_idx,
-						  int nid,
-						  struct dev_pagemap *pgmap)
+static inline void zone_device_template_head_page_init(struct page *template,
+		unsigned long pfn, unsigned long zone_idx, int nid,
+		struct dev_pagemap *pgmap)
 {
 	__zone_device_page_init(template, pfn, zone_idx, nid, pgmap);
 	if (!zone_device_page_init_refcount(pgmap))
 		set_page_count(template, 0);
 }
 
+static inline void zone_device_template_tail_page_init(struct page *template,
+		unsigned long pfn, unsigned long zone_idx, int nid,
+		struct dev_pagemap *pgmap, const struct page *head,
+		unsigned int order)
+{
+	__zone_device_page_init(template, pfn, zone_idx, nid, pgmap);
+	prep_compound_tail(template, head, order);
+	set_page_count(template, 0);
+}
+
 /*
  * The copied template already provides the PFN-invariant portion of a
  * ZONE_DEVICE struct page. Fix up the fields that still depend on @pfn
@@ -1144,10 +1152,12 @@ static void __ref memmap_init_compound(struct page *head,
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
@@ -1156,12 +1166,28 @@ static void __ref memmap_init_compound(struct page *head,
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
+		zone_device_template_tail_page_init(&template, head_pfn + 1,
+						    zone_idx, nid, pgmap,
+						    head, order);
+
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
+		if (use_template) {
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+		} else {
+			zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
+			prep_compound_tail(page, head, order);
+			set_page_count(page, 0);
+		}
 	}
 	prep_compound_head(head, order);
 }
@@ -1195,8 +1221,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	}
 
 	if (use_template)
-		zone_device_template_page_init(&template, start_pfn, zone_idx,
-					       nid, pgmap);
+		zone_device_template_head_page_init(&template, start_pfn,
+						    zone_idx, nid, pgmap);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
@@ -1212,7 +1238,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(altmap, pgmap),
+				     use_template);
 	}
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
-- 
2.20.1
