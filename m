Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D003DF01C
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175159; cv=none; b=iJnUyvqgefJfB0ipRttQ/VBv9pn7LLvjgbgXYaLrVkJpmEPKoK05u4Igst3530RWHB7lSIyET1SV3qZhIN0h1KJmEEmsdWoQe9FdF8Fi5ERaF9Us4u/KaI2BVnUAayvYhilOQPfAjvgmVB5wdntjBIAXJs2IVc/E5ZvGvY/WlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175159; c=relaxed/simple;
	bh=/WJdK3uvdOGxF0fYzqjQfsNLnZOExeJLdWudhu02EJU=;
	h=From:References:To:Subject:In-Reply-To:Date:Message-Id:
	 Content-Type:Cc:Mime-Version; b=Qhp7UfTwTgPH/XEKLNuOQ+MHtSyKcOUfVTXBDc4UwEiyLL3w6aj2ukeNctAn3Ci9dGaNuhzm7h1HswzQhWGLCpYUTPerc3HhoFfpSEAcqbSmd//h2xS4+QcLzN7D1ioeATTptH8z+Kb/AQm0PdiTQzAyI642sEjas5e0WuSW73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PkYX+kv1; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PkYX+kv1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788175151; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ob9H4dgSGLsuZnXTYmFdoB7QrJmgRd8FFQ463R9dn04=;
 b=PkYX+kv1AJTKg57OJLF3Zslaz+IEv+uBxIE8T+c56ZXsN7th1qgAmfcbDN0lrLL0BIV+Oj
 07jRz3wRsxlC1STsAvP7WiDg1UscV66kMGTCK19JzLAUzQ735qybqs93PqwEdTKONTd1B5
 kYZkuSZApJu86B7JCs5/zUDA+L0hGS6hwqA11S2fGWna/vejPOouxCXobIK7yAneZ07rfS
 k427sjX5ESuOjcxIxZCBsfJ3Uxz56b+yz2eIiriXfo+sMaRR0UKntxJN+v33vCCDGDSYpc
 XN6sbqQcvU7jhqoO3OyTKk9Lgb99P6o3uIiQ2N990bqvBn8nJe1noK2sK6HPdw==
From: "Li Zhe" <lizhe.67@bytedance.com>
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v11 4/7] mm: extend the template fast path to zone-device compound tails
In-Reply-To: <20260831111638.76012-1-lizhe.67@bytedance.com>
Date: Mon, 31 Aug 2026 19:16:35 +0800
Message-Id: <20260831111638.76012-5-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a95632d+fefe88+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

The template fast path from the previous patch only accelerates head
pages. Compound tails in memmap_init_compound() still go through the
normal initialization path one by one.

Build separate head and tail templates and reuse one prepared tail
template across the tail pages in a compound range. Head pages preserve
the existing refcount policy, while compound tails always start with a
refcount of 0 after prep_compound_tail().

This extends the template-copy fast path to pfns_per_compound > 1.
Tail-page PFN-dependent fields are refreshed in the reusable tail
template before each copy.

Do not keep a separate non-template fallback for compound tails either.
These pages are still under memmap initialization, and the
initialization-time refcount updates are not part of the observable
lifetime of pages handed out later.

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
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.3-rc1):
  Average of rebinds for dax_pmem driver: 191.20 ms

With this patch and its prerequisites applied:
  Average of rebinds for dax_pmem driver: 176.87 ms

This reduces the average memmap initialization time measured during
rebind from 191.20 ms to 176.87 ms, or about 7.5%.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index ba4148de2b28..04ba37d95bfd 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1060,6 +1060,8 @@ static void __ref memmap_init_compound(struct page *head,
 {
 	unsigned long pfn, end_pfn = head_pfn + nr_pages;
 	unsigned int order = pgmap->vmemmap_shift;
+	struct page template;
+	struct page *page;
 
 	/*
 	 * We have to initialize the pages, including setting up page links.
@@ -1068,13 +1070,23 @@ static void __ref memmap_init_compound(struct page *head,
 	 * the pages in the same go.
 	 */
 	__SetPageHead(head);
-	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(page, head, order);
-		set_page_count(page, 0);
-	}
+	/*
+	 * All tails of the same compound page share the state established by
+	 * prep_compound_tail(). Reuse one tail template for the whole range and
+	 * refresh only the PFN-dependent fields in that template before each copy.
+	 */
+	pfn = head_pfn + 1;
+	page = pfn_to_page(pfn);
+	__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+	prep_compound_tail(page, head, order);
+	set_page_count(page, 0);
+	memcpy(&template, page, sizeof(*page));
+
+	/* Initialize the remaining tail pages from template. */
+	for (pfn = head_pfn + 2; pfn < end_pfn; pfn++)
+		zone_device_page_init_from_template(pfn_to_page(pfn), pfn,
+						    &template);
 	prep_compound_head(head, order);
 }
 
-- 
2.20.1
