Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4413B5AE
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771817806; cv=none; b=ZHTyYJxSPjb26wvUVPEpZRbKHzUGjKsgLvjjepoFxBKL8iRE8KvdQgo0/9thSMtWcN9Y1pvxO4m6d39RCcCk5rKKHY6Temq+OOyLR9r6/8WE93fWSFi7ruIhvVzajJBHWA/5ujN/Djr0o3zX0HWoH6puFuekiGKt+LEKrHE9pmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771817806; c=relaxed/simple;
	bh=VmlsWTO/XNH4PZXK5UBYGjnYFUXHbOe0lkS8/G9eyQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odJw+nyrmG+N5tSoGfVBvY3FazPk24tXMdcj6WZ1vcC61wta05pNI3RUhFd6tfa57YVU1xVgnUlbqKWchh3ErDsOUyrnT5t302zyiXRvtpyIpFc3kbhbt+fB5fdXfne1RzFVCeD7hTswKjFo+rFOKN+sKxmr/1a/dt6DFYk4W74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q2MdICJu; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q2MdICJu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771817793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y+UABCdhx+1FSB4k0JrJcnKXm4mw68KgS4c8CS3QDWE=;
	b=Q2MdICJuuAFuOrJ4291ahoJPC33A1NEyQ9jPeOkHw+pdk0RcfqXGFzbc6D0hQqbOiJtac5
	slpPEzARrM0wwa6cLvRU3b27xnTsdAxrhHSRd25v2gFlD3nTfh9OSOOLhw1dGrATd/AkrR
	AjMq0PUsznCG5VdVH6A1PXZFT9FvAZo=
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
Subject: [PATCH 1/1] mm/mmu_gather: replace IPI with synchronize_rcu() when batch allocation fails
Date: Mon, 23 Feb 2026 11:36:04 +0800
Message-ID: <20260223033604.10198-1-lance.yang@linux.dev>
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
synchronize_rcu() waits for all such sections to complete, providing the
same guarantee as IPI but without disrupting all CPUs.

Since batch allocation already failed, we are in a way slow path, so
replacing the IPI with synchronize_rcu() is fine.

We are in process context (unmap_region, exit_mmap) with only mmap_lock
held, a sleeping lock. synchronize_rcu() will catch any invalid context
via might_sleep().

[1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/

Link: https://lore.kernel.org/linux-mm/20260202150957.GD1282955@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/linux-mm/dfdfeac9-5cd5-46fc-a5c1-9ccf9bd3502a@intel.com/
Link: https://lore.kernel.org/linux-mm/bc489455-bb18-44dc-8518-ae75abda6bec@kernel.org/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/mmu_gather.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index fe5b6a031717..df670c219260 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -339,7 +339,8 @@ static inline void __tlb_remove_table_one(void *table)
 #else
 static inline void __tlb_remove_table_one(void *table)
 {
-	tlb_remove_table_sync_one();
+	if (IS_ENABLED(CONFIG_MMU_GATHER_RCU_TABLE_FREE))
+		synchronize_rcu();
 	__tlb_remove_table(table);
 }
 #endif /* CONFIG_PT_RECLAIM */
-- 
2.49.0

