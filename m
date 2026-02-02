Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD6313E14
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2026 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018423; cv=none; b=u+QSblmIgJb8PeyJBSTOQQiOMt/Btr9eB+fmO9Kwz+26XHvmCZNdPoQgANOX4jwyZT01fiLAHcDzuhOxHoKk4mBuz4drv3Fw/JTPnQFE0uCp8EyiwHiX5YWxoCD6y//ohKheXkrnG4dto+7CizejoVrSG2DIXB6aueCVFoH8boY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018423; c=relaxed/simple;
	bh=jsmpq/Usxx0cLTUgsEtYpyDqIjqblk2OL9+037erLCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfoGw27twU2kPcB4llxICzs/yE1EI0qOY0iiJJlNKWp9g5+YN5kuFVfl2Oi/SuRfvhC3DUP4KRunhtWRMO3GTdAGvo6Azi82GfOLIJl/qmSa6WaOTO1Eoe3bsecfapZxvDth0Lq7sFbTU+uKnB+jb/ejVkpvJoF6SuJvFbQxayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cW0CtRIc; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cW0CtRIc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770018409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXujEoUNJu/9Snvd8x+7m65uywslfWR8iRUR5pLoVkA=;
	b=cW0CtRIcjlR+qdoXFn119hjFWn+vND51Hyj4B41JaZPny8AjoqmKIVlA4gNWteWp+dwdzx
	j6EC7U2UCzrH+Pb/QiYdVzDcwSX6Bix3qjBtySHKO3q2V9suSogN/DMCXgL98TwMFAcQ3u
	XBzs+aQ64ejZ7FphjlXzvoAti/LumqA=
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	ypodemsk@redhat.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	jgross@suse.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v4 1/3] mm: use targeted IPIs for TLB sync with lockless page table walkers
Date: Mon,  2 Feb 2026 15:45:55 +0800
Message-ID: <20260202074557.16544-2-lance.yang@linux.dev>
In-Reply-To: <20260202074557.16544-1-lance.yang@linux.dev>
References: <20260202074557.16544-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Lance Yang <lance.yang@linux.dev>

Currently, tlb_remove_table_sync_one() broadcasts IPIs to all CPUs to wait
for any concurrent lockless page table walkers (e.g., GUP-fast). This is
inefficient on systems with many CPUs, especially for RT workloads[1].

This patch introduces a per-CPU tracking mechanism to record which CPUs are
actively performing lockless page table walks for a specific mm_struct.
When freeing/unsharing page tables, we can now send IPIs only to the CPUs
that are actually walking that mm, instead of broadcasting to all CPUs.

In preparation for targeted IPIs; a follow-up will switch callers to
tlb_remove_table_sync_mm().

Note that the tracking adds ~3% latency to GUP-fast, as measured on a
64-core system.

[1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/asm-generic/tlb.h |  2 ++
 include/linux/mm.h        | 34 ++++++++++++++++++++++++++
 kernel/events/core.c      |  2 ++
 mm/gup.c                  |  2 ++
 mm/mmu_gather.c           | 50 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4aeac0c3d3f0..b6b06e6b879f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -250,6 +250,7 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 #endif
 
 void tlb_remove_table_sync_one(void);
+void tlb_remove_table_sync_mm(struct mm_struct *mm);
 
 #else
 
@@ -258,6 +259,7 @@ void tlb_remove_table_sync_one(void);
 #endif
 
 static inline void tlb_remove_table_sync_one(void) { }
+static inline void tlb_remove_table_sync_mm(struct mm_struct *mm) { }
 
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f8a8fd47399c..d92df995fcd1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2995,6 +2995,40 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 		      pgoff_t *offset);
 int folio_add_pins(struct folio *folio, unsigned int pins);
 
+/*
+ * Track CPUs doing lockless page table walks to avoid broadcast IPIs
+ * during TLB flushes.
+ */
+DECLARE_PER_CPU(struct mm_struct *, active_lockless_pt_walk_mm);
+
+static inline void pt_walk_lockless_start(struct mm_struct *mm)
+{
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Tell other CPUs we're doing lockless page table walk.
+	 *
+	 * Full barrier needed to prevent page table reads from being
+	 * reordered before this write.
+	 *
+	 * Pairs with smp_rmb() in tlb_remove_table_sync_mm().
+	 */
+	this_cpu_write(active_lockless_pt_walk_mm, mm);
+	smp_mb();
+}
+
+static inline void pt_walk_lockless_end(void)
+{
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Clear the pointer so other CPUs no longer see this CPU as walking
+	 * the mm. Use smp_store_release to ensure page table reads complete
+	 * before the clear is visible to other CPUs.
+	 */
+	smp_store_release(this_cpu_ptr(&active_lockless_pt_walk_mm), NULL);
+}
+
 int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 int pin_user_pages_fast(unsigned long start, int nr_pages,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5b5cb620499e..6539112c28ff 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8190,7 +8190,9 @@ static u64 perf_get_page_size(unsigned long addr)
 		mm = &init_mm;
 	}
 
+	pt_walk_lockless_start(mm);
 	size = perf_get_pgtable_size(mm, addr);
+	pt_walk_lockless_end();
 
 	local_irq_restore(flags);
 
diff --git a/mm/gup.c b/mm/gup.c
index 8e7dc2c6ee73..6748e28b27f2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3154,7 +3154,9 @@ static unsigned long gup_fast(unsigned long start, unsigned long end,
 	 * that come from callers of tlb_remove_table_sync_one().
 	 */
 	local_irq_save(flags);
+	pt_walk_lockless_start(current->mm);
 	gup_fast_pgd_range(start, end, gup_flags, pages, &nr_pinned);
+	pt_walk_lockless_end();
 	local_irq_restore(flags);
 
 	/*
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 2faa23d7f8d4..35c89e4b6230 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -285,6 +285,56 @@ void tlb_remove_table_sync_one(void)
 	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
 }
 
+DEFINE_PER_CPU(struct mm_struct *, active_lockless_pt_walk_mm);
+EXPORT_PER_CPU_SYMBOL_GPL(active_lockless_pt_walk_mm);
+
+/**
+ * tlb_remove_table_sync_mm - send IPIs to CPUs doing lockless page table
+ * walk for @mm
+ *
+ * @mm: target mm; only CPUs walking this mm get an IPI.
+ *
+ * Like tlb_remove_table_sync_one() but only targets CPUs in
+ * active_lockless_pt_walk_mm.
+ */
+void tlb_remove_table_sync_mm(struct mm_struct *mm)
+{
+	cpumask_var_t target_cpus;
+	bool found_any = false;
+	int cpu;
+
+	if (WARN_ONCE(!mm, "NULL mm in %s\n", __func__)) {
+		tlb_remove_table_sync_one();
+		return;
+	}
+
+	/* If we can't, fall back to broadcast. */
+	if (!alloc_cpumask_var(&target_cpus, GFP_ATOMIC)) {
+		tlb_remove_table_sync_one();
+		return;
+	}
+
+	cpumask_clear(target_cpus);
+
+	/* Pairs with smp_mb() in pt_walk_lockless_start(). */
+	smp_rmb();
+
+	/* Find CPUs doing lockless page table walks for this mm */
+	for_each_online_cpu(cpu) {
+		if (per_cpu(active_lockless_pt_walk_mm, cpu) == mm) {
+			cpumask_set_cpu(cpu, target_cpus);
+			found_any = true;
+		}
+	}
+
+	/* Only send IPIs to CPUs actually doing lockless walks */
+	if (found_any)
+		smp_call_function_many(target_cpus, tlb_remove_table_smp_sync,
+				       NULL, 1);
+
+	free_cpumask_var(target_cpus);
+}
+
 static void tlb_remove_table_rcu(struct rcu_head *head)
 {
 	__tlb_remove_table_free(container_of(head, struct mmu_table_batch, rcu));
-- 
2.49.0

