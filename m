Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8B24E4AF
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935549; cv=none; b=JgN1/hhlq6egOV4VA+pIR57a9KJQK6eMtY2fTpQFu1fP71cCMff0cyNg8JfbHx4L8FiqtVOtPb+ZFHEBNlfWKpR4H3d9KpCDinVs/pppW3YbvqaiCnWEfiJ/gUN1U9UQWbMEuZ+PCbc5wGbZ57iuhdbpJwKmJwEJzwFD1XC6lSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935549; c=relaxed/simple;
	bh=RBaNRBMwigg9SBnAKCSa6o9xxNkZCEmV2JaIIkxYo8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dlml9QFmMvCUNHNaH8CTGJe5DW0TZyvVaLkkcotSs35SNUg7/ey0OsiKdRlJHrtIKb2pgD59uJBQp/B586yCvbh4SwQoJDxMhLgYS8r3Z7ay9Jt7r9kG9Dgsb9OxzWDOhMRyhs7Y/UzFCuVYhDb8Z1zBlAxZcxmVF51qZq4230U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=skyN0xnR; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="skyN0xnR"
Message-ID: <5cc90e7a-ae32-4352-8e0b-2eee5a5ee122@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771935535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwzxsqX59s+nykKGKsV+/BFhtEGlW2DTi98NYRGnb4k=;
	b=skyN0xnRjwRgE04aLNLlLTrPx8oL4jHzrR0//J5EgUt8UGZeWhbyo6JsPyzz7fgoYbBl+q
	tmcEamzE/HoZRWqgxEyscc1vh59cFCapGF5WwILOMLW/SWiPe2yExbx5gWCfIPXoqn1tEB
	XgjVifKLg9ce4HG6BA34Phgl+hyuXjQ=
Date: Tue, 24 Feb 2026 20:18:46 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260224030700.35857-1-lance.yang@linux.dev>
 <20260224114152.GX1395266@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260224114152.GX1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/24 19:41, Peter Zijlstra wrote:
> On Tue, Feb 24, 2026 at 11:07:00AM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When freeing page tables, we try to batch them. If batch allocation fails
>> (GFP_NOWAIT), __tlb_remove_table_one() immediately frees the one without
>> batching.
>>
>> On !CONFIG_PT_RECLAIM, the fallback sends an IPI to all CPUs via
>> tlb_remove_table_sync_one(). It disrupts all CPUs even when only a single
>> process is unmapping memory. IPI broadcast was reported to hurt RT
>> workloads[1].
>>
>> tlb_remove_table_sync_one() synchronizes with lockless page-table walkers
>> (e.g. GUP-fast) that rely on IRQ disabling. These walkers use
>> local_irq_disable(), which is also an RCU read-side critical section.
>>
>> This patch introduces tlb_remove_table_sync_rcu() which uses RCU grace
>> period (synchronize_rcu()) instead of IPI broadcast. This provides the
>> same guarantee as IPI but without disrupting all CPUs. Since batch
>> allocation already failed, we are in a way slow path where sleeping is
>> acceptable - we are in process context (unmap_region, exit_mmap) with only
>> mmap_lock held. might_sleep() will catch any invalid context.
> 
> So sending the IPIs also requires non-atomic context, so change there.

Yeah, you're right!

> What isn't explained, and very much not clear to me, is why
> tlb_remove_table_sync_one() is retained?

Good point. tlb_remove_table_sync_one() is still needed in:

1) khugepaged (mm/khugepaged.c) - after pmdp_collapse_flush()
2) tlb_finish_mmu() (tlb.h) - when tlb->fully_unshared_tables
3) ...

These are not slow paths like batch allocation failure. This patch only
converts this obvious slow path first.

I'm working on converting the remaining callers as well, but not with
RCU, looking at other options (e.g. targeted IPI).

> 
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 4aeac0c3d3f0..bdcc2778ac64 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -251,6 +251,8 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
>>   
>>   void tlb_remove_table_sync_one(void);
>>   
>> +void tlb_remove_table_sync_rcu(void);
>> +
>>   #else
>>   
>>   #ifdef tlb_needs_table_invalidate
>> @@ -259,6 +261,8 @@ void tlb_remove_table_sync_one(void);
>>   
>>   static inline void tlb_remove_table_sync_one(void) { }
>>   
>> +static inline void tlb_remove_table_sync_rcu(void) { }
>> +
>>   #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>>   
>>   
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index fe5b6a031717..2c6fa8db55df 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -296,6 +296,26 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>>   	call_rcu(&batch->rcu, tlb_remove_table_rcu);
>>   }
>>   
>> +/**
>> + * tlb_remove_table_sync_rcu() - synchronize with software page-table walkers
>> + *
>> + * Like tlb_remove_table_sync_one() but uses RCU grace period instead of IPI
>> + * broadcast. Use in slow paths where sleeping is acceptable.
>> + *
>> + * Software/Lockless page-table walkers use local_irq_disable(), which is also
>> + * an RCU read-side critical section. synchronize_rcu() waits for all such
>> + * sections, providing the same guarantee as tlb_remove_table_sync_one() but
>> + * without disrupting all CPUs with IPIs.
>> + *
>> + * Do not use for freeing memory. Use RCU callbacks instead to avoid latency
>> + * spikes. Cannot be called from any atomic context.
>> + */
>> +void tlb_remove_table_sync_rcu(void)
>> +{
>> +	might_sleep();
>> +	synchronize_rcu();
> 
> synchronize_rcu() should end up in a might_sleep() at some point if it
> blocks (which it typically will).

Right, will drop the explicit might_sleep() and "Cannot be called from
any atomic context" from kerneldoc since both have the same requirements.

Thanks,
Lance
