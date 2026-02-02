Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72531195B
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018420; cv=none; b=C19VZTGUT1kOYb5ml1LFRLUmM+xkvXGUC8WP21cK3RBb9zWoqxWkD9WcCBhTmv3IkZpXXEkh1eNwwVwCCuIA7SMoxlFKdnaWyN69kLw8Bmgc06ez3RNC5MQ+uO3OmzDQTET0mgB2wv7240854gr43S5sK7NhJIMHIDv4pIOJzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018420; c=relaxed/simple;
	bh=fWLHMnr2RM+kDuq4tIuO7SAeaOX2KgxCRWbH6i9QeLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5AJpyZgHSM3X0y/3kDEjTdQl1P9fzK6/YA5FnE3tamwryCpxEBxme+34ILwrveU1Y2MemLO5eq/HscGPioKxbm6mZ3csPp+Jr71ZGAX0C60shcEwsWKCJM6lfJMj3ge7h0JomPx7b7PGHin6G1o+DxzT2RdyqHMBDNf1FQG68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pdjfUjRg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pdjfUjRg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770018415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ic7TrnN6sGlm3l1wxhH2nfdOKdVnIN7B0hP0aUO2aOY=;
	b=pdjfUjRgbpxEevSg5ni8YXtztpS1GezhbgKFAamXf1e+YuJlVEd442UU8eyB74Flpb+8jl
	b7x8L4yO0lU1g9rOZipEkWSVE/vqgsI+7A37FZZZxk48NTkJmLeQED7u46+9MTI0gptwG5
	WMDJBHLqce/JaxPiVm1gYjFcmWeJ99A=
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
Subject: [PATCH v4 2/3] mm: switch callers to tlb_remove_table_sync_mm()
Date: Mon,  2 Feb 2026 15:45:56 +0800
Message-ID: <20260202074557.16544-3-lance.yang@linux.dev>
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

Now that we have tlb_remove_table_sync_mm(), convert callers from
tlb_remove_table_sync_one() to enable targeted IPIs instead of broadcast.

Three callers updated:

1) collapse_huge_page() - after flushing the old PMD, only IPIs CPUs
   walking this mm instead of all CPUs.

2) tlb_flush_unshared_tables() - when unsharing hugetlb page tables,
   use tlb->mm for targeted IPIs.

3) __tlb_remove_table_one() - updated to take mmu_gather parameter so
   it can use tlb->mm when batch allocation fails.

Note that pmdp_get_lockless_sync() (PAE only) also calls
tlb_remove_table_sync_one() under PTL to ensure all ongoing PMD split-reads
complete between pmdp_get_lockless_{start,end}; the critical section is
very short. I'm inclined not to convert it since PAE systems typically
don't have many cores.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/asm-generic/tlb.h | 11 ++++++-----
 mm/khugepaged.c           |  2 +-
 mm/mmu_gather.c           | 12 ++++++------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b6b06e6b879f..40eb74b28f9d 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -831,17 +831,18 @@ static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
 	/*
 	 * Similarly, we must make sure that concurrent GUP-fast will not
 	 * walk previously-shared page tables that are getting modified+reused
-	 * elsewhere. So broadcast an IPI to wait for any concurrent GUP-fast.
+	 * elsewhere. So send an IPI to wait for any concurrent GUP-fast.
 	 *
-	 * We only perform this when we are the last sharer of a page table,
-	 * as the IPI will reach all CPUs: any GUP-fast.
+	 * We only perform this when we are the last sharer of a page table.
+	 * Use targeted IPI to CPUs actively walking this mm instead of
+	 * broadcast.
 	 *
-	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
+	 * Note that on configs where tlb_remove_table_sync_mm() is a NOP,
 	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
 	 * required IPIs already for us.
 	 */
 	if (tlb->fully_unshared_tables) {
-		tlb_remove_table_sync_one();
+		tlb_remove_table_sync_mm(tlb->mm);
 		tlb->fully_unshared_tables = false;
 	}
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fa1e57fd2c46..7781d6628649 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1173,7 +1173,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
 	spin_unlock(pmd_ptl);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_mm(mm);
 
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 35c89e4b6230..76573ec454e5 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -378,7 +378,7 @@ static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 	__tlb_remove_table(ptdesc);
 }
 
-static inline void __tlb_remove_table_one(void *table)
+static inline void __tlb_remove_table_one(struct mmu_gather *tlb, void *table)
 {
 	struct ptdesc *ptdesc;
 
@@ -386,16 +386,16 @@ static inline void __tlb_remove_table_one(void *table)
 	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
 }
 #else
-static inline void __tlb_remove_table_one(void *table)
+static inline void __tlb_remove_table_one(struct mmu_gather *tlb, void *table)
 {
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_mm(tlb->mm);
 	__tlb_remove_table(table);
 }
 #endif /* CONFIG_PT_RECLAIM */
 
-static void tlb_remove_table_one(void *table)
+static void tlb_remove_table_one(struct mmu_gather *tlb, void *table)
 {
-	__tlb_remove_table_one(table);
+	__tlb_remove_table_one(tlb, table);
 }
 
 static void tlb_table_flush(struct mmu_gather *tlb)
@@ -417,7 +417,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
 		if (*batch == NULL) {
 			tlb_table_invalidate(tlb);
-			tlb_remove_table_one(table);
+			tlb_remove_table_one(tlb, table);
 			return;
 		}
 		(*batch)->nr = 0;
-- 
2.49.0

