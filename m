Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8B39A7ED
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937860; cv=none; b=gZeZ+Z2Fbo3k6XpMnNwxcOd6I+bLDNoO0+otj7NKXJDw/hG5SW/qRw9AE2cK7L00PlUTelgqK3DlZydgJiLRAkVTo/quUpGaRhxd6XkIGyYdn0Q8dOZQ0t9vILW1lq9q4nzL3T/AH04AUZVfN8spV0z0FXzSoFflTXvT7zynfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937860; c=relaxed/simple;
	bh=/eAVDE0lHVSB/ji391bim3YNEnZ0tJnlHnIJ10AvUfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFbjGH7OSfSpRXeFWhy4ee20wdA2tOLy8NBeA4IgVjh9jKviLmsImzgc1PBTmm2OT0jCi2FqxWQ+eQZ/5m1r5UgSTfSu0Hbo+4E30uv2T2F7cKo1b77K+qaa5nuljLAYPMmut40QjdhgDcS0nVoqpTcbx9qICgID3pdh0NlfgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjE5rZYu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjE5rZYu"
Message-ID: <d48e0326-a746-40ca-95d4-aff2c457877b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771937856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITpSuVeZjMjGUgIfLU7ZsbRR7wBeR6IvfybRhh1i/bA=;
	b=UjE5rZYub6kFQCuKL9HCjr8WrgA2E5IALHbCXt1HuCtdYZE/De3cHoC2nJqXM7So6YI0EO
	sjhCFAVk+eCZ9rfDWbHJMUGzXokBUfAXFfzEsMD/7sWorxccVdHJ/jVZcUHrhcPu1GXOcm
	ZLtfPwIGxCb+wG05xRf7QHW2bc3qLZI=
Date: Tue, 24 Feb 2026 20:57:28 +0800
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
 <5cc90e7a-ae32-4352-8e0b-2eee5a5ee122@linux.dev>
 <20260224123538.GW1282955@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260224123538.GW1282955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/24 20:35, Peter Zijlstra wrote:
> On Tue, Feb 24, 2026 at 08:18:46PM +0800, Lance Yang wrote:
>>
>>
>> On 2026/2/24 19:41, Peter Zijlstra wrote:
>>> On Tue, Feb 24, 2026 at 11:07:00AM +0800, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> When freeing page tables, we try to batch them. If batch allocation fails
>>>> (GFP_NOWAIT), __tlb_remove_table_one() immediately frees the one without
>>>> batching.
>>>>
>>>> On !CONFIG_PT_RECLAIM, the fallback sends an IPI to all CPUs via
>>>> tlb_remove_table_sync_one(). It disrupts all CPUs even when only a single
>>>> process is unmapping memory. IPI broadcast was reported to hurt RT
>>>> workloads[1].
>>>>
>>>> tlb_remove_table_sync_one() synchronizes with lockless page-table walkers
>>>> (e.g. GUP-fast) that rely on IRQ disabling. These walkers use
>>>> local_irq_disable(), which is also an RCU read-side critical section.
>>>>
>>>> This patch introduces tlb_remove_table_sync_rcu() which uses RCU grace
>>>> period (synchronize_rcu()) instead of IPI broadcast. This provides the
>>>> same guarantee as IPI but without disrupting all CPUs. Since batch
>>>> allocation already failed, we are in a way slow path where sleeping is
>>>> acceptable - we are in process context (unmap_region, exit_mmap) with only
>>>> mmap_lock held. might_sleep() will catch any invalid context.
>>>
>>> So sending the IPIs also requires non-atomic context, so change there.
>>
>> Yeah, you're right!
>>
>>> What isn't explained, and very much not clear to me, is why
>>> tlb_remove_table_sync_one() is retained?
>>
>> Good point. tlb_remove_table_sync_one() is still needed in:
>>
>> 1) khugepaged (mm/khugepaged.c) - after pmdp_collapse_flush()
>> 2) tlb_finish_mmu() (tlb.h) - when tlb->fully_unshared_tables
>> 3) ...
>>
>> These are not slow paths like batch allocation failure. This patch only
>> converts this obvious slow path first.
>>
>> I'm working on converting the remaining callers as well, but not with
>> RCU, looking at other options (e.g. targeted IPI).
> 
> OK, so with that addition to the Changelog,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for taking time to review!
