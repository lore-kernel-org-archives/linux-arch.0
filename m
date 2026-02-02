Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368D2BDC10
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2026 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018392; cv=none; b=sCEPOdV4WZxfRlTbv6CoOh5xkjo5kAim2L6cfpskoOlQMxFX9JC/pJn+Xd205Qe6P+MZqh/d4Oiiobi1O6EdNCVsjPduUeeasQfMoazejsxw3HguXKw18C03ZQOPH7skFKzu6VO6tTnwuLXcNEX5kn5BO+qDlI9YP/mEkkJuvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018392; c=relaxed/simple;
	bh=gF4zFDW2PehmZJWhDlu3AKfkUoaA8TXz36nx5WblA30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+5NzNGQVrZHQ38eMpKsYOwuQ4vxkeXPJ/HltNyu+aXKZQrkg0U5mOvep2+Sp9rhK1uNRwiP/K6RyIFS0Ar9PgC99bni3Liqfs6PuPlCDguSN7TOJfBQJNPWfh3h6od0oKsqMiouBIy4UhbxW1GBqX+PhL/yLwR0vjpk+MfAZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wosxrHeY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wosxrHeY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770018388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYvAr2zSKhz9oURt6YezfDRfsalBr4ckW+gKtHKbiDk=;
	b=wosxrHeYuzwDZibEFFnXesvD5X7Y36t3WcKsgiDyoJ2SLGHe1hgNHCCdxP+y1kkOmpUxuA
	ne4uNUPl7BldrNTKnxZey7beFJS2CLXaR6wQX3nM0I3kAsyzGEv9vQkbHRFw3xVf7CIkzp
	OkP3H2EUOnHpoEgzNH1DFhkFAlP2nGs=
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
	ioworker0@gmail.com
Subject: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table walkers
Date: Mon,  2 Feb 2026 15:45:54 +0800
Message-ID: <20260202074557.16544-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When freeing or unsharing page tables we send an IPI to synchronize with
concurrent lockless page table walkers (e.g. GUP-fast). Today we broadcast
that IPI to all CPUs, which is costly on large machines and hurts RT
workloads[1].

This series makes those IPIs targeted. We track which CPUs are currently
doing a lockless page table walk for a given mm (per-CPU
active_lockless_pt_walk_mm). When we need to sync, we only IPI those CPUs.
GUP-fast and perf_get_page_size() set/clear the tracker around their walk;
tlb_remove_table_sync_mm() uses it and replaces the previous broadcast in
the free/unshare paths.

On x86, when the TLB flush path already sends IPIs (native without INVLPGB,
or KVM), the extra sync IPI is redundant. We add a property on pv_mmu_ops
so each backend can declare whether its flush_tlb_multi sends real IPIs; if
so, tlb_remove_table_sync_mm() is a no-op. We also have tlb_flush() pass
both freed_tables and unshared_tables so lazy-TLB CPUs get IPIs during
hugetlb unshare.

David Hildenbrand did the initial implementation. I built on his work and
relied on off-list discussions to push it further - thanks a lot David!

[1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/

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

Lance Yang (3):
  mm: use targeted IPIs for TLB sync with lockless page table walkers
  mm: switch callers to tlb_remove_table_sync_mm()
  x86/tlb: add architecture-specific TLB IPI optimization support

 arch/x86/hyperv/mmu.c                 |  5 ++
 arch/x86/include/asm/paravirt.h       |  5 ++
 arch/x86/include/asm/paravirt_types.h |  6 +++
 arch/x86/include/asm/tlb.h            | 20 +++++++-
 arch/x86/kernel/kvm.c                 |  6 +++
 arch/x86/kernel/paravirt.c            | 18 +++++++
 arch/x86/kernel/smpboot.c             |  1 +
 arch/x86/xen/mmu_pv.c                 |  2 +
 include/asm-generic/tlb.h             | 28 +++++++++--
 include/linux/mm.h                    | 34 +++++++++++++
 kernel/events/core.c                  |  2 +
 mm/gup.c                              |  2 +
 mm/khugepaged.c                       |  2 +-
 mm/mmu_gather.c                       | 69 ++++++++++++++++++++++++---
 14 files changed, 187 insertions(+), 13 deletions(-)

-- 
2.49.0

