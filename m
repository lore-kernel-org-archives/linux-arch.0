Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B433987E
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045282; cv=none; b=YKJ3CONyV/f0TjMbURSs8LV/gatbVbuZyhYfLV3pnWPha1hzJCxiLBU7XO/mkB5Xx1/9J4oZSZCEkP+FTSC1upTEWYbF9+o1MsubXCc8nHLAR5c+3HKZZ4E0xSzMr1Enh8LMZzUhKy1UmHRLFvIfDo8ov1TcVHdGcT2rJHdxwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045282; c=relaxed/simple;
	bh=etJ/+2RIKsC5O6uHnB0DLrbyV5IAlJ/ziSf95HB66+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B99HIrCQ/haoHWHKCigWK7QpKgkOW7UFSpI7HY3K1jrWiUWmox0aXyGDYG3lBzpmvWypjnfn8FENdNXKbKLLPDydO6IXpmZ81kW3x77UWrVL9r1hLyhH6E9iM07u0fTe+GNWTVi3e0fJ0RBkyZKfKxQrLJJ9lE1wWxs91yJmZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FVMiA25d; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FVMiA25d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777045268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysp3KPMytxumBnUhViA+YLOkzHtdbcKVPu5U5PduTew=;
	b=FVMiA25dgArZNLgbbK4HTmNrusZGey87n92PAC9jHYnERUfYYLftC1BUFSpsuqNc73414b
	R+gednPC/10TAQJi5ow5O05J9ug2nVxVvoj4nTbStoC0J6kfoHCaeWKYeH7cbk2WuhDc5o
	sNw59YsNilfbCrYm2Ai+yQaV/yLAe3s=
From: Lance Yang <lance.yang@linux.dev>
To: lance.yang@linux.dev
Cc: akpm@linux-foundation.org,
	peterz@infradead.org,
	david@kernel.org,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	ypodemsk@redhat.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	ljs@kernel.org,
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
	ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v10 1/2] mm/mmu_gather: prepare to skip redundant sync IPIs
Date: Fri, 24 Apr 2026 23:40:48 +0800
Message-Id: <20260424154048.61420-1-lance.yang@linux.dev>
In-Reply-To: <20260424062528.71951-2-lance.yang@linux.dev>
References: <20260424062528.71951-2-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Apr 24, 2026 at 02:25:27PM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>When page table operations require synchronization with software/lockless
>walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
>TLB (tlb->freed_tables or tlb->unshared_tables).
>
>On architectures where the TLB flush already sends IPIs to all target CPUs,
>the subsequent sync IPI broadcast is redundant. This is not only costly on
>large systems where it disrupts all CPUs even for single-process page table
>operations, but has also been reported to hurt RT workloads[1].
>
>Introduce tlb_table_flush_implies_ipi_broadcast() to check if the prior TLB
>flush already provided the necessary synchronization. When true, the sync
>calls can early-return.
>
>A few cases rely on this synchronization:
>
>1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
>   of the PMD table for other purposes in the last remaining user after
>   unsharing.
>
>2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
>   and (possibly) freeing the page table / re-depositing it.
>
>Currently always returns false (no behavior change). The follow-up patch
>will enable the optimization for x86.
>
>[1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/
>[2] https://lore.kernel.org/linux-mm/6a364356-5fea-4a6c-b959-ba3b22ce9c88@kernel.org/
>[3] https://lore.kernel.org/linux-mm/2cb4503d-3a3f-4f6c-8038-7b3d1c74b3c2@kernel.org/
>
>Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>
>---
> include/asm-generic/tlb.h | 17 +++++++++++++++++
> mm/mmu_gather.c           | 15 +++++++++++++++
> 2 files changed, 32 insertions(+)
>
>diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>index bdcc2778ac64..cb41cc6a0024 100644
>--- a/include/asm-generic/tlb.h
>+++ b/include/asm-generic/tlb.h
>@@ -240,6 +240,23 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
> }
> #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
> 
>+/**
>+ * tlb_table_flush_implies_ipi_broadcast - does TLB flush imply IPI sync
>+ *
>+ * When page table operations require synchronization with software/lockless
>+ * walkers, they flush the TLB (tlb->freed_tables or tlb->unshared_tables)
>+ * then call tlb_remove_table_sync_{one,rcu}(). If the flush already sent
>+ * IPIs to all CPUs, the sync call is redundant.
>+ *
>+ * Returns false by default. Architectures can override by defining this.
>+ */
>+#ifndef tlb_table_flush_implies_ipi_broadcast
>+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
>+{
>+	return false;
>+}
>+#endif
>+
> #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> /*
>  * This allows an architecture that does not use the linux page-tables for
>diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>index 3985d856de7f..37a6a711c37e 100644
>--- a/mm/mmu_gather.c
>+++ b/mm/mmu_gather.c
>@@ -283,6 +283,14 @@ void tlb_remove_table_sync_one(void)
> 	 * It is however sufficient for software page-table walkers that rely on
> 	 * IRQ disabling.
> 	 */
>+
>+	/*
>+	 * Skip IPI if the preceding TLB flush already synchronized with
>+	 * all CPUs that could be doing software/lockless page table walks.
>+	 */
>+	if (tlb_table_flush_implies_ipi_broadcast())
>+		return;

Sashiko told me[1]:

"
Could skipping the global IPI fail to synchronize with lockless walkers
running outside the mm_cpumask?

tlb_remove_table_sync_one() is used (e.g., by khugepaged during THP collapse)
to wait for lockless page table walkers to finish. On 32-bit architectures
like x86 PAE, pmdp_get_lockless() disables interrupts to prevent torn reads
of 64-bit PMDs.

While the preceding TLB flush sends IPIs to CPUs in the target mm's
mm_cpumask, lockless walkers such as pte_offset_map() are frequently executed
by background threads unrelated to the target mm (e.g., kswapd via
page_vma_mapped_walk()). These threads run on CPUs outside of mm_cpumask
and would not receive the TLB flush IPI.

If the global smp_call_function(..., 1) IPI is skipped, the modifying thread
might not wait for kswapd. Could this allow it to overwrite the PMD while the
out-of-context reader is reading it, resulting in a torn PMD?
"

Afraid not.

When CONFIG_MMU_GATHER_RCU_TABLE_FREE=n, tlb_remove_table_sync_one() is
just a NOP.

So if lockless walkers outside mm_cpumask really required a separate
global IPI here, systems running with CONFIG_MMU_GATHER_RCU_TABLE_FREE=n
would already be broken today, because there is no such IPI there to
begin with :)

[1] https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev

>
> 	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
> }
> 
>@@ -312,6 +320,13 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>  */
> void tlb_remove_table_sync_rcu(void)
> {
>+	/*
>+	 * Skip RCU wait if the preceding TLB flush already synchronized
>+	 * with all CPUs that could be doing software/lockless page table walks.
>+	 */
>+	if (tlb_table_flush_implies_ipi_broadcast())
>+		return;
>+

And Sashiko also pointed out[2]:

"
Does skipping synchronize_rcu() here violate the RCU lifetime guarantee of
page tables?

Generic software page table walkers, such as pte_offset_map(), rely strictly
on rcu_read_lock() to protect page table pages from being freed concurrently.
Crucially, they execute with hardware interrupts enabled.

Under CONFIG_PREEMPT_RCU, an IPI broadcast does not wait for rcu_read_lock()
critical sections to complete. The IPI simply interrupts the reader, executes
the flush, and returns immediately.

Could this allow the page table to be freed while the reader is still actively
accessing it, leading to a use-after-free for concurrent pte_offset_map()
readers?
"

Nop.

tlb_remove_table_sync_rcu() still has a single caller: the
!CONFIG_PT_RECLAIM __tlb_remove_table_one() fallback. It was introduced
for that slow batch-allocation-failure path in 1fb3d8c20bfa
("mm/mmu_gather: replace IPI with synchronize_rcu() when batch
allocation fails"), replacing the previous tlb_remove_table_sync_one()
there.

So if pte_offset_map() readers really required a full RCU grace period
in that fallback path, that concern would already have existed before
1fb3d8c20bfa.

So we're safe here :)

[2] https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev

> 	synchronize_rcu();
> }
> 
>-- 
>2.49.0
>
>
