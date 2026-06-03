Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17070405C44
	for <linux-arch@vger.kernel.org>; Wed,  3 Jun 2026 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474094; cv=none; b=IvzxcxH314/sbqLXB3HKhsI1JhHXMThZ+lced2dRDQ4DVzcGsEauDof4Gq7eeO+PV8DSekIqJQibK3t8xNx/z9eUNPPURyZ73X61beTm1xeNeD5yiOGizwfoeiF6FVTTPaZLS1SzZRjyZrakMaTiQ8L6wvqCDbLjgUWdw0dYpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474094; c=relaxed/simple;
	bh=NDZ6qErnQG6w0k+nmX3Ucp0GetTk9yJWwLhq6duuSSU=;
	h=In-Reply-To:Content-Type:To:From:Subject:Date:Message-Id:
	 References:Cc:Mime-Version; b=bRH3iYpgTv5521wK6EfkVx1s+0i/6/fLDI4XR1dLNuuNhziwf0SfBPE3mTpe67QoByzy9kEVBY6m4J7VF5MoiP3+rcYR5bg5nY3GgoGZpKWnkdY8fACIKk2x7CM0/BZWOo39wNkQqvI/73usjebvbzka7ChfKwRgxX9ev/fU4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=pB4S8BwY; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="pB4S8BwY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780474088; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=A5euipl6qc7ONaSWy009BEQvfxAQyFAQV+XgcOVI8kM=;
 b=pB4S8BwYAbNJ4NDAhr3y0o+XUY71E7wUogqlxhMSeC7adJ4B9e3UXJVbAjlOyy39srx9NF
 M6nBZgYHNkTxAxfQUI1EyJlHPBPk73tFzQqtarfY3fIDbYoKSx6wK05noC+cr7UjhqoJvf
 OnLbv6p13Dzpaeh/LC8msfhWHWaPViH4UO3Lk2/d9RueXY7+bnnVebgJP91lvv+So7GqdQ
 VHaJoMHp7BKTyxgdcPFmkVWL5QsIeNOBiQjVHgnbIht7lUfcjcCJOqHN7t06t1a/6vL5l6
 kDZBlBjOLpTdY4UZ8Mk1bFearc1ysjWCtxe0ttTdZqnrqW/xi0oudyu8UhQkdA==
X-Lms-Return-Path: <lba+26a1fe0e6+93eeaf+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260603080152.64728-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Subject: [PATCH v4 8/8] mm: use memcpy_streaming() in zone-device template copies
Date: Wed,  3 Jun 2026 16:01:52 +0800
Message-Id: <20260603080152.64728-9-lizhe.67@bytedance.com>
References: <20260603080152.64728-1-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2

The template fast path still leaves the actual copy sequence up to the
compiler. Use the streaming-copy helpers introduced in the previous
patches for the ZONE_DEVICE template-copy path so common mm code can
request a write-once copy primitive without embedding arch-specific
store layout in the generic layer.

ZONE_DEVICE memmap initialization is a write-once path: each struct page
is populated once and is not expected to be reused from cache
immediately afterwards. A regular cached copy can therefore incur
write-allocate traffic and pollute the cache without much benefit.
Using memcpy_streaming() lets this path use an architecture-optimized
streaming copy where available, while still degrading to memcpy() on
architectures that do not provide a specialized implementation.

Keep pageblock-aligned PFNs on memcpy() so pageblock initialization can
immediately read back page metadata without introducing a
read-after-streaming dependency. For the remaining PFNs, use
memcpy_streaming() so the hot path can avoid write-allocate traffic
while still leaving unsupported or unsuitable cases to the fallback
implementation.

When the streaming backend uses non-temporal stores, order them before
entering memmap_init_compound(), before prep_compound_head() updates the
overlapping compound metadata, and before returning from
memmap_init_zone_device().

Keep sanitized builds on the slow path so KASAN/KMSAN retain their
instrumented stores.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.1-rc6):
  First binding for nd_pmem driver: 1466 ms
  Average of subsequent rebinds: 262.12 ms

  First binding for dax_pmem driver: 1430 ms
  Average of subsequent rebinds: 229.12 ms

With this series:
  First binding for nd_pmem driver: 1359 ms
  Average of subsequent rebinds: 108.36 ms

  First binding for dax_pmem driver: 1273 ms
  Average of subsequent rebinds: 100.17 ms

This reduces the average rebind time by about 58.6% for nd_pmem and
56.3% for dax_pmem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index ad078ee354fb..fbc873284fb8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1070,11 +1070,21 @@ static void __ref zone_device_page_init_slow(struct page *page,
 
 static inline bool zone_device_page_init_optimization_enabled(void)
 {
+	/*
+	 * Keep sanitized builds on the slow path so their stores stay
+	 * instrumented.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN) || IS_ENABLED(CONFIG_KMSAN))
+		return false;
+
 	/*
 	 * The template fast path copies a preinitialized struct page image.
 	 * Skip it when the page_ref_set tracepoint is enabled.
 	 */
-	return !page_ref_tracepoint_active(page_ref_set);
+	if (page_ref_tracepoint_active(page_ref_set))
+		return false;
+
+	return true;
 }
 
 static inline void zone_device_template_page_init(struct page *template,
@@ -1117,9 +1127,19 @@ static void zone_device_page_init_from_template(struct page *page,
 	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
 	 * page. Update the PFN-dependent fields in place before copying it
 	 * to the destination page.
+	 *
+	 * pageblock-aligned pages immediately feed
+	 * init_pageblock_migratetype(), which reads back page metadata via
+	 * helpers like page_zone(page). Avoid a read-after-streaming
+	 * dependency for these rare pages by using regular cached stores
+	 * instead of non-temporal ones.
 	 */
 	zone_device_page_update_template(template, pfn);
-	memcpy(page, template, sizeof(*page));
+	if (unlikely(pageblock_aligned(pfn)))
+		memcpy(page, template, sizeof(*page));
+	else
+		memcpy_streaming(page, template, sizeof(*page));
+
 	zone_device_page_init_pageblock(page, pfn);
 }
 
@@ -1184,6 +1204,15 @@ static void __ref memmap_init_compound(struct page *head,
 			zone_device_tail_page_init(page, pfn, zone_idx, nid,
 						   pgmap, head, order);
 	}
+
+	/*
+	 * When the template path is enabled, order the preceding tail-page copies
+	 * before prep_compound_head() updates the overlapping compound metadata
+	 * in the first tail-page descriptors. If memcpy_streaming() fell back to
+	 * regular cached stores, memcpy_streaming_drain() may be a no-op.
+	 */
+	if (use_template)
+		memcpy_streaming_drain();
 	prep_compound_head(head, order);
 }
 
@@ -1248,10 +1277,26 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		if (pfns_per_compound == 1)
 			continue;
 
+		/*
+		 * When the template path is enabled, order the preceding head-page copy
+		 * before memmap_init_compound(), which immediately updates compound-head
+		 * metadata. If memcpy_streaming() fell back to regular cached stores,
+		 * memcpy_streaming_drain() may be a no-op.
+		 */
+		if (use_template)
+			memcpy_streaming_drain();
+
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
 				     compound_nr_pages(altmap, pgmap),
 				     use_template);
 	}
+	/*
+	 * Ensure any prior template copies are ordered before returning.
+	 * On architectures where memcpy_streaming() used regular cached stores,
+	 * memcpy_streaming_drain() may be a no-op.
+	 */
+	if (use_template)
+		memcpy_streaming_drain();
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
-- 
2.20.1
