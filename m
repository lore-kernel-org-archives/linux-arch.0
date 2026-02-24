Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691D3783BD
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932751; cv=none; b=No8KW9vC6UzHp1uXOcwmrqbTRandHh1FTjDRyEuqj2OdsaXZxCap+3WhJHQ0eIAu5xc/xatPlp7QTR9zOdso+JOp2qyiJBjh9ysOSz7pk/4Abcxaia3wVdt+jtQp7GOiJYXe6G73p78f3idBK1CbachbLFnRCXH44vB2UURou/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932751; c=relaxed/simple;
	bh=Qu+46xWBqUHjFm0EuASXZSN6wMzYSfVEYFwhbgRXvUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd37PxlbnmIYTos3nIP4/D4tZXbq9+tDviEd0/tV+W3qU2gAXrDNtvp/uPG2vm2ijpuVVUpLr/YhPKh5LJzTx4/Vc7T1j4D4h+Zi/L8NmO0w2m5OHx7pCXIy3fxkp0a7ifriX0mVeuOzndXt2KjlU3VDITHEANErIScClVVCMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aGQXpr+L; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aGQXpr+L"
Message-ID: <d8c66312-9961-448b-a786-27faf7a822a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771932737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sUWrbvtvOac8BzVrjFlUEtf6mDEIHrNMXT5s8eGfSo=;
	b=aGQXpr+LFW5UzYlxmtjZAQfaKo3zEtunIzqMLPndRcd0xxFbuOjoWhJ0xxPlu+itItvZYR
	P+25P7pa5OxTJwsTEa3ITD0E2r7Nz4kjvl5jtsdytuZSl3rG8uPtk0+Msf9/Yo4qqAmxMt
	uJ49Hwu6106BiPXR3FnUesDHnVw7NJY=
Date: Tue, 24 Feb 2026 19:32:08 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org,
 peterz@infradead.org
Cc: dave.hansen@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260224030700.35857-1-lance.yang@linux.dev>
 <d5c90e6b-9dc9-4524-bcd7-534e311beec2@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <d5c90e6b-9dc9-4524-bcd7-534e311beec2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/24 19:04, David Hildenbrand (Arm) wrote:
> On 2/24/26 04:07, Lance Yang wrote:
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
>>
>> [1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/
>>
>> Link: https://lore.kernel.org/linux-mm/20260202150957.GD1282955@noisy.programming.kicks-ass.net/
>> Link: https://lore.kernel.org/linux-mm/dfdfeac9-5cd5-46fc-a5c1-9ccf9bd3502a@intel.com/
>> Link: https://lore.kernel.org/linux-mm/bc489455-bb18-44dc-8518-ae75abda6bec@kernel.org/
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> v1 -> v2:
>> - Wrap synchronize_rcu() in tlb_remove_table_sync_rcu() with proper
>>    kerneldoc (per David)
>> - Add might_sleep() to make sleeping constraint explicit (per Dave)
>> - Clarify this is for synchronization, not memory freeing (per Dave)
>> - https://lore.kernel.org/linux-mm/20260223033604.10198-1-lance.yang@linux.dev/
>>
>>   include/asm-generic/tlb.h |  4 ++++
>>   mm/mmu_gather.c           | 22 +++++++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
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
> 
> Nit: no need for the "()"

Oops, @Andrew could you drop the "()" here when applying?

> 
> Thanks!
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for taking time to review!
