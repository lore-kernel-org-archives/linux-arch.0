Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8223B2FDB
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896940; cv=none; b=W9LUX2SSIiXjrZzuxg8cTWg8T5RZhzwtrzSJUEqaUWWG+EpHbNVAKg+Bo17XYHSgzaRzNRJykjaF1LB8dyudv9M3xTnTmoC8dPNkKCvFA5I1gvQP4lQrP3dpx6iifZCWuwfV/qxKmRWXxyPF8VjzzouzhCVaSnvHoyhM20hUc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896940; c=relaxed/simple;
	bh=svQWzxEVmxgAbEyJ6zcLPMSDVD32mcJAkW2hgkQlf0E=;
	h=Mime-Version:References:Content-Type:Cc:Subject:To:From:
	 In-Reply-To:Date:Message-Id; b=daIGypdRMNnbPFWpedUBPs2x6yQUv0RtkV+itsid3hqlh8ZPQWI1XerQCR18z4q3xA33+KiZ5/taIx88whHqwBAed4qc+JXNO5fIqKdK8IyqleB/x0fVpcCbPGArZUcQXE/F5BT8v23b61Se9ezpJNtnZMI8MylVe+EPrJbUJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z2axJOc0; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z2axJOc0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782896931; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/4LpGd1s160eDq45kTLayWuXfCywKUfCzxMxs45e1/A=;
 b=Z2axJOc0VO7AxiEyvJIs1079BbQWS5QAKOqh4D16BOKQED38V2mn+wp3ryfn/04sCnqtO3
 n4hyoSzvFfATOSNW6c5ISjiJAAHsUoTPgtjI5M7ZFznL1V6odxPRi/Lc+Jv4t4yJpi6F0R
 tcBFQDTn2AW2ByiWyeJgEHJ+Y10CaW29Lpi60NNF4OpVHORPrJbDEeh4DvwKWKoKeF7KEi
 noIcFSxXZZqCHDfzW/Ru2/zB0y5MXsYeiomAgeK3wD4K4+IjD8186elRGdJirZ+/3+gHmz
 Ff3fV4tijmXfIBbJauislEcwRHvnyWhut0cwqptt5s6eIDsV6FcF+jBrc38uPA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Subject: [PATCH v5 5/8] mm: extend the template fast path to zone-device compound tails
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a44d921+59cb82+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
Date: Wed,  1 Jul 2026 17:05:50 +0800
Message-Id: <20260701090553.62691-6-lizhe.67@bytedance.com>

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
 mm/mm_init.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index cc8417951467..60794050bc07 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1081,6 +1081,16 @@ static inline void zone_device_template_page_init(struct page *template,
 	memcpy(template, src, sizeof(*template));
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
@@ -1138,10 +1148,12 @@ static void __ref memmap_init_compound(struct page *head,
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
@@ -1150,12 +1162,31 @@ static void __ref memmap_init_compound(struct page *head,
 	 * the pages in the same go.
 	 */
 	__SetPageHead(head);
-	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
+
+	pfn = head_pfn + 1;
+	/*
+	 * All tails of the same compound page share the state established by
+	 * prep_compound_tail(). Reuse one tail template for the whole range and
+	 * refresh only the PFN-dependent fields in that template before each copy.
+	 */
+	if (use_template) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
+		zone_device_tail_page_init(page, pfn, zone_idx, nid,
+					   pgmap, head, order);
+		zone_device_template_page_init(&template, page);
+		pfn++;
+	}
+
+	for (; pfn < end_pfn; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (use_template)
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+		else
+			zone_device_tail_page_init(page, pfn, zone_idx, nid,
+						   pgmap, head, order);
 	}
 	prep_compound_head(head, order);
 }
@@ -1205,7 +1236,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		zone_device_template_page_init(&template, page);
 		if (pfns_per_compound != 1)
 			memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				compound_nr_pages(start_pfn, altmap, pgmap));
+				compound_nr_pages(start_pfn, altmap, pgmap),
+				use_template);
 		pfn += pfns_per_compound;
 	}
 
@@ -1226,7 +1258,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap),
+				     use_template);
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.20.1
