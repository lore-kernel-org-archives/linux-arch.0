Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11E39B4AD;
	Wed, 29 Apr 2026 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458487; cv=none; b=kLiIdFEW+UyATzvqUQurGtAbr4TRfG5c4cOQwJYMgM++C0LDL5y8jch6DoydOYxU6LlCdZjTNdlK9W2EkxlXQKQ+JGfVDrO8IEfRp2n9YeHIF7QlhuYMHDu1wvuQEQLhYysVvD14MUkAcTnseo8B+1I9bvbBWru46M2aYSMgP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458487; c=relaxed/simple;
	bh=YrVa8QM82FyivasB4c6vnJvcttIXWoFHfA8m9suAaJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDq2mBq2Ku+1nBtF7L6DQEx3pgx5lKzdLNL9aY81zMu0/gfclMlQVByAauA35Yi88raL1R3EEtx4azcMyPk/SL0alQLsc7b9ZbDFygF/2CEZoXLjQuvfM3V73wCn3eHUBePZZIc1ex7KutuCivCr8SaA9hn1K/AE+R9jVcd2Gzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=opc+blul; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="opc+blul"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338632A68;
	Wed, 29 Apr 2026 03:27:58 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AF023F763;
	Wed, 29 Apr 2026 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777458483; bh=YrVa8QM82FyivasB4c6vnJvcttIXWoFHfA8m9suAaJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opc+blulF41XR2gdMM77FjNEu7ajZWNaYa0gS9RSolSJOFVKz7RXsOzo5BdWPydZx
	 H3d72HfpHJ188WWApaaZeXaPT7fL7GAriBJ2izZYIXt/eOIKW2Ii03okk0tCtlZCno
	 0t4ESg+0jOqTYdL3fe+4f/92M5fvzvWBLYXP78DQ=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	arnd@arndb.de
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	tglx@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	ryan.roberts@arm.com,
	catalin.marinas@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v4 1/3] vmalloc: add __GFP_SKIP_KASAN support
Date: Wed, 29 Apr 2026 15:57:02 +0530
Message-Id: <20260429102704.680174-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429102704.680174-1-dev.jain@arm.com>
References: <20260429102704.680174-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Usama Anjum <usama.anjum@arm.com>

For allocations that will be accessed only with match-all pointers
(e.g., kernel stacks), setting tags is wasted work. If the caller
already set __GFP_SKIP_KASAN, skip tag setting of vmalloc pages.

Before this patch, __GFP_SKIP_KASAN wasn't being used with vmalloc
APIs. So it wasn't being checked. Now its being checked and acted
upon. Other KASAN modes are unchanged because __GFP_SKIP_KASAN is
ignored for them in the page allocator, and in vmalloc too we ignore
this flag for them.

This is a preparatory patch for optimizing kernel stack allocations.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/gfp_types.h |  6 +++---
 mm/vmalloc.c              | 13 +++++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6c75df30a281d..c2bd723c8ec62 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -281,9 +281,9 @@ enum {
  *
  * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
  * Used for userspace and vmalloc pages; the latter are unpoisoned by
- * kasan_unpoison_vmalloc instead. For userspace pages, results in
- * poisoning being skipped as well, see should_skip_kasan_poison for
- * details. Only effective in HW_TAGS mode.
+ * kasan_unpoison_vmalloc instead. If passed to vmalloc, kasan_unpoison_vmalloc
+ * is skipped too. For userspace pages, results in poisoning being skipped as
+ * well, see should_skip_kasan_poison for details. Only effective in HW_TAGS mode.
  */
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aa08651ec0df6..708ccac293cef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3939,7 +3939,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				__GFP_NOFAIL | __GFP_ZERO |\
 				__GFP_NORETRY | __GFP_RETRY_MAYFAIL |\
 				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
-				GFP_USER | __GFP_NOLOCKDEP)
+				GFP_USER | __GFP_NOLOCKDEP | __GFP_SKIP_KASAN)
 
 static gfp_t vmalloc_fix_flags(gfp_t flags)
 {
@@ -3980,6 +3980,9 @@ static gfp_t vmalloc_fix_flags(gfp_t flags)
  *
  * %__GFP_NOWARN can be used to suppress failure messages.
  *
+ * %__GFP_SKIP_KASAN can be used to skip unpoisoning of mapped pages
+ * (when prot=%PAGE_KERNEL).
+ *
  * Can not be called from interrupt nor NMI contexts.
  * Return: the address of the area or %NULL on failure
  */
@@ -3993,6 +3996,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
 	unsigned long original_align = align;
 	unsigned int shift = PAGE_SHIFT;
+	bool skip_vmalloc_kasan = kasan_hw_tags_enabled() && (gfp_mask & __GFP_SKIP_KASAN);
 
 	if (WARN_ON_ONCE(!size))
 		return NULL;
@@ -4023,7 +4027,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 again:
 	area = __get_vm_area_node(size, align, shift, VM_ALLOC |
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
-				  gfp_mask, caller);
+				  gfp_mask & ~__GFP_SKIP_KASAN, caller);
 	if (!area) {
 		bool nofail = gfp_mask & __GFP_NOFAIL;
 		warn_alloc(gfp_mask, NULL,
@@ -4041,7 +4045,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	 * kasan_unpoison_vmalloc().
 	 */
 	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
-		if (kasan_hw_tags_enabled()) {
+		if (kasan_hw_tags_enabled() && !skip_vmalloc_kasan) {
 			/*
 			 * Modify protection bits to allow tagging.
 			 * This must be done before mapping.
@@ -4078,7 +4082,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	    (gfp_mask & __GFP_SKIP_ZERO))
 		kasan_flags |= KASAN_VMALLOC_INIT;
 	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
-	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
+	if (!skip_vmalloc_kasan)
+		area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
-- 
2.34.1

