Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CF23370F;
	Fri, 24 Apr 2026 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035745; cv=none; b=CgfPye0y/RsnJm90IoKRZRLc1jU238bbwVwLTfpXsaJIQf6p4jp8YP2TgIq+22K9PhtMvNacWjj1NE68voLNGwSK1UHVvUELN58zrD1HJG+1qPA/0Tnvd979IxehDvO+eqeG6cfwTplun8Bwz4Sr2+MfeW43179+g4/Z0EYRKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035745; c=relaxed/simple;
	bh=orwvIT1NW1/FJElOASW5FpIR2+QTAU/sj9g+OTacCeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dg5ISx1Dit30KKUcSa+4ccS542iyhW79qHU+y2NHyn0lWABt+3mSB85b/Sub5R4bVwOyzZ+p+wZ5+6xtvjzqjZ2fD6X1TZ92q3OC+33/DG+s3LniiqTVC7LNp6UiQ3K9jAcZr7Lo5XK0dGP/vrN2MQmAkOwso1W75qIqNvAMuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oXcu333O; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oXcu333O"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0AC51BB0;
	Fri, 24 Apr 2026 06:02:17 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 635893F641;
	Fri, 24 Apr 2026 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777035743; bh=orwvIT1NW1/FJElOASW5FpIR2+QTAU/sj9g+OTacCeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXcu333OFMWTxoUHUEhDo+F+TLgTg4GvdV8uewai7Ub+RJP3aATmvdyWvWhhrddZB
	 RwB4GUMp22pbW1kwZhXb+J5H7oBH9dYRAUMRhI+opuD2XsAy9XB5aApUFokoYaCOIZ
	 cKuo7XwGH+27sthd1aAJCDbRHkZXLpLfvWwvkryk=
From: Dev Jain <dev.jain@arm.com>
To: arnd@arndb.de,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	tglx@kernel.org,
	usama.anjum@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 1/3] vmalloc: add __GFP_SKIP_KASAN support
Date: Fri, 24 Apr 2026 18:31:55 +0530
Message-Id: <20260424130157.3163009-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424130157.3163009-1-dev.jain@arm.com>
References: <20260424130157.3163009-1-dev.jain@arm.com>
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
upon. Other KASAN modes are unchanged because __GFP_SKIP_KASAN isn't
defined there.

This is a preparatory patch for optimizing kernel stack allocations.

Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 mm/vmalloc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b31b208f6ecb3..c94fcb2725b6b 100644
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
@@ -3993,6 +3996,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
 	unsigned long original_align = align;
 	unsigned int shift = PAGE_SHIFT;
+	bool skip_vmalloc_kasan = gfp_mask & __GFP_SKIP_KASAN;
+
+	/* Don't skip metadata kasan unpoisoning */
+	gfp_mask &= ~__GFP_SKIP_KASAN;
 
 	if (WARN_ON_ONCE(!size))
 		return NULL;
@@ -4041,7 +4048,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	 * kasan_unpoison_vmalloc().
 	 */
 	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
-		if (kasan_hw_tags_enabled()) {
+		if (kasan_hw_tags_enabled() && !skip_vmalloc_kasan) {
 			/*
 			 * Modify protection bits to allow tagging.
 			 * This must be done before mapping.
@@ -4054,6 +4061,12 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 			 * poisoned and zeroed by kasan_unpoison_vmalloc().
 			 */
 			gfp_mask |= __GFP_SKIP_KASAN | __GFP_SKIP_ZERO;
+		} else if (skip_vmalloc_kasan) {
+			/*
+			 * Skip page_alloc unpoisoning physical pages backing
+			 * VM_ALLOC mapping, as requested by caller.
+			 */
+			gfp_mask |= __GFP_SKIP_KASAN;
 		}
 
 		/* Take note that the mapping is PAGE_KERNEL. */
@@ -4078,7 +4091,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
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

