Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBE3A0B13
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942901; cv=none; b=apgLwI7lUGmYFvIFC13jo/6BBgrtmj2z1Ei2y6DtW0gTCvTlSMD/rGpFifODv//PMjQ72F+FyRwHrUEs5MkmINIHRSmop+SuJ38wKON0T421EyvgCbcQEOfgL9NBSOnfLVGNQJc9Ehtl7M/2CE4UwMQzryZ1hTAYTqXesSIMZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942901; c=relaxed/simple;
	bh=vyL2dF9NFe0Q60hskWLNLpvSB/oWQKt4my2BoJD+LJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qENiCVbru6gMOwJ5U1r2KaF3JBKDcVpKcjlxeNxSsc78AHZcdjtxI2/7Rqp4IghU9ZJuabvSXbQTT5j0ECSj83/5p/xmHy0/Z0XGY/tWW4LeRK1E8Y08dG7BwpWbAg24CKUqGFRlLfQ241/bEnrOrcNsn9rSlucB3xmDRpRI6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o9jlh0Mr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o9jlh0Mr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771942886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ftf+6nHpcHnhVbfQle8ikpkQkfjTgGA5SgbWctBAI1k=;
	b=o9jlh0MrC64et33agy4TtOcDGNAFpq2a66jieTkh92Zy8afHt05hHjGDJwNcJKNYR4e21O
	gNfaOQW8MhrWaXg36XkSLhomJaJAfDM5MPtM19OEdRVyidiwfQLb74cVCdhEPA3zyvoFfS
	GudLn86DitzE+qdGtFPZSPayaA2D0DE=
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	peterz@infradead.org
Cc: david@kernel.org,
	dave.hansen@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 1/1] mm/mmu_gather: replace IPI with synchronize_rcu() when batch allocation fails
Date: Tue, 24 Feb 2026 22:21:01 +0800
Message-ID: <20260224142101.20500-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Lance Yang <lance.yang@linux.dev>

When freeing page tables, we try to batch them. If batch allocation fails
(GFP_NOWAIT), __tlb_remove_table_one() immediately frees the one without
batching.

On !CONFIG_PT_RECLAIM, the fallback sends an IPI to all CPUs via
tlb_remove_table_sync_one(). It disrupts all CPUs even when only a single
process is unmapping memory. IPI broadcast was reported to hurt RT
workloads[1].

tlb_remove_table_sync_one() synchronizes with lockless page-table walkers
(e.g. GUP-fast) that rely on IRQ disabling. These walkers use
local_irq_disable(), which is also an RCU read-side critical section.

This patch introduces tlb_remove_table_sync_rcu() which uses RCU grace
period (synchronize_rcu()) instead of IPI broadcast. This provides the
same guarantee as IPI but without disrupting all CPUs. Since batch
allocation already failed, we are in a slow path where sleeping is
acceptable - we are in process context (unmap_region, exit_mmap) with only
mmap_lock held.

tlb_remove_table_sync_one() is retained for other callers (e.g., khugepaged
after pmdp_collapse_flush(), tlb_finish_mmu() when
tlb->fully_unshared_tables) that are not slow paths. Converting those may
require different approaches such as targeted IPIs.

[1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/

Link: https://lore.kernel.org/linux-mm/20260202150957.GD1282955@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/linux-mm/dfdfeac9-5cd5-46fc-a5c1-9ccf9bd3502a@intel.com/
Link: https://lore.kernel.org/linux-mm/bc489455-bb18-44dc-8518-ae75abda6bec@kernel.org/
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v2 -> v3:
- Remove explicit might_sleep() as synchronize_rcu() already has it
  (per Peter)
- Add changelog explanation for why tlb_remove_table_sync_one() is retained
  (per Peter)
- Collect Acked-by from David and Peter, thanks!
- https://lore.kernel.org/linux-mm/20260224030700.35857-1-lance.yang@linux.dev/

v1 -> v2:
- Wrap synchronize_rcu() in tlb_remove_table_sync_rcu() with proper
  kerneldoc (per David)
- Add might_sleep() to make sleeping constraint explicit (per Dave)
- Clarify this is for synchronization, not memory freeing (per Dave)
- https://lore.kernel.org/linux-mm/20260223033604.10198-1-lance.yang@linux.dev/

 include/asm-generic/tlb.h |  4 ++++
 mm/mmu_gather.c           | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4aeac0c3d3f0..bdcc2778ac64 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -251,6 +251,8 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 
 void tlb_remove_table_sync_one(void);
 
+void tlb_remove_table_sync_rcu(void);
+
 #else
 
 #ifdef tlb_needs_table_invalidate
@@ -259,6 +261,8 @@ void tlb_remove_table_sync_one(void);
 
 static inline void tlb_remove_table_sync_one(void) { }
 
+static inline void tlb_remove_table_sync_rcu(void) { }
+
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
 
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index fe5b6a031717..3985d856de7f 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -296,6 +296,25 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
 	call_rcu(&batch->rcu, tlb_remove_table_rcu);
 }
 
+/**
+ * tlb_remove_table_sync_rcu - synchronize with software page-table walkers
+ *
+ * Like tlb_remove_table_sync_one() but uses RCU grace period instead of IPI
+ * broadcast. Use in slow paths where sleeping is acceptable.
+ *
+ * Software/Lockless page-table walkers use local_irq_disable(), which is also
+ * an RCU read-side critical section. synchronize_rcu() waits for all such
+ * sections, providing the same guarantee as tlb_remove_table_sync_one() but
+ * without disrupting all CPUs with IPIs.
+ *
+ * Do not use for freeing memory. Use RCU callbacks instead to avoid latency
+ * spikes.
+ */
+void tlb_remove_table_sync_rcu(void)
+{
+	synchronize_rcu();
+}
+
 #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
 static void tlb_remove_table_free(struct mmu_table_batch *batch)
@@ -339,7 +358,7 @@ static inline void __tlb_remove_table_one(void *table)
 #else
 static inline void __tlb_remove_table_one(void *table)
 {
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_rcu();
 	__tlb_remove_table(table);
 }
 #endif /* CONFIG_PT_RECLAIM */
-- 
2.49.0

