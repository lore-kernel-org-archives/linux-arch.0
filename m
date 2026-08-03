Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB139FCB1
	for <linux-arch@vger.kernel.org>; Mon,  3 Aug 2026 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741146; cv=none; b=e7Oheg+nJq/7NyKU/HRCjdmvPgsQKS2d1SPoJ9nlt9uxal35D5IpKv2E9vVESk/B88YUxBrYEYedkuiH+emJSAJcBZupX35DP0J36dE682BRrq9iDsAWas73UOBoRym86i39xrgwRMMgGLitRTiFG+JdTFroBvKaQFWq1+h4yc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741146; c=relaxed/simple;
	bh=o826kn8U588updRRXUYQVFntnje06MBT6170xFpN0cU=;
	h=Content-Type:To:Cc:Mime-Version:References:From:Subject:
	 In-Reply-To:Date:Message-Id; b=F9dArEQPthQlc1eG64sOlNSEGsYik8ZTH7+OfHctNUM3GSpREmaJKbiSIdOuBpQ7dlg6p3PgUMxVoi67mlaCsn7C7ez7ngWreavL2ojEeLrRgQi9zF7k0sqcexvVigZONkI7sCraSe57Acgb7QarOeCv54Wap/Dv9e4A7VWCBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=q8zou163; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="q8zou163"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785741136; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QzfOHUwPwTz47PHoxHFvnWj+LzJxz+4qlyd4fHURS/o=;
 b=q8zou16300MC1W7e7yPTXD2oBxSau3+ECrMGu4Ox9gH4T6m08yOozCUPdBV2eVgDGm8BOJ
 ab2FVeJjik0zfvtMHi71aSQd5AdyQC93QXYW2S0UuRuUXPrvFCKZfaFF+JwIJCZauBTuuM
 3wbrPUaZdc6WcY4mCdfoi5Paf7hScsATlRpWl4DJeYG7NahTGRgh6hM3bQZ8ZXL+wHE3/1
 EaP6xySaFLbaMyWRGmVx7km+biMvilhW5mValFov+uzcseMaiIj6/XIFg+O5+qYoulOWmv
 fKWFDjQY3bP7c70sn76X6acCulGvywDvBurjl40XwfsNVb6by8JYYE7+DPsQRQ==
X-Lms-Return-Path: <lba+26a703f4e+e91667+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
References: <20260803070929.86075-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Subject: [PATCH v9 5/8] mm: extend the template fast path to zone-device compound tails
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260803070929.86075-1-lizhe.67@bytedance.com>
Date: Mon,  3 Aug 2026 15:09:26 +0800
Message-Id: <20260803070929.86075-6-lizhe.67@bytedance.com>

The template fast path from the previous patch only accelerates head
pages. Compound tails in memmap_init_compound() still go through the
zone_device_page_init_slow() one by one.

Build separate head and tail templates and reuse one prepared tail
template across the tail pages in a compound range. Head pages preserve
the existing refcount policy, while compound tails always start with a
refcount of 0 after prep_compound_tail().

This extends the template-copy fast path to pfns_per_compound > 1
without changing the existing zone_device_page_init_slow() helper.
Tail-page PFN-dependent fields are refreshed in the reusable tail
template before each copy.

Do not keep a separate non-template fallback for compound tails either.
This follows the same simplification suggested by Muchun: these pages
are still under memmap initialization, and the initialization-time
refcount updates are not part of the observable lifetime of pages handed
out later.

The impact is controlled for the same reason as for head pages. The
first tail page still seeds the reusable tail template through the
normal tail initialization sequence, and the copied tail pages have the
same final initialized state except for the PFN-dependent fields
refreshed before each copy.

Tested in a VM with a 100 GB devdax namespace (align=2097152) on Intel
Ice Lake server. This test exercises the dax_pmem rebind path and
measures memmap initialization latency.

Test procedure:
Unbind and rebind the dax_pmem driver 30 times, collect memmap
initialization time from the pr_debug() output of memmap_init_zone_device().

Base(v7.2-rc1):
  Average of rebinds for dax_pmem driver: 273.31 ms

With this patch and its prerequisites applied:
  Average of rebinds for dax_pmem driver: 244.37 ms

This reduces the average memmap initialization time measured during rebind
from 273.31 ms to 244.37 ms, or about 10.6%.

Suggested-by: Muchun Song <muchun.song@linux.dev>
Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 56a36a71ba89..9691fa2a060d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1065,6 +1065,16 @@ static void __ref zone_device_page_init_slow(struct page *page,
 		set_page_count(page, 0);
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
@@ -1126,6 +1136,7 @@ static void __ref memmap_init_compound(struct page *head,
 {
 	unsigned long pfn, end_pfn = head_pfn + nr_pages;
 	unsigned int order = pgmap->vmemmap_shift;
+	struct page template;
 
 	/*
 	 * We have to initialize the pages, including setting up page links.
@@ -1134,12 +1145,26 @@ static void __ref memmap_init_compound(struct page *head,
 	 * the pages in the same go.
 	 */
 	__SetPageHead(head);
+
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
+		if (pfn == head_pfn + 1) {
+			/*
+			 * All tails of the same compound page share the
+			 * state established by prep_compound_tail(). Reuse
+			 * one tail template for the whole range and
+			 * refresh only the PFN-dependent fields in that
+			 * template before each copy.
+			 */
+			zone_device_tail_page_init(page, pfn, zone_idx, nid,
+						   pgmap, head, order);
+			/* init template page */
+			memcpy(&template, page, sizeof(*page));
+		} else {
+			zone_device_page_init_from_template(page, pfn,
+							    &template);
+		}
 	}
 	prep_compound_head(head, order);
 }
-- 
2.20.1
