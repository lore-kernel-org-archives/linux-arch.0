Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94140407592
	for <linux-arch@vger.kernel.org>; Wed,  3 Jun 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473990; cv=none; b=MKQa5x/aK/5J2kGCthKXpN+yJqUR5wQcpRy6czKm6GoQ9a3v3tVpdzatUOpaOusgfwYow1+U3cdOt1ouL6Z9OGHMBM+CSliCvsFqUFf8oqkZ4CUIRUPq9J5303f7lnD0a1XGgoi61P3VIkwaiR3DneYHh5vCnOM+EPY+BX6oFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473990; c=relaxed/simple;
	bh=KlIrYySv42sjQ374Xuf4sWKDanycr+WDeKknoYsTVic=;
	h=Content-Type:From:References:In-Reply-To:To:Subject:Date:Cc:
	 Message-Id:Mime-Version; b=nU1pasU2HUBc3RkLRy1ntD3wJkNQZaLRyeNqeMtH6qXNqudaxcGtIB2wP+CXiQz64xWIkswuzIC/Xn/tNnfX3wSmYC1DIuldHkURc32v7OtaXAYPdDZeLlC2BKErL/+mQJr7UGvRXTwkTMkQkheaPw1i83cM3Pg9hvw9L/Mu4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CkDYJ4X/; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CkDYJ4X/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780473984; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=0+pxu4QONrexAlpcc34zjw3GPn7T+Jri0V38RE3OFI0=;
 b=CkDYJ4X/V8qxLlchNcKL8fTOAaZ4SJAT0AeDzNjKgbuv+HwOZ6ihzOAovB0owB1QkxfNZ9
 tVTJ+gDHEMddKMXnFvr5PEdiSqviN+/Qwp92BzlD+geecV13gUF6GXs8PxomqT5Q6FmIuH
 8lhCJBHPh8aiUP74KkseSaQNWo6YD9dSLRfcPyIA/utuGYqg289KZym8pAExSH7WA3Kpmg
 RNr28bCo97u9isEoHZKdEhQkuY5IZ0xppZ9IarAIspLg6VDJGPnSsj69S2A7zTmJ8mdkuH
 JDWLImM+rCaaHlxbRn44RN2opAML2ZrfR1DoqyebT6FMrVkZdFhNcXZo3owtlQ==
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
References: <20260603080152.64728-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <20260603080152.64728-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a1fe07e+1d0752+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Subject: [PATCH v4 5/8] mm: extend the template fast path to zone-device compound tails
Date: Wed,  3 Jun 2026 16:01:49 +0800
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Message-Id: <20260603080152.64728-6-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

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

Base(v7.1-rc6):
  First binding: 1430 ms
  Average of subsequent rebinds: 229.12 ms

With this patch and its prerequisites applied:
  First binding: 1336 ms
  Average of subsequent rebinds: 180.00 ms

This reduces the average rebind time from 229.12 ms to 180.00 ms, or
about 21.4%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 56fe71e966ae..ad078ee354fb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1083,6 +1083,16 @@ static inline void zone_device_template_page_init(struct page *template,
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
@@ -1134,10 +1144,12 @@ static void __ref memmap_init_compound(struct page *head,
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
@@ -1146,12 +1158,31 @@ static void __ref memmap_init_compound(struct page *head,
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
@@ -1200,7 +1231,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		zone_device_template_page_init(&template, page);
 		if (pfns_per_compound != 1)
 			memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-					     compound_nr_pages(altmap, pgmap));
+				compound_nr_pages(altmap, pgmap), use_template);
 		pfn += pfns_per_compound;
 	}
 
@@ -1218,7 +1249,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(altmap, pgmap),
+				     use_template);
 	}
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
-- 
2.20.1
