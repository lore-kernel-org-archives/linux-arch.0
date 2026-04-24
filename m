Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC92BEC27;
	Fri, 24 Apr 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043591; cv=none; b=M+rzJ3O6GkqPXE2FKl5cSXE6V2TvVqwCBKhGU6zW5PuoKrD8G1KFRUIHYA8L/1hocUj6zHF0UL4bOKbr+jpj5ie3vPBplUktHGEaD4h8dwsAsabfPsUUv7Rn37/8e99qJXEdOlGLjbWQ3mD5t/LeSS+7dA3MPWqXRr/Ic8GhNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043591; c=relaxed/simple;
	bh=xYXJK+a+R3f1wnU/4nZkOjCcn01JAxieLKQ2xSOGPB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS9s9kdY7q4lBsb+XCk650T3my/c9M2T2HuyUBs1z1u4HQBaq8yzO+3wwFiRAEORaBaFMn+bD8gtyLZktxR9FV7eU+hpAw+4ymVGFXDYdaGhnLcmu3YRxoJfsNy+prGlOvFZoHJbHYeA99rsOHZaZJUoW7gAuRu9AB6VTWu0/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZhhchdJF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhhchdJF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=baIpBz6aXOlLb2F6BEUohnTvCndCw/3+ATrc+ipc7oU=; b=ZhhchdJFtym8U+LIXCoVLeR2gB
	/csyHZe3SikhGJKPPECkv/IGwNAFB49pA/VgwWs+vJ3q/bThmE33AO9boC7HohP1U5av3e9kSTeOH
	AWLbUnRwoeRUGOHsRMzxe8X/1v7l2IMCLy6h91V0RFCrlcho/8nHHyk8AoPldjdmP9HtOjRKUCxt2
	aQCkricJncWE0f/vLN2+1gicbZAskJsVAVwRIsTu8vBEX+BoQz5/jRVr9KL2m/YH/z2jx9QW5kp5o
	qiRUYnvW3KAOCdw5y/068LZpESHso9/GpHfOBSSafH7EumBrbLlgaxIIMIId9Z4WpUIJywsNo1744
	3zsbr63A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGID3-0000000F1yt-04pa;
	Fri, 24 Apr 2026 15:12:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1ED130301B; Fri, 24 Apr 2026 17:12:47 +0200 (CEST)
Date: Fri, 24 Apr 2026 17:12:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
	jannh@google.com, jgross@suse.com, seanjc@google.com,
	pbonzini@redhat.com, boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v10 2/2] x86/tlb: skip redundant sync IPIs for native
 TLB flush
Message-ID: <20260424151247.GG3126523@noisy.programming.kicks-ass.net>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424062528.71951-3-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424062528.71951-3-lance.yang@linux.dev>

On Fri, Apr 24, 2026 at 02:25:28PM +0800, Lance Yang wrote:
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index cfcb60468b01..2cf1eeaffd6f 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -63,7 +63,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>  	struct hv_tlb_flush *flush;
>  	u64 status;
>  	unsigned long flags;
> -	bool do_lazy = !info->freed_tables;
> +	bool do_lazy = !info->wake_lazy_cpus;
>  
>  	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>  
> @@ -198,7 +198,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>  
>  	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>  	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
> -			info->freed_tables ? NULL : cpu_is_lazy);
> +			info->wake_lazy_cpus ? NULL : cpu_is_lazy);
>  	if (nr_bank < 0)
>  		return HV_STATUS_INVALID_PARAMETER;
>  
> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index 866ea78ba156..fb256fd95f95 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h

>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
>  	unsigned long start = 0UL, end = TLB_FLUSH_ALL;
>  	unsigned int stride_shift = tlb_get_unmap_shift(tlb);
>  
> +	/*
> +	 * Both freed_tables and unshared_tables must wake lazy-TLB CPUs, so
> +	 * they receive IPIs before reusing or freeing page tables, allowing
> +	 * us to safely implement tlb_table_flush_implies_ipi_broadcast().
> +	 */
> +	bool wake_lazy_cpus = tlb->freed_tables || tlb->unshared_tables;
> +
>  	if (!tlb->fullmm && !tlb->need_flush_all) {
>  		start = tlb->start;
>  		end = tlb->end;
>  	}
>  
> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, wake_lazy_cpus);
>  }
>  
>  static inline void invlpg(unsigned long addr)
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 5a3cdc439e38..39b9454781c3 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -225,7 +227,7 @@ struct flush_tlb_info {
>  	u64			new_tlb_gen;
>  	unsigned int		initiating_cpu;
>  	u8			stride_shift;
> -	u8			freed_tables;
> +	u8			wake_lazy_cpus;
>  	u8			trim_cpumask;
>  };
>  
> @@ -315,7 +317,7 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
>  extern void flush_tlb_all(void);
>  extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  				unsigned long end, unsigned int stride_shift,
> -				bool freed_tables);
> +				bool wake_lazy_cpus);
>  extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  
>  static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)

> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 621e09d049cb..3ce254a3982c 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1360,16 +1362,16 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
>  				(info->end - info->start) >> PAGE_SHIFT);
>  
>  	/*
> -	 * If no page tables were freed, we can skip sending IPIs to
> -	 * CPUs in lazy TLB mode. They will flush the CPU themselves
> -	 * at the next context switch.
> +	 * If lazy-TLB CPUs do not need to be woken, we can skip sending
> +	 * IPIs to them. They will flush themselves at the next context
> +	 * switch.
>  	 *
> -	 * However, if page tables are getting freed, we need to send the
> -	 * IPI everywhere, to prevent CPUs in lazy TLB mode from tripping
> -	 * up on the new contents of what used to be page tables, while
> -	 * doing a speculative memory access.
> +	 * However, if page tables are getting freed or unshared, we need
> +	 * to send the IPI everywhere, to prevent CPUs in lazy TLB mode
> +	 * from tripping up on the new contents of what used to be page
> +	 * tables, while doing a speculative memory access.
>  	 */
> -	if (info->freed_tables || mm_in_asid_transition(info->mm))
> +	if (info->wake_lazy_cpus || mm_in_asid_transition(info->mm))
>  		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>  	else
>  		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
> @@ -1402,7 +1404,7 @@ static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
>  
>  static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
>  			unsigned long start, unsigned long end,
> -			unsigned int stride_shift, bool freed_tables,
> +			unsigned int stride_shift, bool wake_lazy_cpus,
>  			u64 new_tlb_gen)
>  {
>  	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
> @@ -1429,7 +1431,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
>  	info->end		= end;
>  	info->mm		= mm;
>  	info->stride_shift	= stride_shift;
> -	info->freed_tables	= freed_tables;
> +	info->wake_lazy_cpus	= wake_lazy_cpus;
>  	info->new_tlb_gen	= new_tlb_gen;
>  	info->initiating_cpu	= smp_processor_id();
>  	info->trim_cpumask	= 0;
> @@ -1448,7 +1450,7 @@ static void put_flush_tlb_info(void)
>  
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  				unsigned long end, unsigned int stride_shift,
> -				bool freed_tables)
> +				bool wake_lazy_cpus)
>  {
>  	struct flush_tlb_info *info;
>  	int cpu = get_cpu();
> @@ -1457,7 +1459,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  	/* This is also a barrier that synchronizes with switch_mm(). */
>  	new_tlb_gen = inc_mm_tlb_gen(mm);
>  
> -	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
> +	info = get_flush_tlb_info(mm, start, end, stride_shift, wake_lazy_cpus,
>  				  new_tlb_gen);
>  
>  	/*

This whole s/freed_tables/wake_lazy_cpus/ rename should probably be its
own patch, as should that include unshare_tables thing be.

That seems like unrelated changes.
