Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF538D
	for <linux-arch@vger.kernel.org>; Mon, 10 Aug 2026 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364616; cv=none; b=oRfOex/rkWr5RJvHuQnW1CX/etsSLIZDkWZUUFjCsQEqZb2whnch2vu67puqhJUYe9ZLJ3ZSy6AS0OexQoFsVpNS6qHRCg11HarHQrkd/tlCS3zIPNbsMJgqHVr1ixqjrQziy6MAlK3cA+Ilvao3cB5cWXCt2SNnPp72JM4urFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364616; c=relaxed/simple;
	bh=d8Qz30+jm+1jK9zOJX3uxZNIPgKolYW1sbUNz1N9uIc=;
	h=Mime-Version:References:From:Cc:Date:Message-Id:Content-Type:To:
	 Subject:In-Reply-To; b=WrW+92to5YZ+JQdqlGlXeTDffTuIzvOf2SRgdxjvboi4iH9BdNRzPDNVlK5D04oaqxGdj3dhQU8vvle226xUYreZB5ZU2IXGYXl+Ma5W+nMLuL3Aa1K59pUVkVCMT95/ltbgGnZYh5RlecCYGjn3PEz3ZmVhW8Aud4eeJHwkMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NEW2BiAv; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NEW2BiAv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786364603; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=s126gl7tRFhaJiWX2giecuLSdCnS+/Lfp4QcjvwoLqg=;
 b=NEW2BiAvcaf9WiFuc+Sdy1VBVa6WLD7vxKEl1iam7o0dQf3m4icujr7UkXEEqhDYL7dqUj
 AZjElPV8OfaphJUDMJLo1eeC2Kh+TW/DBavR6fJEzQM4u1h/yTKXSlutlbDDQ4zUV8YxSs
 oQJMYyySjDlNaWRAQKnajgr/uBcwsAeq732OOIYHE1ad7Stdvtv3xm/8SFhMgW8Uyfcdwl
 NKBLOd8OJlLW5W5d1+6Fo/5vJ0OtdGKIeDfI6TOfOUk2O6eb8DNGZq7kRHpLqvmuhrZ+mJ
 pkuYaOeq81JhcvA2Ue3Zm4zIwUVk3LhbzSpqfOAZ26XNZs0DrrLRVW83f4Uyqg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a79c2b9+b1ce86+vger.kernel.org+lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Date: Mon, 10 Aug 2026 20:20:53 +0800
Message-Id: <20260810122057.30447-5-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v10 4/8] mm: add a template-based fast path for zone-device page init
In-Reply-To: <20260810122057.30447-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2

memmap_init_zone_device() repeats nearly identical head-page
initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
template through the existing slow path, refresh the PFN-dependent
fields in that template before each copy, and memcpy it into each
destination page.

Use the template path unconditionally. The page_ref_set tracepoint is
primarily a debugging aid, while this code is still initializing struct
pages before they are handed out. From the perspective of users of those
pages, the initialization-time refcount transitions are not part of the
observable page lifetime.

This means page_ref_set will no longer observe every initialization-time
refcount assignment for copied ZONE_DEVICE head pages. The impact is
controlled because the final initialized struct page state is unchanged,
and keeping a separate non-template path only for this local tracepoint
observability would add complexity to the common path.

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
  Average of rebinds for nd_pmem driver: 244.28 ms

With this patch and its prerequisites applied:
  Average of rebinds for nd_pmem driver: 215.55 ms

This reduces the average memmap initialization time measured during rebind
from 244.28 ms to 215.55 ms, or about 11%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a70acb7431a6..56a36a71ba89 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1065,6 +1065,35 @@ static void __ref zone_device_page_init_slow(struct page *page,
 		set_page_count(page, 0);
 }
 
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
@@ -1127,6 +1156,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
+	struct page template;
 
 	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
 		return;
@@ -1144,7 +1174,22 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
+		if (pfn == start_pfn) {
+			/*
+			 * Seed the reusable head-page template from the
+			 * first real struct page. This initializes the
+			 * first page through the existing slow path and
+			 * then reuses that final state as the template
+			 * for subsequent pages.
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
