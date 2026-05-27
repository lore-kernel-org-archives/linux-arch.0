Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C902D7DDD
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853129; cv=none; b=OzmrgCo8/4xmFF2/0zbkUSzl9zgm0wL5VOoU1IWTZxunBdjh4suYWiOYIOL2wvCWWgit8E1o3rp5ELol1EhWR0468Mo7GrVzN8Zf6OLZpsNX7wkyMM+Gik/WWgvM2U89pWWGpr7dotCB9/FCev1qgNlOF8YsxGu5wwF/YDj0Kok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853129; c=relaxed/simple;
	bh=zEwM4ExvxDP39KFMRfs9oCMwfWnr8A/tcgD3Hi6W860=;
	h=Cc:References:Message-Id:Subject:Date:Mime-Version:In-Reply-To:
	 Content-Type:To:From; b=j3pswJcxtj9ZSpSqscfPk6ccXW+d+qiVMtapNeiF0wnYbps2VKzhGnjk2ROghqyT6X7MizZD31N6YrL0GCMxf8PFVd9s+wxvuxz2IABylgwEJI3Iw/YnugFG+i7NUWUA5VMHaff6Fr6CF2+ZXOnTvXGcgV/Nw5lqCC1mM4MC8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=neZhJ7m/; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="neZhJ7m/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779853122; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PAoGwOogI0538Jjz3Jr5mPaMM02ePyByPYJiX1kFuRI=;
 b=neZhJ7m/rmzXpsdK/7NyQsm0Tyqm8pOxRJ21fCT9oMOcS4L7iqlXO0Nxhrc0V7VavhVyAe
 GwUkBQA5f66OnY0/zBq86VK6Qnwn/DYWUrh4lIryFRsEVRqLVHyTKx1VEDM3TJmdomuIKQ
 nB0c5FbiXbpal+2WX7Rq1AloKVMByqVMLVMw+42dZFa9Y1SmbEhBYktLgkbJRNYBtmlG0v
 BRsd1UirrTmEUwpxGDOimZZvjOOfm3G3+jR6COoa3LE1hbABUVSgD8chus7VccHzOuu2ZW
 xnSEjwyxcIMBMl47qzyu2T14Wv3X6AMlN+Avo/UGRT5GuqlR7C+calqK056fDA==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>
References: <20260527033636.28231-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Message-Id: <20260527033636.28231-3-lizhe.67@bytedance.com>
Subject: [PATCH v3 2/8] mm: factor zone-device page init helpers out of __init_zone_device_page
Date: Wed, 27 May 2026 11:36:30 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260527033636.28231-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a166740+e8fbf4+vger.kernel.org+lizhe.67@bytedance.com>

memmap_init_zone_device() currently mixes refcount policy, core
ZONE_DEVICE page setup, and pageblock metadata handling in a single
helper.

Factor the refcount-reset predicate into pagemap_resets_refcount(), move
the common page initialization into __zone_device_page_init(), split
pageblock handling into zone_device_page_init_pageblock(), and wrap the
existing slow path in zone_device_page_init_slow().

This keeps the slow-path behaviour unchanged and gives later patches
reusable helper boundaries.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 62 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 35de3b6a186d..2e5899c5cf35 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -987,11 +987,38 @@ static void __init memmap_init(void)
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
+/*
+ * Return true when the free path for this pagemap type restores the page
+ * refcount to 1, so memmap_init_zone_device() can keep the count set by
+ * __init_single_page(). Otherwise initialize the refcount to 0 and leave
+ * it to the allocator or pgmap callbacks to raise it when the page is
+ * handed out again.
+ */
+static inline bool pagemap_resets_refcount(const struct dev_pagemap *pgmap)
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
+		return false;
+	case MEMORY_DEVICE_GENERIC:
+		return true;
+	default:
+		WARN_ONCE(1, "Unknown memory type!");
+		return true;
+	}
+}
+
+static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
 					  unsigned long zone_idx, int nid,
 					  struct dev_pagemap *pgmap)
 {
-
 	__init_single_page(page, pfn, zone_idx, nid);
 
 	/*
@@ -1010,7 +1037,11 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 */
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
+}
 
+static void __ref zone_device_page_init_pageblock(struct page *page,
+						  unsigned long pfn)
+{
 	/*
 	 * Mark the block movable so that blocks are reserved for
 	 * movable at startup. This will force kernel allocations
@@ -1025,23 +1056,16 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
 		cond_resched();
 	}
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
+	if (!pagemap_resets_refcount(pgmap))
 		set_page_count(page, 0);
-		break;
-
-	case MEMORY_DEVICE_GENERIC:
-		break;
-	}
+	zone_device_page_init_pageblock(page, pfn);
 }
 
 /*
@@ -1080,7 +1104,7 @@ static void __ref memmap_init_compound(struct page *head,
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
 		prep_compound_tail(page, head, order);
 		set_page_count(page, 0);
 	}
@@ -1116,7 +1140,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
 
 		if (pfns_per_compound == 1)
 			continue;
-- 
2.20.1
