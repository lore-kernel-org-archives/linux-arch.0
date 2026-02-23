Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EB366048;
	Mon, 23 Feb 2026 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851776; cv=none; b=KVfJwnymCEz6Rp8vF5IFoel/+ArbyPi+KiYBjghslaqhnF3UIYPFcm1rpZWQQI6nVH2ue0qThsZJfaxGA6fjt+g0fJXXmrVBfpN2TZv+YRYdfC0DWW5eNAd2j9pjm48eXvNMYdTuVAI3kt6/GSF+4HG+mW8DzpzWx0HkuMRWPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851776; c=relaxed/simple;
	bh=ptRUSre2ZAhwCRyTmqafxxaRaPN+lKYGNkEB7a3hP9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4wqamkfFJv2QiXUW2Roa0FNhHSNv6QeZ3O8rC3rEDUGffpmZT7VSxyi8bniwL9MbP0ZU7/PIAgCaUxn2Hx61qoDzF20qNYS21VLW6d6OUuwoQ2pkBixj7DGeI3DrRqAvkiZ91oLYDyPjBnfsFLAjIzIfCQzkxxzk4ys1zGf4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkG6/V+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkG6/V+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE70C116C6;
	Mon, 23 Feb 2026 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771851775;
	bh=ptRUSre2ZAhwCRyTmqafxxaRaPN+lKYGNkEB7a3hP9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jkG6/V+6CCoPx7QwGGY9LjtWnT3Cx0CYRQlMmmzR0dlwY85ydB5NBfBqJVlsQ8Jvo
	 XnmHrTgR0m8vGgr7+JNzCaSi7tYRFoi2oP8HfTjyNa3gBkJawjebb3bfRm0zwDUaYq
	 xUGP4O3sa5d5ql/2minx/yt1S8tJRHns70MApU30iiXLsCH6Rt+b1hgtq3AfvYdqmM
	 139yVFJe9vUKEZZDk0wYn9uf4oc1GUhfL5cMWtOI0bz/qu5KGof0Ftw8khjLBb5TJz
	 T33weFbOYqqoVo0JDNfsSX6DzyOPSuqG/eY48ouFCRQgSM/94O5XwTwCKK68kDPNb9
	 snkjHk91pLUaA==
Message-ID: <b7570a41-9bad-403c-b2c8-108393589079@kernel.org>
Date: Mon, 23 Feb 2026 14:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 dave.hansen@intel.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@gmail.com,
 peterz@infradead.org, will@kernel.org
References: <2a6c4e62-1663-4a98-9adc-406a6a1ebfd3@kernel.org>
 <20260223125826.28207-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260223125826.28207-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 13:58, Lance Yang wrote:
> 
> On Mon, Feb 23, 2026 at 10:29:56AM +0100, David Hildenbrand (Arm) wrote:
>> On 2/23/26 04:36, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> When freeing page tables, we try to batch them. If batch allocation fails
>>> (GFP_NOWAIT), __tlb_remove_table_one() immediately frees the one without
>>> batching.
>>>
>>> On !CONFIG_PT_RECLAIM, the fallback sends an IPI to all CPUs via
>>> tlb_remove_table_sync_one(). It disrupts all CPUs even when only a single
>>> process is unmapping memory. IPI broadcast was reported to hurt RT
>>> workloads[1].
>>>
>>> tlb_remove_table_sync_one() synchronizes with lockless page-table walkers
>>> (e.g. GUP-fast) that rely on IRQ disabling. These walkers use
>>> local_irq_disable(), which is also an RCU read-side critical section.
>>> synchronize_rcu() waits for all such sections to complete, providing the
>>> same guarantee as IPI but without disrupting all CPUs.
>>>
>>> Since batch allocation already failed, we are in a way slow path, so
>>> replacing the IPI with synchronize_rcu() is fine.
>>>
>>> We are in process context (unmap_region, exit_mmap) with only mmap_lock
>>> held, a sleeping lock. synchronize_rcu() will catch any invalid context
>>> via might_sleep().
>>>
>>> [1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/
>>>
>>> Link: https://lore.kernel.org/linux-mm/20260202150957.GD1282955@noisy.programming.kicks-ass.net/
>>> Link: https://lore.kernel.org/linux-mm/dfdfeac9-5cd5-46fc-a5c1-9ccf9bd3502a@intel.com/
>>> Link: https://lore.kernel.org/linux-mm/bc489455-bb18-44dc-8518-ae75abda6bec@kernel.org/
>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>>> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>>
>> I think it was primarily Peter and Dave suggesting that :)
> 
> :)
> 
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>    mm/mmu_gather.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>>> index fe5b6a031717..df670c219260 100644
>>> --- a/mm/mmu_gather.c
>>> +++ b/mm/mmu_gather.c
>>> @@ -339,7 +339,8 @@ static inline void __tlb_remove_table_one(void *table)
>>>    #else
>>>    static inline void __tlb_remove_table_one(void *table)
>>>    {
>>> -	tlb_remove_table_sync_one();
>>> +	if (IS_ENABLED(CONFIG_MMU_GATHER_RCU_TABLE_FREE))
>>> +		synchronize_rcu();
>>
>> That should work.
>>
>> Reading all the comments for tlb_remove_table_smp_sync(), I wonder
>> whether we should wrap that in a tlb_remove_table_sync_rcu() function,
>> with a proper kerneldoc for the CONFIG_MMU_GATHER_RCU_TABLE_FREE variant
>> where we discuss how this relates to tlb_remove_table_sync_one (and
>> tlb_remove_table_smp_sync() .
> 
> Good point! That would be cleaner and better ;)
> 
> How about the following:
> 
> ---8<---
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index fe5b6a031717..ea5503d3e650 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -296,6 +296,24 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>   	call_rcu(&batch->rcu, tlb_remove_table_rcu);
>   }
> 
> +/**
> + * tlb_remove_table_sync_rcu() - synchronize with software page-table walkers
> + *
> + * Like tlb_remove_table_sync_one() but uses RCU grace period instead of IPI
> + * broadcast. Should be used in slow paths where sleeping is acceptable.
> + *
> + * Software/Lockless page-table walkers use local_irq_disable(), which is also
> + * an RCU read-side critical section. synchronize_rcu() waits for all such
> + * sections, providing the same guarantee as tlb_remove_table_sync_one() but
> + * without disrupting all CPUs with IPIs.
> + *
> + * Context: Can sleep/block. Cannot be called from any atomic context.
> + */
> +static void tlb_remove_table_sync_rcu(void)
> +{
> +	synchronize_rcu();
> +}
> +
>   #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
> 
>   static void tlb_remove_table_free(struct mmu_table_batch *batch)
> @@ -303,6 +321,10 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>   	__tlb_remove_table_free(batch);
>   }
> 
> +static void tlb_remove_table_sync_rcu(void)
> +{
> +}
> +
>   #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
> 
>   /*
> @@ -339,7 +361,7 @@ static inline void __tlb_remove_table_one(void *table)
>   #else
>   static inline void __tlb_remove_table_one(void *table)
>   {
> -	tlb_remove_table_sync_one();
> +	tlb_remove_table_sync_rcu();
>   	__tlb_remove_table(table);
>   }
>   #endif /* CONFIG_PT_RECLAIM */
> ---
> 
> Thanks for the suggestion!
> Lance

LGTM, but let's hear other options.


-- 
Cheers,

David
