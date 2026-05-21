Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF163859EC
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 04:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336230; cv=none; b=gFYe0f5f/z67ZXsIC+B+rUsL1AC8UFUrbr5xlbky4inz9PHNIF538THNdY6AnnHNRNAW5Zfe7ctulS6N9yG/rpOBu4vcfox7tw2KrWrSMe6kPaVOr/v/BOjNH+nwczIbKXpC7oD8bQwg8zWogUX8x36GUmEzgNxL3AwGoyX9s5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336230; c=relaxed/simple;
	bh=TUt/dRvpfji4gx0lLQS6xlyPGQUGCXfNhUwSRyiuUKs=;
	h=From:Mime-Version:Subject:Date:In-Reply-To:To:Cc:References:
	 Content-Type:Message-Id; b=p2BOZOytx5080UcSB78TVfptjxJpYoYA8uqSHXOYA4+7JaOyBAR/7UdPi5QGyTQRWMJhY92QRUI6OBPccLbiGEGlmSYIw7psi6PMk1AMUOqekiqiviaj0/ZWR+r5hWvh6PThnHwoxHbiqZCREwpUck4Jyrjk9GaozbunlCszQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=oP+cCJ8d; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="oP+cCJ8d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779336223; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WzT6rgRltF1pu1V66u6WO6GZ1NJSxQBmJVnmonaqWWc=;
 b=oP+cCJ8dMsyfbEgYOTRLckiA3oy8+w1BUJHSGMskJ/XDSL48xyyYEZEQf3M4HukHjSZ+T1
 H+2kwrHIeYpb/2RiUdGW5vsf7cuVF+/V+XjuG+OH3ZkqLtaNIiq3E6DpJn9/wPRpD9yvF4
 sfhF6TBnKmHHyF1HT9naohF3VUdnBKc40YL5E/WV2919o7CYM7HD0Jrdg7U9BW0LqQAUZj
 05oCLQ5Tp93LQoBDHFzOCCZP1vzTooGGnBsmbMqWwXK6H6/+5IB438uJDgjtdzKw6jOAtz
 JHtORZM6hhFoYnVTnUj8rS413VzCoO/a2ryL7LVaCoObJyFiVvxghZKHEmMZnA==
Content-Transfer-Encoding: 7bit
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2 3/7] mm: add a template-based fast path for zone-device page init
Date: Thu, 21 May 2026 12:01:20 +0800
In-Reply-To: <20260521040124.10608-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <apopple@nvidia.com>, <akpm@linux-foundation.org>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>, 
	<kees@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <x86@kernel.org>, 
	<linux-hardening@vger.kernel.org>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260521040124.10608-4-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a0e841d+49e983+vger.kernel.org+lizhe.67@bytedance.com>

memmap_init_zone_device() repeats nearly identical head-page
initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
template through the existing slow path, copy it into each destination
page, and then fix up the PFN-dependent fields after the copy.

The optimized path assigns _refcount through the copied template, so
keep it disabled when the page_ref_set tracepoint is enabled. Also fall
back to the slow path if struct page is not an integral number of u64
words.

This patch accelerates the pfns_per_compound == 1 case. Compound tails
are handled in the next patch.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
path (pfns_per_compound == 1).

Test procedure:
Rebind the nd_pmem driver 30 times and collect the memmap initialization
time from the pr_debug() output of memmap_init_zone_device().

Base(v7.1-rc3):
  First binding: 1486 ms
  Average of subsequent rebinds: 273.52 ms

With patches 1-3 applied:
  First binding: 1422 ms
  Average of subsequent rebinds: 245.73 ms

This reduces the average rebind time from 273.52 ms to 245.73 ms, or
about 10%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba506df93bc..2992711351a0 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1066,6 +1066,63 @@ static void __ref zone_device_page_init_slow(struct page *page,
 	zone_device_page_init_pageblock(page, pfn);
 }
 
+/*
+ * ZONE_DEVICE depends on MEMORY_HOTPLUG, and MEMORY_HOTPLUG is 64-bit
+ * only. That means CONFIG_ZONE_DEVICE cannot be enabled on 32-bit
+ * builds, so this fast-path code does not need a separate 32-bit
+ * fallback implementation.
+ */
+static inline bool zone_device_page_init_optimization_enabled(void)
+{
+	/*
+	 * The template fast path copies a preinitialized struct page as an
+	 * array of u64 words. Skip it when the page_ref_set tracepoint is
+	 * enabled, and fall back to the slow path if struct page is not an
+	 * integral number of u64 words.
+	 */
+	return !page_ref_tracepoint_active(page_ref_set) &&
+		IS_ALIGNED(sizeof(struct page), sizeof(u64));
+}
+
+static inline void zone_device_template_page_init(struct page *template,
+						  unsigned long pfn,
+						  unsigned long zone_idx,
+						  int nid,
+						  struct dev_pagemap *pgmap)
+{
+	__zone_device_page_init(template, pfn, zone_idx, nid, pgmap);
+	if (!zone_device_page_init_refcount(pgmap))
+		set_page_count(template, 0);
+}
+
+/*
+ * The copied template already provides the PFN-invariant portion of a
+ * ZONE_DEVICE struct page. Fix up the fields that still depend on @pfn
+ * after the copy, namely the section bits and page->virtual when present.
+ */
+static inline void zone_device_page_init_finish(struct page *page,
+							unsigned long pfn)
+{
+	set_page_section_from_pfn(page, pfn);
+#ifdef WANT_PAGE_VIRTUAL
+	if (!is_highmem_idx(ZONE_DEVICE))
+		set_page_address(page, __va(pfn << PAGE_SHIFT));
+#endif
+}
+
+static void zone_device_page_init_from_template(struct page *page,
+		unsigned long pfn, const struct page *template)
+{
+	const u64 *src = (const u64 *)template;
+	u64 *dst = (u64 *)page;
+	unsigned int i;
+
+	for (i = 0; i < sizeof(struct page) / sizeof(u64); i++)
+		dst[i] = src[i];
+	zone_device_page_init_finish(page, pfn);
+	zone_device_page_init_pageblock(page, pfn);
+}
+
 /*
  * With compound page geometry and when struct pages are stored in ram most
  * tail pages are reused. Consequently, the amount of unique struct pages to
@@ -1114,6 +1171,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
+	bool use_template = zone_device_page_init_optimization_enabled();
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
@@ -1121,6 +1179,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
+	struct page template;
 
 	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
 		return;
@@ -1135,10 +1194,19 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		nr_pages = end_pfn - start_pfn;
 	}
 
+	if (use_template)
+		zone_device_template_page_init(&template, start_pfn, zone_idx,
+					       nid, pgmap);
+
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
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
