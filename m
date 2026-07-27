Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD2371897
	for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2026 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155750; cv=none; b=cDKgGA9udtAD53o7z4wVZXpCRIgeeTV6fcm0g+qiDabDjggkPLgtBQ669md3+YmWo/TjDXuVuzTa6TjScI54KvfwFaox2oFlTqmLQtGilFT1SCLhpCPblI0kU/I3afjsRtThxD6JJhx+IW9++4HYGMMN+zFFeFD+e06cIucUjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155750; c=relaxed/simple;
	bh=DevAn1r9WS6pPdFWehOAQ0KmRVHSptKuRZyUe2bUpqI=;
	h=Date:Mime-Version:To:Subject:References:Content-Type:Cc:From:
	 Message-Id:In-Reply-To; b=O9PLojeLojSNprFE0RDSoaMMfTbyoU3t62XiJuvdJ0ykmhGU6oDrKqiKw11q9NOWmNeSyYN0sPi/g45UTfaiRhGSlbU5kfngPDH0JLs17+sm1aUgWwKys0pKQeCFbnzcrHYKs4Prddfm+lCI42QmtwhXdK1owqqQKL0OC80HTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=oOqyKSXw; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="oOqyKSXw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785155743; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=z2FZl2/YzaMjC0aIAZHsTKk9OBnNm9ulSHwBzV0fwO8=;
 b=oOqyKSXwLOpVVJC8j54MdBlrwcfUpS6vT0ZCATMETVM+EoJeqYyf0F0//b+Amp+MleIXeS
 L0Pg94dSI1e5FxLv9uCtglaNojdlGTJUcsxu4DcMdneM+RZ5NDVoiIH+qQ/B0+3jAXIA/2
 iqA8FDGYoSAx93s9dEVxrhJ7f66jqVqJ22AVitfAPTh1JyqtVzdhzTZWE4E8ZFg6KZ+H+S
 5a29gLXIruZ7+fQoEAJnnPzdC9FKrPAGt1Lb7C/XCaLwNJTHPHLFy8fnjGIdeJ0YYyjiR5
 Gtew+Uc/ZNRPl+6IeDO2kxdaGfx3Wcb/91zRI03WOsIPlv7wY2TXG9iGViA5Dw==
Date: Mon, 27 Jul 2026 20:34:22 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v8 2/9] mm: factor zone-device page init helpers out of __init_zone_device_page
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a67509d+a16c68+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260727123429.5673-3-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <20260727123429.5673-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2

memmap_init_zone_device() currently mixes refcount policy and core
ZONE_DEVICE page setup in a single helper.

Factor the refcount-reset predicate into pagemap_requires_refcount_reset(),
move the common page initialization into __zone_device_page_init(), and
wrap the existing slow path in zone_device_page_init_slow().

This keeps the slow-path behaviour unchanged and gives later patches
reusable helper boundaries.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 56 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 95808ab5cfdb..a70acb7431a6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
+/*
+ * Return true when memmap_init_zone_device() must initialize the page
+ * refcount to 0. MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in
+ * the free path, while the remaining ZONE_DEVICE types start from 0 here
+ * and raise the count again when the allocator or driver hands the page
+ * out.
+ */
+static inline bool pagemap_requires_refcount_reset(const struct dev_pagemap *pgmap)
+{
+	/*
+	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
+	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
+	 * the count again when the allocator or driver hands the page out.
+	 */
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		return true;
+	case MEMORY_DEVICE_GENERIC:
+		return false;
+	}
+
+	return false;
+}
+
+static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
 					  unsigned long zone_idx, int nid,
 					  struct dev_pagemap *pgmap)
 {
-
 	__init_single_page(page, pfn, zone_idx, nid);
 
 	/*
@@ -1028,23 +1054,15 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 */
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
+}
 
-	/*
-	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
-	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
-	 * the count again when the allocator or driver hands the page out.
-	 */
-	switch (pgmap->type) {
-	case MEMORY_DEVICE_FS_DAX:
-	case MEMORY_DEVICE_PRIVATE:
-	case MEMORY_DEVICE_COHERENT:
-	case MEMORY_DEVICE_PCI_P2PDMA:
+static void __ref zone_device_page_init_slow(struct page *page,
+		unsigned long pfn, unsigned long zone_idx, int nid,
+		struct dev_pagemap *pgmap)
+{
+	__zone_device_page_init(page, pfn, zone_idx, nid, pgmap);
+	if (pagemap_requires_refcount_reset(pgmap))
 		set_page_count(page, 0);
-		break;
-
-	case MEMORY_DEVICE_GENERIC:
-		break;
-	}
 }
 
 /*
@@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct page *head,
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
 		prep_compound_tail(page, head, order);
 		set_page_count(page, 0);
 	}
@@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
 
 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
-- 
2.20.1
