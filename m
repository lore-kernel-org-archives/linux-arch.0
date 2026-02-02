Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8793644A0;
	Mon,  2 Feb 2026 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034511; cv=none; b=kApsKS6HBAvlVNsGkb/sD9UXucsFuhqx3OOhQMTjkVrSigtxsPcBH/CNAjeKPoGQTVyVxc/7VUxo4N5M6dc9IAlQ8nxhUt6rYBioQxSF8PdqibhNsnFeqQBccYx+oHZ5kehM9jiUfsHHULBBMRVVJdCPwU6FFvOG4OHTmP0MLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034511; c=relaxed/simple;
	bh=fIZA7nOzhZsk4YFg+si9gOmduydVH6FX3wBjfbu7xWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtCcMiCK9svS5XMbWmkFXQO7Xl5LEwZoz7i8FfnYzJBIK486J9/wPJigBr5k9gAEh9+xMWcLQEv99Oen9qTgkYP2Gitqv4ka2crv2Azo0ne3w3t4Ygs9nCclsvWbMYh4UWGo8meyUt4nowggnG+xhuzhz5Wico3LvCIPH/aQu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c43ucQG9; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c43ucQG9"
Message-ID: <0f44dfb7-fce3-44c1-ab25-b013ba18a59b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770034495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jituq4TCCBnJRRiPEJzrUjf8Tl3pN0KvOPn2lg/6vfc=;
	b=c43ucQG9ejToxHXbWiUtSl7n+JmaAbVKsyyyHJ67d+OURnCrLJ1c7JPyZwM8bBK+3f7Xbx
	WcuCypGqT3+1lpn5LaGRnO61hbdZX5On3WJ1PuhqJicfTM70UlMTt2ktFd2ZJ/Cy+RtXxT
	d+dpXXZfc5SXdF6be85Pzf8UNBt0izw=
Date: Mon, 2 Feb 2026 20:14:32 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] mm: use targeted IPIs for TLB sync with lockless
 page table walkers
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260202074557.16544-1-lance.yang@linux.dev>
 <20260202074557.16544-2-lance.yang@linux.dev>
 <20260202094245.GD2995752@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260202094245.GD2995752@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Peter,

Thanks for taking time to review!

On 2026/2/2 17:42, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 03:45:55PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Currently, tlb_remove_table_sync_one() broadcasts IPIs to all CPUs to wait
>> for any concurrent lockless page table walkers (e.g., GUP-fast). This is
>> inefficient on systems with many CPUs, especially for RT workloads[1].
>>
>> This patch introduces a per-CPU tracking mechanism to record which CPUs are
>> actively performing lockless page table walks for a specific mm_struct.
>> When freeing/unsharing page tables, we can now send IPIs only to the CPUs
>> that are actually walking that mm, instead of broadcasting to all CPUs.
>>
>> In preparation for targeted IPIs; a follow-up will switch callers to
>> tlb_remove_table_sync_mm().
>>
>> Note that the tracking adds ~3% latency to GUP-fast, as measured on a
>> 64-core system.
> 
> What architecture, and that is acceptable?

x86-64.

I ran ./gup_bench which spawns 60 threads, each doing 500k GUP-fast
operations (pinning 8 pages per call) via the gup_test ioctl.

Results for pin pages:
- Before: avg 1.489s (10 runs)
- After:  avg 1.533s (10 runs)

Given we avoid broadcast IPIs on large systems, I think this is a
reasonable trade-off :)

> 
>> +/*
>> + * Track CPUs doing lockless page table walks to avoid broadcast IPIs
>> + * during TLB flushes.
>> + */
>> +DECLARE_PER_CPU(struct mm_struct *, active_lockless_pt_walk_mm);
>> +
>> +static inline void pt_walk_lockless_start(struct mm_struct *mm)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	/*
>> +	 * Tell other CPUs we're doing lockless page table walk.
>> +	 *
>> +	 * Full barrier needed to prevent page table reads from being
>> +	 * reordered before this write.
>> +	 *
>> +	 * Pairs with smp_rmb() in tlb_remove_table_sync_mm().
>> +	 */
>> +	this_cpu_write(active_lockless_pt_walk_mm, mm);
>> +	smp_mb();
> 
> One thing to try is something like:
> 
> 	xchg(this_cpu_ptr(&active_lockless_pt_walk_mm), mm);
> 
> That *might* be a little better on x86_64, on anything else you really
> don't want to use this_cpu_() ops when you *know* IRQs are already
> disabled.

Ah, good to know that. Thanks!

IIUC, xchg() provides the full barrier we need ;)

> 
>> +}
>> +
>> +static inline void pt_walk_lockless_end(void)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	/*
>> +	 * Clear the pointer so other CPUs no longer see this CPU as walking
>> +	 * the mm. Use smp_store_release to ensure page table reads complete
>> +	 * before the clear is visible to other CPUs.
>> +	 */
>> +	smp_store_release(this_cpu_ptr(&active_lockless_pt_walk_mm), NULL);
>> +}
>> +
>>   int get_user_pages_fast(unsigned long start, int nr_pages,
>>   			unsigned int gup_flags, struct page **pages);
>>   int pin_user_pages_fast(unsigned long start, int nr_pages,
> 
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index 2faa23d7f8d4..35c89e4b6230 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -285,6 +285,56 @@ void tlb_remove_table_sync_one(void)
>>   	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
>>   }
>>   
>> +DEFINE_PER_CPU(struct mm_struct *, active_lockless_pt_walk_mm);
>> +EXPORT_PER_CPU_SYMBOL_GPL(active_lockless_pt_walk_mm);
> 
> Why the heck is this exported? Both users are firmly core code.

OK. Will drop this export.

> 
>> +/**
>> + * tlb_remove_table_sync_mm - send IPIs to CPUs doing lockless page table
>> + * walk for @mm
>> + *
>> + * @mm: target mm; only CPUs walking this mm get an IPI.
>> + *
>> + * Like tlb_remove_table_sync_one() but only targets CPUs in
>> + * active_lockless_pt_walk_mm.
>> + */
>> +void tlb_remove_table_sync_mm(struct mm_struct *mm)
>> +{
>> +	cpumask_var_t target_cpus;
>> +	bool found_any = false;
>> +	int cpu;
>> +
>> +	if (WARN_ONCE(!mm, "NULL mm in %s\n", __func__)) {
>> +		tlb_remove_table_sync_one();
>> +		return;
>> +	}
>> +
>> +	/* If we can't, fall back to broadcast. */
>> +	if (!alloc_cpumask_var(&target_cpus, GFP_ATOMIC)) {
>> +		tlb_remove_table_sync_one();
>> +		return;
>> +	}
>> +
>> +	cpumask_clear(target_cpus);
>> +
>> +	/* Pairs with smp_mb() in pt_walk_lockless_start(). */
> 
> Pairs how? The start thing does something like:
> 
> 	[W] active_lockless_pt_walk_mm = mm
> 	MB
> 	[L] page-tables
> 
> So this is:
> 
> 	[L] page-tables
> 	RMB
> 	[L] active_lockless_pt_walk_mm
> 
> ?

On the walker side (pt_walk_lockless_start):

  [W]  active_lockless_pt_walk_mm = mm
  MB
  [L] page-tables (walker reads page tables)

So the walker publishes "I'm walking this mm" before reading page tables.

On the sync side we don't read page-tables. We do:

  RMB
  [L] active_lockless_pt_walk_mm (we read the per-CPU pointer below)

We need to observe the walker's store of active_lockless_pt_walk_mm before
we decide which CPUs to IPI.

So on the sync side we do smp_rmb(), then read active_lockless_pt_walk_mm.

That pairs with the full barrier in pt_walk_lockless_start().

> 
>> +	smp_rmb();
>> +
>> +	/* Find CPUs doing lockless page table walks for this mm */
>> +	for_each_online_cpu(cpu) {
>> +		if (per_cpu(active_lockless_pt_walk_mm, cpu) == mm) {
>> +			cpumask_set_cpu(cpu, target_cpus);
> 
> You really don't need this to be atomic.
> 
>> +			found_any = true;
>> +		}
>> +	}
>> +
>> +	/* Only send IPIs to CPUs actually doing lockless walks */
>> +	if (found_any)
>> +		smp_call_function_many(target_cpus, tlb_remove_table_smp_sync,
>> +				       NULL, 1);
> 
> Coding style wants { } here. Also, isn't this what we have
> smp_call_function_many_cond() for?

Right! That would be better, something like:

static bool tlb_remove_table_sync_mm_cond(int cpu, void *mm)
{
	return per_cpu(active_lockless_pt_walk_mm, cpu) == (struct mm_struct *)mm;
}

on_each_cpu_cond_mask(tlb_remove_table_sync_mm_cond,
			tlb_remove_table_smp_sync,
			(void *)mm, true, cpu_online_mask);

> 
>> +	free_cpumask_var(target_cpus);
>> +}
>> +
>>   static void tlb_remove_table_rcu(struct rcu_head *head)
>>   {
>>   	__tlb_remove_table_free(container_of(head, struct mmu_table_batch, rcu));
>> -- 
>> 2.49.0
>>

Thanks,
Lance

