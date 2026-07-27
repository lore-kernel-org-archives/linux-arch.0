Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CD38DF9
	for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2026 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155942; cv=none; b=gkfITO9u7kaO4EiLtRbfA3Ruml554Vf5uxTKCgkpGE2BuolZK1Yoy9PBQguOFpnQt2VNGyRUIoWxevutBrBvUDt7MM5chjMCq4feKwy/jRlZkKbNnp6/mtGifO5HS1Kt3x/P0ODyufoaE1rDM4QvNEUrBnddJU11RSxApdTWLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155942; c=relaxed/simple;
	bh=B2lFffzW9abBCwheY0aePRqx8cZ0hJLWqOzMVlKY2nk=;
	h=In-Reply-To:Content-Type:Message-Id:Cc:Date:Mime-Version:
	 References:To:From:Subject; b=h02bCST6lA/7xBb8AjaiyWYy/KX+q5UtqAvWmsuFJVMJxj8PdsIEh7G7VBDDpSeFm7mgDLLdmwoq4IzOQq9+0gr2knlOLXNfOgJX1gexKDhru/Gll4J9M3XlIRd4HGFH3kC5elovBhnnTw1K0VQG/FYMO7NJNUEOd+eF18Hpjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i/ZIT7K9; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i/ZIT7K9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785155936; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=j8bUTrgrk6ymdv5ZLPK/ZcA1DiVAjVvBeifaSs352+I=;
 b=i/ZIT7K9AWdM6NeLqH7D243on8VjeaTkhMhJlFVCd3M3r+aHjOc5duwvNUuCmUVfakk4J7
 go0GaRFm6ZcNbE35tZEn9nEvVGzRz/dVfVHLExi2rn+UoPC774QCe0q1QR2uGzZzbViyaO
 CWX2NnmVddorxDapYQEwLtydu+zaJK28RG+LMMXNhElE5zc/HqQNTrOa+DTsgu5IjOXvbL
 O+2uxJyOQST0nenvI07DbKodnsiozggft2oJL0yVOiiWC1pdgqJ1UBgFa+yYL5/LHd3WZD
 sbLpmy/ZaV1hTZP34pt6Puj1YFnE6IfyfxldMMcQN0sVDTsbkb4o4ssB9sDXCg==
In-Reply-To: <20260727123429.5673-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260727123429.5673-10-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Date: Mon, 27 Jul 2026 20:34:29 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v8 9/9] mm: always use the zone-device template init path
X-Lms-Return-Path: <lba+26a67515e+6d2e2b+vger.kernel.org+lizhe.67@bytedance.com>

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
