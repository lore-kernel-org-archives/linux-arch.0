Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179833B6ED
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853204; cv=none; b=EkXly+2pRfY6crp5x5wTTwQ1Jmtn7mjft/jJD48VSJhWIsJ5RzpTI6zj9h8oUyLjqT0YgPL6Nl3b4Y8sM0Po7eYnAwlvS8cXhvfbCHmjXP32uq5fX4wPYLW1u/AIVP0j3Wq7ImeSvRbxSfDREYIo349FyeJzsx2VXyD+2VPeuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853204; c=relaxed/simple;
	bh=DlK+g81q/+QLzt73oFhG2ez81k6aSbUj3H6PZsNZYsY=;
	h=Cc:Mime-Version:Date:Content-Type:Message-Id:References:To:From:
	 Subject:In-Reply-To; b=pYy6eb1xa0X9EmMX8kkDGgZyQI2ubjhTVDFOAEYCHJEYnXqJd2HPJviN3UgG5KcbyEB5G+gL3N2no9APryPy/iCZl6grugVVVv8kQmEIhc+cOX8XhC7w2/sthOSw4yZelpGF3d/LiyCg7BPTP/J+slnoWpPwyAKcZaMHc0UvTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VDBRTUy6; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VDBRTUy6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779853192; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qFCgbSTStAjZ31U1E/z3VlWcowp913bpgnmrB6tBGlA=;
 b=VDBRTUy6wTeRvedsk63DIVKDHdV91v5VfNxab6UMk/we/EWYeA9cDX9OvInP4kxIDXqock
 kdVqQ77BZzfG/PoVSNxWUMByu9yDsJXWu/C8yAQ8q0fJN6wXXj/ldsW/xGcZCxytMQq/ij
 RFlA9L6zsT5EjamwCwiURQpmJM3zkg2EhB6MZw+MoJ0Y/kVg875aHrYSm08Vy6lDUn+wrj
 WFOg2YhrPKvXmlPpaX9qAfS/FAbKpa/Xxzk0EKrxxAy1nxKmkyySwkjH4K4iNxxd9MIX4E
 s6O5zYuhHK3dZqInhXINxZI5NfjRuwTOFPNhfCRV7sUI7YKYFZNx27hgzOaX9w==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 27 May 2026 11:36:33 +0800
X-Lms-Return-Path: <lba+26a166786+8ff2e0+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260527033636.28231-6-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
References: <20260527033636.28231-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v3 5/8] mm: extend the template fast path to zone-device compound tails
In-Reply-To: <20260527033636.28231-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

The template fast path from the previous patch only accelerates head
pages. Compound tails in memmap_init_compound() still go through the
slow path one by one.

Build separate head and tail templates and reuse one prepared tail
template across the tail pages in a compound range. Head pages preserve
the existing refcount policy, while compound tails always start with a
refcount of 0 after prep_compound_tail().

This extends the template-copy fast path to pfns_per_compound > 1
without changing the existing slow path. Tail-page PFN-dependent fields
are refreshed in the reusable tail template before each copy.

Tested in a VM with a 100 GB devdax namespace (align=2097152) on Intel
Ice Lake server. This test exercises the dax_pmem rebind path and
measures memmap initialization latency.

Test procedure:
Unbind and rebind the dax_pmem driver 30 times, collect memmap
initialization time from the pr_debug() output of memmap_init_zone_device().

Base(v7.1-rc3):
  First binding: 1515 ms
  Average of subsequent rebinds: 313.45 ms

With this patch and its prerequisites applied:
  First binding: 1422 ms
  Average of subsequent rebinds: 240.42 ms

This reduces the average rebind time from 313.45 ms to 240.42 ms, or
about 23.3%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 53c0241c66b7..d5ccb49a048f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1077,17 +1077,25 @@ static inline bool zone_device_page_init_optimization_enabled(void)
 	return !page_ref_tracepoint_active(page_ref_set);
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
 	if (!pagemap_resets_refcount(pgmap))
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
  * 'template' is a reusable page prototype rather than a strictly immutable
  * object. Most ZONE_DEVICE fields stay constant across the pages covered by
@@ -1139,10 +1147,12 @@ static void __ref memmap_init_compound(struct page *head,
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
@@ -1151,9 +1161,25 @@ static void __ref memmap_init_compound(struct page *head,
 	 * the pages in the same go.
 	 */
 	__SetPageHead(head);
+
+	/*
+	 * All tails of the same compound page share the state established by
+	 * prep_compound_tail(). Reuse one tail template for the whole range and
+	 * refresh only the PFN-dependent fields in that template before each copy.
+	 */
+	if (use_template)
+		zone_device_template_tail_page_init(&template, head_pfn + 1,
+						    zone_idx, nid, pgmap,
+						    head, order);
+
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
+		if (use_template) {
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+			continue;
+		}
 		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
 		prep_compound_tail(page, head, order);
 		set_page_count(page, 0);
@@ -1190,8 +1216,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	}
 
 	if (use_template)
-		zone_device_template_page_init(&template, start_pfn, zone_idx,
-					       nid, pgmap);
+		zone_device_template_head_page_init(&template, start_pfn,
+						    zone_idx, nid, pgmap);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
@@ -1207,7 +1233,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(altmap, pgmap),
+				     use_template);
 	}
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
-- 
2.20.1
