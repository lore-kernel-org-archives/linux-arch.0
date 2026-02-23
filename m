Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FCC313543
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864230; cv=none; b=m515JxA4GHoxlonndTeVAJyzFzs1MTTToktaZ9VaQUCJDgXEa1D6v1SFkFNndIZR5+dhoss5yiqFb/SkRungecO5Nnip0YimVjHMJYLAYVRJ82N/nvmWIdQnKT9s4m65wLp1yyyOqXTx8gNAS3GnXVQVKwFHTmNf8vV6axCq5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864230; c=relaxed/simple;
	bh=scfm+VtYnK2rI2ku6ej5GIPYPo5Ncct3We+3xFtsKao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M62RHYo9O+Simho69zF1xoqDIod1bkgtduBQDk6XP2vyg4FOU/ZNnGp9gFswr9WO+b+TT+RH7pbDoBsJeobKFG+QLMVvtRXvBZX+VLeJEjRua92nRnVd9nFz0Y5URUHqo6pWvaU94LzRiVez7sPzBUt+9Qogtum9oTgRAfSJPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LyOU3zaz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LyOU3zaz"
Message-ID: <1373db93-3977-425f-ad59-5970e7e50b48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771864226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARqOYR9ga5SHWqbWk98YZPj49IHJaMAkP4feff8FaFI=;
	b=LyOU3zazNaudEi4Z5JNNsUHEUe1xivKzD5sznztk3Sd2AXdXKzTXp3uS54+r+pYexQEYNZ
	Mpiv8YDQm0nICVFPgZtHj/ozvxeDFIkzs/FuBiu36EdcaluQG+q8cTLVsMMFg0RxomVQ/2
	2kWQhdLcAzKl3aM+QOwTK0nDBUcG1yw=
Date: Tue, 24 Feb 2026 00:29:29 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org,
 will@kernel.org, david@kernel.org
References: <2a6c4e62-1663-4a98-9adc-406a6a1ebfd3@kernel.org>
 <20260223125826.28207-1-lance.yang@linux.dev>
 <a0c434c4-ec65-4a37-9422-5614249124bc@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a0c434c4-ec65-4a37-9422-5614249124bc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/23 23:31, Dave Hansen wrote:
> On 2/23/26 04:58, Lance Yang wrote:
> ...
>> +/**
>> + * tlb_remove_table_sync_rcu() - synchronize with software page-table walkers
>> + *
>> + * Like tlb_remove_table_sync_one() but uses RCU grace period instead of IPI
>> + * broadcast. Should be used in slow paths where sleeping is acceptable.
> 
> Just a nit on comments: Use imperative voice:
> 
> 	... Use in slow paths where sleeping is acceptable.

Okay, thanks.

>> + * Software/Lockless page-table walkers use local_irq_disable(), which is also
>> + * an RCU read-side critical section. synchronize_rcu() waits for all such
>> + * sections, providing the same guarantee as tlb_remove_table_sync_one() but
>> + * without disrupting all CPUs with IPIs.
> 
> Yep, synchronize_rcu() is likely slower (longer wall clock time) but
> less disruptive to other CPUs.
> 
> Is it worth explaining here that this should be used when code really
> needs to _wait_ and *not* for freeing memory? Freeing memory should use
> RCU callbacks that don't cause latency spikes in this thread, not this.

Good point! Worth clarifying. Something like:

Note: Use this when code really needs to wait for synchronization,
*not* for freeing memory. Memory freeing should use RCU callbacks
that don't cause latency spikes in this thread.

>> + * Context: Can sleep/block. Cannot be called from any atomic context.
> 
> As a general rule, expressing constraints like this is best done in
> code, not comments, so:
> 
> 	might_sleep();
> or
> 	WARN_ON_ONCE(!in_atomic());
> 
> seem appropriate.
> 
> I didn't see any obvious warning like that in the top levels of
> synchronize_rcu().

Yep, synchronize_rcu() does call might_sleep() internally:

synchronize_rcu()
   -> synchronize_rcu_normal()
     -> wait_rcu_gp()      -> __wait_rcu_gp()
         -> might_sleep()
But adding an explicit might_sleep() here makes the constraint
more obvious. I'll add it :)

>> +static void tlb_remove_table_sync_rcu(void)
>> +{
>> +	synchronize_rcu();
>> +}
>> +
>>   #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>>
>>   static void tlb_remove_table_free(struct mmu_table_batch *batch)
>> @@ -303,6 +321,10 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>>   	__tlb_remove_table_free(batch);
>>   }
>>
>> +static void tlb_remove_table_sync_rcu(void)
>> +{
>> +}
>> +
>>   #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
> This seems a _little_ dangerous to even define. We don't want this
> sneaking into use when it doesn't do anything.

This follows the same pattern as tlb_remove_table_sync_one(), which
also has an empty stub in the !CONFIG_MMU_GATHER_RCU_TABLE_FREE path.

It should be in tlb.h like tlb_remove_table_sync_one(). Will put
it there.


Thanks,
Lance
