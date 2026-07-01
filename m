Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367642AA6
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897044; cv=none; b=FnujDFv/pjc4nLnKVX6y/sul+t8fo+IQNkVQCasAisfgb69lXtOthCiqUhLXVvvBY7QEyrtJsIyWhz37tpxZdE+3o7+G1rBLR4lfLn9PL+2be6xZKZwJ5mEwaLFtst5liN0t3n0QAf/a7a3PFC1iYZH91a6rKZuuv0yZ86vEveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897044; c=relaxed/simple;
	bh=DJH5VPQ9C2rXVhaYH29KFr8idIoJk7Lw1ncLDIhEzFY=;
	h=To:Cc:Mime-Version:In-Reply-To:From:Date:Content-Type:Message-Id:
	 Subject:References; b=oMG8myl+KEW4Ne0OH6Gshh56pTsL2gO7VSHkb8SncMDd/y5RyeB4pKEQxkcz7OWAtszSk60XgXP5ylUcFKqU7HmPRjVPX96K4JWl8jyvNv5cIjknE6AkaQq2HWqtK++I+kyRNWb7uJ2y8kxII4Z2kbuKaFLSEs+chF2ZcKXuEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YqIH91RW; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YqIH91RW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782897037; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=GlwU9A21h4aOkD7NMu1GopyeMNyt93ZxYgfEuylocqo=;
 b=YqIH91RWGvPGdu3vZjAvfTwcnIR/y98PgvyiFvSKOckgXekNzE4ufnke6fRvUzKc2b5vB0
 WdFh0BSqQ7z5I60ojq/g24Lwkzj+j//emWWABoc5C9mBNPlDNPVrUIxlYSVb20UEO3cUlo
 uFPuskvEP0VW+SNllhlWWXNDokQHTIjA+dTaKL6BbT0jqHkBoqbCFixSqGcwviMcDwhDmt
 gibEq56ydx9u6PDV73tZLGymkUSj7fTPkJSXRz6mFm1kiMIzzkfJjeUJvzxl3awSqhu/hq
 cDuwH01ht8S19s8KvbTgb2ZiYp82FoQPl5kU2zQYSk+e6xWMUsettbQ83QaFYQ==
X-Lms-Return-Path: <lba+26a44d98b+4a7ced+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed,  1 Jul 2026 17:05:53 +0800
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260701090553.62691-9-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
Subject: [PATCH v5 8/8] mm: use memcpy_nt() in zone-device template copies
References: <20260701090553.62691-1-lizhe.67@bytedance.com>

The template fast path currently uses memcpy() for the actual struct
page copy. Switch zone_device_page_init_from_template() to memcpy_nt()
and add memcpy_nt_drain() before memmap_init_compound(), before
prep_compound_head() updates overlapping tail metadata, and before
returning from memmap_init_zone_device().

ZONE_DEVICE memmap initialization is largely write-once: each struct
page is populated once, and most destination cachelines are not expected
to be reused immediately afterwards. On x86, a regular cached memcpy()
can therefore incur write-allocate traffic by pulling destination
cachelines into the cache before writeback, and can populate the cache
with data that has little near-term reuse. Using memcpy_nt() lets this
path request non-temporal stores for that copy pattern, which can reduce
cache pollution and avoid part of the associated write-allocate
overhead, while architectures without a specialized backend still fall
back to memcpy().

When memcpy_nt() maps to non-temporal stores, order those stores before
memmap_init_compound(), before prep_compound_head() updates overlapping
compound metadata, and before returning from memmap_init_zone_device().

Keep sanitized builds on the slow path so KASAN/KMSAN retain their
instrumented stores.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.2-rc1):
  First binding for nd_pmem driver: 1456 ms
  Average of subsequent rebinds: 244.28 ms

  First binding for dax_pmem driver: 1462 ms
  Average of subsequent rebinds: 273.31 ms

With this series:
  First binding for nd_pmem driver: 1272 ms
  Average of subsequent rebinds: 96.79 ms

  First binding for dax_pmem driver: 1354 ms
  Average of subsequent rebinds: 119.04 ms

This reduces the average rebind time by about 60.4% for nd_pmem and
56.4% for dax_pmem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 60794050bc07..eb8859a62f70 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1068,11 +1068,21 @@ static void __ref zone_device_page_init_slow(struct page *page,
 
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
@@ -1117,7 +1127,7 @@ static void zone_device_page_init_from_template(struct page *page,
 	 * to the destination page.
 	 */
 	zone_device_page_update_template(template, pfn);
-	memcpy(page, template, sizeof(*page));
+	memcpy_nt(page, template, sizeof(*page));
 }
 
 /*
@@ -1188,6 +1198,15 @@ static void __ref memmap_init_compound(struct page *head,
 			zone_device_tail_page_init(page, pfn, zone_idx, nid,
 						   pgmap, head, order);
 	}
+
+	/*
+	 * When the template path is enabled, order the preceding tail-page copies
+	 * before prep_compound_head() updates the overlapping compound metadata
+	 * in the first tail-page descriptors. If memcpy_nt() fell back to
+	 * regular cached stores, memcpy_nt_drain() may be a no-op.
+	 */
+	if (use_template)
+		memcpy_nt_drain();
 	prep_compound_head(head, order);
 }
 
@@ -1257,10 +1276,26 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		if (pfns_per_compound == 1)
 			continue;
 
+		/*
+		 * When the template path is enabled, order the preceding head-page copy
+		 * before memmap_init_compound(), which immediately updates compound-head
+		 * metadata. If memcpy_nt() fell back to regular cached stores,
+		 * memcpy_nt_drain() may be a no-op.
+		 */
+		if (use_template)
+			memcpy_nt_drain();
+
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
 				     compound_nr_pages(pfn, altmap, pgmap),
 				     use_template);
 	}
+	/*
+	 * Ensure any prior template copies are ordered before returning.
+	 * On architectures where memcpy_nt() used regular cached stores,
+	 * memcpy_nt_drain() may be a no-op.
+	 */
+	if (use_template)
+		memcpy_nt_drain();
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
 
-- 
2.20.1
