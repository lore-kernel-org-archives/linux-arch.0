Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30633644D3
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851546; cv=none; b=BBLVoRzzjhuXXyD0yw/DUD3sGzKeS9Nv3eID0v1KGaGtRu5AZ5ftJcIBdwZFJSRD3ELYde+Bnm+bn7vsjLyEwZ65ruWObu+jiAckZyl92PsXHpjyaq3haZ0gTb5g0BqrL6VemRfFxdn17/psUlJfUrpjHuU4K1HVdspIuPc8c6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851546; c=relaxed/simple;
	bh=k4J6IvsiD9LhsdglHalyH/XYCqp3QjmPUhpzs9eWR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG1ufVhfBVt5ZDH6czkTjiw5wD5IU5Q1E7SiTCcJ7lL/mmQD7pUtKQDeaUDFpZWlwaAuJdpuVCvD1qV9KRkn1fIZ7RwjSqXA6S9rYp+l+/VxO6CzT5wVGGuhKiZQkpGzX3DuO5qdxWkOi+LQ/sQLTb2SjAmyfomJmNq3WC3Gh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g6sxuzEr; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g6sxuzEr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771851541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PY8rg80vENS74DCDq2wg3LcsPVEGgVZEiZlEKxhHQW4=;
	b=g6sxuzEr7b2yqLLl+dbiWwg5XE22KaWXK0xMhuBXMLgQMJxtoVQhwGJwdOauwdJy9RBxt2
	edKAlnHmpJMJlrxCFpfFcFIMjDZ8Vs6DHCX7WCak09ff7JczBnutPHoSSk6f9W2tJfWHLj
	dzgY+Q0LrVtoGldS7EV7fMXNWr1DsxY=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	dave.hansen@intel.com,
	lance.yang@linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	will@kernel.org
Subject: Re: [PATCH 1/1] mm/mmu_gather: replace IPI with synchronize_rcu() when batch allocation fails
Date: Mon, 23 Feb 2026 20:58:26 +0800
Message-ID: <20260223125826.28207-1-lance.yang@linux.dev>
In-Reply-To: <2a6c4e62-1663-4a98-9adc-406a6a1ebfd3@kernel.org>
References: <2a6c4e62-1663-4a98-9adc-406a6a1ebfd3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Feb 23, 2026 at 10:29:56AM +0100, David Hildenbrand (Arm) wrote:
>On 2/23/26 04:36, Lance Yang wrote:
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
>> synchronize_rcu() waits for all such sections to complete, providing the
>> same guarantee as IPI but without disrupting all CPUs.
>> 
>> Since batch allocation already failed, we are in a way slow path, so
>> replacing the IPI with synchronize_rcu() is fine.
>> 
>> We are in process context (unmap_region, exit_mmap) with only mmap_lock
>> held, a sleeping lock. synchronize_rcu() will catch any invalid context
>> via might_sleep().
>> 
>> [1] https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/
>> 
>> Link: https://lore.kernel.org/linux-mm/20260202150957.GD1282955@noisy.programming.kicks-ass.net/
>> Link: https://lore.kernel.org/linux-mm/dfdfeac9-5cd5-46fc-a5c1-9ccf9bd3502a@intel.com/
>> Link: https://lore.kernel.org/linux-mm/bc489455-bb18-44dc-8518-ae75abda6bec@kernel.org/
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>
>I think it was primarily Peter and Dave suggesting that :)

:)

>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/mmu_gather.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index fe5b6a031717..df670c219260 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -339,7 +339,8 @@ static inline void __tlb_remove_table_one(void *table)
>>   #else
>>   static inline void __tlb_remove_table_one(void *table)
>>   {
>> -	tlb_remove_table_sync_one();
>> +	if (IS_ENABLED(CONFIG_MMU_GATHER_RCU_TABLE_FREE))
>> +		synchronize_rcu();
>
>That should work.
>
>Reading all the comments for tlb_remove_table_smp_sync(), I wonder 
>whether we should wrap that in a tlb_remove_table_sync_rcu() function, 
>with a proper kerneldoc for the CONFIG_MMU_GATHER_RCU_TABLE_FREE variant 
>where we discuss how this relates to tlb_remove_table_sync_one (and 
>tlb_remove_table_smp_sync() .

Good point! That would be cleaner and better ;)

How about the following:

---8<---
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index fe5b6a031717..ea5503d3e650 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -296,6 +296,24 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
 	call_rcu(&batch->rcu, tlb_remove_table_rcu);
 }

+/**
+ * tlb_remove_table_sync_rcu() - synchronize with software page-table walkers
+ *
+ * Like tlb_remove_table_sync_one() but uses RCU grace period instead of IPI
+ * broadcast. Should be used in slow paths where sleeping is acceptable.
+ *
+ * Software/Lockless page-table walkers use local_irq_disable(), which is also
+ * an RCU read-side critical section. synchronize_rcu() waits for all such
+ * sections, providing the same guarantee as tlb_remove_table_sync_one() but
+ * without disrupting all CPUs with IPIs.
+ *
+ * Context: Can sleep/block. Cannot be called from any atomic context.
+ */
+static void tlb_remove_table_sync_rcu(void)
+{
+	synchronize_rcu();
+}
+
 #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */

 static void tlb_remove_table_free(struct mmu_table_batch *batch)
@@ -303,6 +321,10 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
 	__tlb_remove_table_free(batch);
 }

+static void tlb_remove_table_sync_rcu(void)
+{
+}
+
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */

 /*
@@ -339,7 +361,7 @@ static inline void __tlb_remove_table_one(void *table)
 #else
 static inline void __tlb_remove_table_one(void *table)
 {
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_rcu();
 	__tlb_remove_table(table);
 }
 #endif /* CONFIG_PT_RECLAIM */
---

Thanks for the suggestion!
Lance
