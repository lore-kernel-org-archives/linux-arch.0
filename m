Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC93CDBC0
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596647; cv=none; b=npG0nqFB63X0s3JzxFl4sp4eZoFZmENmUquFr+f70Q5hYlGbFBME6F92Rfa7BT08//G3QIsAMlnEwPPO/EdphBK4iPS2LvsIUuoRVbolo++gn/2LVTrR9XkgVkb8N0uvGelBfCBd1QgQkF6vIqCLgtJTSQO7mTMX65HxBhg+4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596647; c=relaxed/simple;
	bh=j950b+jkxnNMvrl29X1CJHyRzGrjQn2bn3MzFAZQt4c=;
	h=From:In-Reply-To:Content-Type:Cc:Date:Mime-Version:To:Subject:
	 Message-Id:References; b=KFWKuISTo4/61dXFc0itEi8MOr5ygMcG5IKnJ7vhax0s3wxERa+9x1LDix/MZKwpG5gHVr4Uez15GnC8BnlPhIjvRQHcqsSntdlQ+znYsk7jZAWe+PXRpO1yHZVcjIATInYjT25FVZPzjnv0GdecpwhDlnfwPW8hT2EHjuzjOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kwKIzdWJ; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kwKIzdWJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596527; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UJcKYOJQhKyg/isyMbMzrX1li+G0ZF58QSuW2HC410c=;
 b=kwKIzdWJAlIq6wGx8BgDz//6S0ckbT7x52bNr5qRL0mAfXe5FUrk8K9jV+vJ3GqcG4QqNl
 awQbHDCeAcBw6PVa2QXO+v+9fF9hLg8OG2k9ymylKNLVUi6HZxMmky1oJCkeMcdK7ICds7
 GMpURhN7E5wXZtnKxZLpdPTApnCrn9B0yNt8fnIRAQ/+gp0zaYtk2/2OpVJGr64G18vzz8
 n7lnAFIsCwyTQBI0Q3WDVetpP+4Gb9/ZA0k3Ot3MMNIK4l1EF9ieN7BsZ5uOcAtUW9SgzX
 u9aX5GEflM9TfqtonNut8gyMXmGW7QIFpkUuyi/PzBPhY8yhEsIaRQomO9AYaw==
From: "Li Zhe" <lizhe.67@bytedance.com>
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
Date: Thu,  9 Jul 2026 19:25:20 +0800
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a4f85ed+a011e9+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v6 8/8] mm: use memcpy_nt() in zone-device template copies
Message-Id: <20260709112520.24857-9-lizhe.67@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>

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
index fb855bb0437a..addb4969587e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1067,11 +1067,21 @@ static void __ref zone_device_page_init_slow(struct page *page,
 
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
 
 static inline void zone_device_tail_page_init(struct page *page,
@@ -1110,7 +1120,7 @@ static void zone_device_page_init_from_template(struct page *page,
 	 * to the destination page.
 	 */
 	zone_device_page_update_template(template, pfn);
-	memcpy(page, template, sizeof(*page));
+	memcpy_nt(page, template, sizeof(*page));
 }
 
 /*
@@ -1179,6 +1189,15 @@ static void __ref memmap_init_compound(struct page *head,
 							    &template);
 		}
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
 
@@ -1238,10 +1257,26 @@ void __ref memmap_init_zone_device(struct zone *zone,
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
