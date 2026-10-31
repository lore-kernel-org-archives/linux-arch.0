Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440131;
	b=5AHUHdedg3W/xzrulM6VwjiCvDDyixKAf3voLO/QzFAHK+Vwuai2dtktQHp18wBx0m4H
	 h/4t3VvoCM1SvtR88aqf3zj3LBeZiiNOevOtjBeWaUDnGaK4ozuDEH5BcQuQnzXNc0T31
	 f4L4/Te7Y30+CvXf6RDEpVVF5+NMUz8AhZPhUUjlMQzagiSIdwvZyF7Q0jcgUuOl652rG
	 qCJ+Et/QMC9Go4gkuijR1wqCRwB7iAL1mpi/56xqHm7Vlmh3b5mDiKhOOxEZPMojU6K0h
	 m/fMdiMbI1uoWupZT3PUef51A0sCpRrvncTy0jfbY7IQbWRtC0YIdeRoEEsyZpiY6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440131;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=upFprhezpdKMJTcSeUAhe7iw4SN1joG+lT3Cbq5UNrU=;
	b=STUE68LsZYfqlRD4J4wOHWxgMAQvRg604XPIH2VIEjjogjTApMVMtYMljPEEoPaoe5Hc
	 OsKDZV08b/cH5RcqwaNmt/nUsQx6XIyfpkQOXdNCF6HyrxlHFLbT++qVVQ6tgcgSdNNQV
	 Y2Cc25KJLKe3aXYSETpFPfYZQtFTTIhxwANsW0ijSJnYVzYtzz/ZbzAQppOPRQZx2ahKz
	 Sora5Yx/VAKcUb5podr90Kj5B/gJNfN4fi3pHSfAyZ4ord4OspQaDO135rbz7sullZwKD
	 /YxE477r3olHNrWPdRDf6uoYMEA3QUw95PpE7Ay2njRrHvNYTD5xBBfZgxU895D9p0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPYfRnRW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C8606A323;
	Sat, 31 Oct 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPYfRnRW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72A21F00919;
	Sat, 31 Oct 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440130;
	bh=upFprhezpdKMJTcSeUAhe7iw4SN1joG+lT3Cbq5UNrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hPYfRnRWvRCgdS/2ZwSu5kIewH6+vetx/64ZA8h9BVGbxVrLLG+9joRXk9h4es1Cs
	 5xP+lsaE/lacDT2KSXQI49xsd8gks5OQDIRRtPBNnsbdBVPP5oA0RdKzNZ28R7TqpA
	 C+/66ZmhXR2PprsmSZOlobdYm0Z8NBj13PnyzK75nhfgzhZ6r9DB/mHhaTtW4fa/zK
	 xR28DS8RzDCwCH5bA2TQsV1iErK6pQCBBEnOtSey21WO9eGLA4KosRAvCFUpI7vfGb
	 rCPEUlYygSTnVTCmsB1B43+e2OY7FR/RleKYNMTAhfS/VKvnjZo5NxUOG2Z98OFX8O
	 HJTQdhr/q99NA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:02 +0100
Subject: [PATCH v3 33/47] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes_core-v3-33-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4348; i=david@kernel.org;
 h=from:subject:message-id; bh=MoI6se5jK5RocaEF2vIDcYqeG95uAcFgIf/3oOYWHQM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs8UVp4TfPpmpJ/Qha0qXc4pby6Jn7r9SEh977EFT
 0zcth3521HKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBECu8x/Gbxl0lRL97eF/v0
 nCp/8KSLjflW9sJpbJyXqgzqfz45087wP8jezrvxc8s0pRmhc2NCz4gofrlm/EQw/N5hXeXy/dm
 vmAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

If ZONE_DEVICE memory shares a memory section with ordinary memory, the
section is online and the pfns of the device are valid.
pfn_to_online_page() tells them apart by asking get_dev_pagemap() whether
the pfn belongs to a dev_pagemap.

get_dev_pagemap() only returns a dev_pagemap whose reference is alive.
memunmap_pages() kills the reference first, waits until all pages are
idle, and then removes the memmap. During all that time the function
finds nothing, and pfn_to_online_page() hands out the struct pages of the
device as if they were online memory. A pfn walker reads them while they
are poisoned and freed.

The entry in pgmap_array is only deleted after the pages have been
removed. Look at that instead of trying to get a reference.

This is probably not worth CCing stable.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/memremap.h |  6 ++++++
 mm/memory_hotplug.c      | 13 +++++--------
 mm/memremap.c            | 13 +++++++++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index e3c2ccf872a8a..b5e5e626c7a59 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -231,6 +231,7 @@ void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn);
+bool pfn_has_dev_pagemap(unsigned long pfn);
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long memremap_compat_align(void);
@@ -284,6 +285,11 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn)
 	return NULL;
 }
 
+static inline bool pfn_has_dev_pagemap(unsigned long pfn)
+{
+	return false;
+}
+
 static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
 {
 	return false;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c9cc42e54f05d..944ea6fd88562 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -342,7 +342,6 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
 struct page *pfn_to_online_page(unsigned long pfn)
 {
 	unsigned long nr = pfn_to_section_nr(pfn);
-	struct dev_pagemap *pgmap;
 	struct mem_section *ms;
 
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID));
@@ -363,14 +362,12 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	/*
 	 * Slowpath: when ZONE_DEVICE collides with
 	 * ZONE_{NORMAL,MOVABLE} within the same section some pfns in
-	 * the section may be 'offline' but 'valid'. Only
-	 * get_dev_pagemap() can determine sub-section online status.
+	 * the section may be 'offline' but 'valid'. Only the presence of a
+	 * pgmap can determine sub-section online status: it indicates a
+	 * ZONE_DEVICE offline pfn. That includes a pgmap whose reference has
+	 * been killed, its memmap is about to go away.
 	 */
-	pgmap = get_dev_pagemap(pfn);
-	put_dev_pagemap(pgmap);
-
-	/* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
-	if (pgmap)
+	if (pfn_has_dev_pagemap(pfn))
 		return NULL;
 
 	return pfn_to_page(pfn);
diff --git a/mm/memremap.c b/mm/memremap.c
index accba23aef28c..a1e99a4c55c56 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -413,6 +413,19 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
+/**
+ * pfn_has_dev_pagemap() - does @pfn belong to a dev_pagemap, dead or alive
+ * @pfn: page frame number to lookup page_map
+ *
+ * In contrast to get_dev_pagemap() this also finds a dev_pagemap which is on
+ * its way out: it is registered before its pages are added, and until they
+ * have been removed.
+ */
+bool pfn_has_dev_pagemap(unsigned long pfn)
+{
+	return xa_load(&pgmap_array, pfn);
+}
+
 void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;

-- 
2.43.0

