Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85634B661
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045827; cv=none; b=nOoXpUGsixyGxEla0nn5JTFIRzIQEGJLyiS2irPhJxubw9pFXlCLjAoe6YVNZ89ohl4eV0dqZgrJ4HsRMyOpMrbeavN7gPAEIVbVxEO12EGm1wafBcJkfKzs6qA7pRe05vAaxHH0AYfntkULNfytikyKLglpyBnUbvYKTeCtsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045827; c=relaxed/simple;
	bh=8ajPySBvaEj4QejDUTT/lGKe3oq//ktcHG0pG8tk4J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMfc4HQj0tnP89j2XBYPs/Yr0oZD5mPEyaQEbB3jMHbfELL/+oTf/eF/hkbRhOaWaRJqxgeahhKyeoMtITPK/9twt94kED9B2wajNFAQlyREXQz4JQ4cicB2J/GoyBEaxRAnq24fnQm4usBCDyoO48ydhIutLOkxJ5h03rv6A24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nDYZtFLL; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nDYZtFLL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777045812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0j98C+k0FMWienD6UU5F2vb7kP4FNq4bGSEt/E3eHFc=;
	b=nDYZtFLLrnOgK12w/V+IKSpSn1f+kKAdlx9MxGf9+VxfN8W+VCYuqrJwbVbkr853pz5rGx
	DSsRYviaI913+dgjdnpLDuo5l1LinOTZYG0rPmnGn/WaHi4nK1Qh8qC8CpUOvF1BW3DNGZ
	zruonZ1x3yeh1kvHTNrfZAZ1C0jmVD0=
From: Lance Yang <lance.yang@linux.dev>
To: peterz@infradead.org,
	dave.hansen@intel.com
Cc: lance.yang@linux.dev,
	akpm@linux-foundation.org,
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
Subject: Re: [PATCH 7.2 v10 2/2] x86/tlb: skip redundant sync IPIs for native TLB flush
Date: Fri, 24 Apr 2026 23:49:43 +0800
Message-Id: <20260424154943.67564-1-lance.yang@linux.dev>
In-Reply-To: <20260424151247.GG3126523@noisy.programming.kicks-ass.net>
References: <20260424151247.GG3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Apr 24, 2026 at 05:12:47PM +0200, Peter Zijlstra wrote:
>On Fri, Apr 24, 2026 at 02:25:28PM +0800, Lance Yang wrote:
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index cfcb60468b01..2cf1eeaffd6f 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -63,7 +63,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>>  	struct hv_tlb_flush *flush;
>>  	u64 status;
>>  	unsigned long flags;
>> -	bool do_lazy = !info->freed_tables;
>> +	bool do_lazy = !info->wake_lazy_cpus;
>>  
>>  	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>>  
>> @@ -198,7 +198,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>>  
>>  	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>>  	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
>> -			info->freed_tables ? NULL : cpu_is_lazy);
>> +			info->wake_lazy_cpus ? NULL : cpu_is_lazy);
>>  	if (nr_bank < 0)
>>  		return HV_STATUS_INVALID_PARAMETER;
>>  
>> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>> index 866ea78ba156..fb256fd95f95 100644
>> --- a/arch/x86/include/asm/tlb.h
>> +++ b/arch/x86/include/asm/tlb.h
>
>>  static inline void tlb_flush(struct mmu_gather *tlb)
>>  {
>>  	unsigned long start = 0UL, end = TLB_FLUSH_ALL;
>>  	unsigned int stride_shift = tlb_get_unmap_shift(tlb);
>>  
>> +	/*
>> +	 * Both freed_tables and unshared_tables must wake lazy-TLB CPUs, so
>> +	 * they receive IPIs before reusing or freeing page tables, allowing
>> +	 * us to safely implement tlb_table_flush_implies_ipi_broadcast().
>> +	 */
>> +	bool wake_lazy_cpus = tlb->freed_tables || tlb->unshared_tables;
>> +
>>  	if (!tlb->fullmm && !tlb->need_flush_all) {
>>  		start = tlb->start;
>>  		end = tlb->end;
>>  	}
>>  
>> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
>> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, wake_lazy_cpus);
>>  }
>>  
>>  static inline void invlpg(unsigned long addr)
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index 5a3cdc439e38..39b9454781c3 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -225,7 +227,7 @@ struct flush_tlb_info {
>>  	u64			new_tlb_gen;
>>  	unsigned int		initiating_cpu;
>>  	u8			stride_shift;
>> -	u8			freed_tables;
>> +	u8			wake_lazy_cpus;
>>  	u8			trim_cpumask;
>>  };
>>  
>> @@ -315,7 +317,7 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
>>  extern void flush_tlb_all(void);
>>  extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>>  				unsigned long end, unsigned int stride_shift,
>> -				bool freed_tables);
>> +				bool wake_lazy_cpus);
>>  extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>>  
>>  static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
>
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index 621e09d049cb..3ce254a3982c 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -1360,16 +1362,16 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
>>  				(info->end - info->start) >> PAGE_SHIFT);
>>  
>>  	/*
>> -	 * If no page tables were freed, we can skip sending IPIs to
>> -	 * CPUs in lazy TLB mode. They will flush the CPU themselves
>> -	 * at the next context switch.
>> +	 * If lazy-TLB CPUs do not need to be woken, we can skip sending
>> +	 * IPIs to them. They will flush themselves at the next context
>> +	 * switch.
>>  	 *
>> -	 * However, if page tables are getting freed, we need to send the
>> -	 * IPI everywhere, to prevent CPUs in lazy TLB mode from tripping
>> -	 * up on the new contents of what used to be page tables, while
>> -	 * doing a speculative memory access.
>> +	 * However, if page tables are getting freed or unshared, we need
>> +	 * to send the IPI everywhere, to prevent CPUs in lazy TLB mode
>> +	 * from tripping up on the new contents of what used to be page
>> +	 * tables, while doing a speculative memory access.
>>  	 */
>> -	if (info->freed_tables || mm_in_asid_transition(info->mm))
>> +	if (info->wake_lazy_cpus || mm_in_asid_transition(info->mm))
>>  		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>>  	else
>>  		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
>> @@ -1402,7 +1404,7 @@ static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
>>  
>>  static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
>>  			unsigned long start, unsigned long end,
>> -			unsigned int stride_shift, bool freed_tables,
>> +			unsigned int stride_shift, bool wake_lazy_cpus,
>>  			u64 new_tlb_gen)
>>  {
>>  	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
>> @@ -1429,7 +1431,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
>>  	info->end		= end;
>>  	info->mm		= mm;
>>  	info->stride_shift	= stride_shift;
>> -	info->freed_tables	= freed_tables;
>> +	info->wake_lazy_cpus	= wake_lazy_cpus;
>>  	info->new_tlb_gen	= new_tlb_gen;
>>  	info->initiating_cpu	= smp_processor_id();
>>  	info->trim_cpumask	= 0;
>> @@ -1448,7 +1450,7 @@ static void put_flush_tlb_info(void)
>>  
>>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>>  				unsigned long end, unsigned int stride_shift,
>> -				bool freed_tables)
>> +				bool wake_lazy_cpus)
>>  {
>>  	struct flush_tlb_info *info;
>>  	int cpu = get_cpu();
>> @@ -1457,7 +1459,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>>  	/* This is also a barrier that synchronizes with switch_mm(). */
>>  	new_tlb_gen = inc_mm_tlb_gen(mm);
>>  
>> -	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
>> +	info = get_flush_tlb_info(mm, start, end, stride_shift, wake_lazy_cpus,
>>  				  new_tlb_gen);
>>  
>>  	/*
>
>This whole s/freed_tables/wake_lazy_cpus/ rename should probably be its
>own patch, as should that include unshare_tables thing be.
>
>That seems like unrelated changes.

Thanks, makes sense! Will split the pure s/freed_tables/wake_lazy_cpus/
rename out.

For the tlb->unshared_tables part, I would keep it with this patch, 
since lazy-TLB CPUs still have to be woken before reusing unshared page
tables.

@Dave what do you think?

Thanks,
Lance
