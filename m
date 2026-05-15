Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36237BE8E
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833293; cv=none; b=MMWwLv1NetZolKOfkRNUUeqdnrqBSLkK4/A+jlcZead3HSDWkqteM/WVBUfb34Ue1ugfTEHFHJiY0JtPGYs6/LtlWsA15smTWeigrMhhAOfYYn2T0LT65vItJg4KpBV7ZE5xuuJtjLJgCMAGlg1kxMpistszRcBoWoB1K9OUq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833293; c=relaxed/simple;
	bh=VaEEj9mt4C7OaP2qTTmaeriUw8TC2vZBewDgfVYnEYM=;
	h=To:From:Date:In-Reply-To:Content-Type:Subject:References:
	 Message-Id:Cc:Mime-Version; b=JirRjtwhmnpUjQqtfwXeqtMuM9ZGZ/9UhcsMyVfKtlVyvjRmdldahu7KEvVBKP3XFwTIL1QFqT7KVK5jT4O/Z8xbhiaf7TfwWDBGJ8ryQlflzy4TY24Omzyk3cz/KIuFfZ3wzu5ZJISLDY/KmCPivgRCyjkPNAXQa9fQEA0lTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Znklo0rk; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Znklo0rk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778833281; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Pn4tF8TLTowTahB1RqTQqb2NJ664ubG6BvZ5yr4OYEU=;
 b=Znklo0rkP4IKckRsKDfhmMAydgK9R8Oap6EsM4b3azWMVFOejBmK0WwjMqBb4OsVV3N/DY
 pmzSLsqXATJkuXgQUJ5Yrb2HeRbfCYVL82Hp64zuP0eOe4DMXiSCAgeAd5Eo0VijZ9yqzV
 ckstGZj56zrU/zn4VilF+VwJs0exs44IlKtG1XydK7NzqXg05scReIcGA+dCJ+JjW7vWPA
 DOYXWYqf7iRB+/r8zxGI0QWa4qExNGQ9h9lM1HRUzaZJG2XqqSDAH1MckCMhaTytabuFfL
 +NIRg5NdJ84cf5c48eZGvEzjau4TIFLW449OBLYYX61iae4ZokdWAin3F7R95A==
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <arnd@arndb.de>, <rppt@kernel.org>, 
	<akpm@linux-foundation.org>, <david@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Fri, 15 May 2026 16:20:42 +0800
In-Reply-To: <20260515082045.63029-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/4] mm: factor zone-device page init helpers out of __init_zone_device_page
References: <20260515082045.63029-1-lizhe.67@bytedance.com>
Message-Id: <20260515082045.63029-2-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 7bit
Cc: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a06d77f+7a447a+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

__init_zone_device_page() currently mixes three different jobs: deciding
the initial page refcount, initializing the generic ZONE_DEVICE state, and
setting up pageblock metadata.

Split the refcount policy into zone_device_page_init_refcount() and move
the generic page initialization into generic_init_zone_device_page(). This
keeps the slow path behavior unchanged, but makes the individual pieces
reusable by later fast-path patches.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 62 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..5244acb96dbb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -987,11 +987,36 @@ static void __init memmap_init(void)
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
-					  unsigned long zone_idx, int nid,
-					  struct dev_pagemap *pgmap)
+static inline int zone_device_page_init_refcount(
+		const struct dev_pagemap *pgmap)
 {
+	/*
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
+	 * directly to the driver page allocator which will set the page count
+	 * to 1 when allocating the page.
+	 *
+	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
+	 * their refcount reset to one whenever they are freed (ie. after
+	 * their refcount drops to 0).
+	 */
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		return 0;
+	case MEMORY_DEVICE_GENERIC:
+		return 1;
+	default:
+		WARN_ONCE(1, "Unknown memory type!");
+		return 1;
+	}
+}
 
+static void __ref generic_init_zone_device_page(struct page *page,
+		unsigned long pfn, unsigned long zone_idx, int nid,
+		struct dev_pagemap *pgmap)
+{
 	__init_single_page(page, pfn, zone_idx, nid);
 
 	/*
@@ -1011,6 +1036,16 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
+	if (!zone_device_page_init_refcount(pgmap))
+		set_page_count(page, 0);
+}
+
+static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
+					  unsigned long zone_idx, int nid,
+					  struct dev_pagemap *pgmap)
+{
+	generic_init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+
 	/*
 	 * Mark the block movable so that blocks are reserved for
 	 * movable at startup. This will force kernel allocations
@@ -1025,27 +1060,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
 		cond_resched();
 	}
-
-	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
-	 * directly to the driver page allocator which will set the page count
-	 * to 1 when allocating the page.
-	 *
-	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
-	 * their refcount reset to one whenever they are freed (ie. after
-	 * their refcount drops to 0).
-	 */
-	switch (pgmap->type) {
-	case MEMORY_DEVICE_FS_DAX:
-	case MEMORY_DEVICE_PRIVATE:
-	case MEMORY_DEVICE_COHERENT:
-	case MEMORY_DEVICE_PCI_P2PDMA:
-		set_page_count(page, 0);
-		break;
-
-	case MEMORY_DEVICE_GENERIC:
-		break;
-	}
 }
 
 /*
-- 
2.20.1
