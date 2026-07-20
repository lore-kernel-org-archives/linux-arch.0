Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A496369224
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549325; cv=none; b=bao7gOkCiaZTdnUvzib+SFnmvbu0hvreSzJN4UlT1CAFI7iGq0a1c0p88RO/PLRGzZhg0Mo/Hix3wGykd6dA2PUct0YHFSrZfnt/L2M05KDmkysfOg40nA9dmKrAQaeWj6i84e0b5TMeNkEm1F4tUg4iXvqdzQ7O6kNolSx8juI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549325; c=relaxed/simple;
	bh=B2lFffzW9abBCwheY0aePRqx8cZ0hJLWqOzMVlKY2nk=;
	h=To:Subject:Date:Message-Id:From:Mime-Version:References:
	 Content-Type:Cc:In-Reply-To; b=jRDdaerTpWt+q3QBox7Yi5vetVSEhrylD2INC0Ey7HMKFb9ZapcBCjnSy/UcqkJAzz+b3cgqr0Mh89IBKpDJIe/KQZuaB3L/G3/XFlKpVHKKC02dG7S1ubhmLpbtOtuf2dYTF/guZSTKLl39kKGtw0FVVccQmO+x6BltDyyyuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y3ADUwL8; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y3ADUwL8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549316; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=j8bUTrgrk6ymdv5ZLPK/ZcA1DiVAjVvBeifaSs352+I=;
 b=Y3ADUwL88UciMimN1WEiiFPPwgiVjrR2a0x2Eot/LtPBCXNdVcXDS3VBhUk/CFGzHOKs31
 98vng044HT5FYxQThZvPtq7b3O981oiTiERtxdrogTEtn/cPcFr31izfOCBUTDDkHEssvD
 TWYGbzgZ2i/W4tcI3zKo/9mFl8sdlEKLwab+kVPUtWKhCh3Xw68bma7N1EBsR1yEsoHxa7
 juLhiNqsywhrNiH1bjMi2naKzdBUqNOC90rIcDH0ajpPANuZJnFYe/JRq8SQOPRkyBIfrw
 3TSYvNJFg84seXQZXvXg9LFGg+jC9qP1d5S9k7Rg5VhDgBQHcn11ddbugSoPrg==
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
Subject: [PATCH v7 9/9] mm: always use the zone-device template init path
Date: Mon, 20 Jul 2026 20:02:59 +0800
Message-Id: <20260720120259.1545-11-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a5e0fc2+d70c9f+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>

The template path still has a local opt-out predicate for the
page_ref_set tracepoint and keeps a non-template fallback path. This
makes the code more complex without a strong reason to keep the
separate path.

Use the template path unconditionally after the corresponding seed page
has been initialized: the first head page seeds the head template, and
the first tail page in each compound range seeds the tail template.

This keeps the first-page seeding logic unchanged, but removes the extra
non-template fallback from the main loops.

This also means sanitized builds no longer force this path back to the
per-page initialization stores, and an enabled page_ref_set tracepoint
will no longer observe every ZONE_DEVICE initialization-time refcount
assignment. That tradeoff is intentional: this code is still initializing
struct pages before they are handed out, and keeping those local debug
special cases would preserve a separate initialization-only path while
making the common code more complex.

Suggested-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2a723a518f41..ae42a1311e1d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1065,25 +1065,6 @@ static void __ref zone_device_page_init_slow(struct page *page,
 		set_page_count(page, 0);
 }
 
-static inline bool zone_device_page_init_optimization_enabled(void)
-{
-	/*
-	 * Keep sanitized builds on the slow path so their stores stay
-	 * instrumented.
-	 */
-	if (IS_ENABLED(CONFIG_KASAN) || IS_ENABLED(CONFIG_KMSAN))
-		return false;
-
-	/*
-	 * The template fast path copies a preinitialized struct page image.
-	 * Skip it when the page_ref_set tracepoint is enabled.
-	 */
-	if (page_ref_tracepoint_active(page_ref_set))
-		return false;
-
-	return true;
-}
-
 static inline void zone_device_tail_page_init(struct page *page,
 		unsigned long pfn, unsigned long zone_idx, int nid,
 		struct dev_pagemap *pgmap, const struct page *head,
@@ -1151,8 +1132,7 @@ static void __ref memmap_init_compound(struct page *head,
 				       unsigned long head_pfn,
 				       unsigned long zone_idx, int nid,
 				       struct dev_pagemap *pgmap,
-				       unsigned long nr_pages,
-				       bool use_template)
+				       unsigned long nr_pages)
 {
 	unsigned long pfn, end_pfn = head_pfn + nr_pages;
 	unsigned int order = pgmap->vmemmap_shift;
@@ -1169,10 +1149,7 @@ static void __ref memmap_init_compound(struct page *head,
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (!use_template) {
-			zone_device_tail_page_init(page, pfn, zone_idx, nid,
-						   pgmap, head, order);
-		} else if (pfn == head_pfn + 1) {
+		if (pfn == head_pfn + 1) {
 			/*
 			 * All tails of the same compound page share the
 			 * state established by prep_compound_tail(). Reuse
@@ -1197,7 +1174,6 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
-	bool use_template = zone_device_page_init_optimization_enabled();
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
@@ -1223,10 +1199,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (!use_template) {
-			zone_device_page_init_slow(page, pfn, zone_idx,
-						   nid, pgmap);
-		} else if (pfn == start_pfn) {
+		if (pfn == start_pfn) {
 			/*
 			 * Seed the reusable head-page template from the
 			 * first real struct page, because the existing
@@ -1249,8 +1222,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap),
-				     use_template);
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.20.1
