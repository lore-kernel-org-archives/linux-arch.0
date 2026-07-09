Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918893ED3B2
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596444; cv=none; b=hk5kmpK16Jw8S/9F/cdqxSzww3N1GuKG5sBL8gJJLBbaUAnogPwdRds3UF+2KLKgADFgXTYQR7osPHOfxzpj25fmYowzIQU+X+9/lPkMng7xnH3sVjcjtwcERKoixwOAPmWkjBy9w9qeS4X7tnlYgR42DpU5HrnJwtzPrjsGVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596444; c=relaxed/simple;
	bh=np4DPOsytNf8c3K3MHibm1YsArRbZIOpmor+YhM0ecg=;
	h=Cc:Subject:Message-Id:To:From:Date:Mime-Version:In-Reply-To:
	 Content-Type:References; b=V/NbtKBgqGemw8oooQD6vdREApcGsmtYMPep9wBKtC9ypZHRCfV3wGVL8/A8kTwmG9Ez9kWDg3Go7aGcbXqHHGtFbphcaPIdyTFg5S/dIj17P+mBWWbAYNSz9Kxu6R8Xs4WEfM5u5FVSdAQacYGr9HdRhPHXWRPh3pYMyU3kk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OrSDs+uw; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OrSDs+uw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596435; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=v9CZpy1rL9Q8Ha/0FdtpD+kuKFGiz/BvcuwBKqI0mU0=;
 b=OrSDs+uwB8hCxnNYIkf56XmTfrqbCZdIAf2Z/8nw+e77gH7O1kYBGVpIt6PBN0Xp5Be/dQ
 ZDeG1+1yKsCoW5YHDFkZIvkbSddYdFOFR2K8NaBbnc7LThupcSaNJrQoathXkNZLmgMCJJ
 5/SzlKTWADOsaFBqwgKoiThGNxJ5Ak9fFl5SoHCZpvS0h8UWL1iqgrZa2YORqnDkhZGuAw
 9vEZFDh4G/LzzFmvmO2OwWfJ8RsSXE23hDn8KnvSDDPD68eIDIcuFY34F7EHBeP4Ssyhb4
 6RXCz9rY7bdm+DSieQ6MKEZI82pkftcmo5hnYIAUXTaFo2haf2hHiM3JnUjgzw==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
Subject: [PATCH v6 4/8] mm: add a template-based fast path for zone-device page init
Message-Id: <20260709112520.24857-5-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Thu,  9 Jul 2026 19:25:16 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a4f8591+56efed+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>

memmap_init_zone_device() repeats nearly identical head-page
initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
template through the existing slow path, refresh the PFN-dependent
fields in that template before each copy, and memcpy it into each
destination page.

The optimized path assigns _refcount through the copied template, so
keep it disabled when the page_ref_set tracepoint is enabled.

This patch accelerates head-page initialization. The pfns_per_compound
== 1 case gets the full benefit here, compound tails are handled in the
next patch.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
path (pfns_per_compound == 1).

Test procedure:
Rebind the nd_pmem driver 30 times and collect the memmap initialization
time from the pr_debug() output of memmap_init_zone_device().

Base(v7.2-rc1):
  First binding: 1456 ms
  Average of subsequent rebinds: 244.28 ms

With this patch and its prerequisites applied:
  First binding: 1440 ms
  Average of subsequent rebinds: 217.19 ms

This reduces the average rebind time from 244.28 ms to 217.19 ms, or
about 11%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5fccfbacf855..170021e182e0 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1065,6 +1065,44 @@ static void __ref zone_device_page_init_slow(struct page *page,
 		set_page_count(page, 0);
 }
 
+static inline bool zone_device_page_init_optimization_enabled(void)
+{
+	/*
+	 * The template fast path copies a preinitialized struct page image.
+	 * Skip it when the page_ref_set tracepoint is enabled.
+	 */
+	return !page_ref_tracepoint_active(page_ref_set);
+}
+
+/*
+ * 'template' is a reusable page prototype rather than a strictly immutable
+ * object. Most ZONE_DEVICE fields stay constant across the pages covered by
+ * the current template, but section bits and page->virtual may still depend
+ * on the PFN. Refresh those PFN-dependent fields in the template before
+ * copying it into @page.
+ */
+static inline void zone_device_page_update_template(struct page *template,
+		unsigned long pfn)
+{
+	set_page_section_from_pfn(template, pfn);
+#ifdef WANT_PAGE_VIRTUAL
+	if (!is_highmem_idx(ZONE_DEVICE))
+		set_page_address(template, __va(pfn << PAGE_SHIFT));
+#endif
+}
+
+static void zone_device_page_init_from_template(struct page *page,
+		unsigned long pfn, struct page *template)
+{
+	/*
+	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
+	 * page. Update the PFN-dependent fields in place before copying it
+	 * to the destination page.
+	 */
+	zone_device_page_update_template(template, pfn);
+	memcpy(page, template, sizeof(*page));
+}
+
 /*
  * With compound page geometry and when struct pages are stored in ram most
  * tail pages are reused. Consequently, the amount of unique struct pages to
@@ -1120,6 +1158,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
+	bool use_template = zone_device_page_init_optimization_enabled();
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
@@ -1127,6 +1166,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
+	struct page template;
 
 	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
 		return;
@@ -1144,7 +1184,24 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
+		if (!use_template) {
+			zone_device_page_init_slow(page, pfn, zone_idx,
+						   nid, pgmap);
+		} else if (pfn == start_pfn) {
+			/*
+			 * Seed the reusable head-page template from the
+			 * first real struct page, because the existing
+			 * page-init and pageblock helpers expect a real
+			 * memmap entry rather than a stack object.
+			 */
+			zone_device_page_init_slow(page, pfn, zone_idx,
+						   nid, pgmap);
+			/* init template page */
+			memcpy(&template, page, sizeof(*page));
+		} else {
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+		}
 
 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
-- 
2.20.1
