Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103200;
	b=EeB+S5VvELXYCgVhV13Jd18bUnHcKrwi01iA04lcDgqwa9jGx8PUFoL5Dbbi4NMZ0vwD
	 vWaFOQd8MSafMCWswg/VA3q7MbGO15meoLBXkvFySczWpfNIzE/NSPcSilhTwcwyXpS5x
	 UjaJB6aQ41aybH+C3zp1cMxNQJ4z2GcGz2OOKOkRBsFc3APFWyIjBqsONBDgkSAPJP8jj
	 BgcGZNnM51oPua55W/598NfeQyuFQsq51XlqNYElJi66AAWgWe7dzPfkYXO0eDbUm6tD9
	 gKvx8b6tqFdyXuGc3yaYVxh5tUhAhD+Eol0VakCNr2TgD2xIWATyhUMoRCvbyyZXV6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103200;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=31R7IkymhbZDSeMb1sPHaT1Pw064ctHxU7ykW6z0bv8=;
	b=uCS7lOpegDBHU+PfD2C55qVt5UZy1S41Do+z7+hG6FL4PEPy4qJEUqXdi8pQi2dQx2nO
	 mGiI5pCBqs/dfCW7k1GrYKKNtJDBex1v2IHpwMwn2DCzmF3/13sGJ9lNC3MGQbP+lZ63e
	 Hex8tbNS4x9miWMQbTFahUcJ3Q3aDj3hepfwjWx0Gc87LAoIAfhEUlBxGT8bJti6FtxQo
	 SBuarmBwtpesC6uUiluDD2FtMrMKV2XI5DZ9AkB+BKVc/RdqXCLvZui/O1RMuM0ja1eja
	 lKQGs2tAKOI6QpIeWNt5/VTR+ckvW6eKFWem+FKzheZToGUVREK61SPRMbYQPE1fmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iCJeniYz;
	arc=none smtp.remote-ip=95.215.58.183
Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44107606A338
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 12:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44107606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iCJeniYz
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HldebiX4v8c7RjwCxJgdnN1Xxuzre2SESHSjUs+s7LU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793103197; v=1; x=1793707997;
 b=iCJeniYzOeQbcAQXI5BCvajlY+VMzjI76dvLPSVfX2sneLffZcubV1o9wLRVYrcjxnZws7cN
 FEK1oO5Pmqg6ZAJRDivxs0RExlDmP+L+juUuH1Ht7QFL6BSk1ePWhJPiBiK/aV4HigQKrbvy3iw
 5t9ksfvI0x6DDXWi2CE/eTlY=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 05d4f9fd0d387be9;
	Tue, 27 Oct 2026 12:13:17 +0000
X-Mizu-Trace-ID: 05d4f9fd0d387be9
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in pfn_to_online_page() with dying pgmap
Date: Tue, 27 Oct 2026 20:13:07 +0800
Message-ID: <20261027121307.40431-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Oct 27, 2026 at 12:17:52AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>If ZONE_DEVICE memory shares a memory section with ordinary memory, the
>section is online and the pfns of the device are valid.
>pfn_to_online_page() tells them apart by asking get_dev_pagemap() whether
>the pfn belongs to a dev_pagemap.
>
>get_dev_pagemap() only returns a dev_pagemap whose reference is alive.
>memunmap_pages() kills the reference first, waits until all pages are
>idle, and then removes the memmap. During all that time the function
>finds nothing, and pfn_to_online_page() hands out the struct pages of the
>device as if they were online memory. A pfn walker reads them while they
>are poisoned and freed.
>
>The entry in pgmap_array is only deleted after the pages have been
>removed. Look at that instead of trying to get a reference.
>
>This is probably not worth CCing stable.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> include/linux/memremap.h |  6 ++++++
> mm/memory_hotplug.c      | 13 +++++--------
> mm/memremap.c            | 13 +++++++++++++
> 3 files changed, 24 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>index e3c2ccf872a8a..b5e5e626c7a59 100644
>--- a/include/linux/memremap.h
>+++ b/include/linux/memremap.h
>@@ -231,6 +231,7 @@ void memunmap_pages(struct dev_pagemap *pgmap);
> void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
> void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
> struct dev_pagemap *get_dev_pagemap(unsigned long pfn);
>+bool pfn_has_dev_pagemap(unsigned long pfn);
> bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
> 
> unsigned long memremap_compat_align(void);
>@@ -284,6 +285,11 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn)
> 	return NULL;
> }
> 
>+static inline bool pfn_has_dev_pagemap(unsigned long pfn)
>+{
>+	return false;
>+}
>+
> static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
> {
> 	return false;
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 796af1028ee23..5a972d7a9e478 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -342,7 +342,6 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
> struct page *pfn_to_online_page(unsigned long pfn)
> {
> 	unsigned long nr = pfn_to_section_nr(pfn);
>-	struct dev_pagemap *pgmap;
> 	struct mem_section *ms;
> 
> 	BUILD_BUG_ON(IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID));
>@@ -363,14 +362,12 @@ struct page *pfn_to_online_page(unsigned long pfn)
> 	/*
> 	 * Slowpath: when ZONE_DEVICE collides with
> 	 * ZONE_{NORMAL,MOVABLE} within the same section some pfns in
>-	 * the section may be 'offline' but 'valid'. Only
>-	 * get_dev_pagemap() can determine sub-section online status.
>+	 * the section may be 'offline' but 'valid'. Only the presence of a
>+	 * pgmap can determine sub-section online status: it indicates a
>+	 * ZONE_DEVICE offline pfn. That includes a pgmap whose reference has
>+	 * been killed, its memmap is about to go away.
> 	 */
>-	pgmap = get_dev_pagemap(pfn);
>-	put_dev_pagemap(pgmap);
>-
>-	/* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
>-	if (pgmap)
>+	if (pfn_has_dev_pagemap(pfn))
> 		return NULL;
> 
> 	return pfn_to_page(pfn);


LLM stumbled upon a possible race in kpage_read() ... 

Say the reader passes pfn_section_valid() for a device PFN in a section
shared with online RAM, gets preempted, and resumes after
pgmap_array_delete(). We'd then find no pgmap and return pfn_to_page(pfn),
even though the subsection is no longer valid ...

Could we take the memory hotplug read lock in kpage_read(), covering both
the lookup and the metadata reads? We can drop it before put_user(), once
we're done with the page.

Maybe along these lines?

---8<---
diff --git a/fs/proc/page.c b/fs/proc/page.c
index 6aa99e42ec22..12bed36d76dc 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -12,6 +12,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memremap.h>
 #include <linux/memcontrol.h>
+#include <linux/memory_hotplug.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/kernel-page-flags.h>
@@ -77,6 +78,8 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
 	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);

 	while (count > 0) {
+		/* Prevent memory removal while inspecting the memmap. */
+		get_online_mems();
 		/*
 		 * TODO: ZONE_DEVICE support requires to identify
 		 * memmaps that were actually initialized.
@@ -101,6 +104,8 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
 		} else
 			info = 0;

+		put_online_mems();
+
 		if (put_user(info, out)) {
 			ret = -EFAULT;
 			break;
--

Cheers, Lance
