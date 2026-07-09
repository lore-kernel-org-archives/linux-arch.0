Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18E41168F
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596464; cv=none; b=Zm3mzLGSOzTuvW2pw/gl3Z0qfOFGWRiS7kkIOfpvYpo3vkiP1oAPbnViNrXx3/jVwmm2H/d55/4Ylu2pROdmfyv3THbw2hruZP75vo5IsqT1OUKSEJkISKd2FET/ej6a0H4f7lkKjIqFfoMcNVynu68IcASniDEKQAEbXJSXnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596464; c=relaxed/simple;
	bh=Wg3QI6R5Pj4fcNzGJWqeC0scWS4AlAW//zqMaln/l2c=;
	h=From:Subject:Mime-Version:Content-Type:References:Message-Id:
	 In-Reply-To:To:Cc:Date; b=m/FfjzfFWa5MAbyxn4vuRB0lY9bdtgnx2duV1CTh9vcfqARP3H7P5ezm28Lt47h+mYOITBFGifsTb/u0NL1iT/wSEUSmGLL39YNCJQXpDubl6FAjCcISOTcA3lbQECh8PyKhr3iu4GrnBHeM+J+4BUvYmu8d8cXKlR+mWZJ0yPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BYvV94v0; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BYvV94v0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596455; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=VkruUotUpYotmWNBhi+IQ/cN55rHKdD+MW/eLLud6s4=;
 b=BYvV94v0JMmP+yNdPSONAEcCZASSt84hTUZ0gNRx3Cn4P+bdR7AsTkLjyPqQKiDlsMB1xj
 DRC07PyRFdwBh6Q4OQWBSYSDYfEMInXPkEwOVQ6aH9K1XYfuI+1SSWWZgCfc9tfXQqLhVE
 BcFWxYPcWxYahJCLXQBBf7aA/W8USz8qKLKjcbyROdoSkvc5wimnaSsehy+Ed1KNHexyUO
 k2oFHFfPUF3XQMZxmMR/A4ykceSF8lxkq168be0H2qzWifh8+HH3u9m3E736JWQ5DscVYz
 /qcGczTZS4ZphCJbQY6fPLlMhi4d3zclxQ6CCmiIYNswnve4SAw+nYenOnHd1w==
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v6 5/8] mm: extend the template fast path to zone-device compound tails
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
Message-Id: <20260709112520.24857-6-lizhe.67@bytedance.com>
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4f85a5+2084f2+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
Date: Thu,  9 Jul 2026 19:25:17 +0800
X-Mailer: git-send-email 2.45.2

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

Base(v7.2-rc1):
  First binding: 1462 ms
  Average of subsequent rebinds: 273.31 ms

With this patch and its prerequisites applied:
  First binding: 1403 ms
  Average of subsequent rebinds: 244.37 ms

This reduces the average rebind time from 273.31 ms to 244.37 ms, or
about 10.6%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 170021e182e0..fb855bb0437a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1074,6 +1074,16 @@ static inline bool zone_device_page_init_optimization_enabled(void)
 	return !page_ref_tracepoint_active(page_ref_set);
 }
 
+static inline void zone_device_tail_page_init(struct page *page,
+		unsigned long pfn, unsigned long zone_idx, int nid,
+		struct dev_pagemap *pgmap, const struct page *head,
+		unsigned int order)
+{
+	zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
+	prep_compound_tail(page, head, order);
+	set_page_count(page, 0);
+}
+
 /*
  * 'template' is a reusable page prototype rather than a strictly immutable
  * object. Most ZONE_DEVICE fields stay constant across the pages covered by
@@ -1131,10 +1141,12 @@ static void __ref memmap_init_compound(struct page *head,
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
@@ -1143,12 +1155,29 @@ static void __ref memmap_init_compound(struct page *head,
 	 * the pages in the same go.
 	 */
 	__SetPageHead(head);
+
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
+		if (!use_template) {
+			zone_device_tail_page_init(page, pfn, zone_idx, nid,
+						   pgmap, head, order);
+		} else if (pfn == head_pfn + 1) {
+			/*
+			 * All tails of the same compound page share the
+			 * state established by prep_compound_tail(). Reuse
+			 * one tail template for the whole range and
+			 * refresh only the PFN-dependent fields in that
+			 * template before each copy.
+			 */
+			zone_device_tail_page_init(page, pfn, zone_idx, nid,
+						   pgmap, head, order);
+			/* init template page */
+			memcpy(&template, page, sizeof(*page));
+		} else {
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+		}
 	}
 	prep_compound_head(head, order);
 }
@@ -1210,7 +1239,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap),
+				     use_template);
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.20.1
