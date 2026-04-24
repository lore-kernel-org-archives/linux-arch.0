Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A579DA
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011994; cv=none; b=l0qU67Drhr+5aJCHPVLwloEIOUW41Ct2dUrMCsCB2WGEoccIzcEuJ3T73aZzMvfqLBwFx0+vapJCVKmZQtK7E83eYaATqk3hwX/rYtMN+JX6IP+eQKb/oWRwUTz0yTd7lExoG+fdLbeulJw/ANGaxSPidzQFsuK3rUFckolChkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011994; c=relaxed/simple;
	bh=r3cX9/cKucEKI7jeSBF7ovZVeEBlaU54h0dr4Se14LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqnDxnpRrVyOYa0limsiUkDBiWaDkd6+gLaoYfLqMQ9Wi2snGe3UYYILsLItpRpejtyPhbYHjA1OaYcmUW3gp9f6mv/jX2+YE8q1+jDRYW5Y2EZM2WZAHhtdlOKnHYVJIYW8VHEqABMPQB1s0gP7aLvYOsZctj6DYSukOYNtWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lXFN78sr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lXFN78sr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777011989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTh+Yvx/G+4eA9lbJw6qEK4XyieG3LR31VvrGkRr96o=;
	b=lXFN78sryZ4PB+yHSBlA0WPl5M4L4ogY1eH/biaBzsnxm7WNDoMkzHzGdk7QKgYfxNeOy0
	5st7Qf4OgYppgPfZFHjFoqGEV8pmnNmBKnkB0JO8npFF6lWb+nYs/1TlvCaH5DfMx0R1aR
	DISGE9gPZLPERc1OKnbM0iSsegCiaus=
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
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 7.2 v10 2/2] x86/tlb: skip redundant sync IPIs for native TLB flush
Date: Fri, 24 Apr 2026 14:25:28 +0800
Message-ID: <20260424062528.71951-3-lance.yang@linux.dev>
In-Reply-To: <20260424062528.71951-1-lance.yang@linux.dev>
References: <20260424062528.71951-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Lance Yang <lance.yang@linux.dev>

Some page table operations need to synchronize with software/lockless
walkers after a TLB flush by calling tlb_remove_table_sync_{one,rcu}().
On x86, that extra synchronization is redundant when the preceding TLB
flush already broadcast IPIs to all relevant CPUs.

native_pv_tlb_init() checks whether native_flush_tlb_multi() is in use.
On CONFIG_PARAVIRT systems, it checks pv_ops; on non-PARAVIRT, native
flush is always in use.

It decides once at boot whether to enable the optimization: if using
native TLB flush and INVLPGB is not supported, we know IPIs were sent
and can skip the redundant sync. The decision is fixed via a static
key as Peter suggested[1].

PV backends (KVM, Xen, Hyper-V) typically have their own implementations
and don't call native_flush_tlb_multi() directly, so they cannot be trusted
to provide the IPI guarantees we need.

Also rename the x86 flush_tlb_info bit from freed_tables to wake_lazy_cpus,
as Dave suggested[2], to match the behavior it controls: whether the remote
flush may skip CPUs in lazy TLB mode. Both freed_tables and unshared_tables
set it, because lazy-TLB CPUs must receive IPIs before page tables can be
freed or reused. With that guarantee in place,
tlb_table_flush_implies_ipi_broadcast() can safely skip the later sync IPI.

Two-step plan as David suggested[3]:

Step 1 (this patch): Skip redundant sync when we're 100% certain the TLB
flush sent IPIs. INVLPGB is excluded because when supported, we cannot
guarantee IPIs were sent, keeping it clean and simple.

Step 2 (future work): Send targeted IPIs only to CPUs actually doing
software/lockless page table walks, benefiting all architectures.

Regarding Step 2, it obviously only applies to setups where Step 1 does
not apply: like x86 with INVLPGB or arm64.

[1] https://lore.kernel.org/linux-mm/20260302145652.GH1395266@noisy.programming.kicks-ass.net/
[2] https://lore.kernel.org/linux-mm/f856051b-10c7-4d65-9dbe-6b1677af74bd@intel.com/
[3] https://lore.kernel.org/linux-mm/bbfdf226-4660-4949-b17b-0d209ee4ef8c@kernel.org/

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 arch/x86/hyperv/mmu.c           |  4 ++--
 arch/x86/include/asm/tlb.h      | 19 +++++++++++++++-
 arch/x86/include/asm/tlbflush.h |  6 +++--
 arch/x86/kernel/smpboot.c       |  1 +
 arch/x86/mm/tlb.c               | 39 +++++++++++++++++++++++----------
 5 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cfcb60468b01..2cf1eeaffd6f 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -63,7 +63,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	struct hv_tlb_flush *flush;
 	u64 status;
 	unsigned long flags;
-	bool do_lazy = !info->freed_tables;
+	bool do_lazy = !info->wake_lazy_cpus;
 
 	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
 
@@ -198,7 +198,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
-			info->freed_tables ? NULL : cpu_is_lazy);
+			info->wake_lazy_cpus ? NULL : cpu_is_lazy);
 	if (nr_bank < 0)
 		return HV_STATUS_INVALID_PARAMETER;
 
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..fb256fd95f95 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -5,22 +5,39 @@
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
 
+#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
+static inline bool tlb_table_flush_implies_ipi_broadcast(void);
+
 #include <asm-generic/tlb.h>
 #include <linux/kernel.h>
 #include <vdso/bits.h>
 #include <vdso/page.h>
 
+DECLARE_STATIC_KEY_FALSE(tlb_ipi_broadcast_key);
+
+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
+{
+	return static_branch_likely(&tlb_ipi_broadcast_key);
+}
+
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	unsigned long start = 0UL, end = TLB_FLUSH_ALL;
 	unsigned int stride_shift = tlb_get_unmap_shift(tlb);
 
+	/*
+	 * Both freed_tables and unshared_tables must wake lazy-TLB CPUs, so
+	 * they receive IPIs before reusing or freeing page tables, allowing
+	 * us to safely implement tlb_table_flush_implies_ipi_broadcast().
+	 */
+	bool wake_lazy_cpus = tlb->freed_tables || tlb->unshared_tables;
+
 	if (!tlb->fullmm && !tlb->need_flush_all) {
 		start = tlb->start;
 		end = tlb->end;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, wake_lazy_cpus);
 }
 
 static inline void invlpg(unsigned long addr)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 5a3cdc439e38..39b9454781c3 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -18,6 +18,8 @@
 
 DECLARE_PER_CPU(u64, tlbstate_untag_mask);
 
+void __init native_pv_tlb_init(void);
+
 void __flush_tlb_all(void);
 
 #define TLB_FLUSH_ALL	-1UL
@@ -225,7 +227,7 @@ struct flush_tlb_info {
 	u64			new_tlb_gen;
 	unsigned int		initiating_cpu;
 	u8			stride_shift;
-	u8			freed_tables;
+	u8			wake_lazy_cpus;
 	u8			trim_cpumask;
 };
 
@@ -315,7 +317,7 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
-				bool freed_tables);
+				bool wake_lazy_cpus);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 294a8ea60298..df776b645a9c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1256,6 +1256,7 @@ void __init native_smp_prepare_boot_cpu(void)
 		switch_gdt_and_percpu_base(me);
 
 	native_pv_lock_init();
+	native_pv_tlb_init();
 }
 
 void __init native_smp_cpus_done(unsigned int max_cpus)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 621e09d049cb..3ce254a3982c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -26,6 +26,8 @@
 
 #include "mm_internal.h"
 
+DEFINE_STATIC_KEY_FALSE(tlb_ipi_broadcast_key);
+
 #ifdef CONFIG_PARAVIRT
 # define STATIC_NOPV
 #else
@@ -1360,16 +1362,16 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 				(info->end - info->start) >> PAGE_SHIFT);
 
 	/*
-	 * If no page tables were freed, we can skip sending IPIs to
-	 * CPUs in lazy TLB mode. They will flush the CPU themselves
-	 * at the next context switch.
+	 * If lazy-TLB CPUs do not need to be woken, we can skip sending
+	 * IPIs to them. They will flush themselves at the next context
+	 * switch.
 	 *
-	 * However, if page tables are getting freed, we need to send the
-	 * IPI everywhere, to prevent CPUs in lazy TLB mode from tripping
-	 * up on the new contents of what used to be page tables, while
-	 * doing a speculative memory access.
+	 * However, if page tables are getting freed or unshared, we need
+	 * to send the IPI everywhere, to prevent CPUs in lazy TLB mode
+	 * from tripping up on the new contents of what used to be page
+	 * tables, while doing a speculative memory access.
 	 */
-	if (info->freed_tables || mm_in_asid_transition(info->mm))
+	if (info->wake_lazy_cpus || mm_in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
@@ -1402,7 +1404,7 @@ static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
 
 static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
-			unsigned int stride_shift, bool freed_tables,
+			unsigned int stride_shift, bool wake_lazy_cpus,
 			u64 new_tlb_gen)
 {
 	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
@@ -1429,7 +1431,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->end		= end;
 	info->mm		= mm;
 	info->stride_shift	= stride_shift;
-	info->freed_tables	= freed_tables;
+	info->wake_lazy_cpus	= wake_lazy_cpus;
 	info->new_tlb_gen	= new_tlb_gen;
 	info->initiating_cpu	= smp_processor_id();
 	info->trim_cpumask	= 0;
@@ -1448,7 +1450,7 @@ static void put_flush_tlb_info(void)
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
-				bool freed_tables)
+				bool wake_lazy_cpus)
 {
 	struct flush_tlb_info *info;
 	int cpu = get_cpu();
@@ -1457,7 +1459,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	/* This is also a barrier that synchronizes with switch_mm(). */
 	new_tlb_gen = inc_mm_tlb_gen(mm);
 
-	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
+	info = get_flush_tlb_info(mm, start, end, stride_shift, wake_lazy_cpus,
 				  new_tlb_gen);
 
 	/*
@@ -1834,3 +1836,16 @@ static int __init create_tlb_single_page_flush_ceiling(void)
 	return 0;
 }
 late_initcall(create_tlb_single_page_flush_ceiling);
+
+void __init native_pv_tlb_init(void)
+{
+#ifdef CONFIG_PARAVIRT
+	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
+		return;
+#endif
+
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return;
+
+	static_branch_enable(&tlb_ipi_broadcast_key);
+}
-- 
2.49.0

