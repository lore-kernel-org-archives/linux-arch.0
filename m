Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380A39184E;
	Tue, 24 Mar 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342409; cv=none; b=DOi40VYRR3LIIP8noFCs/wU/e/ojxSH5LN0lTUQ5N9VidUn8xipt+R03BHRBJZDZO0zWnznOHGN0sUvNylk+3vhlUw/BjqCfRogNbzTHwr67ilA60fFK9ucpOxIeWmAy+i9HJoBvqwolJATbrvNnRQIqubBGlWfwQ9OJJpMr4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342409; c=relaxed/simple;
	bh=x3AbBSH/6zc/3JdVH91tTFUja889KAbu62u1Vjccw0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KeyoTKPCPcAd0V4EsuzptMwwzk7AjnvyJG28vZIym3ZkyjU5z+P5OrBB60HTTP5wjUVbhv+2lFotQw1z4sit1+ib8U7w2RwcxCkBsFdk0CszXsGW+/nx9bqfkyNlMdrJmUeFXqJjmxJ4tIxm11zZhywaHqbAJG0v1QlX6Uqp1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ehx+GvCQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ehx+GvCQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774342395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cooa/41xI7d+DZUvbghWmkV6GAOYjQWfhrGJsw3E+Hc=;
	b=Ehx+GvCQR7JSE3G0Gcv67EFfJuYOYPtcS6CVJgMxW9nvVX1uHVU+O9ZtrvqPr1sZO9Vos8
	RZ8pygTVO30fZj+U9PODUBVQ4GmxXMmPvam/Z9FB2sPnjVwxAHx9+mYbDoG3O+ES6AekQF
	Rz7lQiIdgJAhpWLNyo2xOXvidlRKOE0=
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org,
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
	ioworker0@gmail.com
Subject: [PATCH v8 0/2] skip redundant sync IPIs when TLB flush sent them
Date: Tue, 24 Mar 2026 16:52:36 +0800
Message-ID: <20260324085238.44477-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

When page table operations require synchronization with software/lockless
walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
TLB (tlb->freed_tables or tlb->unshared_tables).

On architectures where the TLB flush already sends IPIs to all target CPUs,
the subsequent sync IPI broadcast is redundant. This is not only costly on
large systems where it disrupts all CPUs even for single-process page table
operations, but has also been reported to hurt RT workloads[1].

This series introduces tlb_table_flush_implies_ipi_broadcast() to check if
the prior TLB flush already provided the necessary synchronization. When
true, the sync calls can early-return.

A few cases rely on this synchronization:

1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
   of the PMD table for other purposes in the last remaining user after
   unsharing.

2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
   and (possibly) freeing the page table / re-depositing it.

Two-step plan as David suggested[4]:

Step 1 (this series): Skip redundant sync when we're 100% certain the TLB
flush sent IPIs. INVLPGB is excluded because when supported, we cannot
guarantee IPIs were sent, keeping it clean and simple.

Step 2 (future work): Send targeted IPIs only to CPUs actually doing
software/lockless page table walks, benefiting all architectures.

Regarding Step 2, it obviously only applies to setups where Step 1 does not
apply: like x86 with INVLPGB or arm64. Step 2 work is ongoing; early
attempts showed ~3% GUP-fast overhead. Reducing the overhead requires more
work and tuning; it will be submitted separately once ready.

On a 64-core Intel x86 server, the CAL interrupt count in
/proc/interrupts dropped from 646,316 to 785 when collapsing a 20 GiB
range with this series applied.

David Hildenbrand did the initial implementation. I built on his work and
relied on off-list discussions to push it further - thanks a lot David!

[1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/
[2] https://lore.kernel.org/linux-mm/6a364356-5fea-4a6c-b959-ba3b22ce9c88@kernel.org/
[3] https://lore.kernel.org/linux-mm/2cb4503d-3a3f-4f6c-8038-7b3d1c74b3c2@kernel.org/
[4] https://lore.kernel.org/linux-mm/bbfdf226-4660-4949-b17b-0d209ee4ef8c@kernel.org/

v7 -> v8:
- Pick up Acked-by tags from David, thanks!
- Add CAL interrupt numbers to the cover letter (per Andrew, thanks!)
- Rewrite the [2/2] changelog and reword the comment (per David, thanks!)
- https://lore.kernel.org/linux-mm/20260309020711.20831-1-lance.yang@linux.dev/

v6 -> v7:
- Simplify init logic and eliminate duplicated X86_FEATURE_INVLPGB checks
  (per Dave, thanks!)
- Remove flush_tlb_multi_implies_ipi_broadcast property because no PV
  backend sets it today.
- https://lore.kernel.org/linux-mm/20260304021046.18550-1-lance.yang@linux.dev/

v5 -> v6:
- Use static_branch to eliminate the branch overhead (per Peter, thanks!)
- https://lore.kernel.org/linux-mm/20260302063048.9479-1-lance.yang@linux.dev/

v4 -> v5:
- Drop per-CPU tracking (active_lockless_pt_walk_mm) from this series;
  defer to Step 2 as it adds ~3% GUP-fast overhead
- Keep pv_ops property false for PV backends like KVM: preempted vCPUs
  cannot be assumed safe (per Sean, thanks!)
  https://lore.kernel.org/linux-mm/aaCP95l-m8ISXF78@google.com/
- https://lore.kernel.org/linux-mm/20260202074557.16544-1-lance.yang@linux.dev/ 

v3 -> v4:
- Rework based on David's two-step direction and per-CPU idea:
  1) Targeted IPIs: per-CPU variable when entering/leaving lockless page
     table walk; tlb_remove_table_sync_mm() IPIs only those CPUs.
  2) On x86, pv_mmu_ops property set at init to skip the extra sync when
     flush_tlb_multi() already sends IPIs.
  https://lore.kernel.org/linux-mm/bbfdf226-4660-4949-b17b-0d209ee4ef8c@kernel.org/
- https://lore.kernel.org/linux-mm/20260106120303.38124-1-lance.yang@linux.dev/

v2 -> v3:
- Complete rewrite: use dynamic IPI tracking instead of static checks
  (per Dave Hansen, thanks!)
- Track IPIs via mmu_gather: native_flush_tlb_multi() sets flag when
  actually sending IPIs
- Motivation for skipping redundant IPIs explained by David:
  https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/
- https://lore.kernel.org/linux-mm/20251229145245.85452-1-lance.yang@linux.dev/

v1 -> v2:
- Fix cover letter encoding to resolve send-email issues. Apologies for
  any email flood caused by the failed send attempts :(

RFC -> v1:
- Use a callback function in pv_mmu_ops instead of comparing function
  pointers (per David)
- Embed the check directly in tlb_remove_table_sync_one() instead of
  requiring every caller to check explicitly (per David)
- Move tlb_table_flush_implies_ipi_broadcast() outside of
  CONFIG_MMU_GATHER_RCU_TABLE_FREE to fix build error on architectures
  that don't enable this config.
  https://lore.kernel.org/oe-kbuild-all/202512142156.cShiu6PU-lkp@intel.com/
- https://lore.kernel.org/linux-mm/20251213080038.10917-1-lance.yang@linux.dev/

Lance Yang (2):
  mm/mmu_gather: prepare to skip redundant sync IPIs
  x86/tlb: skip redundant sync IPIs for native TLB flush

 arch/x86/include/asm/tlb.h      | 18 +++++++++++++++++-
 arch/x86/include/asm/tlbflush.h |  2 ++
 arch/x86/kernel/smpboot.c       |  1 +
 arch/x86/mm/tlb.c               | 15 +++++++++++++++
 include/asm-generic/tlb.h       | 17 +++++++++++++++++
 mm/mmu_gather.c                 | 15 +++++++++++++++
 6 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.49.0

