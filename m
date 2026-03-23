Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64844390217
	for <linux-arch@vger.kernel.org>; Mon, 23 Mar 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262936; cv=none; b=GhRiXr0dJc3NVtadJ8fFtBum20GERMW2nQYlAq0735/vh0eELfvtTyMdt1ZuIjyS+vzQWHAMYI5Pf7i9irKTEcNK+hSHNiAqqs7LuV+rZfv/9zAxN1Cpp/vt8JFNwjZCrXdMFKzuVcBuheI59qIRVz/6KgrnBq58ZeodGfnBkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262936; c=relaxed/simple;
	bh=SHaYoo67LAzF6MLKxO0BpyvZV5GeULmIBGMyykaF4/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ndmh8irbepo9jJp2/WhNu74oIA22w4gKx8cQifCsqAEwlZ3rH8RPDBOPr4/cGii9TQIZVk2elYv/SjPtTMYGPzXjVJ6MbzKPP23hGZ4j4hDzXr6sFPXfBIN6+4x8DPXh3FhI9UJ9lm0hhYmep6z68p81NOb2+lC7167fq4d/RSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MF2ZZBzr; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MF2ZZBzr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774262932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIWA57EXEjW5hjoCtv+I9HTIMV/HrYvLk+JVmnYDAwg=;
	b=MF2ZZBzrtuNrSpZLTH2a3gF6RV1eNpmkt3BAmaWgG6S8RxOxlaeNFX4d222z2xmMeS3l0s
	PIWBBUZQzzpEaGMYLzW4Fl7YjT6YlY42cEP+aWy63xavFj9szHY6GcdXWHYrO71AUkL9uE
	pmzv4xes6AXSJgB1d4qf9aX8eXVokxw=
From: Lance Yang <lance.yang@linux.dev>
To: dave.hansen@intel.com,
	peterz@infradead.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
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
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v7 2/2] x86/tlb: skip redundant sync IPIs for native TLB flush
Date: Mon, 23 Mar 2026 18:48:28 +0800
Message-Id: <20260323104828.55481-1-lance.yang@linux.dev>
In-Reply-To: <20260316023630.92368-1-lance.yang@linux.dev>
References: <20260316023630.92368-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Just following up on this series. Any feedback would be appreciated!

Thanks,
Lance

On Mon, Mar 16, 2026 at 10:36:30AM +0800, Lance Yang wrote:
>
>Gently ping :)
>
>On Mon, Mar 09, 2026 at 10:07:11AM +0800, Lance Yang wrote:
>>From: Lance Yang <lance.yang@linux.dev>
>>
>>Enable the optimization introduced in the previous patch for x86.
>>
>>native_pv_tlb_init() checks whether native_flush_tlb_multi() is in use.
>>On CONFIG_PARAVIRT systems, it checks pv_ops; on non-PARAVIRT, native
>>flush is always in use.
>>
>>It decides once at boot whether to enable the optimization: if using
>>native TLB flush and INVLPGB is not supported, we know IPIs were sent
>>and can skip the redundant sync. The decision is fixed via a static
>>key as Peter suggested[1].
>>
>>PV backends (KVM, Xen, Hyper-V) typically have their own implementations
>>and don't call native_flush_tlb_multi() directly, so they cannot be trusted
>>to provide the IPI guarantees we need.
>>
>>Two-step plan as David suggested[2]:
>>
>>Step 1 (this patch): Skip redundant sync when we're 100% certain the TLB
>>flush sent IPIs. INVLPGB is excluded because when supported, we cannot
>>guarantee IPIs were sent, keeping it clean and simple.
>>
>>Step 2 (future work): Send targeted IPIs only to CPUs actually doing
>>software/lockless page table walks, benefiting all architectures.
>>
>>Regarding Step 2, it obviously only applies to setups where Step 1 does
>>not apply: like x86 with INVLPGB or arm64.
>>
>>[1] https://lore.kernel.org/linux-mm/20260302145652.GH1395266@noisy.programming.kicks-ass.net/
>>[2] https://lore.kernel.org/linux-mm/bbfdf226-4660-4949-b17b-0d209ee4ef8c@kernel.org/
>>
>>Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>>Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>---
>> arch/x86/include/asm/tlb.h      | 17 ++++++++++++++++-
>> arch/x86/include/asm/tlbflush.h |  2 ++
>> arch/x86/kernel/smpboot.c       |  1 +
>> arch/x86/mm/tlb.c               | 15 +++++++++++++++
>> 4 files changed, 34 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>>index 866ea78ba156..99de622d3856 100644
>>--- a/arch/x86/include/asm/tlb.h
>>+++ b/arch/x86/include/asm/tlb.h
>>@@ -5,11 +5,21 @@
>> #define tlb_flush tlb_flush
>> static inline void tlb_flush(struct mmu_gather *tlb);
>> 
>>+#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
>>+static inline bool tlb_table_flush_implies_ipi_broadcast(void);
>>+
>> #include <asm-generic/tlb.h>
>> #include <linux/kernel.h>
>> #include <vdso/bits.h>
>> #include <vdso/page.h>
>> 
>>+DECLARE_STATIC_KEY_FALSE(tlb_ipi_broadcast_key);
>>+
>>+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
>>+{
>>+	return static_branch_likely(&tlb_ipi_broadcast_key);
>>+}
>>+
>> static inline void tlb_flush(struct mmu_gather *tlb)
>> {
>> 	unsigned long start = 0UL, end = TLB_FLUSH_ALL;
>>@@ -20,7 +30,12 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>> 		end = tlb->end;
>> 	}
>> 
>>-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
>>+	/*
>>+	 * Pass both freed_tables and unshared_tables so that lazy-TLB CPUs
>>+	 * also receive IPIs during unsharing page tables.
>>+	 */
>>+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
>>+			   tlb->freed_tables || tlb->unshared_tables);
>> }
>> 
>> static inline void invlpg(unsigned long addr)
>>diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>>index 5a3cdc439e38..8ba853154b46 100644
>>--- a/arch/x86/include/asm/tlbflush.h
>>+++ b/arch/x86/include/asm/tlbflush.h
>>@@ -18,6 +18,8 @@
>> 
>> DECLARE_PER_CPU(u64, tlbstate_untag_mask);
>> 
>>+void __init native_pv_tlb_init(void);
>>+
>> void __flush_tlb_all(void);
>> 
>> #define TLB_FLUSH_ALL	-1UL
>>diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>>index 5cd6950ab672..3cdb04162843 100644
>>--- a/arch/x86/kernel/smpboot.c
>>+++ b/arch/x86/kernel/smpboot.c
>>@@ -1167,6 +1167,7 @@ void __init native_smp_prepare_boot_cpu(void)
>> 		switch_gdt_and_percpu_base(me);
>> 
>> 	native_pv_lock_init();
>>+	native_pv_tlb_init();
>> }
>> 
>> void __init native_smp_cpus_done(unsigned int max_cpus)
>>diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>>index 621e09d049cb..8f5585ebaf09 100644
>>--- a/arch/x86/mm/tlb.c
>>+++ b/arch/x86/mm/tlb.c
>>@@ -26,6 +26,8 @@
>> 
>> #include "mm_internal.h"
>> 
>>+DEFINE_STATIC_KEY_FALSE(tlb_ipi_broadcast_key);
>>+
>> #ifdef CONFIG_PARAVIRT
>> # define STATIC_NOPV
>> #else
>>@@ -1834,3 +1836,16 @@ static int __init create_tlb_single_page_flush_ceiling(void)
>> 	return 0;
>> }
>> late_initcall(create_tlb_single_page_flush_ceiling);
>>+
>>+void __init native_pv_tlb_init(void)
>>+{
>>+#ifdef CONFIG_PARAVIRT
>>+	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
>>+		return;
>>+#endif
>>+
>>+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
>>+		return;
>>+
>>+	static_branch_enable(&tlb_ipi_broadcast_key);
>>+}
>
>
